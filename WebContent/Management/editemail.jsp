<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "Edit Email Crentials");
%>
<%@include file="/Common/Header.jsp"%>
<%int id = Integer.parseInt(request.getParameter("id"));
Connection con = DbConnection.getConnection();
PreparedStatement ps = con.prepareStatement("select * from emailaccounts where id = ?");
ps.setInt(1, id);
ResultSet rs = ps.executeQuery();
if(rs.next()){
%>
<section id="main-content">
	<section class="wrapper">
			<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="icon-folder-open">Edit Email Crendials</i>
						</h3>
						</div>
						</div>
						</div>
						
		<div class="panel-body">
								<form class="form-horizontal" id="editemail" name="editemails" action ="<%=request.getContextPath() %>/Ajax/emailupdate.jsp" method = "post">
								
								<div  class="form-group" align = "center">
								
								
								<div class="form-group">
										<label class="col-lg-3 control-label">Name</label>
										<div class="col-lg-8">
											<input type="text" name="name" id="name" value="<%=rs.getString("ename")%>"
												data-required="true" class="form-control parsley-validated" required>
										</div>
									</div>
									<div class="form-group">
										<label class="col-lg-3 control-label">Email</label>
										<div class="col-lg-8">
											<input type="text" name="email" id="email" value="<%=rs.getString("email")%>"
												data-required="true" class="form-control parsley-validated" required>
										</div>
									</div>
											<div class="form-group">
										<label class="col-lg-3 control-label">Old Password</label>
										<div class="col-lg-8">
											<input type="password" name="oldpass" id="oldpass" value=""
												data-required="true" class="form-control parsley-validated" required>
										</div>
									</div>
											<div class="form-group">
										<label class="col-lg-3 control-label">New Password</label>
										<div class="col-lg-8">
											<input type="password" name="newpass" id="newpass" value=""
												data-required="true" class="form-control parsley-validated" required>
										</div>
									</div>
											<div class="form-group">
										<label class="col-lg-3 control-label">Re Enter password</label>
										<div class="col-lg-8">
											<input type="password" name="repass" id="repass" value=""
												data-required="true" class="form-control parsley-validated" required>
										</div>
									</div>
									<div class="form-group">
										<div class="col-lg-9 col-lg-offset-3">
										<input type= "hidden" name=  "id" value = "<%= id%>"/>
											<input type="submit" value="Update" class="btn btn-primary">
										
										<input type="button" value="Back" class="btn btn-danger" onclick = "window.history.back();">
										</div>
									</div>
									</div>
									</form>
									</div>
									</section>
									</section>
								

<%} %>

<script>
$(document).ready(function(){
	$("#editemail").submit(function(){
		var newpass = $("#newpass").val();
		var repass = $("#repass").val()
if(	newpass!=repass){
	alert("Enter Same Password Twice");
	return false;
}
	});
});


</script>

<%con.close(); %>


<%@include file="/Common/Footer.jsp"%>