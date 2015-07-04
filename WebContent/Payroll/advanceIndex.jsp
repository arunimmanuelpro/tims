
<%@page import="java.util.Calendar"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "Advance");
%>
<%@include file="../Common/Header.jsp"%>


<%
	if(userroles.contains("payroll_management") || userroles.contains("advance_management")){
	
}else{
response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
return;
}
	Connection con = DbConnection.getConnection();
	Statement sss = con.createStatement();
	String sql = "SELECT DISTINCT `my` FROM  `advance` ";
	ResultSet rs = sss.executeQuery(sql);
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<section class="panel">
					<section class="panel-body">
						<select id="pinfo">
							<option value="">------SELECT---------</option>
							<%
							if(rs.next()){
								rs.beforeFirst();
								while(rs.next()){
							%>
							<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
							
						</select>
						<a href="advance.jsp?my=<%=rs.getString("my")%>"><i class="btn btn-success">Generate Advance</i></a>
					<%
								}}
							%>
					</section>
				</section>
			</div>
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-folder-open"> Employee Advance</i>
					</h3>
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Employee ID</th>
								<th>Employee Name</th>
								<th>Maximum Advance</th>
								<th>Paid Amount</th>
								<th>Status</th>
								<th>More...</th>
							</tr>
						</thead>
						<tbody id="payroll_info_ajax_display">
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>
		<script type="text/javascript">
			$(document).ready(function() {

				$("#pinfo").change(function() {
					var str = "";
				    $( "select option:selected" ).each(function() {
				      str += this.value + " ";
				    });
				    
				    if(str==""){
				    	alert("error");
				    	return false;
				    }
				    $("#payroll_info_ajax_display").load("<%=request.getContextPath()%>/Payroll/AjaxAdvance.jsp?pr="
																			+ str,
																	function(
																			response,
																			status,
																			xhr) {
																		if (status = "success") {
																			$(
																					"#payroll_info_ajax_display")
																					.html(
																							response);
																		}
																	});
												});
							});
		</script>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>