
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "All Enquiries");
%>
<%@include file="../Common/Header.jsp"%>
<%
		if(userroles.contains("view_enquiry") || userroles.contains("add_enquiry")){			
		}else{
			response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
			return;
		}
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="icon-folder-open"> All Enquiries</i>
					</h3>
					<% if(userroles.contains("add_enquiry")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newEnq" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%} %>
				</div>
				<section class="panel">
					<div class="table-responsive">
						<table class="table table-striped border-top datatable" id="sample_1"
							class="dtable">
							<thead>
								<tr>
									<th width="15%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Email</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>
									<th width="10%">Follow on</th>
									<th width="10%">Done</th>
									<th width="10%">Work</th>
								</tr>
							</thead>
							<tbody>
								<%
									Connection dbc = DbConnection.getConnection();
										Statement s = dbc.createStatement();
										String sql = "";
										if(request.getParameter("completed")==null)
											sql = "SELECT * FROM enquiry WHERE `status` LIKE 'NEW' OR `status` LIKE 'FOLLOW UP' ";
										else
											sql = "SELECT * FROM enquiry WHERE `status` = 'COMPLETED' OR `status` LIKE 'NOT INTERESTED' OR `status` LIKE 'DUPLICATE'";
										ResultSet rs = s.executeQuery(sql);
										while (rs.next()) {
											int id = rs.getInt("id");
											
											
											Connection con3 = DbConnection.getConnection();
											Statement st;
											String sqlq;
											ResultSet rss;
											st = con3.createStatement();

											SimpleDateFormat ddmm = new SimpleDateFormat("dd/MM/yyyy");
											Date today = new Date();
											String todayd = ddmm.format(today);

											HttpSession ses3 = request.getSession();
											 String ses_user_id = ses3.getAttribute("id").toString();
											
											sqlq = "SELECT * FROM enquiry_data where `enquiry_id` = '" + id
													+ "' ORDER BY id DESC LIMIT 1";
											rss = st.executeQuery(sqlq);
											String emp_id = "",followon="";
											if (rss.next()) {
											 	emp_id = rss.getString("donebyempid");
											 	followon = rss.getString("followon");
																																	}
								%>
								<tr>
									<td>
										<%
											out.print(rs.getString("source"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("name"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("email"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("courseinterested"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("status"));
										%>
									</td>
									<td><%=followon%></td>
									<td>
										<%
											if(emp_id==null)
																																													out.print("NO");
																																												else
																																													out.print("YES");
										%>
									</td>
									<td><a class="btn btn-info btn-xs"
										href="details.jsp?id=<%=id%>"><i class="icon-wrench"></i>
											More...</a></td>
								</tr>
								<%
									}
																																//Close DbConnection
																																DbConnection.close();
								%>
							</tbody>
						</table>
					</div>
				</section>

			</div>
		</div>
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="newEnq" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">new Enquiry</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading">Enquiry details</header>
									<div class="panel-body">
										<form class="form-horizontal" id="newempdetadd"
											data-validate="parsley">
											<div class="form-group">
												<label class="col-lg-3 control-label">Enquiry Source</label>
												<div class="col-lg-8">
													<select name="source" id="source" data-required="true">
														<option value="">Please Choose</option>
														<option value="db">DB</option>
														<option value="walkin">Walkin</option>
														<option value="walkin-emp-ref">Walkin Employee
															Referal</option>
														<option value="walkin-stu-ref">Walkin Student
															Referal</option>
														<option value="phone">Phone Enquiry</option>
														<option value="sulekha-manual">Sulekha Manual</option>
														<option value="justdial-manual">JustDial Manual</option>
														<option value="yet5-manual">Yet5 Manual</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Name</label>
												<div class="col-lg-8">
													<input type="text" name="name" id="name"
														data-required="true"
														class="form-control parsley-validated">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Email</label>
												<div class="col-lg-8">
													<input type="text" name="email" id="email"
														data-type="email" class="form-control parsley-validated">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Mobile</label>
												<div class="col-lg-8">
													<input type="text" name="mobile" id="mobile"
														data-required="true" data-type="phone"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Qualification</label>
												<div class="col-lg-8">
													<input type="text" name="qualification" id="qualification"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Stream</label>
												<div class="col-lg-8">
													<input type="text" name="designation" id="designation"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">School /
													College / Company in</label>
												<div class="col-lg-8">
													<input type="text" name="currentlyin" id="currentlyin"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Home Phone /
													Alt contact</label>
												<div class="col-lg-8">
													<input type="text" name="homephone" id="homephone"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Course
													Interested</label>
												<div class="col-lg-8">
													<input type="text" name="courseinterestedin"
														data-required="true" id="courseinterestedin"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Address /
													Location</label>
												<div class="col-lg-8">
													<input type="text" name="address" id="address"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Notes for
													staff</label>
												<div class="col-lg-8">
													<input type="text" name="notes" id="notes"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Status</label>
												<div class="col-lg-8">
													<select name="status" id="status" data-required="true">
														<option value="">Please Choose</option>
														<option value="NEW">Enquiry Only</option>
														<option value="REGISTERED">Registered</option>
														<option value="NI">Not Interested</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Follow on (if
													enquiry only)</label>
												<div class="col-lg-8">
													<input type="text" name="date" id="date"
														class="form-control parsley-validated datepicker">
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<input type="submit" value="Add new Enquiry"
														class="btn btn-success">
												</div>
											</div>

										</form>
									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			$(document)
					.ready(
							function() {

								//Contact Details Update Start
								$("#newempdetadd")
										.submit(
												function() {

													$('#newempdetadd').parsley(
															'validate');

													if ($('#newempdetadd')
															.parsley('isValid')) {

													} else {
														$.gritter
																.add({
																	title : 'Fill Fields',
																	text : 'Oops Please Fill All Fields'
																});
														return false;
													}

													var str = $(this)
															.serialize();

													$
															.ajax({
																url : "../Ajax/newenquiry.jsp",
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
																					text : 'new Enquiry Added'
																				});
																		window.location
																				.reload();
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
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>