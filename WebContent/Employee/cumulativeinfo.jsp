
<%@page import="security.SecureNew"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "All Employees");
%>
<%@include file="../Common/Header.jsp"%>

<%
	Connection con = DbConnection.getConnection();	
	Statement s;
	String sql = "";

	//Get Emp
	sql = "SELECT e.id, e.firstname, e.lastname, e.addressline1, e.addressline2, e.city, e.state, e.zipcode, e.bloodgroup, e.pfnumber, e.mobile, e.hometelephone, e.terminationid, b.accnumber FROM employee e LEFT OUTER JOIN bankdetails b ON e.id = b.empid";
	s = con.createStatement();
	ResultSet empdetails = s.executeQuery(sql);
	
	sql = "SELECT * FROM `bankdetails` order by id";
	s = con.createStatement();
	ResultSet bankdetails = s.executeQuery(sql);
	
%>
<%
	if(userroles.contains("view_employees") || userroles.contains("add_employee")){
	
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
						<i class="fa fa-folder-open">Employees Details</i>
					</h3>
				</div>	
				<%-- 	<%
						if(userroles.contains("add_employee")){
					%>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#empdetails" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%
						}
					%> --%>
				
				<section class="panel">
				<div class="row">
				<div class="col-sm-12">
					<div class="table-responsive">
					<table class="display table table-bordered table-striped" id="dynamic-table">
						<thead>
							<tr>
								<th>#</th>
								<th width="15%">Name</th>
								<th width="15%">Residence</th>
								<th>Contact</th>
								<th>Emergency Contact</th>
								<th>Blood Group</th>
								<th>Account Number</th>
								<th>PF Number</th>								
								<!-- <th>Role</th> -->
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								while(empdetails.next()) {
							%>
							<tr class="odd">
								<%
									SecureNew sn = new SecureNew();
									int terminated = empdetails.getInt("TerminationId"); 
									String Fname = empdetails.getString("FirstName");
									String Lname = empdetails.getString("LastName");
									String Term = " (Past Employee)";
									String addr1 = empdetails.getString("AddressLine1");
									addr1 = sn.decrypt(addr1);
									String addr2 = empdetails.getString("AddressLine2");
									addr2 = sn.decrypt(addr2);
									String city = empdetails.getString("City");
									String state = empdetails.getString("State");
									String zipcode = empdetails.getString("ZipCode");
									String emgcont = empdetails.getString("hometelephone");									
									emgcont = sn.decrypt(emgcont);									
									String acctno = empdetails.getString("AccNumber");
									acctno = sn.decrypt(acctno);
									String Name,Address;
									Address = addr1 +" "+ addr2 + " " + city + " " + state + " " +"Pincode: "+zipcode;
									if(terminated > 0 ){
										Name = Fname + " " + Lname + " " + Term;									
									}else{
										Name = Fname + " " + Lname;
									}
								%>
								<td><%=(empdetails.getString(1)==null?"":empdetails.getString(1))%></td>
								<td><%=Name%></td>
								<td><%=Address%></td>
								<td><%=(empdetails.getString("Mobile")==null?"":empdetails.getString("Mobile"))%></td>
								<td><%=emgcont%></td>
								<td><%=(empdetails.getString("Bloodgroup")==null?"":empdetails.getString("Bloodgroup"))%></td>
								<td><%=acctno%></td>
								<td><%=(empdetails.getString("pfnumber")==null?"":empdetails.getString("pfnumber"))%></td>
								<%-- <td><%= %> --%>
								<td><a class="btn btn-info btn-xs"
									href="profile.jsp?id=<%=empdetails.getInt("id")%>"><i
										class="fa fa-info"></i></a></td>
							</tr>
							<%
								}
							%>
							
						</tbody>
					</table>
					</div>
					</div>
					</div>
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="empdetails" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">New Employee details</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading">new Employee details</header>
									<div class="panel-body">
										<form class="form-horizontal" id="newempdetadd"
											data-validate="parsley">
											<div class="form-group">
												<label for="FirstName" class="col-lg-3 control-label">First	Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="First Name"
														data-required="true" data-notblank="true" name="FirstName"
														placeholder="First Name" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="LastName" class="col-lg-3 control-label">Last Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="Last Name" name="LastName"
														data-required="true" data-notblank="true"
														placeholder="Last Name" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="Mobile" class="col-lg-3 control-label">Mobile</label>
												<div class="col-lg-8">
													<input class="form-control" id="Mobile" name="Mobile"
														data-required="true" data-notblank="true"
														data-type="phone" placeholder="Mobile"
														data-mask="+91-999-999-9999" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="JoinDate" class="col-lg-3 control-label">Join Date:</label>
												<div class="col-lg-8">
													   <input class="form-control datep" data-required="true"
														data-notblank="true" data-type="dateIso" id="Joindate"
														name="Joindate" placeholder="YYYY-MM-DD" type="text" readonly>									
																									
														
												</div>
											</div>
											<script>
												$(function() {
													$(".datep")
															.datepicker(
																	{																		
																		dateFormat : "yy-mm-dd",
																		changeMonth : true,
																		changeYear : true
																	});
												});
											</script>
											<div class="form-group">
												<label for="contract" class="col-lg-3 control-label"> Contract </label>
												<div class="col-lg-8">
												<input type = "checkbox" name="contract" id="con" value="con" class="contract">
												</div>
												</div>
												<div class="form-group" id="contractstart">
												<label for="Contractstart" class="col-lg-3 control-label">Contract
													Start:</label>
												<div class="col-lg-8">
													<input class="form-control datepicker"
														name="contractstart" placeholder="YYYY-MM-DD" type="text"
														data-type="dateIso" readonly >
												</div>
											</div>
											<div class="form-group" id="contractend">
												<label for="ContractEnd" class="col-lg-3 control-label">Contract
													End:</label>
												<div class="col-lg-8">
													<input class="form-control datepicker"
														name="contractend" placeholder="YYYY-MM-DD" type="text"
														data-type="dateIso" readonly>
												</div>
											</div>
											<script>
											$(".contract").change(function () {
											    //check if its checked. If checked move inside and check for others value
											    if (this.checked && this.value === "con") {
											        //show a text box
											        $("#contractstart").show();
											        $("#contractend").show();
											    } else if (!this.checked && this.value === "con"){
											        //hide the text box
											        $("#contractstart").hide();
											        $("#contractend").hide();
											    }
											});
											
											</script>
	
											<div class="form-group">
												<label for="Basicpay" class="col-lg-3 control-label">Basic
													Pay</label>
												<div class="col-lg-8">
													<input class="form-control" id="Basicpay" name="Basicpay"
														type="text" data-required="true" data-notblank="true"
														data-type="number">
												</div>
											</div>
											<div class="form-group">
												<label for="roleid" class="col-lg-3 control-label">Role	ID:</label>
												<div class="col-lg-8">
													<select id="roleid" class="form-control" name="roleid"
														data-required="true" data-notblank="true">
														<option value="">---select---</option>
														<%
															s = con.createStatement();																																			ResultSet rs = s.executeQuery("SELECT * FROM `roles` ORDER BY `role_id`");
																																							while (rs.next()) {
														%>
														<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
														<%
															}
														%>

													</select>
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-danger">Create	new Employee</button>
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
			$(document).ready(
							function() {

								//Contact Details Update Start
								$("#newempdetadd")
										.submit(
												function() {

													$('#newempdetadd').parsley('validate');

													if ($('#newempdetadd').parsley('isValid')) {
				
													} else {
														$.gritter
																.add({
																	title : 'Fill Fields',
																	text : 'Oops Please Fill All Fields'
																});
														return false;
													}

													var str = $(this).serialize();

													$
															.ajax({
																url : "../Ajax/editEmpDetails.jsp",
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
																					text : 'new Employee Created'
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