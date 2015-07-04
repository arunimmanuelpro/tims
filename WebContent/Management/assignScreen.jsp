<!DOCTYPE html>
<%@page import="constant.InfoConstant"%>
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

    <title>Advanced Form Components</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/bootstrap-reset.css" rel="stylesheet">
    <!--external css-->
    <link href="<%=request.getContextPath()%>/assets/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-fileupload/bootstrap-fileupload.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-datepicker/css/datepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-timepicker/compiled/timepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-colorpicker/css/colorpicker.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-daterangepicker/daterangepicker-bs3.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/bootstrap-datetimepicker/css/datetimepicker.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/assets/jquery-multi-select/css/multi-select.css" />

    <!--right slidebar-->
    <link href="<%=request.getContextPath()%>/css/slidebars.css" rel="stylesheet">

    <!--  summernote -->
    <link href="<%=request.getContextPath()%>/assets/summernote/dist/summernote.css" rel="stylesheet">

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
<%
	Connection con = DbConnection.getConnection();
	PreparedStatement ps,ps1;
	String sql = "";	
%>
      <!--sidebar end-->
      <!--main content start-->
      <section id="main-content">
          <section class="wrapper">
          <!-- page start-->
              <!--multiple select start-->
              <div class="row">
              <div class="col-md-12">
                  <section class="panel">
                      <header class="panel-heading">
                          Multiple Select
                          <span class="tools pull-right">
                            <a href="javascript:;" class="fa fa-chevron-down"></a>
                            <a href="javascript:;" class="fa fa-times"></a>
                          </span>
                      </header>
                      <div class="panel-body">
                      <form action="#" class="form-horizontal tasi-form">
                      		 <div class="form-group">
								<label for="pancard" class="col-lg-3 control-label"> Select Job Title:</label>
								<div class="col-lg-8">													
									<select id="roleid" class="form-control" name="roleid"
										data-required="true" data-notblank="true">
										<option value="">---select---</option>
									<%
										ps = con.prepareStatement("SELECT * FROM `jobtitles` ORDER BY `id`");
								        ResultSet rs = ps.executeQuery();
										while (rs.next()) {
									%>
								         <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
									<%	}
										rs.close(); ps.close();	
									%>
									</select>											
								</div>
							 </div>
                             <div class="form-group">
                                  <label class="control-label col-md-3">Grouped Options</label>
                                  <div class="col-md-9">
                                      <select multiple="multiple" class="multi-select" id="my_multi_select2" name="my_multi_select2[]">
                                      <%
										ps = con.prepareStatement("SELECT * FROM `group` ORDER BY `id`");
								        rs = ps.executeQuery();
										while (rs.next()) {
									  %>
                                          <optgroup id="<%=rs.getString(1) %>" label="<%=rs.getString(2) %>">
                                          <%
											ps = con.prepareStatement("SELECT * FROM `groupitems` where groupid=? ORDER BY `id`");
                                            ps.setInt(1, Integer.parseInt(rs.getString(1)));
								        	ResultSet rs1 = ps.executeQuery();
											while (rs1.next()) {
									      %>
                                              <option value="<%=rs1.getString(1) %>"><%=rs1.getString(2) %></option>
                                      <%
											}
										}
                                      %>    
                                          </optgroup>                                          
                                      </select>
                                  </div>
                              </div>  
                              <div class="modal-footer">
                                	<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                                    <button class="btn btn-success" type="submit">Save changes</button>
                              </div>	                       
                      </form>
                  </div>
                  </section>
              </div>
          </div>
              <!--multiple select end-->

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
    <script src="<%=request.getContextPath()%>/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/respond.min.js" ></script>
  
    <!--this page plugins-->

  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/fuelux/js/spinner.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-fileupload/bootstrap-fileupload.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-wysihtml5/wysihtml5-0.3.0.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-wysihtml5/bootstrap-wysihtml5.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-datetimepicker/js/bootstrap-datetimepicker.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-daterangepicker/moment.min.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-daterangepicker/daterangepicker.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/bootstrap-timepicker/js/bootstrap-timepicker.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/jquery-multi-select/js/jquery.multi-select.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/assets/jquery-multi-select/js/jquery.quicksearch.js"></script>


  <!--summernote-->
  <script src="<%=request.getContextPath()%>/assets/summernote/dist/summernote.min.js"></script>

  <!--right slidebar-->
  <script src="<%=request.getContextPath()%>/js/slidebars.min.js"></script>

  <!--common script for all pages-->
    <script src="<%=request.getContextPath()%>/js/common-scripts.js"></script>
    <!--this page  script only-->
    <script src="<%=request.getContextPath()%>/js/advanced-form-components.js"></script>

  <script>
  	  jQuery(document).ready(function(){
          $('.summernote').summernote({
              height: 200,                 // set editor height
              minHeight: null,             // set minimum height of editor
              maxHeight: null,             // set maximum height of editor
              focus: true                 // set focus to editable area after initializing summernote
          });
      });
  </script>

  </body>
</html>
