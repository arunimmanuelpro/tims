<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="general.GetInfoAbout"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	request.setAttribute("title", "Payroll Process");
%>
<%@include file="../Common/Header.jsp"%>

<%
Connection con;
	ResultSet rs;
	int adv_amt = 0;
	String id = request.getParameter("id");
	String empid22 = "";
	if (id == null) {
		response.sendRedirect(request.getContextPath()
		+ "/Payroll/advanceIndex.jsp?msg=Access Error");
		return;
	} else {
		if (id.isEmpty()) {
	response.sendRedirect(request.getContextPath()
	+ "/Payroll/advanceIndex.jsp?msg=Access Error");
	return;
		} else {
	//process
	con = DbConnection.getConnection();
	Statement s = con.createStatement();
	String sql = "SELECT * FROM `advance` WHERE `id` = '"
	+ id + "' LIMIT 1";
	rs = s.executeQuery(sql);

	if (rs.next()) {
		empid22 = rs.getString("empid");
	} else {
		response.sendRedirect(request.getContextPath()
		+ "/Payroll/advanceIndex.jsp?msg=Information Invalid");
		return;
	}

		}
	}
%>
<%


%>
<%
	if(GetInfoAbout.getbasicpay(empid22)!=null){
int adv = Integer.parseInt(GetInfoAbout.getbasicpay(empid22));
float advamt = adv*0.3f;
adv_amt = (int)advamt;
}else{
	response.sendRedirect(request.getContextPath()
	+ "/Payroll/advanceIndex.jsp?msg=Information Invalid");
	return;
}
%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">

		<div class="modal-body">
			<div class="row">
				<div class="col-lg-12">
					<section class="panel">
						<header class="panel-heading">Advance Process</header>
						<div class="panel-body">
							<form class="form-horizontal" id="contactup"
								data-validate="parsley">
								<input type="hidden" id="pr" name="pr" value="<%=id%>">
								<div class="form-group">
									<label for="empid" class="col-lg-3 control-label">Employee
										Id </label>
									<div class="col-lg-8">
										<input class="form-control" readonly id="empid" name="empid"
											data-required="true" value="<%=empid22%>" type="text">
									</div>
								</div>
								<div class="form-group">
									<label for="EmpName" class="col-lg-3 control-label">Employee
										Name</label>
									<div class="col-lg-8">
										<input class="form-control" id="Empname" name="Empname"
											readonly placeholder="Emp Name" data-required="true"
											value="<%=GetInfoAbout.gettrainername(empid22) %>" type="text">
									</div>
								</div>
								<div class="form-group">
									<label for="maxallowed" class="col-lg-3 control-label">Maximum
										Allowed</label>
									<div class="col-lg-8">
										<input class="form-control" id="maxallow" name="maxallow"
											data-required="true" value="<%=adv_amt%>" readonly
											type="text">
									</div>
								</div>
								<div class="form-group">
									<label for="paidamt" class="col-lg-3 control-label">Amount
										Paid</label>
									<div class="col-lg-8">
										<input class="form-control" id="paidamt" data-required="true"
											name="paidamt" placeholder="Amount Paid"
											data-range="[100,<%= adv_amt %>]" type="text">
									</div>
								</div>
								<div class="form-group">
									<div class="col-lg-offset-2 col-lg-10">
										<a href="advanceIndex.jsp"
											class="btn btn-default">Back</a>
										<button type="submit" class="btn btn-danger">Update</button>
									</div>
								</div>
								<script type="text/javascript">
									$(document)
											.ready(
													function() {

														//Contact Details Update Start
														$("#contactup")
																.submit(
																		function() {

																			$(
																					'#contactup')
																					.parsley(
																							'validate');
																			if (!$(
																					'#contactup')
																					.parsley(
																							'isValid')) {
																				$.gritter
																						.add({
																							title : 'Fill Fields',
																							text : 'Oops Please Fill All Fields'
																						});
																				return false;
																			} else {

																			}

																			var str = $(
																					this)
																					.serialize();

																			$
																					.ajax({
																						url : "../Ajax/generateAdvance.jsp",
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
																								$(location).attr('href','advanceIndex.jsp');
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




							</form>
						</div>
					</section>
				</div>
			</div>
		</div>

	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>