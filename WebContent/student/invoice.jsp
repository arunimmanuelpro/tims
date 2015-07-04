
<%@page import="general.GetInfoAbout"%>
<%
	request.setAttribute("title", "Student Invoice");
%>
<%@include file="../Common/Header.jsp"%>
<%
	Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";
	ResultSet paymentdetails;

	//Get Student Details
	String stuid = request.getParameter("id");
	if (stuid == null || stuid.isEmpty()) {
		response.sendRedirect("../error.jsp");
		return;
	}
	sql = "SELECT * FROM `students` WHERE `id` = '" + stuid + "'";
	s = con.createStatement();
	ResultSet empdetails = s.executeQuery(sql);
	if (empdetails.next()) {
		sql = "SELECT * FROM `payments` WHERE `studentid` = '" + stuid
		+ "'";
		s = con.createStatement();
		paymentdetails = s.executeQuery(sql);
	} else {
		//Student Does not Exist
		response.sendRedirect("../error.jsp?msg=invalid student information");
		return;
	}
%>
<%
	if (userroles.contains("invoice_management")) {

	} else {
		out.print("Access Denied");
		return;
	}
%>
<script type="text/javascript">
	$(document).ready(function() {

		$("#printbtn").click(function() {
			$("header").toggle();
			$("#sidebar").toggle();
			$("#wp").toggleClass("wrapper");	
		});
	});
</script>
<!--main content start-->
<section id="main-content" class="mc">
	<section class="wrapper" id="wp">
		<section>
			<div class="panel panel-info">
				<button id="printbtn" class="btn btn-info">Toggle Print
					View</button>
				<div class="panel-heading">INVOICE</div>
				<div class="panel-body" id="printable-area">
					<div class="row">
						<div class="col-lg-4"></div>
						<div class="col-lg-4">
							<h1>
								<a href="#" class="logo">TIMS<span>Brain</span></a>
							</h1>
						</div>
						<div class="col-lg-4"></div>
					</div>

					<div class="row invoice-list">
						<div class="col-lg-4 col-sm-4">
							<h4 style="text-decoration: underline;">INVOICE FROM</h4>
							<p>
								<b>TIMS BRAIN</b> <br> 192.168.127.1<br>00000000000
							</p>
						</div>
						<div class="col-lg-4 col-sm-4">
							<h4 style="text-decoration: underline;">STUDENT DETAILS</h4>
							<p>
								<%=empdetails.getString("fName")%>
								<%=empdetails.getString("lName")%>
								<br><%=empdetails.getString("addressline1")%>
								<br><%=empdetails.getString("city")%>,<%=empdetails.getString("state")%>,<%=empdetails.getString("country")%>
								<br><%=empdetails.getString("Mobile")%>
							</p>
						</div>
						<div class="col-lg-4 col-sm-4">
							<h4 style="text-decoration: underline;">INVOICE INFO</h4>
							<ul class="unstyled">
								<li>Student Number : <strong><%=empdetails.getString("id")%></strong></li>
								<li>Join Date : <%=empdetails.getString("joindate")%></li>
								<li>Student Status : <%=empdetails.getString("status")%></li>
							</ul>
						</div>
					</div>
					<table class="table table-striped table-hover">
						<thead>
							<tr>
								<th>Payment #</th>
								<th>Course</th>
								<th>Staff</th>
								<th>Method</th>
								<th>Date</th>
								<th>Amount</th>
								<th>Total</th>
							</tr>
						</thead>
						<tbody>
							<%
								long paidtotal = 0;
								while (paymentdetails.next()) {
							%>
							<tr>
								<td><%=paymentdetails.getString("id")%></td>
								<td><%=GetInfoAbout.getcoursename(empdetails
						.getString("courseid"))%></td>
								<td><%=GetInfoAbout.gettrainername(paymentdetails
						.getString("collectedbyid"))%></td>
								<td><%=paymentdetails.getString("method")%></td>
								<td><%=paymentdetails.getString("date")%></td>
								<td><%=paymentdetails.getString("amount")%></td>
								<td><%=paymentdetails.getString("amount")%></td>

							</tr>
							<%
								int amt = Integer.parseInt(paymentdetails.getString("amount"));
									paidtotal = paidtotal + amt;
								}
							%>
						</tbody>
					</table>
					<div class="row">
						<div class="col-lg-4 invoice-block pull-right">
							<ul class="unstyled amounts">
								<li><strong>Sub - Total amount :</strong> <%=paidtotal%></li>
								<li><strong>Grand Total :</strong> <%=paidtotal%></li>
								<li><strong>Balance :</strong> <%=empdetails.getInt("totalfees") - paidtotal%></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>