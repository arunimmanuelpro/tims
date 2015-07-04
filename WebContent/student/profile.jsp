
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
		//Get Book Informations
		sql = "SELECT * FROM `books` WHERE `courseid` = '"+rs1.getInt("courseid")+"' order by id ASC";
		s = con1.createStatement();
		bookdetails = s.executeQuery(sql);
		//Get certificate Informations
		sql = "SELECT * FROM `certificates` WHERE `courseid` = '"+rs1.getInt("courseid")+"' order by id ASC";
		s = con1.createStatement();
		certdetails = s.executeQuery(sql);
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
						<%if(!rs1.getString("status").equalsIgnoreCase("NEW")){
							%>
						<li><a href="invoice.jsp?id=<%= stuid %>"><i
								class="icon-inr"></i>VIEW INVOICE</a></li>
						<%} %>
						<li>
							<%
							String status = rs1.getString("status");
							if(!status.equalsIgnoreCase("NEW")){
								String batid =rs1.getString("batchid");
								
																	if(batid==null || batid.isEmpty()){
							%> <a href="#assigntobfm" data-toggle="modal">Assign to Batch</a>
							<%
								}else{
							 						out.print("Assigned to batch :"+batid);
							 					}
							}else{
		 						out.print("NO PAYMENT RECEIVED");
		 					}
							%>
						</li>

					</ul>

				</section>
			</aside>
			<aside class="profile-info col-lg-9">

				<section class="panel">
					<div class="panel-body bio-graph-info">

						<h1>Bio Graph</h1>
						<div class="row">
							<div class="bio-row">
								<span>
									<span>First Name </span>:<%=(rs1.getString("fName")==null?"":rs1.getString("fName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Last Name </span>:
									<%=(rs1.getString("lName")==null?"":rs1.getString("lName"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Location </span>:
									<%=(rs1.getString("city")==null?"":rs1.getString("city")+",")%>
									<%=(rs1.getString("state")==null?"":rs1.getString("state")+",")%>
									<%=(rs1.getString("country")==null?"":rs1.getString("country")+".")%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Birthday</span>:
									<%=(rs1.getString("dateofbirth")==null?"":rs1.getString("dateofbirth"))%>
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
									<span>Email Address</span>:
									<%=(rs1.getString("Emailaddress")==null?"":rs1.getString("Emailaddress"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Address</span>:
									<%=(rs1.getString("addressline1")==null?"":rs1.getString("addressline1")+",")%>
									<%=(rs1.getString("addressline2")==null?"":rs1.getString("addressline2"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Stream:</span>:
									<%=(rs1.getString("stream")==null?"":rs1.getString("stream"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Qualification</span>:
									<%=(rs1.getString("qualification")==null?"":rs1.getString("qualification"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Blood Group </span>:
									<%=(rs1.getString("bloodgroup")==null?"":rs1.getString("bloodgroup"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Home Phone </span>:
									<%=(rs1.getString("homephone")==null?"":rs1.getString("homephone"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Join Date</span>:
									<%=(rs1.getString("joindate")==null?"":rs1.getString("joindate"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Status</span>:
									<%=(rs1.getString("status")==null?"":rs1.getString("status"))%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Total Fees </span>:
									<%
										int totalfees = rs1.getInt("totalfees"); out.print(totalfees);
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Balance </span>:
									<%
										long bal = totalfees - amt_paid; out.print(bal);
									%>
								</span>
							</div>
							<div class="bio-row">
								<span>
									<span>Payment Status</span>:
									<%
										if(bal==0){
																		out.print("<b class='text-success'>Payment Cleared</b>");
																	}else if(bal>0){
																		out.print("<b class='text-warning'>Payment Pending</b>");
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

			</aside>
		</div>
	</section>

	<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
		tabindex="-1" id="assigntobfm" class="modal fade">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button data-dismiss="modal" class="close" type="button">×</button>
					<h4 class="modal-title">Assign to</h4>
				</div>

				<div class="modal-body">

					<form class="form-horizontal" id="assigntob" method="POST"
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
									<%=rs13.getString(10)%></option>
								<%
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
						<div class="form-group">
							<label for="nextduedate">Next Due date</label> <input type="text"
								id="nextduedate" class="form-control datepicker"
								name="nextduedate" placeholder="Next Due Date"
								data-type="dateIso" readonly> <input type="hidden"
								name="studentid" value="<%=stuid%>">
						</div>
						<div class="form-group">
							<div class="col-lg-offset-2 col-lg-10">
								<button type="submit" class="btn btn-default">Sign in</button>
							</div>
						</div>
					</form>

				</div>

			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {

			$("#newpayment").submit(function() {

				$('#newpayment').parsley('validate');

				if ($('#newpayment').parsley('isValid')) {

				} else {
					$.gritter.add({
						title : 'Fill Fields',
						text : 'Oops Please Fill All Fields'
					});
					return false;
				}

				var str = $(this).serialize();

				$.ajax({
					url : "../Ajax/newPayment.jsp",
					type : "POST",
					data : str,
					success : function(data, textStatus, jqXHR) {
						if (data == 1) {
							$.gritter.add({
								title : 'Success',
								text : 'All new Payment Added'
							});
							window.location.reload();
						} else {
							$.gritter.add({
								title : 'Sorry',
								text : 'Some Error Occured, Please Try Again.'
							});
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						alert("Sorry, Error.");
						$.gritter.add({
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