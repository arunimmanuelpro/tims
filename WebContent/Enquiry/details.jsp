<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	int id = 0;
	String strid = request.getParameter("id");
	if (strid != null) {
		id = Integer.parseInt(request.getParameter("id"));
	} else {
		id = 0;
	}
	

	String source = "", name = "", email = "", mobile = "", qua = "", des = "", curr = "", home = "", ci = "", address = "", gender = "", status = "";
	boolean valid = false;

	if (id == 0) {
		//error
		valid = false;
	} else {
		Connection dbc = DbConnection.getConnection();
		Statement s = dbc.createStatement();
		String sql = "SELECT * FROM enquiry where `id`='" + id + "'";
		ResultSet rs = s.executeQuery(sql);
		if (rs.next()) {
	source = rs.getString("source");
	name = rs.getString("name");
	email = rs.getString("email");
	mobile = rs.getString("mobile");
	home = rs.getString("homephone");
	qua = rs.getString("qualification");
	des = rs.getString("stream");
	curr = rs.getString("currentlyin");
	ci = rs.getString("courseinterested");
	address = rs.getString("address");
	status = rs.getString("status");
	valid = true;
		} else {
	//enquiry not found
	valid = false;
		}
	}
	if (!valid) {
		RequestDispatcher rds = request
		.getRequestDispatcher("error.jsp");
		rds.forward(request, response);
	} else {
		//its valid
	}
%>
<%
	request.setAttribute("title", "All Enquiries");
%>
<%@include file="../Common/Header.jsp"%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-lg-6">
				<div class="row">
					<div class="col-xs-6">
						<section class="panel text-center">
							<div class="panel-body">
								<a class="btn btn-circle btn-lg btn-info"><i
									class="fa fa-coffee"></i></a>
								<div class="h4">
									Enquiry
									<%=id%></div>
								<div class="line m-l m-r"></div>
								<small>Status : <%=status%></small>
							</div>
						</section>
					</div>
					<div class="col-xs-6">
						<section class="panel text-center">
							<div class="panel-body">
								<a class="btn btn-circle btn-lg btn-success"><i
									class="fa fa-user"></i></a>
								<div class="h4"><%=name%></div>
								<div class="line m-l m-r"></div>
								<small>Course Interested :<b><%=ci%></b></small>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading">
								<span class="hidden-sm">Source : <%=source%></span>
							</header>
							<div class="panel-body">
								<form class="form-horizontal" id="newemp" name="newemp">
									<div class="form-group">
										<label class="col-lg-3 control-label">Name</label>
										<div class="col-lg-8">
											<input type="text" name="name" id="name" value="<%=name%>"
												data-required="true" class="form-control parsley-validated">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Email</label>
										<div class="col-lg-8">
											<input type="text" name="email" value="<%=email%>" id="email"
												data-type="email" data-required="true"
												class="form-control parsley-validated">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Qualification</label>
										<div class="col-lg-8">
											<input type="text" name="qualification" id="qualification"
												value="<%=qua%>" class="form-control parsley-validated">

										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Stream</label>
										<div class="col-lg-8">
											<input type="text" name="designation" id="designation"
												value="<%=des%>" class="form-control parsley-validated">

										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">School / College
											/ Company in</label>
										<div class="col-lg-8">
											<input type="text" name="currentlyin" id="currentlyin"
												value="<%=curr%>" class="form-control parsley-validated">

										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Home Phone / Alt
											contact</label>
										<div class="col-lg-8">
											<input type="text" name="homephone" id="homephone"
												data-type="phone" value="<%=home%>"
												class="form-control parsley-validated">

										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Address /
											Location</label>
										<div class="col-lg-8">
											<input type="text" name="address" id="address"
												value="<%=address%>" class="form-control parsley-validated">

										</div>
									</div>
									<input type="hidden" name="id" value="<%=id%>">
									<div class="form-group">
										<div class="col-lg-9 col-lg-offset-3">
											<input type="submit" value="Update" class="btn btn-primary">
										</div>
									</div>
								</form>
								<div class="alert alert-success" id="result"
									style="display: none"></div>
								<div class="alert alert-warning" id="loading"
									style="display: none">Please Wait Loading . . .</div>
								<script type="text/javascript">
								// we will add our javascript code here           

								$(document)
										.ready(
												function() {
													$("#newemp")
															.submit(
																	function() {

																		// 'this' refers to the current submitted form
																		var str = $(
																				this)
																				.serialize();

																		$(
																				"#loading")
																				.show();
																		$(
																				"#result")
																				.hide();

																		$
																				.ajax({
																					url : "<%=request.getContextPath()%>/Ajax/enquiryupdate.jsp",
																						type : "POST",
																						data : str,
																						success : function(
																								data,
																								textStatus,
																								jqXHR) {
																							$(
																									"#loading")
																									.hide();
																							$(
																									"#result")
																									.show();
																							$(
																									"#result")
																									.html(
																											data);
																						},
																						error : function(
																								jqXHR,
																								textStatus,
																								errorThrown) {
																							alert("Error");
																							$(
																									"#loading")
																									.hide();
																						}
																					});
																			return false;

																		});

													});
								</script>
							</div>
						</section>
					</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="row">
					<div class="col-xs-12">
						<section class="panel">
							<header class="panel-heading bg-white">Operations in
								current Enquiry</header>
							<div class="panel-body doc-buttons">
							<%if (!(status.equalsIgnoreCase("ONCALL"))){ %>
								<a style="display:none"
									href="../Ajax/enquiryoperations.jsp?bid=<%=id%>&operation=COMPLETED"
									class="btn btn-info">COMPLETED</a> <a
									href="ProcessStudent.jsp?id=<%=id%>"
									class="btn btn-success">SWITCH TO STUDENT</a> <a
									href="../Ajax/enquiryoperations.jsp?bid=<%=id%>&operation=DUPLICATE"
									class="btn btn-warning">DUPLICATE ENQUIRY</a>
									<%} %>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading"> Today </header>
							<div>
								<%
									Connection con3 = DbConnection.getConnection();
														Statement st;
														String sqlq;
														ResultSet rss;
														st = con3.createStatement();

														SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
														Date today = new Date();
														String todayd = ddmm.format(today);

														String ses_user_id = request.getAttribute("userid").toString();
														
														sqlq = "SELECT * FROM enquiry_data where `followon` = '" + todayd
																+ "' AND `enquiry_id` = '" + id
																+ "' ORDER BY id DESC LIMIT 1";
														rss = st.executeQuery(sqlq);
														if (rss.next()) {
															String callin = rss.getString("callin");
															String callout = rss.getString("callout");
															String emp_id = rss.getString("donebyempid");
															
															if (callout == null || callout.isEmpty()) {
																if (status.equalsIgnoreCase("NEW")
																		|| status.equalsIgnoreCase("FOLLOWUP")) {
								%>
								<a
									href="<%=request.getContextPath()%>/Ajax/enquirycall.jsp?id=<%=id%>"
									class="btn btn-success btn-circle"><i class="icon-phone"></i>Call</a>
								<%
									} else if (status.equalsIgnoreCase("ONCALL") && emp_id.equals(ses_user_id)) {
															//if call on
								%>
								<h2><%=mobile%></h2>
								<br> <a href="#" class="btn btn-danger btn-circle"
									id="endcall"><i class="icon-stop"></i>End</a>
								<%
									} else {
																	out.println("<h2>Call in Progress (or) Enquiry Status Invalid</h2>");
																}
															} else {
																out.println("<h2>Call for today is Complete</h2>");
															}
														}
								%>
							</div>
							<script type="text/javascript">
								// we will add our javascript code here           

								$(document)
										.ready(
												function() {

													$(validatebtn)
															.click(
																	function() {
																		$(
																				'#statusform')
																				.parsley(
																						'validate');
																		if (!$(
																				'#statusform')
																				.parsley(
																						'isValid')) {
																			//Invalid
																		} else {
																			$(
																					"#validatebtn")
																					.hide();
																			$(
																					"#formsubmit")
																					.show();
																		}
																	});

													$("#endcall")
															.click(
																	function() {
																		$(
																				"#leave-log")
																				.toggle();
																	});
												});
							</script>
						</section>
					</div>
				</div>
				<div class="row" id="leave-log" style="display: none">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading"> Leave a Log </header>
							<div>
								<form class="form-horizontal" id="statusform" name="statusform"
									method="post"
									action="<%=request.getContextPath()%>/Ajax/enquirycallend.jsp">
									<div class="form-group">
										<label class="col-lg-3 control-label">Status Info</label>
										<div class="col-lg-8">
											<select name="status" id="status" data-required="true">
												<option value="">---------Please Choose--------</option>
												<option value="PROSPECT">PROSPECT</option>
												<option value="LOCATION-CONSTRAIN">LOCATION
													CONSTRAIN</option>
												<option value="JOINED-OTHER-CONCERN">JOINED OTHER
													CONCERN</option>
												<option value="SWITCHED-OFF">SWITCHED OFF</option>
												<option value="NOT-REACHABLE">NOT REACHABLE</option>
												<option value="NO-RESPONSE">NO RESPONSE</option>
												<option value="NOT-IN-USE">NOT IN USE</option>
												<option value="WRONG-ENQUIRY">WRONG ENQUIRY</option>
												<option value="WRONG-NUMBER">WRONG NUMBER</option>
												<option value="NOT-INTERESTED">NOT INTERESTED</option>
												<option value="OTHER">OTHER</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Message</label>
										<div class="col-lg-8">
											<input type="text" name="message" id="message"
												data-required="true" class="form-control parsley-validated">
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Follow on (if
											needed)</label>
										<div class="col-lg-8">
											<input type="text" name="followon" id="followon"
												class="form-control parsley-validated datepicker"> <input
												type="hidden" id="id" name="id" value="<%=id%>">
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-9 col-lg-offset-3">
											<a class="btn btn-white" id="validatebtn">Validate</a> <input
												type="submit" id="formsubmit" value="End Call"
												class="btn btn-danger" style="display: none">
										</div>
									</div>
								</form>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading">
								<span class="label bg-danger pull-right"></span> Logs
							</header>
							<div>
								<table class="table table-striped m-b-none text-small">
									<thead>
										<tr>
											<th>Call by</th>
											<th>Follow on</th>
											<th>Status</th>
											<th>Message</th>
										</tr>
									</thead>
									<tbody>
										<%
											Connection dbc = DbConnection.getConnection();
											Statement s = dbc.createStatement();
											String sql = "SELECT * FROM enquiry_data where `enquiry_id` = '"
													+ id + "' ";
											ResultSet rs = s.executeQuery(sql);
											while (rs.next()) {
										%>
										<tr>
											<td>
												<%
													out.print(rs.getString("donebyempid") == null ? "NA" : rs
																.getString("donebyempid"));
												%>
											</td>
											<td>
												<%
													out.print(rs.getString("followon") == null ? "NA" : rs
																.getString("followon"));
												%>
											</td>
											<td>
												<%
													out.print(rs.getString("status") == null ? "NA" : rs
																.getString("status"));
												%>
											</td>
											<td>
												<%
													out.print(rs.getString("message") == null ? "NA" : rs
																.getString("message"));
												%>
											</td>
										</tr>
										<%
											}
										%>
									</tbody>
								</table>
							</div>
						</section>
					</div>
				</div>

			</div>
		</div>

	</section>
</section>

<%@ include file="../Common/Footer.jsp"%>
