
<%@page import="java.sql.SQLException"%>
<%@page import="security.SecureNew"%>
<%@page import="general.GetInfoAbout"%>
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
%>
<%@include file="../Common/Header.jsp"%>

<%
	SecureNew sn = new SecureNew();
	Connection con1;
	ResultSet rs1 = null;
	ResultSet proofdetails = null;
	ResultSet bankdetails = null;
	Statement s = null;
	String emid = request.getParameter("id");
	session.setAttribute("editEmpId", emid);
	if(emid==null){
		response.sendRedirect(request.getContextPath()+"/error.jsp");
		return;
	}else if(emid.isEmpty()){
		response.sendRedirect(request.getContextPath()+"/error.jsp");
		return;
	}else{
		con1 = DbConnection.getConnection();
		s = con1.createStatement();
		String sql = "SELECT * FROM `employee` where `id` = '"+emid + "' and TerminationId is NULL LIMIT 1";
 		rs1 = s.executeQuery(sql);
 		
 		//Get Proof Details
 		sql = "SELECT * FROM `proof` WHERE `empid` = '"	+ emid + "' order by id";
 		s = con1.createStatement();
 		proofdetails = s.executeQuery(sql);

 		//Get Bank Details
 		sql = "SELECT * FROM `bankdetails` WHERE `empid` = '" + emid + "' order by id";
 		s = con1.createStatement();
 		bankdetails = s.executeQuery(sql); 		
	}
	if(rs1.next()){	
	}else{
		response.sendRedirect(request.getContextPath()+"/error.jsp");
	}
%>
<!--main content start-->

<section id="main-content">

	<section class="wrapper">
		<!-- page start-->
		<div class="row">
			<aside class="profile-nav col-lg-3">
				<section class="panel">
					<div class="user-heading round">
						<a href="#"> <img src="<%=request.getContextPath() %>/GetPicture.jsp?empid=<%=emid %>" alt="">
						</a>
						<h1><%=emid%></h1>						
						<h1>

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
								out.print(Name);
							%>
						</h1>
					</div>

					<ul class="nav nav-pills nav-stacked">

						<li>
							<a href="#profile.jsp?id=<%=emid%>" data-toggle="emp"> 
								<i class="fa fa-user"></i> Profile
							</a>
						</li>
						<li><a href="editEmpAdmin.jsp?id=<%=emid%>"> 
							<i class="fa fa-edit"></i> Edit employee details
						</a></li>
						<li><a href="#perscontact" data-toggle="modal"> 
								<i class="fa fa-edit"></i> Edit Personal details
						</a></li>
						<li><a href="#contact" data-toggle="modal"> 
								<i class="fa fa-edit"></i> Edit contact details
						</a></li>
						<%
							if(terminated > 0 ){} else{
						%>
								<li><a href="termination.jsp?id=<%=emid%>" data-toggle="emp">
										<i class="fa fa-sign-out"></i>Relieve Employee
								</a></li>
						<%
							}
						%>
						<li><a href="<%=request.getContextPath() %>/Employee/" data-toggle="modal"> 
								<i class="fa fa-edit"></i> Go Back
						</a></li>
					</ul>

				</section>
			</aside>

<!-- Personal Details Modal Start -->
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="perscontact" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Personal Details</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Personal Details </header>
									<div class="panel-body">
										<form class="form-horizontal" data-validate="parsley"
											id="perup">
											<div class="form-group">
												<label for="FirstName" class="col-lg-3 control-label">First
													Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="First Name"
														name="FirstName" placeholder="First Name"
														value="<%=(rs1.getString("FirstName")==null?"":rs1.getString("FirstName"))%>"
														type="text" data-required="true" data-rangelength="[4,50]"
														data-notblank="true">
												</div>
											</div>
											<div class="form-group">
												<label for="LastName" class="col-lg-3 control-label">Last
													Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="Last Name" name="LastName"
														data-required="true"
														value="<%=(rs1.getString("LastName")==null?"":rs1.getString("LastName"))%>"
														placeholder="Last Name" type="text" data-notblank="true">
												</div>
											</div>
											<div class="form-group">
												<label for="Gender" class="col-lg-3 control-label">Gender:</label>
												<div class="col-lg-8">
													<select id="gender" class="form-control" name="gender"
														data-required="true" data-notblank="true">
														<%String gender = rs1.getString("Gender"); %>
														<option value="">---Select---</option>
														<%
															if(gender==null || gender.isEmpty()){
														%>	
															<option value="Male">Male</option>
															<option value="Female">Female</option>
														<%	} else { %>
															<option value="Male" <%if(gender.equals("Male"))out.println("Selected"); %>>Male</option>
	                                                        <option value="Female" <%if(gender.equals("Female"))out.println("Selected"); %>>Female</option>
														<%} %>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="Marital Status" class="col-lg-3 control-label">Marital
													Status:</label>
												<div class="col-lg-8">
													<select id="MaritalStatus" class="form-control"
														name="MaritalStatus" data-required="true"
														data-notblank="true">
														<%String status = rs1.getString("MaritalStatus"); %>
														<option value="">---Select---</option>
														<%
														  if(status==null || status.isEmpty()){
                                                        %>  
                                                            <option value="Single">Single</option>
                                                            <option value="Married">Married</option>
                                                        <%}else{ %>
														    <option value="Single" <%if(status.equals("Single"))out.println("Selected"); %>>Single</option>
														    <option value="Married" <%if(status.equals("Married"))out.println("Selected"); %>>Married</option>
														<%} %>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="Dateofbirth" class="col-lg-3 control-label">Date
													of Birth:</label>
												<div class="col-lg-8">
													<input class="form-control datep" id="dob" name="dob"
														value="<%=(rs1.getString("DateOfBirth")==null?"":rs1.getString("DateOfBirth"))%>"
														data-required="true" placeholder="Date of Birth"
														type="text" data-notblank="true" data-type="dateIso"
														readonly>
												</div>
											</div>
											<script>
												$(function() {
													$(".datep")
															.datepicker(
																	{
																		maxDate : "-15Y",
																		dateFormat : "yy-mm-dd",
																		changeMonth : true,
																		changeYear : true
																	});
												});
											</script>
											<div class="form-group">
												<label for="Nationality" class="col-lg-3 control-label">Nationality:</label>
												<div class="col-lg-8">
													<input class="form-control" id="Nationality"
														data-required="true" name="Nationality"
														value="<%=(rs1.getString("Nationality")==null?"":rs1.getString("Nationality"))%>"
														placeholder="Nationality" type="text" data-notblank="true">
												</div>
											</div>
											<div class="form-group">
												<label for="Bloodgroup" class="col-lg-3 control-label">Blood
													Group:</label>
												<div class="col-lg-8">
													<select id="Bloodgroup" class="form-control"
														name="Bloodgroup" data-required="true"
														data-notblank="true">
														<%String blood = rs1.getString("Bloodgroup"); %>
														<option value="">---Select---</option>
														<% if(blood==null || blood.isEmpty()){ %>
														<option value="O+ve">O+ve</option>
                                                        <option value="O-ve">O-ve</option>
                                                        <option value="A+ve">A+ve</option>
                                                        <option value="A-ve">A-ve</option>
                                                        <option value="B+ve">B+ve</option>
                                                        <option value="B-ve">B-ve</option>
                                                        <option value="AB+ve">AB+ve</option>
                                                        <option value="AB-ve">AB-ve</option>
                                                        <option value="A1B+ve">A1B+ve</option>
                                                        <option value="A2B+ve">A2B+ve</option>														
														<% }else{ %>
														<option value="O+ve" <%if(blood.equals("O+ve"))out.println("Selected"); %>>O+ve</option>
														<option value="O-ve" <%if(blood.equals("O-ve"))out.println("Selected"); %>>O-ve</option>
														<option value="A+ve" <%if(blood.equals("A+ve"))out.println("Selected"); %>>A+ve</option>
														<option value="A-ve" <%if(blood.equals("A-ve"))out.println("Selected"); %>>A-ve</option>
														<option value="B+ve" <%if(blood.equals("B+ve"))out.println("Selected"); %>>B+ve</option>
														<option value="B-ve" <%if(blood.equals("B-ve"))out.println("Selected"); %>>B-ve</option>
														<option value="AB+ve" <%if(blood.equals("AB+ve"))out.println("Selected"); %>>AB+ve</option>
														<option value="AB-ve" <%if(blood.equals("AB-ve"))out.println("Selected"); %>>AB-ve</option>
														<option value="A1B+ve" <%if(blood.equals("A1B+ve"))out.println("Selected"); %>>A1B+ve</option>
														<option value="A2B+ve" <%if(blood.equals("A2B+ve"))out.println("Selected"); %>>A2B+ve</option>
														<% } %>
													</select>
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<a href="profile.jsp" class="btn btn-default">Cancel</a> <input
														type="submit" id="formsubmit" value="Update"
														class="btn btn-primary">
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
<!-- Personal Details Modal End -->

<!-- Contact Details Modal Start -->

<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="contact" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Contact details</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Contact details</header>
									<div class="panel-body">
										<form class="form-horizontal" data-validate="parsley"
											id="contactup">
											<div class="form-group">
												<label for="Mobile" class="col-lg-3 control-label">Mobile</label>
												<div class="col-lg-8">
													<input class="form-control" id="Mobile" name="Mobile"
														data-required="true" placeholder="Mobile" type="text"
														value="<%=(rs1.getString("Mobile")==null?"":rs1.getString("Mobile"))%>"
														data-type="phone" data-notblank="true">
												</div>
											</div>
											<div class="form-group">
												<label for="inputEmail1" class="col-lg-3 control-label">Work
													Email</label>
												<div class="col-lg-8">
													<%String wemail = rs1.getString("WorkEmail"); %>
													<input class="form-control" id="WorkEmail" name="WorkEmail"
														data-required="true" placeholder="Work Email" type="text"
														value="<%if(wemail!=null ) out.print(sn.decrypt(wemail));%>"
														data-type="email" data-notblank="true"> <span
														class="help-block"> Work Email Address.</span>
												</div>
											</div>
											<div class="form-group">
												<label for="inputEmail2" class="col-lg-3 control-label">Personal
													Email</label>
												<div class="col-lg-8">
													<input class="form-control" id="EmailAddress"
														data-required="true" data-type="email"
														data-notblank="true" name="EmailAddress"
														placeholder="Personal Email" type="text"
														value="<%String pemail = rs1.getString("PersonalEmail");
														  if(pemail!=null) out.print(sn.decrypt(pemail));%>">
													<span class="help-block"> Personal Email Address.</span>
												</div>
											</div>
											<div class="form-group">
												<label for="Addressline1" class="col-lg-3 control-label">Address
													Line1:</label>
												<div class="col-lg-8">
													<input class="form-control" id="AddressLine1"
														data-required="true" data-notblank="true"
														name="AddressLine1" placeholder="AddressLine1" type="text"
														value="<%String addr1 = rs1.getString("AddressLine1");%>" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="AddressLine2" class="col-lg-3 control-label">Address
													Line2:</label>
												<div class="col-lg-8">
													<input class="form-control" id="AddressLine2"
														data-required="true" data-notblank="true"
														value="<%String addr2 = rs1.getString("AddressLine2");
			if(addr2!=null) out.print(sn.decrypt(addr2));%>"
														name="AddressLine2" placeholder="Address Line2"
														type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="City" class="col-lg-3 control-label">City:</label>
												<div class="col-lg-8">
													<input class="form-control" id="City" name="City"
														data-required="true" data-notblank="true"
														placeholder="City" type="text"
														value="<%=(rs1.getString("City")==null?"":rs1.getString("City"))%>">
												</div>
											</div>
											<div class="form-group">
												<label for="State" class="col-lg-3 control-label">State</label>
												<div class="col-lg-8">
													<input class="form-control" id="State" name="State"
														data-required="true" data-notblank="true"
														placeholder="State" type="text"
														value="<%=(rs1.getString("State")==null?"":rs1.getString("State"))%>">
												</div>
											</div>
											<div class="form-group">
												<label for="ZipCode" class="col-lg-3 control-label">ZipCode:</label>
												<div class="col-lg-8">
													<input class="form-control" id="ZipCode" name="ZipCode"
														data-required="true" data-notblank="true"
														data-rangelength="[5,10]" placeholder="Zip Code"
														type="text"
														value="<%=(rs1.getString("ZipCode")==null?"":rs1.getString("ZipCode"))%>">
												</div>
											</div>
											<div class="form-group">
												<label for="Country" class="col-lg-3 control-label">Country:</label>
												<div class="col-lg-8">
													<select id="Country" name="Country" class="form-control"
														data-required="true" data-notblank="true">
														<%String country = rs1.getString("Country"); 
														  if(country==null || country.isEmpty()){
														%>
														<option value="India">India</option>
                                                        <option value="Australia">Australia</option>
														<%}else{ %>
														<option value="India" <%if(country.equals("India"))out.println("Selected"); %>>India</option>
														<option value="Australia" <%if(country.equals("Australia"))out.println("Selected"); %>>Australia</option>
														<%} %>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label for="HomeTelephone" class="col-lg-3 control-label">Home
													phone:</label>
												<div class="col-lg-8">
													<input class="form-control" id="homeTelephone"
														data-required="true" data-type="phone"
														data-notblank="true" name="homeTelephone"
														value="<%String hp = rs1.getString("HomeTelephone");
			if(hp!=null) out.print(sn.decrypt(hp));%>"
														placeholder="Home Phone" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="workphone" class="col-lg-3 control-label">Emergency
													Contact</label>
												<div class="col-lg-8">
													<input class="form-control" id="wphone" name="workphone"
														data-required="true" data-type="phone"
														data-notblank="true" placeholder="Emergency Contact"
														type="text"
														value="<%String wp = rs1.getString("WorkTelephone");
			if(wp!=null) out.print(sn.decrypt(wp));%>">
												</div>
											</div>
											<div class="form-group">
												<label for="pancard" class="col-lg-3 control-label">Pan
													Card No.:</label>
												<div class="col-lg-8">
													<input class="form-control" id="pancard" name="pancard"
														data-required="true" data-rangelength="[5,15]"
														data-notblank="true" placeholder="Pancard Number"
														type="text"
														value="<%String pan4 = rs1.getString("Pancardnumber");
			if(pan4!=null) out.print(sn.decrypt(pan4));%>">
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

<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="empcontact" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Employment details</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Employment details</header>
									<div class="panel-body">
										<form class="form-horizontal" data-validate="parsley">
											<div class="form-group">
												<label for="JoinDate" class="col-lg-3 control-label">Join Date:</label>
												<div class="col-lg-8">
													<input class="form-control-datepicker" id="joindate"
														name="Joindate" placeholder="YYYY-MM-DD" type="text"
														data-requried="true" data-notblank="true" readonly>
												</div>
											</div>
											<div class="form-group">
												<label for="Contractstart" class="col-lg-3 control-label">Contract Start:</label>
												<div class="col-lg-8">
													<input class="form-control-datepicker" id="contractstart"
														name="contractstart" placeholder="YYYY-MM-DD" type="text"
														readonly>
												</div>
											</div>
											<div class="form-group">
												<label for="ContractEnd" class="col-lg-3 control-label">Contract End:</label>
												<div class="col-lg-8">
													<input class="form-control" id="contractend"
														name="contractend" placeholder="YYYY-MM-DD" type="text"
														readonly>
												</div>
											</div>
											<div class="form-group">
												<label for="Basicpay" class="col-lg-3 control-label">Basic Pay</label>
												<div class="col-lg-8">
													<input class="form-control" id="Basicpay" name="Basicpay"
														type="text" data-requried="true" data-notblank="true"
														data-type="number">
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-danger">Create</button>
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
<!-- Contact Details Modal End -->

<!-- Proof Modal start -->
<div aria-hidden="true" aria-labelledby="newproofmodal" role="dialog"
			tabindex="-1" id="newProof" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Add New Proof</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" role="form" id="newProofForm"
							data-validate="parsley">
							<div class="form-group">
								<label class="col-lg-8 control-label" for="type">Proof Type </label> 
								<div class="col-lg-12">
								<select id="type" name="type"
									class="form-control" data-required="true" data-notblank="true">
									<option value="">---select---</option>
									<option value="DrivingLicence">Driving Licence</option>
									<option value="VoterId">Voter Id</option>
									<option value="Passport">Passport</option>
									<option value="RationCard">Ration Card</option>
									<option value="AadhaarCard">Aadhaar Card</option>
								</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="number">Number</label>
								<div class="col-lg-12"> 
								<input type="text"
									class="form-control col-lg-2" id="number" name="number"
									placeholder="Number" data-required="true"
									data-rangelength="[5,15]" data-notblank="true">
								</div>	
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="validupto">Valid Upto</label>
								<div class="col-lg-12"> 
								<input type="text" class="form-control datepicker" id="validupto" name="validupto"
									placeholder="Valid Upto" data-type="dateIso">
								</div>	
							</div>
                            <div class="form-group modal-footer">
								<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>								
								<button class="btn btn-success" type="submit">Create</button>	
							</div>							
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- Proof Modal End -->

<!-- Bank Details Modal start -->
<div aria-hidden="true" aria-labelledby="newBankDetailmodal"
			role="dialog" tabindex="-1" id="newBankDetail" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Add New Bank Details</h4>
					</div>
					<div class="modal-body">
						<form class="form-horizontal" id="newbankform"
							data-validate="parsley">
							<div class="form-group">
								<label class="col-lg-8 control-label" for="bankname">Bank Name</label> 
								<div class="col-lg-12"> 
								<input type="text"
									class="form-control" id="bankname" name="bankname"
									placeholder="Bank Name" data-required="true"
									data-notblank="true" data-rangelength="[5,50]">
								</div>	
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="accholder">Acc Holder Name</label>
								<div class="col-lg-12">  
								<input type="text" class="form-control" id="accholdername"
									name="accholdername" placeholder="Acc holder"
									data-required="true" data-notblank="true"
									data-rangelength="[5,50]">
								</div>	
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="bankloacation">Branch Location</label>
								<div class="col-lg-12">  
								<input type="text" class="form-control" id="bankloacation"
									name="bankloacation" placeholder="Bank Loacation"
									data-required="true" data-notblank="true"
									data-rangelength="[3,15]">
								</div>	
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="accnumber">Acc Number</label>
								<div class="col-lg-12"> 
								<input type="text" class="form-control" id="accnumber" name="accnumber"
									placeholder="Acc Number" data-required="true"
									data-type="number" data-notblank="true" data-type="number"
									data-rangelength="[5,25]">
								</div>	
							</div>
							<div class="form-group">
								<label class="col-lg-8 control-label" for="ifsc code">IFSC Code</label>
								<div class="col-lg-12">  
								<input type="text" class="form-control" id="ifsccode" name="ifsccode"
									placeholder="IFSC Code" data-required="true"
									data-rangelength="[3,13]" data-notblank="true">
								</div>	
							</div>
							
							<div class="form-group modal-footer">
                                <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>                               
                                <button class="btn btn-success" type="submit">Add New Bank</button>   
                            </div>							
						</form>
					</div>
				</div>
			</div>
		</div>
<!-- Bank Details End Hers -->

			<aside class="profile-info col-lg-9">

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
										//String wemail = rs1.getString("WorkEmail");
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
										//String pemail = rs1.getString("PersonalEmail");
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
			<%-- 	<section class="panel">
					<section class="panel-body">
						<label for="from">From</label> <input type="text" id="from"
							name="from" /> <label for="to">to</label> <input type="text"
							id="to" name="to" /> <input type="hidden" name="empid"
							id="empid" value="<%=emid %>">
						<button id="getattendance">Get Attendance Details</button>
						<br>
						<div id="success_geta"></div>
					</section>
				</section>
				<script>
					$(function() {
						$("#getattendance").click(function(){
							var from = $("#from").val();
							var to = $("#to").val();
							var empid = $("#empid").val();
														
							$("#getattendance").hide();
							$("#success_geta").load("<%=request.getContextPath() %>/Ajax/getAttendance.jsp?userid=" + empid +"&from=" + from +"&to="+to, function( response, status, xhr ) {
								  if(status="success"){
									  $("#getattendance").show();
								  }
							});
						});
						$("#from").datepicker(
								{
									dateFormat : "yy-mm-dd",
									defaultDate : "+1w",
									changeMonth : true,
									numberOfMonths : 2,
									onClose : function(selectedDate) {
										$("#to").datepicker("option",
												"minDate", selectedDate);
									}
								});
						$("#to").datepicker(
								{
									defaultDate : "+1w",
									dateFormat : "yy-mm-dd",
									changeMonth : true,
									numberOfMonths : 2,
									onClose : function(selectedDate) {
										$("#from").datepicker("option",
												"maxDate", selectedDate);
									}
								});
					});
				</script> --%>
					<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="fa fa-book"> Your Proof`s</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newProof" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
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
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newBankDetail" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
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
								
								//Personal Details Update Start
			$("#perup")
					.submit(
							function() {

								$('#perup').parsley(
										'validate');
								if (!$('#perup').parsley(
										'isValid')) {
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
											url : "<%=request.getContextPath()%>/Ajax/editPersonalDetails.jsp",
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
			//End Personal Details Update
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
								//Emp Termination start
								$("#terminationemp")
										.submit(
												function() {

													$('#terminationemp')
															.parsley('validate');

													if ($('#terminationemp')
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
																url : "../Ajax/newCertificate.jsp",
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
			//Emp Termination is End
			
			
			
		</script>
	</section>
	<!-- page end-->
</section>
<%
try{
	rs1.close();
	proofdetails.close();
	bankdetails.close();
	s.close();
	con1.close();
}catch(SQLException se){
	se.printStackTrace();
}
%>
<%@include file="../Common/Footer.jsp"%>