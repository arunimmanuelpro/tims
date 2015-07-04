<%@page import="general.GetInfoAbout"%>
<%@page import="security.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="com.sun.xml.internal.messaging.saaj.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>
<%
	request.setAttribute("title", "Your Profile");
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMMM-yyyy");
	Date today = new Date();
	String td = sdf.format(today);
%>
<%@include file="Common/Header.jsp"%>

<%
	Connection con1 = DbConnection.getConnection();
	Statement s = con1.createStatement();
	String sql = "SELECT * FROM `employee` where `id` = '"+ request.getAttribute("userid") + "' and TerminationId is NULL LIMIT 1";
	ResultSet rs1 = s.executeQuery(sql);
	rs1.next();
	SecureNew sn = new SecureNew();

	//Get Proof Details
	sql = "SELECT * FROM `proof` WHERE `empid` = '"+ request.getAttribute("userid") + "' order by id";
	s = con1.createStatement();
	ResultSet proofdetails = s.executeQuery(sql);

	//Get Bank Details
	sql = "SELECT * FROM `bankdetails` WHERE `empid` = '"+ request.getAttribute("userid") + "' order by id";
	s = con1.createStatement();
	ResultSet bankdetails = s.executeQuery(sql);
%>

<!--main content start-->
<section id="main-content">

	<section class="wrapper">
		<!-- page start-->
		<div class="row">
			<aside class="profile-nav col-lg-3">
				<section class="panel">
					<div class="user-heading round">
						<a href="#"> <img src="GetPicture.jsp" alt="">
						</a>
						<h1><%=request.getAttribute("user")%></h1>
						<span><%=request.getAttribute("userid")%> | <%=request.getAttribute("level")%></span>
					</div>

					<ul class="nav nav-pills nav-stacked">

						<li class="active"><a href="#new.jsp" data-toggle="emp">
								<i class="fa fa-user"></i> Profile
						</a></li>
						<!-- <li><a href="#perscontact" data-toggle="modal"> 
								<i class="fa fa-edit"></i> Edit Personal details
						</a></li>
						<li><a href="#contact" data-toggle="modal"> 
								<i class="fa fa-edit"></i> Edit contact details
						</a></li> -->
						<li><a href="#changepicmodal" data-toggle="modal"> 
							<i class="fa fa-edit"></i> Change Picture
						</a></li>
						<li><a href="#changepass" data-toggle="modal"> 
							<i class="fa fa-edit"></i> Change Password
						</a></li>

					</ul>

				</section>
			</aside>
			<aside class="profile-info col-lg-9">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Employee summary</h4>
						<span><%=td %></span>
					</header>
					<!-- <div class="panel-body">
						<ul class="summary-list">
							<li><a href="javascript:;"> <i
									class=" fa fa-shopping-cart text-primary"></i> 1 Purchase
							</a></li>
							<li><a href="javascript:;"> <i
									class="fa fa-envelope text-info"></i> 15 Emails
							</a></li>
							<li><a href="javascript:;"> <i
									class=" fa fa-picture text-muted"></i> 2 Photo Upload
							</a></li>
							<li><a href="javascript:;"> <i
									class="fa fa-tags text-success"></i> 19 Sales
							</a></li>
							<li><a href="javascript:;"> <i
									class="fa fa-microphone text-danger"></i> 4 Audio
							</a></li>
						</ul>
					</div> -->
				</section>
				<%
								//SecureNew sn = new SecureNew();
								int terminated = rs1.getInt("TerminationId"); 
								String Fname = rs1.getString("FirstName");
								String Lname = rs1.getString("LastName");
								//String Term = " (Past Employee)";
								String Name;
								//if(terminated > 0 ){
								//	Name = Fname + " " + Lname + " " + Term;
								//}else{
									Name = Fname + " " + Lname;
								//}
								//out.print(Name);
							%>
				
				<section class="panel">
					<div class="panel-body bio-graph-info">
						<h1>Bio Graph</h1>
						<div class="row">
							<div class="bio-row">
								<span>
									<span>First Name </span>:<%=(rs1.getString("FirstName")==null?"":rs1.getString("FirstName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Last Name </span>:
									<%=(rs1.getString("LastName")==null?"":rs1.getString("LastName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Location </span>:
									<%=(rs1.getString("City")==null?"":rs1.getString("City")+",")%>
									<%=(rs1.getString("State")==null?"":rs1.getString("State")+",")%>
									<%=(rs1.getString("ZipCode")==null?"":rs1.getString("ZipCode")+",")%>
									<%=(rs1.getString("Country")==null?"":rs1.getString("Country")+".")%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Nationality</span>:
									<%=(rs1.getString("Nationality")==null?"":rs1.getString("Nationality"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Date of Birth</span>:
									<%=(rs1.getString("DateofBirth")==null?"":rs1.getString("DateofBirth"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Mobile </span>:
									<%=(rs1.getString("Mobile")==null?"":rs1.getString("Mobile"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Official Email</span>:
									<%
										String wemail = rs1.getString("WorkEmail");
										if(wemail!=null){
											out.print(sn.decrypt(wemail));
										}
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Personal Email</span>:
									<%
										String pemail = rs1.getString("PersonalEmail");
										if(pemail!=null){
											out.print(sn.decrypt(pemail));
										}
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Blood Group </span>:
									<%=(rs1.getString("Bloodgroup")==null?"":rs1.getString("Bloodgroup"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Home Phone </span>:
									<%
										String hphone = rs1.getString("HomeTelephone");
										if(hphone!=null){
											out.print(sn.decrypt(hphone));
										}
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Emergency Contact</span>:
									<%
										String wphone = rs1.getString("WorkTelephone");
										if(wphone!=null){
											out.print(sn.decrypt(wphone));
										}
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Date of Joining</span>:
									<%=(rs1.getString("JoinDate")==null?"":rs1.getString("JoinDate"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>PF Number</span>:
									<%=(rs1.getString("pfnumber")==null?"":rs1.getString("pfnumber"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>ESIC Number</span>:
									<%=(rs1.getString("esicnumber")==null?"":rs1.getString("esicnumber"))%>
								</span>
							</div>
							<div class="bio-row">
                                <span>
                                    <span>Manager</span>:
                                        <%=GetInfoAbout.getManagerName(rs1.getString("ReportTo"))==null?"":GetInfoAbout.getManagerName(rs1.getString("ReportTo"))%>
                                </span>
                            </div>
                            <div class="bio-row">
                                <span>
                                    <span>Mode of Role</span>:
                                        <%=(rs1.getString("ModeOfRole")==null?"":rs1.getString("ModeOfRole"))%>
                                </span>
                            </div>
							
							
							<%
								//Contract
									if(rs1.getString("ContractStart")!=null || rs1.getString("ContractEnd")!=null){
							%>
							<div class="bio-row">
								<span>
									<span>Contract Start</span>:
										<%=(rs1.getString("ContractStart")==null?"":rs1.getString("ContractStart"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Contract End</span>:
										<%=(rs1.getString("ContractEnd")==null?"":rs1.getString("ContractEnd"))%>
								</span>
							</div>
							<%
								}
								if(terminated > 0 ){
									out.println("<h3 class='text-danger'>Employee has been Terminated</h3>");
								}
							%>
						</div>
					</div>
				</section>
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="fa fa-book"> Your Proof`s</i>
					</h3>
				<!-- 	<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newProof" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form> -->
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Type</th>
								<th>Number</th>
								<th>Valid upto</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (proofdetails.next()) {
							%>
							<tr>
								<td><%=(proofdetails.getString(1)==null?"":proofdetails.getString(1))%></td>
								<td><%=(proofdetails.getString(3)==null?"":proofdetails.getString(3))%></td>
								<td><%=(proofdetails.getString(4)==null?"":proofdetails.getString(4))%></td>
								<td><%=(proofdetails.getString(5)==null?"":proofdetails.getString(5))%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="fa fa-book"> Your Bank Details</i>
					</h3>
				<!-- 	<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newBankDetail" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form> -->
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Bank Name</th>
								<th>Account Holder Name</th>
								<th>Bank Location</th>
								<th>Account Number</th>
								<th>IFCS Code</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (bankdetails.next()) {
							%>
							<tr>
								<td><%=(bankdetails.getString(1)==null?"":bankdetails.getString(1))%></td>
								<td><%=(bankdetails.getString(2)==null?"":bankdetails.getString(2))%></td>
								<td><%=(bankdetails.getString(4)==null?"":bankdetails.getString(4))%></td>
								<td><%=sn.decrypt((bankdetails.getString(5)==null?"":bankdetails.getString(5)))%></td>
								<td><%=sn.decrypt((bankdetails.getString(6)==null?"":bankdetails.getString(6)))%></td>
								<td><%=(bankdetails.getString(7)==null?"":bankdetails.getString(7))%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End --> 
			</aside>
		</div>

		
		<div aria-hidden="true" aria-labelledby="picm" role="dialog"
			tabindex="-1" id="changepicmodal" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Change picture</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Change Picture</header>
									<div class="panel-body">
										<form class="form-horizontal" enctype="multipart/form-data"
											action="changepic.jsp" method="POST">
											<div class="form-group">
												<label for="Photo" class="col-lg-3 control-label">Photo
													Upload</label>
												<div class="col-lg-8">
													<input type="file" id="picfile" name="picfile"
														data-requried="true" data-notblank="true">
													<p class="help-block">
														Upload photo not more than 60KB.</span>
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-danger">Update</button>
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
		<div aria-hidden="true" aria-labelledby="picm" role="dialog"
			tabindex="-1" id="changepass" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Change password</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<div class="panel-body">
										<form class="form-horizontal" id="changepassw">
											<div class="form-group">
												<label for="current_password" class="col-lg-4 control-label">Current
													Password:</label>
												<div class="col-lg-8">
													<input type="password" class="form-control" id="password"
														name="currpass" placeholder="Current password">
												</div>
											</div>
											<div class="form-group">
												<label for="password" class="col-lg-4 control-label">New
													Password:</label>
												<div class="col-lg-8">
													<input type="password" class="form-control"
														id="new_password" name="newpass"
														placeholder="Must be Eyeopen webmail Password">
												</div>
											</div>
										<!-- 	<div class="password-meter">
												<div class="password-meter-message"></div>
												<div class="password-meter-bg">
													<div class="password-meter-bar"></div>
												</div>
											</div> -->
											<div class="form-group">
												<label for="password_confirm" class="col-lg-4 control-label">Confirm
													Password:</label>
												<div class="col-lg-8">
													<input type="password" class="form-control"
														id="password_confirm" name="confpass"
														placeholder="Re-enter Eyeopen webmail Password">

												</div>
											</div>
										<!-- 	<input name="change_password[id]" value="2"
												id="change_password_id" type="hidden" /> 
												<input name="change_password[_csrf_token]"
												value="66dbd4dc532ad1c9dd668e5e86235136"
												id="change_password__csrf_token" type="hidden" /> -->
											<div class="form-group">
												<div class="col-lg-offset-4 col-lg-10">
													<div class="submitBlock">
														<input type="submit" class="btn btn-danger" value="Submit" />
													</div>
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
								$("#contactup")
										.submit(
												function() {

													$('#contactup').parsley(
															'validate');
													if (!$('#contactup')
															.parsley('isValid')) {
														$.gritter
																.add({
																	title : 'Fill Fields',
																	text : 'Oops Please Fill All Fields'
																});
														return false;
													} else {

													}

													var str = $(this)
															.serialize();

													$
															.ajax({
																url : "<%=request.getContextPath()%>/Ajax/editContactDetails.jsp",
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
								//End Contact Details Update

							
								//Change Password start
								$("#changepassw")
										.submit(
												function() {
													
													$('#changepassw').parsley('validate');
													if (!$('#changepassw').parsley('isValid')) {
														$.gritter.add({
															title : 'Fill Fields',
															text : 'Oops Please Fill All Fields'
														});
														return false;
													} else {
													}

												/* 	$(document).ready(function () {
													    // validate signup form on keyup and submit
													    $("#changepassw").validate({
													        errorClass: 'jqueryError',
													        rules: {
													            "change_password[password]": {
													                required: true,
													                minlength: 8,
													                password: false
													            },
													            "change_password[new_password]": {
													                required: true,
													                minlength: 8,
													                password: true
													            },
													            "change_password[password_confirm]": {
													                required: true,
													                equalTo: "#new_password",
													                password: false
													            }
													        },
													        messages: {
													            "change_password[password]": {
													                required: "Enter your current password",
													                minlength: "Enter at least {0} characters"
													            },
													            "change_password[new_password]": {
													                required: "Enter your new password",
													                minlength: "Enter at least {0} characters"
													            },
													            "change_password[password_confirm]": {
													                required: "Repeat your password",
													                equalTo: "Enter the same password as above"
													            }
													        },
													        // the errorPlacement has to take the table layout into account
													        errorPlacement: function (error, element) {
													            error.prependTo(element.parent().next());
													        },
													        // specifying a submitHandler prevents the default submit, good for the demo
													        submitHandler: function (form) {
													            alert("submitted!");
													            return false;
													        },
													        // set this class to error-labels to indicate valid fields
													        success: function (label) {
													            // set &nbsp; as text for IE
													            label.html("&nbsp;").addClass("jqueryChecked");
													        }
													    });
												});  */
												//alert("change password action start");
													var str = $(this)
															.serialize();

													$
															.ajax({
																url : "<%=request.getContextPath()%>/Ajax/newPassword.jsp",
																type : "GET",
																data : str,
																success : function(
																		data,
																		textStatus,
																		jqXHR) {
																	if (data == 1) {
																		$.gritter
																				.add({
																					title : 'Success',
																					text : 'Password Changed Successfully'
																				});
																		$("#changepass").hide();
																		//window.location.reload(true);
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
																	alert("Sorry, Error."
																			+ errorThrown);
																	$.gritter
																			.add({
																				title : 'Sorry',
																				text : 'Some Error Occured, Please Try Again.'
																			});

																}
															});
													return false;

												});
								//End Change Password

								//new bank Details Update Start
								$("#newbankform")
										.submit(
												function() {

													$('#newbankform').parsley(
															'validate');
													if (!$('#newbankform')
															.parsley('isValid')) {
														$.gritter
																.add({
																	title : 'Fill Fields',
																	text : 'Oops Please Fill All Fields'
																});
														return false;
													} else {

													}

													var str = $(this)
															.serialize();

													$
															.ajax({
																url : "<%=request.getContextPath()%>/Ajax/newBankDetails.jsp",
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
								//End new Bank Details Update

								//new Proof Details Update Start
								$("#newProofForm")
										.submit(
												function() {

													$('#newProofForm').parsley(
															'validate');
													if (!$('#newProofForm')
															.parsley('isValid')) {
														$.gritter
																.add({
																	title : 'Fill Fields',
																	text : 'Oops Please Fill All Fields'
																});
														return false;
													} else {

													}

													var str = $(this)
															.serialize();

													$
															.ajax({
																url : "<%=request.getContextPath()%>/Ajax/newProof.jsp",
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
								//End new Proof Details Update

							});
		</script>

		<!-- page end-->
	</section>
</section>
<%
   rs1.close();
   s.close();
   con1.close();
%>
<%@include file="Common/Footer.jsp" %>