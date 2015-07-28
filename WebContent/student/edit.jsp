
<%
	request.setAttribute("title", "Edit Student Details");
%>
<%@include file="../Common/Header.jsp"%>

<%@page import="java.sql.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>

<%
	ResultSet rs2 = null;
String stuid = request.getParameter("id");
if(stuid==null){
	response.sendRedirect(request.getContextPath()+"/error.jsp");
	return;
}else if(stuid.isEmpty()){
	response.sendRedirect(request.getContextPath()+"/error.jsp");
}else{
Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";

	//Get student
	sql = "SELECT * FROM `students` WHERE `id`='"+stuid+ "' LIMIT 1";
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
					<header class="panel-heading"> Edit Student Details </header>
					<div class="panel-body">
						<form class="form-horizontal" id="newstudentadd"
							data-validate="parsley">
							<div class="form-group">
								<label for="firstname" class="col-lg-2 control-label">First
									Name</label>
								<div class="col-lg-10">
									<input class="form-control" id="firstname" name="firstname"
										placeholder="FirstName" type="text" data-required="true"
										data-notblank="true" data-rangelength="[1,15]"
										value="<%=(rs2.getString("fName")==null?"":rs2.getString("fName"))%>">

								</div>
							</div>
							<div class="form-group">
								<label for="lastname" class="col-lg-2 control-label">Last
									Name</label>
								<div class="col-lg-10">
									<input class="form-control" id="lastname" name="lastname"
										placeholder="LastName" type="text" data-required="true"
										data-notblank="true" data-rangelength="[1,15]"
										value="<%=(rs2.getString("lName")==null?"":rs2.getString("lName"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="mobile" class="col-lg-2 control-label">Mobile</label>
								<div class="col-lg-10">
									<input class="form-control" id="mobile" name="mobile"
										placeholder="Mobile Number" type="text" data-required="true"
										data-notblank="true" data-type="phone"
										value="<%=(rs2.getString("Mobile")==null?"":rs2.getString("Mobile"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="email" class="col-lg-2 control-label">Email</label>
								<div class="col-lg-10">
									<input class="form-control" id="email" name="email"
										placeholder="Email Address" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,50]"
										data-type="email"
										value="<%=(rs2.getString("Emailaddress")==null?"":rs2.getString("Emailaddress"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="addresline1" class="col-lg-2 control-label">Address
									Line1</label>
								<div class="col-lg-10">
									<input class="form-control" id="addresline1" name="addresline1"
										placeholder="Addres Line1" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,20]"
										value="<%=(rs2.getString("addressline1")==null?"":rs2.getString("addressline1"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="addresline2" class="col-lg-2 control-label">Address
									Line2</label>
								<div class="col-lg-10">
									<input class="form-control" id="addressline2"
										name="addresline2" placeholder="Addres Line2" type="text"
										data-required="true" data-notblank="true"
										value="<%=(rs2.getString("addressline2")==null?"":rs2.getString("addressline2"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="city" class="col-lg-2 control-label">City</label>
								<div class="col-lg-10">
									<input class="form-control" id="city" name="city"
										placeholder="City" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,15]"
										value="<%=(rs2.getString("city")==null?"":rs2.getString("city"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="state" class="col-lg-2 control-label">State</label>
								<div class="col-lg-10">
									<input class="form-control" id="state" name="state"
										placeholder="State" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,15]"
										value="<%=(rs2.getString("state")==null?"":rs2.getString("state"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="zipcode" class="col-lg-2 control-label">ZipCode</label>
								<div class="col-lg-10">
									<input class="form-control" id="zipcode" name="zipcode"
										placeholder="Zip Code" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,10]"
										data-type="number"
										value="<%=(rs2.getString("zipcode")==null?"":rs2.getString("zipcode"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="homephone" class="col-lg-2 control-label">Home
									Phone</label>
								<div class="col-lg-10">
									<input class="form-control" id="homephone" name="homephone"
										placeholder="Home Phone" type="text" data-required="true"
										data-notblank="true" data-type="phone"
										value="<%=(rs2.getString("homephone")==null?"":rs2.getString("homephone"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="dob" class="col-lg-2 control-label">Date Of
									Birth</label>
								<div class="col-lg-10">
									<input class="form-control" id="dob" name="dob"
										placeholder="Date Of Birth" type="date" data-required="true"
										data-notblank="true" 
										value="<%=(rs2.getString("dateofbirth")==null?"":rs2.getString("dateofbirth"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="stream" class="col-lg-2 control-label">Stream</label>
								<div class="col-lg-10">
									<input class="form-control" id="stream" name="stream"
										placeholder="Stream" type="text" data-required="true"
										data-notblank="true" data-rangelength="[1,20]"
										value="<%=(rs2.getString("stream")==null?"":rs2.getString("stream"))%>">
								</div>
							</div>
							<div class="form-group">
								<label for="qualification" class="col-lg-2 control-label">Qualification</label>
								<div class="col-lg-10">
									<input class="form-control" id="qualification"
										name="qualification" placeholder="Qualification" type="text"
										data-required="true" data-notblank="true"
										data-rangelength="[1,10]"
										value="<%=(rs2.getString("qualification")==null?"":rs2.getString("qualification"))%>">
								</div>
							</div>
						<%-- 	<div class="form-group">
								<label for="totalfees" class="col-lg-2 control-label">Total
									Fees</label>
								<div class="col-lg-10">
									<input class="form-control" id="totalfees" name="totalfees"
										placeholder="Total Fees" type="text" data-required="true"
										data-notblank="true" data-rangelength="[4,10]"
										data-type="number"
										value="<%=(rs2.getString("totalfees")==null?"":rs2.getString("totalfees"))%>">
								</div>
							</div> --%>
							<input type="hidden" name="stuid" value="<%=stuid%>">
							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<a href="index.jsp" class="btn btn-default">Back</a>
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
		$("#newstudentadd").submit(function() {

			$('#newstudentadd').parsley('validate');
			
			if ($('#newstudentadd').parsley('isValid')) {
				
			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}
			
			
			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/editStudentDetails.jsp",
				type : "POST",
				data : str,
				success : function(data, textStatus, jqXHR) {
					if (data == 1) {
						$.gritter.add({
							title : 'Success',
							text : 'All Data Saved'
						});
						$(location).attr('href','profile.jsp?id=<%=stuid%>');
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
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>