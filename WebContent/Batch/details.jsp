
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="general.GetInfoAbout"%>
<%
	String bid = request.getParameter("id");
	if (bid == null) {
		response.sendRedirect(request.getContextPath()
		+ "/Batch/?msg=Invalid Batch Information");
		return;
	} else {
		if (bid.isEmpty()) {
	response.sendRedirect(request.getContextPath()
			+ "/Batch/?msg=Invalid Batch Information");
	return;
		} else {

		}
	}
	request.setAttribute("title", "Details for Batch " + bid);
%>
<%@include file="../Common/Header.jsp"%>
<%
	String Courseid, Trainerid, StartDate, EndDate, Session, type, duration, status;
	Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	ResultSet rs = s
	.executeQuery("SELECT * FROM `batchdetails` WHERE `id` = '"
			+ bid + "' LIMIT 1");
	if (rs.next()) {
		Courseid = rs.getString(2);
		Trainerid = rs.getString(3);
		StartDate = rs.getString(4);
		EndDate = rs.getString(5);
		Session = rs.getString(6);
		type = rs.getString(7);
		duration = rs.getString(8);
		status = rs.getString(10);
	} else {
		//Batch Not Found
		response.sendRedirect(request.getContextPath()
		+ "/Batch/?msg=Invalid Batch Information");
		return;
	}
%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-lg-4">
				<section class="panel">
					<div class=" state-overview">
						<section class="panel">
							<div class="symbol red">
								<i class="fa fa-group"></i>
							</div>
							<div class="value">
								<h1 style="color: rgb(136, 131, 131);">
									Batch
									<%=bid%></h1>
								<p>
									Course : <b><%=GetInfoAbout.getcoursename(Courseid)%></b>
								</p>
								<p>
									Status : <b><%=status%></b>
								</p>
							</div>
						</section>
					</div>
				</section>
			</div>
			<div class="col-lg-4">
				<section class="panel">
					<div class=" state-overview">
						<section class="panel">
							<div class="symbol red">
								<i class="fa fa-user"></i>
							</div>
							<div class="value">
								<h1 style="color: rgb(136, 131, 131);"><%=GetInfoAbout.gettrainername(Trainerid)%></h1>
								<p>
									Session : <b><%=Session%></b>
								</p>
								<p>
									Type : <b><%=type%></b>
								</p>
								<p>
									Duration : <b><%=duration%></b>
								</p>
							</div>
						</section>
					</div>
				</section>
			</div>
			<div class="col-lg-4">
				<div class="panel">
					<div class="panel-body">
						<p class="text-muted">Batch Progress</p>
						<div class="progress progress-striped active progress-sm">
							<%
						s = con.createStatement();
						String sql = "SELECT * FROM batchsession where `status`='COMPLETED' AND `batchid` = '"
								+ bid + "' ";
						rs = s.executeQuery(sql);
						int com = 0, pen = 0;
						while (rs.next()) {
							com++;
						}
						sql = "SELECT * FROM batchsession where `status`='PENDING' AND `batchid` = '"
								+ bid + "' ";
						rs = s.executeQuery(sql);
						while (rs.next()) {
							pen++;
						}
						int p = (com * 100) / (pen + com);
						%>
							<div class="progress-bar progress-bar-success" role="progressbar"
								style="width: <%=p%>%">
								<span class="sr-only"><%=p%>% Complete</span>
							</div>
						</div>
						<p>
							Batch Duration :
							<%=StartDate%>
							-
							<%=EndDate%></p>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-6">
				<section class="panel">
					<header class="panel-heading">Sessions Today</header>
					<div>
						<table class="table table-striped m-b-none text-small">
							<thead>
								<tr>
									<th>Batch Id</th>
									<th>Date</th>
									<th>Session Status</th>
									<th>Work</th>
								</tr>
							</thead>
							<tbody>
								<%
									Connection con3 = DbConnection.getConnection();
															Statement st;
															String sqlq;
															st = con3.createStatement();

															SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
															Date today = new Date();
															String todayd = ddmm.format(today);

															HttpSession ses = request.getSession();

															sqlq = "SELECT * FROM batchsession where `date` = '" + todayd
																	+ "' AND `batchid` = '" + bid + "' ";
															rs = st.executeQuery(sqlq);
															while (rs.next()) {
																String sstatus = rs.getString("status");
																int sesid = rs.getInt("id");
								%>
								<tr>
									<td>
										<%
											out.print(rs.getString("batchid"));
										%>
									</td>
									<td><%=todayd%></td>
									<td><%=sstatus%></td>
									<td>
										<%
											if (sstatus.equalsIgnoreCase("PENDING")) {
										%> <a
										href="session_operation.jsp?sid=<%=sesid%>&operation=CANCEL&bid=<%=bid%>">
											<i class="icon-remove-sign"></i>
									</a> <%
 	//to allow only one operation on session
  			ses.setAttribute("ope_allow", "true");
  		}
  		if (sstatus.equalsIgnoreCase("STARTED")) {
  			//to allow only one operation on session
  			ses.setAttribute("ope_allow", "true");
 %> <a href="#" class="<%=sesid%>" id="stopbatch"><i
											class="icon-stop"></i></a> <%
 	} else if (sstatus.equalsIgnoreCase("PENDING")) {
  			//to allow only one operation on session
 %> <a
										href="session_operation.jsp?sid=<%=sesid%>&operation=START&bid=<%=bid%>"><i
											class="icon-play"></i></a> <%
 	}
 %>
									</td>
								</tr>
								<%
									}
															con3.close();
								%>
							</tbody>
						</table>
						<br> <br> <i class="icon-remove-sign"></i> - Cancel
						Batch <i class="icon-play"></i> - Start Batch <i class="icon-stop"></i>
						- End Batch
					</div>
				</section>
				<script type="text/javascript" charset="utf-8">
					$(document).ready(function() {
						$("#stopbatch").click(function() {
							$("#attendance").toggle();
							$("#sid").val($("#stopbatch").attr('class'));
						});
					});
				</script>
				<section class="panel" id="attendance" style="display: none">
					<header class="panel-heading"> Enter id`s of Students
						Present </header>
					<form class="form-horizontal"
						action="session_operation.jsp?operation=END&bid=<%=bid%>"
						method="get">
						<div class="form-group">
							<label class="col-lg-3 control-label">Students Present</label>
							<div class="col-lg-8">
								<select multiple id="sids" name="sids" style="width: 200px"
									class="chosen-select">
									<%
										Connection dbc4 = DbConnection.getConnection();
										Statement s4 = dbc4.createStatement();
										String sql4 = "SELECT * FROM students where `batchid` = '" + bid
												+ "' ";
										rs = s4.executeQuery(sql4);
										while (rs.next()) {
									%>
									<option value="<%=rs.getString("id")%>"><%=rs.getString("fName")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-3 control-label">Topic(s) Completed</label>
							<div class="col-lg-8">
								<select multiple id="topics" name="topics" style="width: 200px"
									class="chosen-select">
									<option value="lab" selected>Lab / Disscussion</option>
									<%
										Connection dbc5 = DbConnection.getConnection();
										Statement s5 = dbc4.createStatement();
										StringBuffer sb = new StringBuffer();
										sb.append("SELECT * FROM `coursetopics` where `courseid` = ");
										sb.append(Courseid);
										sb.append(" ORDER BY `id` ASC");
										String sql7 = sb.toString();
										//System.out.print(sql7);
										rs = s5.executeQuery(sql7);
										while (rs.next()) {
									%>
									<option value="<%=rs.getString("id")%>"><%=rs.getString("topic")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-lg-3 control-label"></label>
							<div class="col-lg-8">
								<input type="hidden" name="sid" id="sid" value=""> <input
									type="hidden" name="operation" value="END"> <input
									type="hidden" name="bid" value="<%=bid%>"> <input
									type="Submit" class="btn btn-primary" value="END BATCH">
							</div>
						</div>
					</form>
				</section>
				<section class="panel">
					<header class="panel-heading">
						<span class="label bg-danger pull-right"></span> Students in Batch
					</header>
					<div>
						<table class="table table-striped m-b-none text-small">
							<thead>
								<tr>
									<th>Student id</th>
									<th>Name</th>
								</tr>
							</thead>
							<tbody>
								<%
											s = con.createStatement();
											sql = "SELECT * FROM students where `batchid` = '" + bid
													+ "' ";
											rs = s.executeQuery(sql);
											while (rs.next()) {
									%>
								<tr>
									<td>
										<%
												out.print(rs.getString("id"));
										%>
									</td>
									<td>
										<%
												out.print(rs.getString("fName"));
										%>
									</td>

								</tr>
								<%
										}
								%>
							</tbody>
						</table>
					</div>
				</section>
			</div>
			<div class="col-lg-6">
				<section class="panel">
					<header class="panel-heading bg bg-inverse"> Batch Dates </header>
					<div class="list-group">
						<%
									s = con.createStatement();
									String sqll = "SELECT * FROM batchsession where `batchid` = '"
											+ bid + "' ORDER BY `id` ASC";
									ResultSet rsss = s.executeQuery(sqll);
									String attendes = "";
									while (rsss.next()) {
										String date = rsss.getString("date");
										int sess_id = rsss.getInt("id");
										String stat = rsss.getString("status");
										String spanclass = "info";
										if (stat.equalsIgnoreCase("PENDING")) {
											spanclass = "info";
											attendes = "";
										} else if (stat.equalsIgnoreCase("STARTED")) {
											spanclass = "warning";
											attendes = "";
										} else if (stat.equalsIgnoreCase("COMPLETED")) {
											spanclass = "success";
											s = con.createStatement();
										sqll = "SELECT count(*) FROM session_attendance where `sessionid` = '"+ sess_id + "'";
										ResultSet rss3 = s.executeQuery(sqll);
										if (rss3.next())
											attendes = " | "+rss3.getInt(1) +" Attendees";
										} else if (stat.equalsIgnoreCase("CANCELLED")) {
											spanclass = "danger";
											attendes = "";
										}
							%>
						<a href="#" class="list-group-item bg-lighter"> <span
							class="badge bg-<%=spanclass%>"><%=stat%></span><%=date%><span
							class="info"><%=attendes%></span>
						</a>
						<%
								}
									//DbConnection.close();
							%>
					</div>
				</section>
			</div>
		</div>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>