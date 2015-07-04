
<!DOCTYPE html>
<%@page import="security.SecureNew"%>
<%@page import="constant.InfoConstant"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Mosaddek">
    <meta name="keyword" content="FlatLab, Dashboard, Bootstrap, Admin, Template, Theme, Responsive, Fluid, Retina">
    <link rel="shortcut icon" href="img/favicon.png">

    <title>People Directory</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <!--right slidebar-->
    <link href="<%=request.getContextPath()%>/css/slidebars.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/style-responsive.css" rel="stylesheet" />

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 tooltipss and media queries -->
    <!--[if lt IE 9]>
      <script src="js/html5shiv.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

  <section id="container" class="">
      <!--header start-->
      <header class="header white-bg">
          <div class="sidebar-toggle-box">
              <div data-original-title="Toggle Navigation" data-placement="right" class="fa fa-bars tooltips"></div>
          </div>
          <!--logo start-->
          <a href="#" class="logo"><span style="color: #FF0000;">EYEOPEN</span><br>
				<p style="font-size: 10px; text-align: center;">TECHNOLOGIES</p></a>
          <!-- <a href="index.html" class="logo" >Flat<span>lab</span></a> -->
          <!--logo end-->
          <div class="nav notify-row" id="top_menu">
            <!--  notification start -->
            <ul class="nav top-menu">
              <!-- settings start -->
              <li class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                      <i class="fa fa-tasks"></i>
                      <span class="badge bg-success">6</span>
                  </a>
                  <ul class="dropdown-menu extended tasks-bar">
                      <div class="notify-arrow notify-arrow-green"></div>
                      <li>
                          <p class="green">You have 6 pending tasks</p>
                      </li>
                      <li>
                          <a href="#">
                              <div class="task-info">
                                  <div class="desc">Dashboard v1.3</div>
                                  <div class="percent">40%</div>
                              </div>
                              <div class="progress progress-striped">
                                  <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
                                      <span class="sr-only">40% Complete (success)</span>
                                  </div>
                              </div>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <div class="task-info">
                                  <div class="desc">Database Update</div>
                                  <div class="percent">60%</div>
                              </div>
                              <div class="progress progress-striped">
                                  <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">
                                      <span class="sr-only">60% Complete (warning)</span>
                                  </div>
                              </div>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <div class="task-info">
                                  <div class="desc">Iphone Development</div>
                                  <div class="percent">87%</div>
                              </div>
                              <div class="progress progress-striped">
                                  <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 87%">
                                      <span class="sr-only">87% Complete</span>
                                  </div>
                              </div>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <div class="task-info">
                                  <div class="desc">Mobile App</div>
                                  <div class="percent">33%</div>
                              </div>
                              <div class="progress progress-striped">
                                  <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 33%">
                                      <span class="sr-only">33% Complete (danger)</span>
                                  </div>
                              </div>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <div class="task-info">
                                  <div class="desc">Dashboard v1.3</div>
                                  <div class="percent">45%</div>
                              </div>
                              <div class="progress progress-striped active">
                                  <div class="progress-bar"  role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
                                      <span class="sr-only">45% Complete</span>
                                  </div>
                              </div>

                          </a>
                      </li>
                      <li class="external">
                          <a href="#">See All Tasks</a>
                      </li>
                  </ul>
              </li>
              <!-- settings end -->
              <!-- inbox dropdown start-->
              <li id="header_inbox_bar" class="dropdown">
                  <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                      <i class="fa fa-envelope-o"></i>
                      <span class="badge bg-important">5</span>
                  </a>
                  <ul class="dropdown-menu extended inbox">
                      <div class="notify-arrow notify-arrow-red"></div>
                      <li>
                          <p class="red">You have 5 new messages</p>
                      </li>
                      <li>
                          <a href="#">
                              <span class="photo"><img alt="avatar" src="./img/avatar-mini.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Jonathan Smith</span>
                                    <span class="time">Just now</span>
                                    </span>
                                    <span class="message">
                                        Hello, this is an example msg.
                                    </span>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <span class="photo"><img alt="avatar" src="./img/avatar-mini2.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Jhon Doe</span>
                                    <span class="time">10 mins</span>
                                    </span>
                                    <span class="message">
                                     Hi, Jhon Doe Bhai how are you ?
                                    </span>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <span class="photo"><img alt="avatar" src="./img/avatar-mini3.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Jason Stathum</span>
                                    <span class="time">3 hrs</span>
                                    </span>
                                    <span class="message">
                                        This is awesome dashboard.
                                    </span>
                          </a>
                      </li>
                      <li>
                          <a href="#">
                              <span class="photo"><img alt="avatar" src="./img/avatar-mini4.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Jondi Rose</span>
                                    <span class="time">Just now</span>
                                    </span>
                                    <span class="message">
                                        Hello, this is metrolab
                                    </span>
                          </a>
                      </li>
                      <li>
                          <a href="#">See all messages</a>
                      </li>
                  </ul>
              </li>
              <!-- inbox dropdown end -->
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
      <!--header end-->
      <!--sidebar start-->
      <aside>
          <div id="sidebar"  class="nav-collapse ">
              <!-- sidebar menu start-->
             <ul class="sidebar-menu" id="nav-accordion">
				<li>
					<a class="active" href="<%=request.getContextPath()%>/home.jsp"> 
						<i class="fa fa-dashboard"></i>
						<span>Dashboard</span>
					</a>
				</li>
				<li class="sub-menu">
						<a href="javascript:;"> 
							<i class="fa fa-eye"></i><span>Employee</span>							
						</a>
						<ul class="sub">							
							<li><a class="" href="<%=request.getContextPath()%>/Employee/">Payroll Employee</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Employee/relivedinfo.jsp">Relieved Employee</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Employee/cumulativeinfo.jsp">Employee Info</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Employee/directory.jsp">Directory</a></li>
						</ul>
				  	</li>
					<li class="sub-menu">
						<a href="<%=request.getContextPath()%>/Timesheet/" class=""> 
							<i class="fa fa-user"></i><span>Timesheets</span></span>
						</a>
						<ul class="sub">
							<li><a class="" href="cntTimeSheet.jsp">Current Sheet</a></li>
							<li><a class="" href="viewTimeSheet.jsp">View TimeSheet</a></li>												
						</ul> 
			  		</li>
			  		<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-gear"></i><span>Management</span><span class="arrow"></span>
						</a>
						<ul class="sub">
							<li><a class="" href="<%=request.getContextPath()%>/Management/">Management Area</a></li>
							
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
					<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-crop"></i><span>Leave</span><span class="arrow"></span>
						</a>
						<ul class="sub">
							<li><a class="" href="<%=request.getContextPath()%>/Leave/">List of Leaves</a> 
							<li><a class="" href="<%=request.getContextPath()%>/Leave/leavetype.jsp">Leave Type</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Leave/assignLeave.jsp">Assign Leave</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Leave/myLeave.jsp">My Leave</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Leave/leaveList.jsp">Leave List</a></li>															
						</ul>
					</li> 
					<li class="sub-menu">
						<a href="javascript:;" class=""> 
							<i class="fa fa-gears"></i><span>Enquiry</span> <span class="arrow"></span>
						</a>
						<ul class="sub">
							<li><a class="" href="<%=request.getContextPath()%>/Enquiry/">New Enquiry</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/Enquiry/">Pending</a></li>
							<li><a class=""	href="<%=request.getContextPath()%>/Enquiry/?completed">Completed</a></li>
						</ul>
					</li>
					<li class="sub-menu"> <a href="javascript:;" class=""> 
						<i class="fa fa-sitemap"></i><span>Students</span><span class="arrow"></span>
					</a>
						<ul class="sub">
							<li><a class="" href="comingsoon.jsp">Pursuing</a></li>						
							<li><a class="" href="comingsoon.jsp">Alumni</a></li>
							<li><a class="" href="<%=request.getContextPath()%>/student/">View All</a></li>
					</ul></li>
						<li class="sub-menu">
							<a href="javascript:;" class=""> 
							<i class="fa fa-group"></i><span>Batch</span><span class="arrow"></span> </a>
							<ul class="sub">
								<li><a class="" href="<%=request.getContextPath()%>/Batch/">New Batch</a></li>
							    <li><a href="<%=request.getContextPath()%>/comingsoon.jsp">Scheduled Batch</a></li>
								<li><a href="<%=request.getContextPath()%>/comingsoon.jsp">Batch Info</a></li>							
							</ul>
						</li>
						<li class="sub-menu">
							<a href="javascript:;" class=""> 
							<i class="fa fa-legal"></i><span>Online Exam</span><span class="arrow"></span> </a>
							<ul class="sub">
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Centre</a></li>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Schedule</a></li>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Reviews</a></li>
								<li><a class="" href="<%=request.getContextPath()%>/Exam/comingsoon.jsp">Exam Report</a></li>							
							</ul>
						</li>
				<li class="sub-menu">
					<a href="javascript:;" class="">
						<i class="fa fa-suitcase"></i><span>Payroll</span><span class="arrow"></span>
					</a>
					<ul class="sub">
						<li><a class="" href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Generate Payroll</a></li>
						<li><a class=""	href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Salary Advance</a></li>
						<li><a class=""	href="<%=request.getContextPath()%>/Payroll/comingsoon.jsp">Loan</a></li>
					</ul></li>
			
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
						<li><a class="" href="<%=request.getContextPath()%>/Report/comingsoon.jsp">Payroll Report</a></li>
					</ul></li>			
			</ul>
              <!-- sidebar menu end-->
          </div>
      </aside>
      <!--sidebar end-->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper site-min-height">
              <!-- page start-->
              <ul class="directory-list">
                  <li><a href="#">a</a></li>
                  <li><a href="#">b</a></li>
                  <li><a href="#">c</a></li>
                  <li><a href="#">d</a></li>
                  <li><a href="#">e</a></li>
                  <li><a href="#">f</a></li>
                  <li><a href="#">g</a></li>
                  <li><a href="#">h</a></li>
                  <li><a href="#">i</a></li>
                  <li><a href="#">j</a></li>
                  <li><a href="#">k</a></li>
                  <li><a href="#">l</a></li>
                  <li><a href="#">m</a></li>
                  <li><a href="#">n</a></li>
                  <li><a href="#">o</a></li>
                  <li><a href="#">p</a></li>
                  <li><a href="#">q</a></li>
                  <li><a href="#">r</a></li>
                  <li><a href="#">s</a></li>
                  <li><a href="#">t</a></li>
                  <li><a href="#">u</a></li>
                  <li><a href="#">v</a></li>
                  <li><a href="#">w</a></li>
                  <li><a href="#">x</a></li>
                  <li><a href="#">y</a></li>
                  <li><a href="#">z</a></li>
              </ul>
              <div class="directory-info-row">
              <div class="row">        

<%
	SecureNew sn = new SecureNew();
	Connection con = DbConnection.getConnection();	
	PreparedStatement s;
	String sql = "";
	//Get Emp
	sql = "SELECT * FROM `employee` WHERE TerminationId is null order by id";
	s = con.prepareStatement(sql);
	ResultSet empSet = s.executeQuery();
	while(empSet.next()){
		String Eid = empSet.getString("id");
		String Fname = empSet.getString("FirstName");
		String Lname = empSet.getString("LastName");
%>
        <div class="col-md-6 col-sm-6">
                  <div class="panel">
                      <div class="panel-body">
                          <div class="media">
                              <a class="pull-left" href="#">
                                  <img class="thumb media-object" src="<%=request.getContextPath()%>/GetPicture.jsp?empid=<%=Eid %>" alt="">
                              </a>
                              <div class="media-body">
                                  <h4><%=Fname %> <%=Lname %><span class="text-muted small"> - <%=GetInfoAbout.getjobtitlename(empSet.getString("JobTitleId")) %></span></h4>
                                  <ul class="social-links">
                                      <li><a title="" data-placement="top" data-toggle="tooltip" class="tooltips" href="" data-original-title="Facebook"><i class="fa fa-facebook"></i></a></li>
                                      <li><a title="" data-placement="top" data-toggle="tooltip" class="tooltips" href="" data-original-title="Twitter"><i class="fa fa-twitter"></i></a></li>
                                      <li><a title="" data-placement="top" data-toggle="tooltip" class="tooltips" href="" data-original-title="LinkedIn"><i class="fa fa-linkedin"></i></a></li>
                                      <li><a title="" data-placement="top" data-toggle="tooltip" class="tooltips" href="" data-original-title="Skype"><i class="fa fa-skype"></i></a></li>
                                  </ul>
                                  <address>
                                      <strong><%=InfoConstant.companyName %></strong><br>
                                      <%=sn.decrypt(empSet.getString("AddressLine1")) %><br>
                                      <%=sn.decrypt(empSet.getString("AddressLine2")) %>, <%=empSet.getString("City") %><br>   
                                      <%=sn.decrypt(empSet.getString("WorkEmail")) %><br>                                   
                                      <abbr title="Phone">P:</abbr> <%=empSet.getString("Mobile") %>
                                  </address>

                              </div>
                          </div>
                      </div>
                  </div>
         </div>   
<%	} 
	empSet.close(); s.close(); con.close();
%>
           

              </div>
              </div>
              <!-- page end-->
          </section>
      </section>
      <!--main content end-->
    </section>

    <!-- js placed at the end of the document so the pages load faster -->
    <script src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.scrollTo.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/slidebars.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/respond.min.js" ></script>

    <!--common script for all pages-->
    <script src="<%=request.getContextPath()%>/js/common-scripts.js"></script>



  </body>
</html>
