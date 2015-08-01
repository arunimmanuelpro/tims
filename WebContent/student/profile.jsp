
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
	long bal = 0;
int totalfees =0;
	Connection con1;int amt_paid;String sql,sql3;
	ResultSet rs1 = null,allpayments=null,paymentdetails = null,bookdetails = null,certdetails = null;
String stuid = request.getParameter("id");
if(stuid==null){
	response.sendRedirect(request.getContextPath()+"/error.jsp");
	return;
}else if(stuid.isEmpty()){
	response.sendRedirect(request.getContextPath()+"/error.jsp");
	return;
}else{
	con1 = DbConnection.getConnection();

	Statement s = con1.createStatement();
	sql = "SELECT * FROM `students` where `id` = '"
	+stuid + "' LIMIT 1";
 rs1 = s.executeQuery(sql);

}
if(rs1.next()){
		//Get Payment Informations
		sql3 = "SELECT * FROM `payments` WHERE `studentid` = '"+rs1.getInt(1)+"' order by id ASC";
		Statement s = con1.createStatement();
		allpayments = s.executeQuery(sql3);
		amt_paid = 0;
		while(allpayments.next()){
	int paid = Integer.parseInt(allpayments.getString(3));
	amt_paid = amt_paid + paid;
		}
		PreparedStatement ps = con1.prepareStatement("select * from studentcourse where studid = ?");
		ps.setInt(1, rs1.getInt(1));
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()){
		//Get Book Informations
		sql = "SELECT * FROM `books` WHERE `courseid` = '"+rs.getInt("courseid")+"' order by id ASC";
		
		s = con1.createStatement();
		bookdetails = s.executeQuery(sql);
		//Get certificate Informations
		sql = "SELECT * FROM `certificates` WHERE `courseid` = '"+rs.getInt("courseid")+"' order by id ASC";
		s = con1.createStatement();
		certdetails = s.executeQuery(sql);
		 totalfees+=rs.getInt("fees");
		}
}else{
	response.sendRedirect(request.getContextPath()+"/error.jsp");
	return;
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

						<h1><%=(rs1.getString("fName")==null?"":rs1.getString("fName"))%>
							<%=(rs1.getString("lName")==null?"":rs1.getString("lName"))%>
						</h1>

					</div>

					<ul class="nav nav-pills nav-stacked">

						<li class="active"><a href="#" data-toggle="emp"> <i
								class="icon-user"></i> Profile
						</a></li>
						<li><a href="edit.jsp?id=<%=stuid%>"> <i
								class="icon-edit"></i> Edit Student details
						</a></li>
						<%
							if(!rs1.getString("status").equalsIgnoreCase("NEW")){
						%>
						<li>
							<%-- <a href="invoice.jsp?id=<%= stuid %>"><i
								class="icon-inr"></i> --%> <a href="comingsoon.jsp">VIEW
								INVOICE</a>
						</li>
						<%
							}
						%>


					</ul>

				</section>
			</aside>
			<aside class="profile-info col-lg-9">

				<section class="panel">
					<div class="panel-body bio-graph-info">

						<h1>Bio Graph</h1>
						<div class="row">
							<div class="bio-row">
								<span> <span>First Name </span>:<%=(rs1.getString("fName")==null?"":rs1.getString("fName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Last Name </span>: <%=(rs1.getString("lName")==null?"":rs1.getString("lName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Location </span>: <%=(rs1.getString("city")==null?"":rs1.getString("city")+",")%>
									<%=(rs1.getString("state")==null?"":rs1.getString("state")+",")%>
									<%=(rs1.getString("country")==null?"":rs1.getString("country")+".")%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Birthday</span>: <%=(rs1.getString("dateofbirth")==null?"":rs1.getString("dateofbirth"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Mobile </span>: <%=(rs1.getString("Mobile")==null?"":rs1.getString("Mobile"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Email Address</span>: <%=(rs1.getString("Emailaddress")==null?"":rs1.getString("Emailaddress"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Address</span>: <%=(rs1.getString("addressline1")==null?"":rs1.getString("addressline1")+",")%>
									<%=(rs1.getString("addressline2")==null?"":rs1.getString("addressline2"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Stream:</span>: <%=(rs1.getString("stream")==null?"":rs1.getString("stream"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Qualification</span>: <%=(rs1.getString("qualification")==null?"":rs1.getString("qualification"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Blood Group </span>: <%=(rs1.getString("bloodgroup")==null?"":rs1.getString("bloodgroup"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Home Phone </span>: <%=(rs1.getString("homephone")==null?"":rs1.getString("homephone"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Join Date</span>: <%=(rs1.getString("joindate")==null?"":rs1.getString("joindate"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Status</span>: <%=(rs1.getString("status")==null?"":rs1.getString("status"))%>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Total Fees </span>: <%
 	out.print(totalfees);
 %>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Balance </span>: <%
 	bal = totalfees - amt_paid; out.print(bal);
 %>
								</span>
							</div>
							<div class="bio-row">
								<span> <span>Payment Status</span>: <%
 	if(bal==0 && (totalfees!=0)){
  																out.print("<b class='text-success'>Payment Cleared</b>");
  															}else if(bal>0){
  																out.print("<b class='text-warning'>Payment Pending</b>");
  															}else if(totalfees==0 && bal==0){
  																out.print("<b class='text-success'>Fees not discussed</b>");
  															}
 %>
								</span>
							</div>
						</div>

					</div>


				</section>
				<!--  One Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-book"> Books Informations</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#assignbook" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Name</th>
								<th>Publisher</th>
								<th>Course</th>
								<th>Process</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								if(bookdetails!=null){
																		while (bookdetails.next()) {
							%>
							<tr>
								<td><%=(bookdetails.getString(1)==null?"":bookdetails.getString(1))%></td>
								<td><%=(bookdetails.getString(2)==null?"":bookdetails.getString(2))%></td>
								<td><%=(bookdetails.getString(3)==null?"":bookdetails.getString(3))%></td>
								<td><%=GetInfoAbout.getcoursename(bookdetails.getString(4))%></td>
								<td>
									<%
										boolean delivered = true;
																																				Statement sbook = con1.createStatement();
																																				String bsql = "SELECT * FROM `student_books` WHERE `bookid`='"+bookdetails.getString(1)+"' AND `studentid`='"+stuid+"' LIMIT 1";
																																				ResultSet rsb = sbook.executeQuery(bsql);
																																				if(rsb.next()) out.print("DELIVERED"); else{ out.print("PENDING"); delivered = false;}
									%>
								</td>
								<td>
									<%
										if(!delivered){
									%><a
									href="../Ajax/studentoperations.jsp?sid=<%=stuid%>&id=<%=bookdetails.getInt("id")%>&o=books"><i
										class="icon-arrow-right"></i></a> <%
 	}
 %>
								</td>

							</tr>
							<%
								}
																	}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Topic End -->
				<!--  One Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-file"> Certificate Informations</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#assigncert" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Certificate</th>
								<th>Course</th>
								<th>Process</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<%
								if(certdetails!=null){
																		while (certdetails.next()) {
							%>
							<tr>
								<td><%=(certdetails.getString(1)==null?"":certdetails.getString(1))%></td>
								<td><%=(certdetails.getString(2)==null?"":certdetails.getString(2))%></td>
								<td><%=GetInfoAbout.getcoursename((certdetails.getString(3)==null?"":certdetails.getString(3)))%></td>
								<td>
									<%
										boolean delivered = true;
																																				Statement sbook = con1.createStatement();
																																				String bsql = "SELECT * FROM `students_certificate` WHERE `certificateid`='"+certdetails.getString(1)+"' AND `studentid`='"+stuid+"' LIMIT 1";
																																				ResultSet rsb = sbook.executeQuery(bsql);
																																				if(rsb.next()) out.print("DELIVERED"); else{ out.print("PENDING"); delivered = false;}
									%>
								</td>
								<td>
									<%
										if(!delivered){
									%><a
									href="../Ajax/studentoperations.jsp?sid=<%=stuid%>&id=<%=certdetails.getInt("id")%>&o=certificates"><i
										class="icon-arrow-right"></i></a> <%
 	}
 %>
								</td>
							</tr>
							<%
								}
																	}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Topic End -->
				<!--  One Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-inr"> Payment Informations</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newPaymentm" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Amount</th>
								<th>Method</th>
								<th>Date</th>
								<th>Next Due</th>
								<th>Collected By</th>
							</tr>
						</thead>
						<tbody>
							<%
								Statement s3 = con1.createStatement();
																												paymentdetails = s3.executeQuery(sql3);
																												while (paymentdetails.next()) {
							%>
							<tr>
								<td><%=(paymentdetails.getString(1)==null?"":paymentdetails.getString(1))%></td>
								<td><%=(paymentdetails.getString(3)==null?"":paymentdetails.getString(3))%></td>
								<td><%=(paymentdetails.getString(4)==null?"":paymentdetails.getString(4))%></td>
								<td><%=(paymentdetails.getString(5)==null?"":paymentdetails.getString(5))%></td>
								<td><%=(paymentdetails.getString(7)==null?"":paymentdetails.getString(7))%></td>
								<td><%=GetInfoAbout.gettrainername((paymentdetails.getString(6)==null?"":paymentdetails.getString(6)))%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Topic End -->

				<!--  One Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-book"> Course Information</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#assigncourse" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Course Name</th>
								<th>Fees</th>
								<th>Bach</th>

							</tr>
						</thead>
						<tbody>
							<%
								PreparedStatement ps = con1.prepareStatement("select * from studentcourse where studid = ?");
														ps.setInt(1, Integer.parseInt(stuid));
														ResultSet rs  = ps.executeQuery();
														while(rs.next()){
							%>
							<tr>
								<td></td>
								<td>
									<%
										PreparedStatement ps2 = con1.prepareStatement("select * from coursedetails where id = ?");
																								ps2.setInt(1, rs.getInt("courseid"));
																								ResultSet rs2 = ps2.executeQuery();
																								if(rs2.next()){
									%> <%=rs2.getString("Name")%> <%
 	}
 %>
								</td>
								<td><%=rs.getInt("fees")%></td>
								<td>
									<%
										int batid =rs.getInt("batchid");
																															if(batid==0){
									%> <a href="#assigntobfm" data-toggle="modal">Assign to
										Batch</a> <%
 	}else{
 												 						out.print("Assigned to batch :"+batid);
 												 					}
 %>

								</td>
							</tr>
							<%
								}
							%>

						</tbody>
					</table>
				</section>









			</aside>
		</div>
	</section>
	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-1" id="assigncourse" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">Assign Course</h4>
				</div>

				<div class="modal-body">

					<form class="form-horizontal" id="newcourse" role="form"
						data-validate="parsley">
						<div class="form-group">
							<label for="amount">Course Name</label> <select name="cname"
								class="form-control" id="cname">
								<%
									PreparedStatement ps1 = con1.prepareStatement("select * from coursedetails");
																					ResultSet rs2 = ps1.executeQuery();
																					while(rs2.next()){
								%>
								<option value="<%=rs2.getInt("id")%>"><%=rs2.getString("Name")%></option>
								<%
									}
								%>

							</select>
						</div>
						<div class="form-group">
							<label for="paymode">Fees</label> <input type="text"
								class="form-control" id="fees" name="fees" placeholder="Fees"
								data-required="true" data-range="[0,1000000]" data-type="number">
						</div>
						<input type="hidden" name="sid" value="<%=stuid%>" />
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<button type="submit" class="btn btn-default">Save</button>
							</div>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>




	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-1" id="assigntobfm" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">Assign to</h4>
				</div>

				<div class="modal-body">

					<form class="form-horizontal" id="assigntob" method="get"
						action="assign.jsp" role="form" data-validate="parsley">
						<div class="form-group">
							<label for="amount">Batch</label> <select id="batchid"
								name="batchid" class="form-control" data-required="true"
								data-notblank="true">
								<option value="">---select----</option>
								<%
									Connection con13 = DbConnection.getConnection();
																																		Statement s13 = con13.createStatement();
																																		ResultSet rs13 = s13
																																				.executeQuery("SELECT * FROM `batchdetails` ORDER BY `id`");
																																		while (rs13.next()) {
								%>
								<option value="<%=rs13.getString(1)%>"><%=rs13.getString(1)%>
									-
									<%
									PreparedStatement ps0 = con1.prepareStatement("select * from coursedetails where id = ?");
																					ps0.setInt(1, rs13.getInt("id"));
																					ResultSet rs0 = ps0.executeQuery();
																					if(rs0.next()){
								%>
									<%=rs0.getString("Name")%>
									<%
										}
									%>
									-
									<%=rs13.getString(10)%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="course">Course</label> <select id="batchid"
								name="cid" class="form-control" data-required="true"
								data-notblank="true">

								<%
									PreparedStatement ps5 = con1.prepareStatement("select * from studentcourse where studid = ? and batchid = ?");
																					ps5.setInt(1, Integer.parseInt(stuid));
																					ps5.setInt(2, 0);
																					ResultSet rs5 = ps5.executeQuery();
																					while(rs5.next()){
																						PreparedStatement ps6 = con1.prepareStatement("select * from coursedetails where id = ?");
																						ps6.setInt(1, rs5.getInt("courseid"));
																						ResultSet rs6 = ps6.executeQuery();
																						if(rs6.next()){
								%>

								<option value="<%=rs5.getInt("courseid")%>"><%=rs6.getString("Name")%></option>

								<%
									}
																						
																					}
								%>

							</select>
						</div>


						<input type="hidden" name="stid" value="<%=stuid%>">
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<button type="submit" class="btn btn-default">Assign</button>
							</div>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>



	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-1" id="newPaymentm" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">New Payment</h4>
				</div>

				<div class="modal-body">

					<form class="form-horizontal" id="newpayment" role="form"
						data-validate="parsley">
						<div class="form-group">
							<label for="amount">Towards</label> <select class="form-control"
								id="towards" name="towards" data-required="true">

								<%
									PreparedStatement ps3 = con1.prepareStatement("select * from studentcourse where studid =?");
																					ps3.setInt(1, Integer.parseInt(stuid));
																					ResultSet rs3 = ps3.executeQuery();
																					while(rs3.next()){
																						PreparedStatement ps4 = con1.prepareStatement("select * from coursedetails where id = ?");
																						ps4.setInt(1, rs3.getInt("courseid"));
																						ResultSet rs4 = ps4.executeQuery();
																						if(rs4.next()){
								%>
								<option value="<%=rs3.getInt("courseid")%>"><%=rs4.getString("Name")%></option>
								<%
									}
																						}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="amount">Amount</label> <input type="text"
								class="form-control" id="amount" name="amount"
								placeholder="Amount" data-required="true"
								data-range="[100,<%=bal%>]" data-type="number">
						</div>
						<div class="form-group">
							<label for="paymode">Pay Mode</label> <select
								class="form-control" id="paymode" name="paymode"
								placeholder="Pay Mode" data-required="true">
								<option value="">-------SELECT--------</option>
								<option value="CASH">CASH</option>
								<option value="CHEQUE">CHEQUE</option>
								<option value="CARD">CARD</option>
							</select>
						</div>
						<div id="cheque" style="display: none;">
							<div class="form-group">
								<label>Cheque Number</label> <input type="text"
									placeholder="Cheque Number" id="cno" name="cno"
									class="form-control">
							</div>
							<div class="form-group">
								<label>Cheque Date</label> <input type="text" id="cdate"
									class="form-control datepicker" name="cdate"
									placeholder="Cheque Date" data-type="dateIso" readonly>
							</div>
							<div class="form-group">
								<label>Bank</label> <input type="text" placeholder="Bank"
									id="cbank" name="cbank" class="form-control">
							</div>

							<div class="form-group">
								<label>Branch</label> <input type="text" id="cbranch"
									name="cbranch" placeholder="Branch" class="form-control">
							</div>
						</div>
						<div id="card" style="display: none;">
							<div class="form-group">
								<label>Card Type</label> <select class="form-control" id="ctype"
									name="ctype">

									<option value="Credit">CREDIT</option>
									<option value="Debit">DEBIT</option>

								</select>
							</div>
							<div class="form-group">
								<label>Bank Name</label> <input type="text"
									placeholder="Bank Name" id="cardbank" name="cardbank"
									class="form-control">
							</div>

						</div>
						<div class="form-group">
							<label for="nextduedate">Next Due date</label> <input type="text"
								id="nextduedate" class="form-control datepicker"
								name="nextduedate" placeholder="Next Due Date"
								data-type="dateIso" readonly> <input type="hidden"
								name="studentid" value="<%=stuid%>">
						</div>
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<button type="submit" class="btn btn-default">Save</button>
							</div>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>

	<%
		con1.close();
	%>
	<script type="text/javascript">
	
		$(document).ready(function() {
		
			$("#paymode").change(function(){
				if($('#paymode :selected').text()=="CHEQUE"){
					$("#card").hide();
					$("#cheque").show(1000);
				}else if($('#paymode :selected').text()=="CARD"){
					$("#cheque").hide();
					$("#card").show(1000);
				}else{
					$("#cheque").hide();
					$("#card").hide();
				}
			});
			
			
			$("#newcourse").submit(function() {
			
			$("#newcourse").parsley('validate');
			var str = $(this).serialize();
			$.ajax({
				url : "<%=request.getContextPath()%>/Ajax/adstudentcourse.jsp",
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
																				text : 'New Course Added'
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
							$("#newpayment")
									.submit(
											function() {

												$('#newpayment').parsley(
														'validate');

												if ($('#newpayment').parsley(
														'isValid')) {

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
															url : "../Ajax/newPayment.jsp",
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
																				text : 'All new Payment Added'
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
	<!-- page end-->
</section>
<%@include file="../Common/Footer.jsp"%>