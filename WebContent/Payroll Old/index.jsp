
<%@page import="java.util.Calendar"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "Payroll");
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
	String sql = "SELECT DISTINCT `my` FROM  `payroll_info` ";
	ResultSet rs = sss.executeQuery(sql);
	
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<section class="panel">
					<section class="panel-body">
						<select id="pinfo" class = "form-control">
							<option value="">------SELECT---------</option>
							<%
							if(rs.next()){
								rs.beforeFirst();
							while(rs.next()){
							%>
							<option value="<%= rs.getString(1) %>"><%= rs.getString(1) %></option>
							
						</select>
						<a href="payroll.jsp?my=<%=rs.getString("my")%>"><i class="btn btn-primary">Generate Payroll</i></a>
					<%}} %>
					</section>
				</section>
			</div>
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-folder-open"> Employee Payroll</i>
					</h3>
					<div>
						<%
							if(userroles.contains("add_payroll")){
						%>
						<form action="">
							<a href="#newbatchm" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
								</button>
							</a>
						</form>
						<%
							}
						%>
					</div>
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Employee</th>
								<th>Name</th>
								<th>Payroll Status</th>
								<th>Payslip Status</th>
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
				    $("#payroll_info_ajax_display").load("<%=request.getContextPath() %>/Payroll/Ajax/GetPayroll.jsp?pr=" + str, function( response, status, xhr ) {
						  if(status="success"){
							  $("#payroll_info_ajax_display").html(response);
						  }
					});
				});
			});
		</script>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>