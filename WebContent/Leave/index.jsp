<%@page import="security.SecureNew"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
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
   // Statement s = con1.createStatement();
    PreparedStatement ps,ps1,ps2;
    String sql = "SELECT * FROM `employee` where `id` = '" + request.getAttribute("userid") + "' LIMIT 1";
    ps2 = con.prepareStatement(sql);
    ResultSet rs1 = ps2.executeQuery();
    rs1.next();
    SecureNew sn = new SecureNew();
    String fName = rs1.getString("FirstName");
    String lName = rs1.getString("LastName");
    String eName = fName+" "+lName;
    String wMail = sn.decrypt(rs1.getString("WorkEmail"));    

    
%>

<%
			
	sql = "SELECT * FROM `holiday` WHERE hdate BETWEEN CONCAT(YEAR(CURDATE()),'-01-01') AND CONCAT(YEAR(CURDATE()),'-12-31') order by hdate";
	ps = con.prepareStatement(sql);
	String sql1 = "select (CONCAT(YEAR(CURDATE()),'-01-01'))fromdate, (CONCAT(YEAR(CURDATE()),'-12-31'))todate from dual;";
	ps1 = con.prepareStatement(sql1);
	ResultSet holidaySet = ps.executeQuery(); 
	ResultSet yearSet = ps1.executeQuery();
	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	DateFormat dFormat = new SimpleDateFormat("dd-MMM-yyyy");
%>


<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
		<div class="col-lg-4">
                        <!--widget start-->
                            <aside class="profile-nav alt blue-border">
                              <section class="panel">
                                  <div class="twt-feed alt blue-bg">
                                      <h1><%=eName %></h1>
                                      <p><%=wMail %></p>
                                      <a href="#">
                                          <img src="<%=request.getContextPath() %>/GetPicture.jsp" alt="">
                                      </a>
                                  </div>
                                  <div class="weather-category twt-category">
                                      <ul>
                                          <li class="active"><h5>12</h5>Earned Leave</li>
                                          <li> <h5>5</h5>Taken Leave</li>
                                          <li><h5>7</h5>Balance Leave</li>
                                      </ul>
                                  </div>   
                               <div>
                               <%
                                  	DateFormat df = new SimpleDateFormat("yyyy");                                  	
                               %>
                                <ul class="nav nav-pills nav-stacked">
                                  <li class="active"><a href="javascript:;"><i class="fa fa-list"></i> List of Leaves (<%=df.format(new Date()) %>) <span class="label label-primary pull-right r-activity" >19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leavetype.jsp"> <i class="fa fa-user"></i>Leave Type<span class="label label-primary pull-right r-activity" id="typecount"></span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/assignLeave.jsp"> <i class="fa fa-calendar"></i>Assign Leave<span class="label label-primary pull-right r-activity">19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/myLeave.jsp"> <i class="fa fa-bell-o"></i> My Leave <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leaveList.jsp"> <i class="fa fa-envelope-o"></i> Leave List  <span class="label label-success pull-right r-activity">10</span></a></li>
                                </ul>
                               </div>                                                               
                              </section> 
                         </aside>                             
                              <!--widget end-->
                   </div>
                   
                <aside class="profile-info col-lg-8">    
                   
			<!-- <div class="col-sm-12"> -->
				<!--  One Management Topic Start -->
				<header class="panel-heading summary-head">
					<%
					Date frDate = null;
					Date toDate = null;
					if(yearSet.next()){
						frDate = format1.parse(yearSet.getString(1));
						toDate = format1.parse(yearSet.getString(2));												
					}
					%>
					<h4>List of Leaves</h4>
					<span><%=dFormat.format(frDate) %> to <%=dFormat.format(toDate) %></span>
				</header>				
				<br />
				<form class="pull-left position" action="#">
					<div class="input-append">
						<a href="#addleavedays" data-toggle="modal">
							<button type="button" class="btn btn-success">Add</button>
						</a>
						<a href="#deleteleave" data-toggle="modal">
							<button id="ldelete" name="ldelete" type="button" class="btn btn-danger">Delete</button>
						</a>	
						<a href="<%=request.getContextPath()%>/Leave/myLeave.jsp">
							<button type="button" class="btn btn-warning">Apply Leave</button>
						</a>				
					</div>
				</form> 
				<!-- <input type="button" value = "Send Mail" id = "btnMail" class="btn btn-info"/> -->
				<section class="panel">				
					<div class="adv-table">
					<table class="table table-striped m-b-none text-small datatable  dataTable" id="sample_1" >						
							<thead style="background-color: #F3F781; color: #000000;">
								<tr>
									<th><input type="checkbox" id="selectall" /></th>
									<th width="25%">Name of Leave</th>
									<th>Date</th>																		
									<th>Day</th>
									<th>Regular/Floating</th>										
									<th width="10%">Apply Floating Leave</th>									
								</tr>
							</thead>
							<tbody>
								<%
									while (holidaySet.next()) {
								%>
										<tr>									
										<td><input type="checkbox" name="hid"
											id="hid-<%=(holidaySet.getString(1)==null?"":holidaySet.getString(1))%>"
											value="<%=(holidaySet.getString(1)==null?"":holidaySet.getString(1))%>" /></td>
										<td><%=(holidaySet.getString(2)==null?"":holidaySet.getString(2)) %></td>
										<%
											format1 = new SimpleDateFormat("yyyy-MM-dd");
											Date hdate = format1.parse(holidaySet.getString("hdate"));
											format1 = new SimpleDateFormat("dd-MMM-yyyy");
											DateFormat format2 = new SimpleDateFormat("EEEE");
										%>
										<td><%=(holidaySet.getString("hdate")==null?"":format1.format(hdate))%></td>
										<td><%=(holidaySet.getString("hdate")==null?"":format2.format(hdate))%></td>
										<%
											if(holidaySet.getString("htype").equals("Regular")){
										%>
												<td style="color:green;"><%=(holidaySet.getString("htype")==null?"":holidaySet.getString("htype"))%></td>
										<%	}else{ %>	
												<td style="color:red;"><%=(holidaySet.getString("htype")==null?"":holidaySet.getString("htype"))%></td>
										<%
											}	
											if(holidaySet.getString("htype").equals("Floating")){
										%>											
											<td><button type="button" class="btn btn-primary">Apply Leave</button></td>
										<%	} else {%>
											<td></td>
										<%} %>	
										</tr>
								<%
									}
								holidaySet.close();
								ps.close();
								con.close();
								%>
							</tbody>
						</table>
					</div>
				</section>
				<!--  One Management Topic End -->
			<!-- </div> -->
			</aside>
		</div>

		<!-- Modal -->
		<div id="addleavedays" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" class="modal fade">
           <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-header">
	                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                         <h4 class="modal-title"> Add Leave </h4>
	                    </div>					
						<div class="modal-body">
							<form class="form-horizontal" role="form" id = "addleavedate">
								<div class="form-group">
									<label class="col-lg-3 control-label">Holiday Name</label>
									<div class="col-lg-8">
										<input type="text" name="hname" id="hname" class="form-control" />										
									</div>
								</div>
								<div class="form-group">
									<label for="JoinDate" class="col-lg-3 control-label">Date:</label>
									<div class="col-lg-8">
										<input class="form-control datep" data-required="true"
											data-notblank="true" data-type="dateIso" id="hdate"
											name="hdate" placeholder="YYYY-MM-DD" type="text">
									</div>
								</div>
								<script>
									$(function() {
										$('.datep').datepicker(
											{
												minDate : "-1Y",
												maxDate : "1Y",
												dateFormat : "yy-mm-dd",
												changeMonth : true,
												changeYear : true
											}).val();
									});
								</script>
								<div class="form-group">
									<label for="roleid" class="col-lg-3 control-label">Holiday Type:</label>
									<div class="col-lg-8">
										<select id="htype" class="form-control" name="htype"
											data-required="true" data-notblank="true">
											<option value="">---select---</option>
											<option value="Regular">Regular</option>	
											<option value="Floating">Floating</option>																					
										</select>
									</div>
								</div>
								<div class="form-group">
									<label for="contract" class="col-lg-3 control-label">Repeats Annually:</label>
									<div class="col-lg-8">
									    <input type = "checkbox" name="rindicator" id="rindicator" class="contract">
									</div>
								</div>
								<!-- <div class="form-group">
									<label for="roleid" class="col-lg-3 control-label">Location:</label>
									<div class="col-lg-8">
										<select id="location" class="form-control" name="location"
											data-required="true" data-notblank="true">
											<option value="">---select---</option>
											<option value="Chennai">Chennai</option>	
											<option value="Coimbatore">Coimbatore</option>
											<option value="Hyderabad">Hyderabad</option>
											<option value="Mumbai">Mumbai</option>		
											<option value="Pune">Pune</option>
											<option value="Kolkata">Kolkata</option>
											<option value="Delhi">Delhi</option>											
										</select>
									</div>
								</div> -->
								<div class="modal-footer">
                                	<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                                    <button class="btn btn-success" type="submit">Save changes</button>
                                </div>								
							</form>
						</div>						
					</div>
				</div>
			</div>	


		<!-- modal -->

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
									<header class="panel-heading">New Employee details</header>
									<div class="panel-body">
										<form class="form-horizontal" id="newempdetadd"
											data-validate="parsley">
											<div class="form-group">
												<label for="FirstName" class="col-lg-3 control-label">First
													Name</label>
												<div class="col-lg-8">
													<input class="form-control" id="First Name"
														data-required="true" data-notblank="true" name="FirstName"
														placeholder="First Name" type="text">
												</div>
											</div>
											<div class="form-group">
												<label for="LastName" class="col-lg-3 control-label">Last
													Name</label>
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
												<label for="JoinDate" class="col-lg-3 control-label">Join
													Date:</label>
												<div class="col-lg-8">
													<input class="form-control datep" data-required="true"
														data-notblank="true" data-type="dateIso" id="Joindate"
														name="Joindate" placeholder="YYYY-MM-DD" type="text">


												</div>
											</div>
										
											<!-- 	<div class="form-group">
												<label for="contract" class="col-lg-3 control-label"> Contract: </label>
												<div class="col-lg-8">
												    <input type = "checkbox" name="contract" id="con" value="con" class="contract">
												</div>
										    </div>
											<div class="form-group" id="contractstart">
												<label for="Contractstart" class="col-lg-3 control-label">Contract Start:</label>
												<div class="col-lg-8">
													<input class="form-control datepicker"
														name="contractstart" placeholder="YYYY-MM-DD" type="text"
														data-type="dateIso" readonly >
												</div>
											</div>
											<div class="form-group" id="contractend">
												<label for="ContractEnd" class="col-lg-3 control-label">Contract End:</label>
												<div class="col-lg-8">
													<input class="form-control datepicker"
														name="contractend" placeholder="YYYY-MM-DD" type="text"
														data-type="dateIso" readonly>
												</div>
											</div>
											<script>
											$(document).ready(function(){
											    $("#contractstart").hide();											    
											    $("#contractend").hide();	
											    $("#empbasicpay").hide(); 
											});
											
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
											</script> -->
											<%-- <div class="form-group">
												<label for="roleid" class="col-lg-3 control-label">Department:</label>
												<div class="col-lg-8">
													<select id="roleid" class="form-control" name="roleid"
														data-required="true" data-notblank="true">
														<option value="">---select---</option>
														<%
															s = con.createStatement();
													        ResultSet rs = s.executeQuery("SELECT * FROM `roles` ORDER BY `role_id`");
															while (rs.next()) {
														%>
														         <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
														<%	}	%>
													</select>
												</div>
											</div>
											<div class="form-group">
                                                <label for="roleid" class="col-lg-3 control-label">Level:</label>
                                                <div class="col-lg-8">
                                                    <select id="elevel" class="form-control" name="elevel"
                                                        data-required="true" data-notblank="true" onchange="getPayRange(this.value)">
                                                        <option value="">---select---</option>
                                                        <option value="Level1">Level-1 (Expert)</option>
                                                        <option value="Level2">Level-2 (Advanced)</option>
                                                        <option value="Level3">Level-3 (Regular)</option>
                                                        <option value="Level4">Level-4 (Freshers)</option>
                                                    </select>
                                                </div>
                                            </div>
                                            <script type="text/javascript">
	                                            function getPayRange(level){
	                                            	var roleid = document.getElementById("roleid").value;
	                                            	var xmlhttp;
	                                            	if (window.XMLHttpRequest)  {
	                                            	  xmlhttp=new XMLHttpRequest();
	                                            	}
	                                            	else {
	                                            	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	                                            	}
	                                            	xmlhttp.onreadystatechange=function() {
	                                            	  if (xmlhttp.readyState==4 && xmlhttp.status==200) {
	                                            		  document.getElementById("empbasicpay").style.display="";
	                                            	      document.getElementById("Basicpay").placeholder=xmlhttp.responseText;
	                                            	  }
	                                            	}
	                                            	xmlhttp.open("GET","<%= request.getContextPath()%>/Ajax/getpayrange.jsp?roleid="+roleid+"&level="+level,true);
	                                            	xmlhttp.send();
	                                            }
                                            </script> --%>
											<!-- 	<div class="form-group" id="modeofroll">
                                                <label for="Basicpay" class="col-lg-4 control-label">Mode of Role:</label>
                                                <div class="radio">
                                                    <input id="mode" name="mode" type="radio" value="Inhouse">In-House&nbsp;   
                                                    <input id="mode" name="mode" type="radio" value="Offrole">Off-Role
                                                </div>                                                             
                                            </div>  -->
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-danger">Create
														new Employee</button>
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
								$("#addleavedate")
										.submit(
												function() {
													$('#addleavedate').parsley(
															'validate');
													if ($('#addleavedate')
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
																url : "../Ajax/addLeaveDate.jsp",
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
																					text : 'Leave date Created'
																				});
																		window.location.reload();
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
								
								$("#mail")
								.submit(
										function() {
											$.ajax({
														url : "<%=request.getContextPath()%>/Ajax/sendmail.jsp?mailid="+$("#inputEmail1").val()+"&cc="+$("#cc").val()+"&bcc="+$("#bcc").val()+"&sub="+$("#inputPassword1").val()+"&msg="+$("#msg").val(),
														type : "POST",
														
														success : function(
																data,
																textStatus,
																jqXHR) {
															document.getElementById("sendmail").style.display="none";
															if (data == 1) {
																$.gritter
																		.add({
																			title : 'Success',
																			text : 'Mail Sent Successfully'
																		});
																
															} else {
																$.gritter
																		.add({
																			title : 'Sorry',
																			text : 'Some Error Occured, Please Try Again.'
																		});
																document.getElementById("sendmail").style.display="none";
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