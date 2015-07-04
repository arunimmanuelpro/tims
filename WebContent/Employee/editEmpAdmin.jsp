 
<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
	request.setAttribute("title", "Edit employee Details");
%>
<%@include file="../Common/Header.jsp"%>

<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>

<%
	SecureNew sn = new SecureNew();
	ResultSet rs2 = null;
	String empid1 = request.getParameter("id");
	if(empid1==null){
		response.sendRedirect(request.getContextPath()+"/error.jsp");
		return;
	}else if(empid1.isEmpty()){
		response.sendRedirect(request.getContextPath()+"/error.jsp");
	}else{
	Connection con = DbConnection.getConnection();
		Statement s;
		String sql = "";
		sql = "SELECT * FROM `employee` WHERE `id`='"+empid1+ "' LIMIT 1";
		s = con.createStatement();
		rs2 = s.executeQuery(sql);
	}
if(rs2.next()){	
}else{
	response.sendRedirect(request.getContextPath()+"/error.jsp");
	return;
}
%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> Edit employee Details </header>
					<div class="panel-body">
						<form class="form-horizontal" id="editempdet"
							data-validate="parsley">
							<div class="form-group">
								<label for="workemail" class="col-lg-2 control-label">Work Email:</label>
								<div class="col-lg-10">
									<input class="form-control" id="workemail" name="workemail"
										placeholder="workemail" type="text" data-type="email" data-required="true"
										value="<%String wemail = rs2.getString("WorkEmail");
											if(wemail!=null){
												out.print(sn.decrypt(wemail));
											}
										%>">

								</div>
							</div>
							<div class="form-group">
                                <label for="empstatus" class="col-lg-2 control-label">Employment Status: </label>
                                <div class="col-lg-10">
                                    <select id="empstatus" name="empstatus" class="form-control"
                                        data-required="true" data-notblank="true">
                                        <option value="">---select---</option>
                                        <%
                                            Connection con12 = DbConnection.getConnection();                                                                                                Statement s12 = con12.createStatement();
                                            ResultSet rs12 = s12.executeQuery("SELECT * FROM `employmentstatus` ORDER BY `id`");
                                            while (rs12.next()) {
                                        %>
                                              <option value="<%=(rs12.getString(1)==null?"":rs12.getString(1))%>"><%=(rs12.getString(2)==null?"":rs12.getString(2))%></option>
                                        <%  }   %>
                                    </select>
                                </div>
                            </div>
							    <div class="form-group">
									<label for="contract" class="col-lg-2 control-label"> Contract </label>
									<div class="col-lg-10">
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
								</script>	
							 <div class="form-group">
                                <label for="userrole" class="col-lg-2 control-label">Department:
                                </label>
                                <div class="col-lg-10">
                                    <select id="userrole" name="userrole" class="form-control"
                                        data-required="true" data-notblank="true" onchage="getJobTitles(this.value)">
                                        <option value="">---select---</option>                                        
                                        <%                                            
                                            Statement s1 = con12.createStatement();                                            
                                            ResultSet rs1 = s1.executeQuery("SELECT * FROM `roles` ORDER BY `role_id`");
                                            while (rs1.next()) {
                                        %>
                                                <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2) %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>		
                            <script type="text/javascript">
                               $(function(){
                                	  $("select#userrole").change(function(){                                		 
                                	    $.getJSON("<%= request.getContextPath()%>/Ajax/getjobtitles.jsp",{level: $(this).val(), ajax: 'true'}, function(j){
                                	      var options = '<option value=0>---Select---</option>';                                	      
                                	      for (var i = 0; i < j.length; i++) {
                                	        options += '<option value="' + j[i].optionValue + '">' + j[i].optionDisplay + '</option>';
                                	      }
                                	      $("select#jobtitles").html(options);                                	   
                                	    });                                		 
                                	  });
                                	})
                            </script>
                            				
							<div class="form-group">
								<label for="jobtitles" class="col-lg-2 control-label">Designation: </label>
								<div class="col-lg-10">
									<select id="jobtitles" name="jobtitles" class="form-control"
										data-required="true" data-notblank="true">	
										<option value="">---select---</option>								
									</select>
								</div>
							</div>
						
						    <div class="form-group">
                                <label for="elevel" class="col-lg-2 control-label">Level: </label>
                                <div class="col-lg-10">
                                    <select id="elevel" name="elevel" class="form-control"
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
	                                 var roleid = document.getElementById("userrole").value;
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
	                                          document.getElementById("basicpay").placeholder=xmlhttp.responseText;
	                                     }
	                                 }
	                                 xmlhttp.open("GET","<%= request.getContextPath()%>/Ajax/getpayrange.jsp?roleid="+roleid+"&level="+level,true);
	                                 xmlhttp.send();
                                 }
                             </script>
						
							<div class="form-group" id="empbasicpay">
                                <label for="basicpay" class="col-lg-2 control-label">Basic Pay:</label>
                                <div class="col-lg-10">
                                    <input class="form-control" id="basicpay" name="basicpay"
                                        type="text" >
                                </div>
                            </div>
                            
                             <div class="form-group">
                                <label for="reportTo" class="col-lg-2 control-label">Reporting Person:
                                </label>
                                <div class="col-lg-10">
                                    <select id="reportTo" name="reportTo" class="form-control"
                                        data-required="true" data-notblank="true" onchage="getJobTitles(this.value)">
                                        <option value="">---select---</option>                                        
                                        <%                                            
                                            s1 = con12.createStatement();                                            
                                            rs1 = s1.executeQuery("SELECT id, FirstName, LastName, JobTitleId FROM `employee` where TerminationId is null ORDER BY `id`");                                    
                                            while (rs1.next()) {
                                            	String fName = rs1.getString(1);
                                                String lName = rs1.getString(2);
                                                String desig = GetInfoAbout.getjobtitlename(rs1.getString("JobTitleId"))==null?"":GetInfoAbout.getjobtitlename(rs1.getString("JobTitleId"));
                                                String reportTo = fName+" "+lName+" - "+desig;
                                        %>
                                                <option value="<%=rs1.getString(1)%>"><%=reportTo %></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>      
                            
                            <div class="form-group" id="modeofroll">
                                <label for="Basicpay" class="col-lg-2 control-label">Mode of Role:</label>
                                <div class="col-lg-10">
                                    <input id="mode" name="mode" type="radio" value="Inhouse">In-House&nbsp;   
                                    <input id="mode" name="mode" type="radio" value="Offrole">Off-Role
                                </div>                                                             
                            </div> 
                            
							<div class="form-group">
								<label for="pfnum" class="col-lg-2 control-label">PF Number:</label>
								<div class="col-lg-10">
									<input class="form-control" id="pfnumber" name="pfnumber"
										type="text" data-rangelength="[4,25]"
										value="<%=(rs2.getString("pfnumber")==null?"":rs2.getString("pfnumber"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="esicnum" class="col-lg-2 control-label">ESIC
									Number:</label>
								<div class="col-lg-10">
									<input class="form-control" id="esicnumber" name="esicnumber"
										type="text" data-rangelength="[4,25]"
										value="<%=(rs2.getString("esicnumber")==null?"":rs2.getString("esicnumber"))%>">
								</div>
							</div>
							<input type="hidden" name="empid" value="<%=empid1%>">
							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<a href="profile.jsp?id=<%=rs2.getInt("id")%>"
										class="btn btn-default">Back</a>
									<button type="submit" class="btn btn-danger">Update</button>
								</div>
							</div>
						</form>
					</div>
				</section>
			</div>
		</div>


		<script type="text/javascript">
	$(document).ready(function() {
		

		//Contact Details Update Start
		$("#editempdet").submit(function() {

			$('#editempdet').parsley('validate');
			
			if ($('#editempdet').parsley('isValid')) {
				
			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}
			
			
			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/editEmployeeDetails.jsp",
				type : "POST",
				data : str,
				success : function(data, textStatus, jqXHR) {
					if (data == 1) {
						$.gritter.add({
							title : 'Success',
							text : 'All Data Saved'
						});
						$(location).attr('href','profile.jsp?id=<%=empid1%>');
																	} else {
																		$.gritter
																				.add({
																					title : 'Sorry',
																					text : 'Some Error Occured, Please Try Again.'
																							+ data
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

<%@include file="../Common/Footer.jsp"%>