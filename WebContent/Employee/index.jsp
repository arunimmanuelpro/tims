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
	sql = "SELECT * FROM `employee` WHERE TerminationId is null order by id";
	s = con.createStatement();
	ResultSet empdetails = s.executeQuery(sql);
%>
<%
	if(userroles.contains("view_employees") || userroles.contains("add_employee")){
	
	}else{
		response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
		return;
	}
%>
<script>
$(document).ready(function(){	
	    $('#selectall').click(function(event) {  //on click 
	        if(this.checked) { // check select status
	            $('input[name="empid"]').each(function() { //loop through each checkbox
	                this.checked = true;  //select all checkboxes with class "checkbox1"               
	            });
	        }else{
	            $('input[name="empid"]').each(function() { //loop through each checkbox
	                this.checked = false; //deselect all checkboxes with class "checkbox1"                       
	            });         
	        }
	    });
	  
	$("#btnMail").click(function(){
		var uid="";
	$('input[name="empid"]:checked').each(function() {
		uid += this.value+",";   
		console.log(this.value);
	});
	uid=uid.substring(0,uid.length - 1);	
	var xmlhttp;	
	if (window.XMLHttpRequest) {
	  xmlhttp=new XMLHttpRequest();
	}
	else {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function() {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200) {
		  var someText=xmlhttp.responseText;
          someText = someText.replace(/(\r\n|\n|\r)/gm,"");
          var jsonData = JSON.parse(someText);
          var email="";
          for (var i = 0; i < jsonData.length; i++) {
              var counter = jsonData[i];
              email+=counter.email+";";             
          }
          if(email==""){
        	  document.getElementById("inputEmail1").value = "";
          }
          document.getElementById("inputEmail1").value =email;
          document.getElementById("cc").value="";
          document.getElementById("bcc").value="";
          document.getElementById("inputPassword1").value="";
          document.getElementById("msg").value="";
	    }
	  }
	  xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/getmailtoemp.jsp?id="+ uid, true);
	  xmlhttp.send();
	});
});
</script>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="fa fa-folder-open"> Payroll Employees</i>
					</h3>

					<%
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
					%>
				</div>
				<br />
				<form class="pull-left position" action="#">
					<!-- <div class="input-append"> -->
					<a class="btn btn-info" data-toggle="modal" href="#sendmail"> <i
						class="fa fa-envelope"></i> <input type="button" value="Send Mail"
						id="btnMail" class="btn btn-info" />
					</a>
					<!-- <a href="#sendmail" data-toggle="modal">
							<button type="button" class="btn btn-info" value="Send Mail">
								<i class="fa fa-envelope">  Send Mail</i>
								</button>
							</a> -->
					<!-- <input type="submit" data-toggle="modal" value="Send Mail" id="sendmail" class="btn btn-info"/> -->
					<!-- </div> -->
				</form>
				<!-- <input type="button" value = "Send Mail" id = "btnMail" class="btn btn-info"/> -->
				<section class="panel">
					<div class="adv-table">
						<table class="display table table-bordered table-striped"
							id="dynamic-table">
							<thead>
								<tr>
									<th><input type="checkbox" id="selectall" /></th>
									<th>Id</th>
									<th>Name</th>
									<th>Gender</th>
									<th>Mobile</th>
									<th>Location</th>
									<th>Department</th>
									<th>Designation</th>
									<th>Mode Of Role</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%
									while (empdetails.next()) {
								%>
								<tr class="odd">
									<%
										int terminated = empdetails.getInt("TerminationId"); 
																String Fname = empdetails.getString("FirstName");
																String Lname = empdetails.getString("LastName");
																String Term = " (Past Employee)";
																String Name;
																if(terminated > 0 ){
																	Name = Fname + " " + Lname + " " + Term;
																}else{
																	Name = Fname + " " + Lname;
																}
									%>
									<td><input type="checkbox" name="empid"
										id="checkbox-<%=(empdetails.getString(1)==null?"":empdetails.getString(1))%>"
										value="<%=(empdetails.getString(1)==null?"":empdetails.getString(1))%>" /></td>
									<td><%=(empdetails.getString(1)==null?"":empdetails.getString(1))%></td>
									<td><%=Name%></td>
									<td><%=(empdetails.getString("Gender")==null?"":empdetails.getString("Gender"))%></td>
									<td><%=(empdetails.getString("Mobile")==null?"":empdetails.getString("Mobile"))%></td>
									<td><%=(empdetails.getString("City")==null?"":empdetails.getString("City")+",")%>
										<%=(empdetails.getString("State")==null?"":empdetails.getString("State")+",")%>
										<%=(empdetails.getString("Country")==null?"":empdetails.getString("Country"))%></td>
									<td><%=(empdetails.getString("roleid")==null?"":GetInfoAbout.getrolename(empdetails.getString("roleid")))%></td>
									<td><%=(empdetails.getString("JobTitleId")==null?"":GetInfoAbout.getjobtitlename(empdetails.getString("JobTitleId")))%></td>
									<td><%=(empdetails.getString("ModeOfRole")==null?"":empdetails.getString("ModeOfRole"))%></td>

									<td><a class="btn btn-info btn-xs edit"
										href="profile.jsp?id=<%=empdetails.getInt("id")%>"><i
											class="fa fa-wrench">info</i></a></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="sendmail" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title">Send Email</h4>
					</div>
					<div class="modal-body">
						<div class="modal-body">
							<form class="form-horizontal" role="form" id = "mail">
								<div class="form-group">
									<label class="col-lg-1 control-label">To</label>
									<div class="col-lg-11">
										<textarea name="inputEmail1" id="inputEmail1" class="form-control" cols="30"></textarea>										
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-1 control-label">Cc</label>
									<div class="col-lg-11">
										<input type="text" class="form-control" id="cc" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-1 control-label">Bcc</label>
									<div class="col-lg-11">
										<input type="text" class="form-control" id="bcc" placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-1 control-label">Subject</label>
									<div class="col-lg-11">
										<input type="text" class="form-control" id="inputPassword1"
											placeholder="">
									</div>
								</div>
								<div class="form-group">
									<label class="col-lg-1 control-label">Message</label>
									<div class="col-lg-11">
										<textarea name="msg" id="msg" class="form-control" cols="30"
											rows="10"></textarea>
									</div>
								</div>

								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<span class="btn green fileinput-button"> <i
											class="fa fa-plus fa fa-white"></i> <span>Attachment</span> <input
											type="file" multiple="" name="files[]">
										</span>
										<button type="submit" class="btn btn-send">Send</button>
									</div>
								</div>
							</form>
						</div>
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
											<script>
												$(function() {
													$('.datep')
															.datepicker(
																	{
																		dateFormat : "yy-mm-dd",
																		changeMonth : true,
																		changeYear : true
																	}).val();
												});
											</script>
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