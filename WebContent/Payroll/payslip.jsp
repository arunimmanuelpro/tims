<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "PaySlip");
%>
<%@include file="../Common/Header.jsp"%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<section class="panel">
					<section class="panel-body">

						<table border = "2" align = "center" width = "100%">
							<tr style ="text-align:center;">
								<td><b>Eyeopen Technologies</b></td>
							</tr>
							<tr  style ="text-align:center;">
							<%int month = Integer.parseInt(request.getParameter("month"));
							
							%>
								<td>Pay Slip for the month of <b><%=DbConnection.monthname[month-1]%>
										<%=request.getParameter("year")%></b></td>
							</tr>


						</table>
					</section>
				</section>
			</div>
		</div>
	</section>
</section>

<%@include file="../Common/Footer.jsp"%>