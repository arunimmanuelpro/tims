<%@page import="java.util.TreeSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
Connection con3 = DbConnection.getConnection();


	int id = 0;
	String strid = request.getParameter("id");
	if (strid != null) {
		id = Integer.parseInt(request.getParameter("id"));
	} else {
		id = 0;
	}
	

	String source = "", name = "", email = "", mobile = "", qua = "", des = "", curr = "", home = "", ci = "", address = "", gender = "", status = "",stype="";
	boolean valid = false;

	if (id == 0) {
		//error
		valid = false;
	} else {
		
		Statement s = con3.createStatement();
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
	stype = rs.getString("stype");
	valid = true;
		} else {
	//enquiry not found
	valid = false;
		}
	}
	//Check Duplicate

	boolean duplicate=false;
	
	PreparedStatement ps = con3.prepareStatement("select * from enquiry where mobile = ?	 and mobile!=''");
	ps.setString(1, mobile);
	ResultSet r = ps.executeQuery();
	List<Integer> mobduplicate = new LinkedList<Integer>();
	List<Integer> emailduplicate = new LinkedList<Integer>();
	while(r.next()){
		mobduplicate.add(r.getInt(1));
	}
	for(int i = 0; i<mobduplicate.size();i++){
		if(mobduplicate.get(i)==id){
			mobduplicate.remove(i);
		}
	}

	if(mobduplicate.size()>0){
		duplicate=true;
	}
//Email Duplication
	
	r.first();
if(!(email==null||email.isEmpty())){
	ps = con3.prepareStatement("select * from enquiry where email = ?and email!=''");
	ps.setString(1, email);
	r = ps.executeQuery();
	while(r.next()){
		emailduplicate.add(r.getInt(1));
	}
	for(int i = 0; i<emailduplicate.size();i++){
		if(emailduplicate.get(i)==id){
			emailduplicate.remove(i);
		}
	}
	if(emailduplicate.size()>0){
		duplicate=true;
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
								
								<div  class="form-group" align = "center">
								
												<input type= "radio"  name = "type" value ="Student" id = "type" <%if((!stype.isEmpty()&&stype!=null)&&stype.contains("Student")){out.println("checked");} %>/>  Student
												<input type= "radio"  name = "type" value ="Professional" id = "type" <%if((!stype.isEmpty()&&stype!=null)&&stype.contains("Professional")){out.println("checked");} %>/>  Professional
												<input type= "radio"  name = "type" value ="Project" id = "type" <%if((!stype.isEmpty()&&stype!=null)&&stype.contains("Project")){out.println("checked");} %>/>  Project
												</div>
								
								
									<div class="form-group">
										<label class="col-lg-3 control-label">Name</label>
										<div class="col-lg-8">
											<input type="text" name="name" id="name" value="<%=name%>"
												data-required="true" class="form-control parsley-validated">
										</div>
									</div>
										<div class="form-group">
										<label class="col-lg-3 control-label">Mobile</label>
										<div class="col-lg-8">
											<input type="text" name="mobile" value="<%=mobile%>" id="mobile"
												data-type="phone" data-required="true"
												class="form-control parsley-validated">
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
									
									<div class="form-group">
												<label class="col-lg-3 control-label">Course
													Interested</label>
												<div class="col-lg-8">
												<select name = "courseinterestedin"  id = "courseinterestedin" class = "form-control">
													<option value = "Code Java" >Core Java</option>
													<option value=  "Android" >Android</option>
													<option value=  "Other">Other</option>
												
												</select>
												<div id = "other" style = "display:none;">
												<input type = "text" name= "courseinterestedino" class = "form-control"/>
												</div>
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
													$("#courseinterestedin").change(function(){

														if($("#courseinterestedin").val()=="Other"){
															$("#other").show();
														}else{
															$("#other").hide();
														}
													});
													
													
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
									class="btn btn-success">SWITCH TO STUDENT</a> 
									<%
							}
									if(!status.contains("DUPLICATE") ){ 
										if(duplicate){
											%>
											<a
												href="../Ajax/enquiryoperations.jsp?bid=<%=id%>&operation=DUPLICATE"
												class="btn btn-danger">DUPLICATE ENQUIRY</a>	
										<%
												}else{
									%>
									<a
									href="../Ajax/enquiryoperations.jsp?bid=<%=id%>&operation=DUPLICATE"
									class="btn btn-warning">DUPLICATE ENQUIRY</a>
									<%
									}
									} %>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading"> Today </header>
							<div>
							<%-- <a
									href="<%=request.getContextPath()%>/Ajax/enquirycall.jsp?id=<%=id%>"
									class="btn btn-success btn-circle">
									<i class="icon-phone"></i>Call</a> --%>
										<h2><%=mobile%></h2>
								<br> <a href="#" class="btn btn-danger btn-circle"
									id="endcall"><i class="icon-stop"></i>Follow</a>
								
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
									method="get"
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
											
											Statement s = con3.createStatement();
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


<%if(duplicate){ %>
				<div class="row">
					<div class="col-lg-12">
						<section class="panel">
							<header class="panel-heading">
								<span class="label bg-danger pull-right"></span> Duplicate
							</header>
							<div>
								<table class="table table-striped m-b-none text-small">
									<thead>
										<tr>
											<th>Source</th>
											<th>Name</th>
											<th>Course</th>
											<th>Message</th>
											<th>Status</th>
										</tr>
									</thead>
									<tbody>
										<%Set<Integer> uniqueid = new TreeSet<Integer>();
									
										for(int i = 0;i<mobduplicate.size();i++){
											uniqueid.add(mobduplicate.get(i));
										}
										for(int i = 0;i<emailduplicate.size();i++){
											uniqueid.add(emailduplicate.get(i));
										}
										for(int i : uniqueid){
										ps  = con3.prepareStatement("select * from enquiry where id = ?");
										ps.setInt(1,i);
										rs = ps.executeQuery();
										if(rs.next()){
										%>
										<tr>
											<td><%=rs.getString("source") %></td>
											<td><%=rs.getString("name") %></td>
											<td><%=rs.getString("courseinterested") %></td>
											<td><%PreparedStatement
											 ps1 = con3.prepareStatement("select * from enquiry_data where enquiry_id = ?");
											ps1.setInt(1, i);
											ResultSet rs1 = ps1.executeQuery();
											if(rs1.next()){
											 %>
											 <%=rs1.getString("message") %>
											 
											 <%} %>
											 </td>
											<td><%=rs.getString("status") %></td>
										</tr>
										
										
										<%}} %>
									</tbody>
								</table>
							</div>
						</section>
					</div>
				</div>

<%} %>

			</div>
		</div>

	</section>
</section>
<%con3.close(); %>
<%@ include file="../Common/Footer.jsp"%>
