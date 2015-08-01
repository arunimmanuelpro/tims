<!DOCTYPE html>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%-- <% @SupressWarnings("unchecked") %> --%>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title><%=request.getAttribute("title")%> - TIMS Brain</title>
    
    <!-- Bootstrap core CSS -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/img/favicon.png">   
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">	
	<link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" 	rel="stylesheet">
	
	<%-- <link media="print" href="<%=request.getContextPath()%>/css/bootstrap-fullcalendar.css" rel="stylesheet"> --%>	
	<link media="print" href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
    <link media="print" href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">   
    <link media="print" href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" />
    <link media="print" href="<%=request.getContextPath()%>/css/style-responsive.css" rel="stylesheet" />
    
    <!--external css-->
    <link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/assets/bootstrap-datepicker/css/datepicker.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/assets/jquery-easy-pie-chart/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css" media="screen"/>
        
    <!--  right slidebar -->
    <link href="<%=request.getContextPath()%>/css/slidebars.css" rel="stylesheet">
    
    <!-- Custom styles for this template -->        
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">	
	<link href="<%=request.getContextPath()%>/css/style-responsive.css" rel="stylesheet" />	
	<link href="<%=request.getContextPath()%>/css/jqueryui.css" rel="stylesheet" />
	<link href="<%=request.getContextPath()%>/css/owl.carousel.css" rel="stylesheet" type="text/css" >
    <link href="<%=request.getContextPath()%>/css/normalize.css"/>  
	
		
	<link href="<%=request.getContextPath()%>/assets/gritter/css/jquery.gritter.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/assets/jquery-multi-select/css/multi-select.css" rel="stylesheet" type="text/css"/> 
	<link href="<%=request.getContextPath()%>/assets/advanced-datatable/media/css/demo_page.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/assets/advanced-datatable/media/css/demo_table.css" rel="stylesheet" />
    <link href="<%=request.getContextPath()%>/assets/data-tables/DT_bootstrap.css" rel="stylesheet" />   
    
    <script src="<%=request.getContextPath()%>/js/jquery.js"></script>	
   
    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
    
  </head>
  <body>
  	<noscript>
		<style type="text/css">
			#container {
				display: none;
			}
		</style>
		<div class="noscriptmsg">You don't have javascript enabled.	Please Enable it.</div>
	</noscript>
	<section id="container">
		<!--header start-->
		<header class="header white-bg">
			 <div class="sidebar-toggle-box">
                  <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
              </div>
				
			<!--logo start-->
			<a href="#" class="logo"><span style="color: #FF0000;">EYEOPEN</span><br>
				<p style="font-size: 10px; text-align: center;">TECHNOLOGIES</p></a>
			<!--logo end-->
			<div class="nav notify-row" id="top_menu">
				<!--  notification start -->
				<ul class="nav top-menu">
					<!-- notification dropdown start-->
					<li id="header_notification_bar" class="dropdown">
						<a data-toggle="modal" class="dropdown-toggle" href="#notificationsm">
							<i class="fa fa-bell-o"></i> 
							<span class="badge bg-warning" id="al1444">0</span>
						</a>
						
						<ul class="dropdown-menu extended notification">
							<!-- <div class="notify-arrow notify-arrow-yellow"> -->							
								<li><p class="yellow">Your Notifications</p></li>
							<!-- </div>
							<div id="al25"> -->
								<li><a href="#">See all notifications</a></li>
							<!-- </div> -->
						</ul>
					</li>					
					<!-- notification dropdown end -->
					<li id="header_notification_bar"></li>
				</ul>
			</div>
			
			<script type="text/javascript">
					$(document).ready(function() {
						//Load Notifications
						$("#al1444").load('<%=request.getContextPath()%>/Ajax/getNotifications.jsp?e=count');
						setInterval(function(){
					        $.get("<%=request.getContextPath()%>/Ajax/getNotifications.jsp?e=count",
									function(
										result) {
											$(
												'#al1444')
												.html(result);
											});
							}, 2000);
					});
			</script>
			
			<div class="top-nav ">
				<ul class="nav pull-right top-menu">
					<li><input type="text" class="form-control search" placeholder="Search"></li>
					<!-- user login dropdown start-->
					<li class="dropdown">
						<a data-toggle="dropdown" class="dropdown-toggle" href="#"> 
							<img alt="" width="30px" height="30px" src="<%=request.getContextPath()%>/GetPicture.jsp">
							<span class="username"><%=request.getAttribute("user")%></span><b class="caret"></b>
						</a>
						<ul class="dropdown-menu extended logout">
							<div class="log-arrow-up"></div>
							<li><a href="<%=request.getContextPath()%>/profile.jsp"><i class=" fa fa-suitcase"></i>Profile</a></li>
							<li><a href="#"><i class="fa fa-cog"></i>Settings</a></li>
							<li><a href="#Attendance" data-toggle="modal"><i class="fa fa-bell-o"></i> Attendance</a></li>
							<li><a href="<%=request.getContextPath()%>/logout.jsp"><i class="fa fa-key"></i>Log Out</a></li>
						</ul>
					</li>
					<!-- user login dropdown end -->
				</ul>
			</div>
		</header>
	</section>
    <%
    	String jobTitle = (String)session.getAttribute("designation");   
    	String roleId = (String)session.getAttribute("access");
		List<String> userroles = (List<String>)session.getAttribute("roles");
	%>
	<!--sidebar start-->
	<aside>
		<div id="sidebar" class="nav-collapse ">
			<!-- sidebar menu start-->
			<ul class="sidebar-menu" id="nav-accordion">
				<li>
					<a class="active" href="<%=request.getContextPath()%>/home.jsp"> 
						<i class="fa fa-dashboard"></i>
						<span>Dashboard</span>
					</a>
				</li>
				
				<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4") || jobTitle.equals("5") || jobTitle.equals("10") || jobTitle.equals("11") || jobTitle.equals("12")) {	%>
					<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-gears"></i><span>Enquiry</span> <span class="arrow"></span>
						</a>
						<ul class="sub">							
							<li><a class="" href="<%=request.getContextPath()%>/Enquiry/">Mail Enquiry</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Enquiry/newenquiry.jsp">New Enquiry</a></li>
							
							<li><a class="" href="<%=request.getContextPath()%>/Enquiry/?Follow">Follow Up</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Enquiry/?completed">Closed</a></li>		
							<li><a class=""	href="<%=request.getContextPath()%>/Enquiry/?Duplicate">Duplicate</a></li>							
						</ul>
					</li>	
					<%  } %>		
				
				<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4") || jobTitle.equals("5") || jobTitle.equals("10") || jobTitle.equals("11") || jobTitle.equals("12") || jobTitle.equals("7") || jobTitle.equals("8") || jobTitle.equals("9")) {	%>	
					<li class="sub-menu"> <a href="javascript:;" class=""> 
						<i class="fa fa-sitemap"></i><span>Students</span><span class="arrow"></span>
					</a>
						<ul class="sub">
							<li><a class="" href="<%=request.getContextPath()%>/student/">Pursuing</a></li>						
							<li><a class="" href="<%=request.getContextPath()%>/student/comingsoon.jsp">Alumni</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/student/comingsoon.jsp">View All</a></li>
						</ul>
					</li>					
				<%	}  %>
				
					<li class="sub-menu">
						<a href="javascript:;"> 
							<i class="fa fa-eye"></i><span>Employee</span>							
						</a>
						<ul class="sub">	
			<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")) {	%>						
							<li><a class="" href="<%=request.getContextPath()%>/Employee/">Payroll Employee</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Employee/relivedinfo.jsp">Relieved Employee</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Employee/cumulativeinfo.jsp">Employee Info</a></li>
			<%	}	%>				
							<li><a class=""	href="<%=request.getContextPath()%>/Employee/directory.jsp">Directory</a></li>
						</ul>
				  	</li>				
					<li class="sub-menu">
						<a href="<%=request.getContextPath()%>/Timesheet/" class=""> 
							<i class="fa fa-user"></i><span>Timesheets</span></span>
						</a>
						<ul class="sub">
						<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4") || jobTitle.equals("5")) {	%>
							<li><a class="" href="<%=request.getContextPath()%>/Timesheet/">Manage Category</a></li>
						<%	} %>	
							<li><a class="" href="<%=request.getContextPath()%>/Timesheet/cntTimeSheet.jsp">Current Sheet</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Timesheet/viewTimeSheet.jsp">View TimeSheet</a></li>												
						</ul> 
			  		</li>
			  	<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")) {	%>	
					<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-gear"></i><span>Management</span><span class="arrow"></span>
						</a>
						<ul class="sub">
							<li><a class="" href="<%=request.getContextPath()%>/Management/">Management Area</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Management/emailpassword.jsp">Email Password</a></li>
						<!-- 	<li><a class=""	href="javascript:;" class="">
								<i class=""></i><span>Performance</span><span class="arrow"></span></a>
								<ul class="sub">
									<li><a class="" href="comingsoon.jsp">Management Area</a></li>
									<li><a class="" href="comingsoon.jsp">Attendance Report</a></li>
									<li><a class=""	href="comingsoon.jsp">Leave Report</a></li>
								</ul>
							</li> -->								
						</ul>
					</li> 
					<% } %>
						<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-crop"></i><span>Leave</span><span class="arrow"></span>
						</a>
						<ul class="sub">						
							<li><a class="" href="<%=request.getContextPath()%>/Leave/"> List of Leaves</a> 
						<%	if (jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")) {	%>		
							<li><a class="" href="<%=request.getContextPath()%>/Leave/leavetype.jsp"> Manage Leaves</a></li>							
						<%	} %>	
							<li><a class=""	href="<%=request.getContextPath()%>/Leave/myLeave.jsp"> My Leave</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Leave/leaveList.jsp"> Leave List</a></li>															
						</ul>
					</li> 
					
					
						<li class="sub-menu">
							<a href="javascript:;" class=""> 
							<i class="fa fa-group"></i><span>Batch</span><span class="arrow"></span> </a>
							<ul class="sub">
							<% 			
								if(jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4") || jobTitle.equals("5")){
							%>	
								<li><a class="" href="<%=request.getContextPath()%>/Batch/">New Batch</a></li>
							<% 	}	%>
							    <li><a href="<%=request.getContextPath()%>/comingsoon.jsp">Scheduled Batch</a></li>
								<li><a href="<%=request.getContextPath()%>/comingsoon.jsp">Batch Info</a></li>							
							</ul>
						</li>
						<li class="sub-menu">
							<a href="javascript:;" class=""> 
							<i class="fa fa-legal"></i><span>Online Exam</span><span class="arrow"></span> </a>
							<ul class="sub">
							<% 	if(jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")){	%>	
									<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Centre</a></li>
							<% 	}	%>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Schedule</a></li>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Reviews</a></li>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Report</a></li>							
							</ul>
						</li>
				
				<%	if(jobTitle.equals("2") || jobTitle.equals("3")) {	%>
				<li class="sub-menu">
					<a href="javascript:;" class="">
						<i class="fa fa-suitcase"></i><span>Payroll</span><span class="arrow"></span>
					</a>
					<ul class="sub">
						<li><a class="" href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Generate Payroll</a></li>
						<li><a class=""	href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Salary Advance</a></li>
						<li><a class=""	href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Loan</a></li>
					</ul></li>
				<%	}  if(jobTitle.equals("2") || jobTitle.equals("3") || jobTitle.equals("4")){ %>
				<li class="sub-menu"><a href="javascript:;" class=""><i
						class="fa fa-signal"></i> <span>Report</span><span class="arrow"></span>
				</a>
					<ul class="sub">					
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Student Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Batch Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Enquiry Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Timesheet Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Leave Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Employee Report</a></li>
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Management Report</a></li>
					<% } if(jobTitle.equals("2") || jobTitle.equals("3")){ %>	
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Payroll Report</a></li>
					<% } %>	
					</ul></li>				
			</ul>
			<!-- sidebar menu end-->
		</div>
	</aside>
	<!--sidebar end-->
	 