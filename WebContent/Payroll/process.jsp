<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="security.SecureNew"%>
<%@page import="general.GetInfoAbout"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	request.setAttribute("title", "Payroll Process");
%>
<%@include file="../Common/Header.jsp"%>

<%
	SecureNew sn = new SecureNew();
	String id = request.getParameter("id");
	ResultSet attendance = null;
	String empid22 = "";
	if (id == null) {
		response.sendRedirect(request.getContextPath()
		+ "/Payroll/index.jsp?msg=Access Error");
		return;
	} else {
		if (id.isEmpty()) {
	response.sendRedirect(request.getContextPath()
	+ "/Payroll/index.jsp?msg=Access Error");
	return;
		} else {
	//process
	Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	String sql = "SELECT * FROM `payroll_info` WHERE `id` = '"
	+ id + "' LIMIT 1";
	ResultSet rs = s.executeQuery(sql);

	if (rs.next()) {
		empid22 = rs.getString("empid");
		//get attendance details
		Statement s1 = con.createStatement();
		String sql1 = "SELECT * FROM `attendance` WHERE `logouttime` IS NOT NULL AND`empid` = "
		+ empid22 + " ORDER BY `Date` ASC";
		attendance = s1.executeQuery(sql1);
	} else {
		response.sendRedirect(request.getContextPath()
		+ "/Payroll/index.jsp?msg=Information Invalid");
		return;
	}

		}
	}
%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">

		<div class="modal-body">
			<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading"> Payroll Process</header>
						<div class="panel-body">
							<form class="form-horizontal" id="contactup"
								data-validate="parsley">
								<input type="hidden" name="pr" id="pr" value="<%=id%>">
								<div class="form-group">
									<label for="EmpName" class="col-lg-3 control-label">Employee
										Name</label>
									<div class="col-lg-8">
										<input class="form-control" id="Empname" name="Empname"
											readonly placeholder="Emp Name" data-required="true"
											value="<%=GetInfoAbout.gettrainername(empid22)%>" type="text">
									</div>
								</div>
								<div class="form-group">
									<label for="Designation" class="col-lg-3 control-label">Employee
										Id </label>
									<div class="col-lg-8">
										<input class="form-control" readonly id="empid" name="empid"
											data-required="true" value="<%=empid22%>" type="text">
									</div>
								</div>
								<div class="form-group">
									<label for="Basicpay" class="col-lg-3 control-label">Basic
										Pay</label>
									<div class="col-lg-8">
										<input class="form-control"
											value="<%=GetInfoAbout.getbasicpay(empid22)%>" readonly
											data-required="true" id="BasicPay" name="BasicPay"
											placeholder="Basic Pay" type="text">
									</div>
									<section class="panel">
										<header class="panel-heading"> Attendance </header>
										<table class="table">
											<thead>
												<tr>
													<th>Date</th>
													<th>Login Time</th>
													<th>Logout Time</th>
													<th>Total Hours</th>
												</tr>
											</thead>
											<tbody>
												<%
													int dayspresent = 0;
																							while (attendance.next()) {
												%><tr>
													<td><%=attendance.getString(3)%></td>
													<td><%=attendance.getString(4)%></td>
													<td><%=attendance.getString(5)%></td>
													<td><%
													String thours = attendance.getString(8);
													if(thours!=null){
														out.print(sn.decrypt(thours));
													}
													%></td>
												</tr>
												<%
													dayspresent++;
																							}
												%>
											</tbody>
										</table>
									</section>
									<div class="form-group">
										<label for="Leavetaken" class="col-lg-3 control-label">Days
											Present </label>
										<div class="col-lg-8">
											<input class="form-control" id="PresentD" name="PresentD"
												data-required="true" value="<%=dayspresent%>"
												readonly="true" type="text" data-range="[0,31]">
										</div>
									</div>
									<div class="form-group">
										<label for="Leavetaken" class="col-lg-3 control-label">Total
											Days This Month </label>
										<div class="col-lg-8">
											<input class="form-control" id="totaldaysthism"
												data-required="true" name="totaldaysthism"
												placeholder="28 or 29 or 30 or 31" data-range="[28,31]"
												type="text">
										</div>
									</div>
									<script type="text/javascript">
										$(document)
												.ready(
														function() {
															$("#totaldaysthism")
																	.change(
																			function() {
																				var present = $(
																						"#PresentD")
																						.val();
																				var total = $(
																						this)
																						.val();
																				$(
																						this)
																						.attr(
																								"readonly",
																								true);
																				$(
																						"#Leavetaken")
																						.val(
																								total
																										- present);
																				$(
																						"#Approvedleave")
																						.attr(
																								"readonly",
																								false);
																				$(
																						"#Compensatoryleave")
																						.attr(
																								"readonly",
																								false);
																			});

														});
									</script>
									<div class="form-group">
										<label for="Leavetaken" class="col-lg-3 control-label">Leave
											Taken </label>
										<div class="col-lg-8">
											<input class="form-control" id="Leavetaken" name="Leavetaken"
												data-required="true" placeholder="Leave Taken" type="text"
												readonly="true" data-range="[0,31]">
										</div>
									</div>
									<div class="form-group">
										<label for="Approvedleave" class="col-lg-3 control-label">Approved
											Leave </label>
										<div class="col-lg-8">
											<input class="form-control" id="Approvedleave"
												data-required="true" readonly="true" name="Approvedleave"
												data-range="[0,31]" placeholder="Approved leave" type="text">
										</div>
									</div>
									<div class="form-group">
										<label for="Compenrotoryleave" class="col-lg-3 control-label">Compensatory
											leave </label>
										<div class="col-lg-8">
											<input class="form-control" id="Compensatoryleave"
												data-required="true" data-range="[0,20]" readonly="true"
												name="Compensatoryleave" placeholder="Compensatory Leave"
												type="text">
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<input type="submit" value="GENERATE">
									</div>
								</div>

								<script type="text/javascript">
									$(document)
											.ready(
													function() {

														//Contact Details Update Start
														$("#contactup")
																.submit(
																		function() {

																			$(
																					'#contactup')
																					.parsley(
																							'validate');
																			if (!$(
																					'#contactup')
																					.parsley(
																							'isValid')) {
																				$.gritter
																						.add({
																							title : 'Fill Fields',
																							text : 'Oops Please Fill All Fields'
																						});
																				return false;
																			} else {

																			}

																			var str = $(
																					this)
																					.serialize();

																			$
																					.ajax({
																						url : "../Ajax/generatePayroll.jsp",
																						type : "POST",
																						data : str,
																						success : function(
																								data,
																								textStatus,
																								jqXHR) {
																							if (data == 1) {
																								$.gritter
																										.add({
																											title : 'Success',
																											text : 'All Data Saved'
																										});
																								$(location).attr('href','index.jsp');
																							} else {
																								$.gritter
																										.add({
																											title : 'Sorry',
																											text : 'Some Error Occured, Please Try Again.'
																										});
																							}
																						},
																						error : function(
																								jqXHR,
																								textStatus,
																								errorThrown) {
																							alert("Sorry, Error.");
																							$.gritter
																									.add({
																										title : 'Sorry',
																										text : 'Some Error Occured, Please Try Again.'
																									});

																						}
																					});
																			return false;

																		});
														//End Contact Details Update
													});
								</script>




							</form>
						</div>
					</section>
				</div>
			</div>
		</div>

	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>