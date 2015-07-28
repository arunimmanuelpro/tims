
<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>

<%request.setAttribute("title", "Student"); %>
<%@include file="../Common/Header.jsp"%>
<%
		if(userroles.contains("view_students") || userroles.contains("add_student")){
			
		}else{
			response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
			return;
		}
		%>
<%
	Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";

	//Get student
	sql = "SELECT * FROM `students` order by id DESC	";
	s = con.createStatement();
	ResultSet studetails = s.executeQuery(sql);
	String stuid = request.getAttribute("userid").toString();
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">

		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-folder-open"> Students</i>
					</h3>
					<%if(userroles.contains("add_student")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#studentdetails" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%} %>
				</div>
				<section class="panel">
					<table class="table table-striped border-top" id="sample_3"
						class="dtable">
						<thead>
							<tr>
								<th>#</th>
								<th>Name</th>
								<th>Mobile</th>
								<th>Join Date</th>
								<th>Batch ID</th>
								<th>Status</th>
								<th>Edit</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (studetails.next()) {
							%>
							<tr>
								<td><%=(studetails.getString(1)==null?"":studetails.getString(1))%></td>
								<td><%=(studetails.getString("fname")==null?"":studetails.getString("fname"))%>
									<%=(studetails.getString("lname")==null?"":studetails.getString("lname"))%></td>
								<td><%=(studetails.getString("Mobile")==null?"":studetails.getString("Mobile"))%></td>
								<td><%=(studetails.getString("joindate")==null?"":studetails.getString("joindate"))%></td>
								<td><%=studetails.getString("batchid")==null?"NOT ASSIGNED":studetails.getString("batchid")%></td>
								<td><%=(studetails.getString("status")==null?"":studetails.getString("status"))%>
								<td><a class="btn btn-info btn-xs"
									href="profile.jsp?id=<%=studetails.getString(1)%>"> <i
										class="icon-archive">View </i>
								</a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="studentdetails" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Student details</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Student details</header>
									<div class="panel-body">

										<form class="form-horizontal" id="newstudentadd"
											data-validate="parsley">
											<div class="form-group">
												<label for="firstname" class="col-lg-3 control-label">First	Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="firstname" name="firstname"
														placeholder="FirstName" type="text" data-required="true"
														data-notblank="true" data-rangelength="[1,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="lastname" class="col-lg-3 control-label">Last
													Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="lastname" name="lastname"
														placeholder="LastName" type="text" data-required="true"
														data-notblank="true" data-rangelength="[1,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="mobile" class="col-lg-3 control-label">Mobile</label>
												<div class="col-lg-8">
													<input class="form-control" id="mobile" name="mobile"
														placeholder="Mobile Number" type="text"
														data-required="true" data-notblank="true"
														data-type="phone">
												</div>
											</div>
											<div class="form-group">
												<label for="email" class="col-lg-3 control-label">Email</label>
												<div class="col-lg-8">
													<input class="form-control" id="email" name="email"
														placeholder="Email Address" type="text"
														data-required="true" data-notblank="true"
														data-type="email">
												</div>
											</div>
											<div class="form-group">
												<label for="addresline1" class="col-lg-3 control-label">Address
													Line1</label>
												<div class="col-lg-8">
													<input class="form-control" id="addresline1"
														name="addresline1" placeholder="Addres Line1" type="text"
														data-required="true" data-notblank="true"
														data-rangelength="[4,20]">
												</div>
											</div>
											<div class="form-group">
												<label for="addresline2" class="col-lg-3 control-label">Address
													Line2</label>
												<div class="col-lg-8">
													<input class="form-control" id="addressline2"
														name="addresline2" placeholder="Addres Line2" type="text"
														data-rangelength="[1,150]">
												</div>
											</div>
											<div class="form-group">
												<label for="city" class="col-lg-3 control-label">City</label>
												<div class="col-lg-8">
													<input class="form-control" id="city" name="city"
														placeholder="City" type="text" data-required="true"
														data-notblank="true" data-rangelength="[1,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="state" class="col-lg-3 control-label">State</label>
												<div class="col-lg-8">
													<input class="form-control" id="state" name="state"
														placeholder="State" type="text" data-required="true"
														data-notblank="true" data-rangelength="[1,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="zipcode" class="col-lg-3 control-label">ZipCode</label>
												<div class="col-lg-8">
													<input class="form-control" id="zipcode" name="zipcode"
														placeholder="Zip Code" type="text" data-required="true"
														data-notblank="true" data-type="number"
														data-rangelength="[6,10]">
												</div>
											</div>
											<div class="form-group">
												<label for="country" class="col-lg-3 control-label">Country</label>
												<div class="col-lg-8">
													<select id="country" name="country" class="form-control"
														data-required="true" data-notblank="true">
														<option value="">----select------</option>
														<option value="India">India</option>
														<option value="USA">U.S.A</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="homephone" class="col-lg-3 control-label">Home Phone</label>
												<div class="col-lg-8">
													<input class="form-control" id="homephone" name="homephone"
														placeholder="Home Phone" type="text" data-required="true"
														data-notblank="true" data-type="phone">
												</div>
											</div>
											<div class="form-group">
												<label for="dob" class="col-lg-3 control-label">Date Of Birth</label>
												<div class="col-lg-8">
													<input class="form-control datepicker dobd" id="dob" name="dob"
														placeholder="Date Of Birth" type="text"
														data-required="true" data-notblank="true"
														data-type="dateIso" readonly>
												</div>
											</div>
											<script type="text/javascript">
												$(document).ready(function(){
													$(".dobd").datepicker({
														dateFormat : "yy-mm-dd",														
												        changeMonth: true,
												        changeYear: true
													});

												});
											</script>
											<div class="form-group">
												<label for="bloodgroup" class="col-lg-3 control-label">Blood Group</label>
												<div class="col-lg-8">
													<select id="bloodgroup" name="bloodgroup" class="form-control"
														data-required="true" data-notblank="true">
														<option>O+</option>
														<option>O-</option>
														<option>A+</option>
														<option>A-</option>
														<option>B+</option>
														<option>B-</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="gender" class="col-lg-3 control-label">Gender</label>
												<div class="col-lg-8">
													<input type="radio" class="form-controle" data-required="true" name="gender" value="Male">Male
													<input type="radio" class="form-controle" data-required="true" name="gender" value="Female">Female
													<!-- <select id="gender" name="gender" data-required="true"
														data-notblank="true" class="form-control">
														<option>Male</option>
														<option>Female</option>
													</select> -->
												</div>
											</div>
											<div class="form-group">
												<label for="stream" class="col-lg-3 control-label">Stream</label>
												<div class="col-lg-8">
													<input class="form-control" id="stream" name="stream"
														placeholder="Stream" type="text" data-required="true"
														data-notblank="true" data-rangelength="[4,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="qualification" class="col-lg-3 control-label">Qualification</label>
												<div class="col-lg-8">
													<input class="form-control" id="qualification"
														name="qualification" placeholder="Qualification"
														type="text" data-required="true" data-notblank="true"
														data-rangelength="[4,15]">
												</div>
											</div>
											<div class="form-group">
												<label for="totalfees" class="col-lg-3 control-label">Total	Fees</label>
												<div class="col-lg-8">
													<input class="form-control" id="totalfees" name="totalfees"
														data-required="true" data-notblank="true"
														data-type="number" placeholder="Total Fees" type="text"
														data-rangelength="[3,10]">
												</div>
											</div>
											<div class="form-group">
												<label for="courseid" class="col-lg-3 control-label">Course</label>
												<div class="col-lg-8"> 
													<select	id="courseid" name="courseid" class="form-control"
													data-required="true" data-notblank="true">
													<option value="">---select----</option>
													<%
														Connection con13 = DbConnection.getConnection();
														Statement s13 = con13.createStatement();
														ResultSet rs13 = s13.executeQuery("SELECT * FROM `coursedetails` ORDER BY `id`");
														while (rs13.next()) {
													%>
															<option	value="<%=(rs13.getString(1)==null?"":rs13.getString(1))%>"><%=(rs13.getString(2)==null?"":rs13.getString(2))%></option>
													<%
														}
													%>
												</select>
												</div>
											</div>
											<div class="modal-footer">
                                				<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                                    			<button class="btn btn-success" type="submit">Save changes</button>
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

								$("#newstudentadd")
										.submit(
												function() {

													$('#newstudentadd')
															.parsley('validate');

													if ($('#newstudentadd')
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
																url : "../Ajax/newStudent.jsp",
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
							});
		</script>

	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>