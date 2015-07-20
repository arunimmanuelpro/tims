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
							<td></td>
						</tr>
						<tr>
							<td>Month</td>
							<td>	
								<select id = "month" class = "form-control" style ="width:200px;">
								
								</select>
							</td>
							<td><input type= "button" value = "Generate Payslip" onclick = "getPayroll();" class = "btn btn-primary"/></td>
						</tr>
					</table>
					
					</section>
					</section>
					</div>
					<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-folder-open"> Employee Payroll</i>
					</h3>
					
				</div>
				<section class="panel" id = "paysliptable">
				
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>
					
				</section>
				</section>	
				<script>
					function getPayroll(){
						var year = parseInt(document.getElementById("year").value);
						
					var month = document.getElementById("month").value;
					
					if((year!=0) && (month!="")){
						var xmlhttp;
						xmlhttp = new XMLHttpRequest();
						xmlhttp.onreadystatechange = function(){
							if(xmlhttp.readyState==4&&xmlhttp.status==200){
								var response = xmlhttp.responseText.trim();
								document.getElementById("paysliptable").innerHTML = response;
							}
						}
						xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/calculatepayslip.jsp?year="+year+"&month="+month,true);
						xmlhttp.send();
					}else{
						alert("Kindly Select Year and Month");
						
					}
					
					}
				
				</script>
					
					
					
					<script>
	function getMonth(year){
		var x = document.getElementById("month");
		x.remove(x.selectedIndex);
		if(year!=0){
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange = function(){
				if(xmlhttp.readyState==4&&xmlhttp.status==200){
					var response = xmlhttp.responseText.trim();
					if(response!="[]"){
					response = response.replace("[","");
					
					response = response.replace("]","");
					var entry = response.split(",");
					
				   var month = new Array("Jan","Feb","March","April","May","June","July","August","Sept","Oct","Nov","Dec");
					for(var i = 0; i<entry.length;i++){
					
						 var option = document.createElement("option");
						   
						    option.value=entry[i];
						    option.text = month[entry[i]-1];
						    x.add(option);
						
						}
					}
				}
			}
			xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/getyear.jsp?year="+year,true);
			xmlhttp.send();
		}
	}		
</script>
<%con.close(); %>
<%@include file="../Common/Footer.jsp"%>