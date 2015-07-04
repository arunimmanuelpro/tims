<!DOCTYPE html>
<%@page import="mailing.SendMail"%>
<%@page import="java.util.UUID"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>
<%@page import="security.SecureNew"%>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Forgot Password</title>

<link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css"
	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/style-responsive.css" rel="stylesheet" />
<script src="<%=request.getContextPath()%>/jscripts/jquery.js"></script>

<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-body">

	<div class="container">

		<%
			String email = request.getParameter("empid");

			SecureNew sn = new SecureNew();
			ResultSet rs = null;
			if (email == null) {
				response.sendRedirect(request.getContextPath() +"/index.jsp?msg=Invalid Resource");
				return;
			} else {
				if (email.isEmpty()) {
					response.sendRedirect(request.getContextPath() +"/index.jsp?msg=Invalid Resource");
					return;
				} else {
					//Actual Processing

					Connection con = DbConnection.getConnection();
					Statement ps = con.createStatement();
					String sql = "SELECT * FROM `employee` WHERE `id`='"
							+ email + "' LIMIT 1";
					rs = ps.executeQuery(sql);

					if (rs.next()) {

					} else {
						response.sendRedirect(request.getContextPath() +"/index.jsp?msg=Account Not Found Sorry");
						return;
					}
				}
			}
		%>

		<form class="form-signin" action="Forgot_Proceed.jsp" method="POST">
			<h2 class="form-signin-heading">Your Account information</h2>
				Hurray, We just found your account.
				<h3>
					Hi <b><%=rs.getString("FirstName")%></b>!
				</h3>
				<%
					String WorkEmail = rs.getString("WorkEmail");
					String PersonalEmail = rs.getString("PersonalEmail");

					if (WorkEmail != null) {
				%>
				<span><br> <input type="radio" id="email" name="email"
					value="<%=sn.decrypt(WorkEmail)%>" ><%=sn.decrypt(WorkEmail)%></span>

				<%
					}
					if (PersonalEmail != null) {
				%>
				<span> <br><input type="radio" id="email" name="email"
					value="<%=sn.decrypt(PersonalEmail)%>"><%=sn.decrypt(PersonalEmail)%></span>

				<%
					}
				%><br>
				<input type="hidden" name="empid" value="<%=email %>">
				<br>
				Select Any of the accounts Below to reset your Mail
				<button class="btn btn-lg btn-login btn-block"
					id="signinbtn" type="submit">Send Reset Details</button>
		</form>
		<script type="text/javascript">
			$(document).ready(function() {

			});
		</script>

	</div>

</body>
</html>