<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Login - TIMS [The Brain]</title>

<link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css"	rel="stylesheet" />
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/css/style-responsive.css"	rel="stylesheet" />
<script src="<%=request.getContextPath()%>/js/jquery.js"></script>

<!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body class="login-body">

	<div class="container">

		<form class="form-signin" action="LoginAuthService" method="POST">
			<h2 class="form-signin-heading">Sign in now</h2>
			<%
				String msg = request.getParameter("msg");
				if (msg != null && (!msg.isEmpty())) {
			%>
					<div class="alert alert-block alert-danger"><%=msg%></div>
			<%
				}
			%>
			<div class="login-wrap">
				<input type="text" id="userName" name="userName" class="form-control" placeholder="Employee Id" autofocus> 
				<input type="password" readonly id="passWord" name="passWord" class="form-control" placeholder="Password">
				<div id="remm">
					<label class="checkbox"> <input type="checkbox" id="rembtn"	value="remember-me">Remember me</label>
				</div>
				<button class="btn btn-lg btn-login btn-block" disabled id="signinbtn" type="submit">Sign in</button>
					<a class="btn btn-sm btn-block" id="fpp">Forgot Password</a>
			</div>
		</form>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#userName").keyup(function() {
					var usern = $("#userName").val();
					if (usern != "" && usern.length >= 1) {
						$("#passWord").attr("readonly", false);
						$("#signinbtn").attr("disabled", false);
					} else {
						$("#passWord").attr("readonly", true);
						$("#signinbtn").attr("disabled", true);
					}
				});

				//Hide Forgot Password Area
				$("#forgotpassf").hide();

				//Toggle Forgot password Area
				$("#fpp").click(function() {
					$("#forgotpassf").toggle();
					$("#passWord").toggle();
					$("#userName").toggle();
					$("#remm").toggle();
					$("#signinbtn").toggle();
				});
			});
		</script>
		<form class="form-signin" id="forgotpassf"
			action="Accounts/Recovery/ForgotProcess.jsp" method="POST">
			<h2 class="form-signin-heading">Forgot Password</h2>
			<div class="login-wrap">
				<input type="text" id="empid" name="empid" class="form-control"	placeholder="Employee Id" autofocus> 
				<input type="submit" class="btn btn-login btn-lg btn-block" value="Get">
			</div>
		</form>
	</div>
</body>
</html>