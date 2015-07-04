<%@page import="payroll.NumberToWords"%>
<%@page import="security.SecureNew"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "Pay Slip");
%>
<%@include file="../Common/Header.jsp"%>

<%
	Connection con = DbConnection.getConnection();
	Statement s; 
	String sql = "";
	ResultSet bankdetails;
	ResultSet payrolldetails;
	ResultSet empdetails;
	SecureNew sn = new SecureNew();
	String emid = request.getParameter("emid");
	
	
	s = con.createStatement();
	sql = "SELECT * FROM `pay_slip` WHERE `empid`='"+emid+"' LIMIT 1";
	ResultSet rs = s.executeQuery(sql);
	rs.next();
	
	s = con.createStatement();
	sql = "SELECT * FROM `employee` WHERE `id`='"+emid+"' LIMIT 1";
	empdetails = s.executeQuery(sql);
	empdetails.next();
	
	s = con.createStatement();
	sql = "SELECT * FROM `payroll_info` WHERE `empid`='"+emid+"' LIMIT 1";
	payrolldetails = s.executeQuery(sql);
	payrolldetails.next();
	
	s = con.createStatement();
	sql = "SELECT * FROM `bankdetails` WHERE `empid`='"+emid+"' LIMIT 1";
	bankdetails = s.executeQuery(sql);
	if(bankdetails.next()==false){
		response.sendRedirect("../error.jsp?e=bank_details_not_found");
		return;
	}
%>
<script type="text/javascript">
	$(document).ready(function() {

		$("#printbtn").click(function() {
			$("header").toggle();
			$("#sidebar").toggle();
			$("#wp").toggleClass("wrapper");
		});
	});
</script>
<!--main content start-->
<section id="main-content" class="mc">
	<section class="wrapper" id="wp">
		<section>
			<div class="panel panel-info">
				<button id="printbtn" class="btn btn-danger">Toggle Print
					View</button>
				<div class="panel-heading" align="center">
					<h4>
						<b>PAY-SLIP FOR THE MONTH OF <%=payrolldetails.getString("my")%></b>
					</h4>
				</div>

				<div class="panel-body" id="printable-area" align="center">
					<div class="row" align="center">
						
							
								<h3><b>Eyeopen Technologies</b>
							</h3>
						
						<div class="col-lg-6"></div>
					</div>

					<div class="row">
						<div class="col-lg-6 col-sm-6">
							<style scoped>
table {
	border-collapse: collapse;
	border: solid thin;
}

colgroup,tbody {
	border: solid medium;
}

colgroup,thead {
	border: solid medium;
}

tr {
	border: solid thin;
	height: 1.4em;
	width: 1.4em;
	padding: 0;
}
th {
	border: solid thin;
	height: 1.4em;
	width: 1.4em;
	padding: 0;
}

td {
	border: solid thin;
	height: 1.4em;
	width: 1.4em;
	padding: 0;
}
</style>
							<table class="table table-striped table-hover">
								<tbody>
									<tr>
										<td><div class="col-lg-4">
												<b> Employee ID:</b>
											</div>
											<div class="col-lg-4">
												<b><%=empdetails.getString("id")%></b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> Name:</b>
											</div>
											<div class="col-lg-3">
												<b><%=(empdetails.getString("FirstName") == null ? ""
					: empdetails.getString("FirstName"))%><%=(empdetails.getString("LastName") == null ? ""
					: empdetails.getString("LastName"))%></b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> Designation: </b>
											</div>
											<div class="col-lg-4">
												<b><%=GetInfoAbout.getjobtitlename(empdetails.getString("JobTitleId"))%></b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> Date of Joining:</b>
											</div>
											<div class="col-lg-4">
												<b><%=(empdetails.getString("JoinDate") == null ? ""
					: empdetails.getString("JoinDate"))%></b>
											</div></td>
									</tr>

								</tbody>
							</table>
						</div>
						<div class="col-lg-6 col-sm-6">
							<table class="table table-striped table-hover">
								<tbody>
									<tr>
										<td><div class="col-lg-4">
												<b> Bank Name: </b>
											</div>
											<div class="col-lg-4">
												<b><%=bankdetails.getString("BankName")%></b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> Bank Account No:</b>
											</div>
											<div class="col-lg-4">
												<b>
													<%
														String bdet = bankdetails.getString("AccNumber");
														if (bdet != null) {
															out.print(sn.decrypt(bdet));
														}
													%>
												</b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> PF A/C No:</b>
											</div>
											<div class="col-lg-4">
												<b><%=empdetails.getString("pfnumber")%></b>
											</div></td>
									</tr>
									<tr>
										<td><div class="col-lg-4">
												<b> Pancard Number: </b>
											</div>
											<div class="col-lg-4">
												<b>
													<%
														String pan = empdetails.getString("PancardNumber");
														if (pan != null) {
															out.print(sn.decrypt(pan));
														}
													%>
												</b>
											</div></td>
									</tr>

								</tbody>
							</table>
						</div>
						<%
							String twdays = payrolldetails.getString("total_working");
							String nwdays = payrolldetails.getString("net_wdays");
							float itwdays = Float.parseFloat(twdays);
							float inwdays = Float.parseFloat(nwdays);
							float lop = itwdays-inwdays;
							int ilop = (int)lop;
						%>
						<div class="col-lg-12 col-sm-12">
							<table class="table table-striped table-hover">
								<thead>
									<tr>
										<th><div class="col-lg-6">
												<b>Total Working Days:</b>
											</div>
											<div class="col-lg-6">
												<b><%=payrolldetails.getString("total_working")%></b>
											</div></th>
											<th><div class="col-lg-4">
												<b>LOP:</b>
											</div>
											<div class="col-lg-4">
												<b><%=ilop%></b>
											</div></th>
											<th><div class="col-lg-4">
												<b>PAID DAYS:</b>
											</div>
											<div class="col-lg-4">
												<b><%=payrolldetails.getString("net_wdays")%></b>
											</div></th>
									</tr>
								</thead>
							</table>
							<div class="col-lg-6 col-sm-6">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<td><b>EARNINGS</b></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><div class="col-lg-4">
													<b> Basic:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("basicpay")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b> HRA:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("hra")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b> A-CCA:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("a_cca")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b>CCA:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("cca")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b>CONV:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("conv")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b>LTA:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("lta")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-4">
													<b>CH-EDU:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("ch_edu")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6" align="right">
													<b>GROSS PAY:</b>
												</div>
												<div class="col-lg-6" align="right">
													<b><%=rs.getString("gross")%></b>
												</div></td>
										</tr>
									</tbody>
								</table>
							</div>
							<div class="col-lg-6 col-sm-6">
								<table class="table table-striped table-hover">
									<thead>
										<tr>
											<td><b>DEDUCTIONS</b></td>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td><div class="col-lg-6">
													<b>PROVIDENT FUND:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("pf")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b> ESI:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("esi")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b> PROFESSIONAL TAX:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("p_tax")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b>ADVANCE AMOUNT:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("adv_amt")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b>LOAN AMOUNT:</b>
												</div>
												<div class="col-lg-4">
													<b><%=(rs.getString("loan_amt")==null?"":rs.getString("loan_amt"))%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b>TDS:</b>
												</div>
												<div class="col-lg-4">
													<b><%=rs.getString("tds")%></b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6">
													<b>OTHER DEDUCTIONS:</b>
												</div></td>
										</tr>
										<tr>
											<td><div class="col-lg-6" align="right">
													<b>TOTAL DEDUCTION:</b>
												</div>
												<div class="col-lg-6" align="right">
													<b><%=rs.getString("deduction")%></b>
												</div></td>
										</tr>									</tbody>
								</table>
							</div>
							<div class="row">
								<div class="col-lg-6 invoice-block pull-right">
									<ul class="unstyled amounts">
									<%
									String netpay = rs.getString("netpay");
									%>
										<li><strong>Total Gross : <%=rs.getString("gross") %></strong></li>
										<li><strong>Total Deduction : <%=rs.getString("deduction") %></strong></li>
										<li><strong>NET PAY: <%=netpay %></strong> (<%=NumberToWords.getword(netpay) %>)</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					</div>
					</div>
		</section>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>