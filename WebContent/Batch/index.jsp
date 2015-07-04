
<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "All Batch(`s)");
%>
<%@include file="../Common/Header.jsp"%>

<%
	Connection con = DbConnection.getConnection();
	Statement s;
	PreparedStatement ps = null;
	String sql = "";
	//Get Emp
	
	
	
%>
<%		
	if(jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")){	
		ps = con.prepareStatement("SELECT * FROM `batchdetails` order by id DESC");
	}else if(jobTitle.equals("6") || jobTitle.equals("8") || jobTitle.equals("9")){
		int id = (Integer)request.getAttribute("userid");
		System.out.println("UserID: "+id);
		ps = con.prepareStatement("SELECT * FROM `batchdetails` where Trainerid='"+id+"' order by id DESC");
	}else{
		response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
		return;
	}
	ResultSet empdetails = ps.executeQuery();	
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="fa fa-folder-open"> Batch(`s)</i>
					</h3>
					<% if(jobTitle.equals("2") || jobTitle.equals("4") || jobTitle.equals("10")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newbatchm" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%} %>
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Course</th>
								<th>Trainer</th>
								<th>Start Date</th>
								<th>End Date</th>
								<th>Session</th>
								<th>Type</th>
								<th>Status</th>
								<th>More...</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (empdetails.next()) {
							%>
							<tr>
								<td><%=empdetails.getString(1)%></td>
								<td><%=GetInfoAbout.getcoursename(empdetails.getString(2))%></td>
								<td><%=GetInfoAbout.gettrainername(empdetails.getString(3))%></td>
								<td><%=empdetails.getString(4)%></td>
								<td><%=empdetails.getString(5)%></td>
								<td><%=empdetails.getString(6)%></td>
								<td><%=empdetails.getString(7)%></td>
								<td><%=empdetails.getString(10)%></td>
								<td><a data-placement="top" data-toggle="tooltip"
									class="tooltips"
									data-original-title="See More Details on batch <%=empdetails.getString(1)%>"
									href="details.jsp?id=<%= empdetails.getString(1) %>"><i
										class="fa fa-archive"></i></a></td>
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
			tabindex="-1" id="newbatchm" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">New Batch</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading">Details for New Batch</header>
									<div class="panel-body">
										<form class="form-horizontal" id="newempdetadd"	data-validate="parsley">
											<div class="form-group">
												<label class="col-lg-3 control-label">Course</label>
												<div class="col-lg-8">
													<select name="Course" data-required="true">
														<option value="">--------Select--------------</option>
														<%
															s = con.createStatement();
																						sql = "SELECT * FROM coursedetails";
																						ResultSet rs = s.executeQuery(sql);
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
												<label class="col-lg-3 control-label">Trainer</label>
												<div class="col-lg-8">
													<select name="Trainer" data-required="true">
														<option value="">--------Select--------------</option>
														<%
															s = con.createStatement();
																						sql = "SELECT * FROM `employee` where `roleid` in (4,5) and jobtitleid not in (3,5,10,12,11,13,14,15) and terminationid is null order by roleid";
																						ResultSet rs2 = s.executeQuery(sql);
																						while (rs2.next()) {
														%>
														<option value="<%out.print(rs2.getString(1));%>">
															<%
																out.print(rs2.getString(2)+" "+rs2.getString(3));
															%>
														</option>
														<%
															}
														%>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Session</label>
												<div class="col-lg-8">
													<select name="Session" data-required="true">
														<option value="">--------Select--------------</option>

														<option value="Morning">Morning</option>
														<option value="Noon">Noon</option>
														<option value="Evening">Evening</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Hours Per Day</label>
												<div class="col-lg-8">
													<select name="Hours" data-required="true">
														<option value="">--------Select----------</option>
														<option value="2">2 Hours</option>
														<option value="3">3 Hours</option>
														<option value="4">4 Hours</option>
														<option value="6">6 Hours</option>														
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Type</label>
												<div class="col-lg-8">
													<select name="Type" data-required="true">
														<option value="">--------Select----------</option>
														<option value="Mon-Fri">Mon - Fri</option>
														<option value="Mon-Sat">Mon - Sat</option>
														<option value="Tue-Fri">Tue - Fri</option>
														<option value="Mon-Wed-Fri">Mon - Wed- Fri</option>
														<option value="Tue-Thu-Sat">Tue - Thu - Fri</option>
														<option value="Thu-Fri-Sat">Thu - Fri - Sat</option>
														<option value="Sat-Sun">Sat & Sun</option>
														<option value="Sun-Only">Sunday Only</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Start Date</label>
												<div class="col-lg-8">
													<input class="form-control datepicker" name="sdate"
														size="16" type="text" data-required="true" readonly>
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
		<script type="text/javascript">
			$(document)
					.ready(
							function() {
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
													var str = $(this)
															.serialize();
													$
															.ajax({
																url : "../Ajax/newBatch.jsp",
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
																					text : 'new Batch Created'
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
							});
		</script>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>