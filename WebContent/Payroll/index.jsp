<%@page import="java.sql.PreparedStatement"%>
<%
	request.setAttribute("title", "Payroll");
%>
<%@include file="../Common/Header.jsp"%>
<%	if(userroles.contains("payroll_management") || userroles.contains("advance_management")){
	
}else{
response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
return;
} %>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<section class="panel">
					<section class="panel-body">
					<%Connection con = DbConnection.getConnection();
					PreparedStatement ps = con.prepareStatement("select DISTINCT year from empattendance");
					ResultSet rs = ps.executeQuery();
					
					%>
					<table>
						<tr>
							<td>Year</td>
							<td><select id = "year" class = "form-control" style ="width:200px;" onchange ="getMonth(this.value);">
									<option value = "0" >--SELECT--</option>
									<%while(rs.next()){ %>
									<option value ="<%= rs.getInt("year")%>"><%= rs.getInt("year")%></option>
									<%} %>
									</select>
							</td>
						</tr>
						<tr>
							<td>Month</td>
							<td>	
								<select id = "month" class = "form-control" style ="width:200px;">
								
								</select>
							</td>
						</tr>
					</table>
					</section>
					</section>
					</div>
					</div>
					</section>
					</section>
<script>
	function getMonth(year){
		if(year!=0){
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4&&xmlhttp.status==200){
					alert(xmlhttp.responseText);
				}
			}
			xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/getyear.jsp?year="+year,true);
			xmlhttp.send();
		}
	}		
</script>
<%con.close(); %>
<%@include file="../Common/Footer.jsp"%>