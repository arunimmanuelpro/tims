<%@page import="access.DbConnection"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "Home");
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	Date today = new Date();
	String td = sdf.format(today);
	Connection con = DbConnection.getConnection();
	ResultSet rs;
	Statement st;
	String sqlq;
	
	/* st = con.createStatement();	
	total batch count		
		int tbatches = 0;
		int total_dates = 0;
		int total_courses = 0;
		int total_enq = 0;	
		tbatches = GetInfoAbout.getBatchCount();		
		sqlq = "SELECT Count(*) FROM batchsession";
		rs = st.executeQuery(sqlq);
			if(rs.next())
		total_dates = rs.getInt(1);		
		sqlq = "SELECT Count(*) FROM enquiry";
		rs = st.executeQuery(sqlq);
			if (rs.next())
			total_enq = rs.getInt(1);
			total courses
			sqlq = "SELECT Count(*) FROM coursedetails";
			rs = st.executeQuery(sqlq);
		if (rs.next())
			total_courses = rs.getInt(1); */
%>
<%@include file="Common/Header.jsp"%>
<script>	



function getContextPath() {
	   return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	}

</script>
<script>
function countUp(count,variable)
{
    var div_by = 100,
        speed = Math.round(count / div_by),
        $display = $(variable),
        run_count = 1,
        int_speed = 24;

    var int = setInterval(function() {
        if(run_count < div_by){
            $display.text(speed * run_count);
            run_count++;
        } else if(parseInt($display.text()) < count) {
            var curr_count = parseInt($display.text()) + 1;
            $display.text(curr_count);
        } else {
            clearInterval(int);
        }
    }, int_speed);
}
function initVal(url,variable){
	
	var xmlhttp;
	if (window.XMLHttpRequest)
	  {
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  val = xmlhttp.responseText;
		  val = val.replace(/(\r\n|\n|\r)/gm,"");
			console.log(variable +"    "+val);
			
			countUp(val,variable);

	    }
	  }
	xmlhttp.open("GET",url,true);
	xmlhttp.send();
}
initVal(getContextPath()+"/Ajax/homeajax.jsp?i=batch",".count");
initVal(getContextPath()+"/Ajax/homeajax.jsp?i=present",".count2");
initVal(getContextPath()+"/Ajax/homeajax.jsp?i=enquiry",".count3");
initVal(getContextPath()+"/Ajax/homeajax.jsp?i=batchCnt",".count4");
</script>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row state-overview">
			<div class="col-lg-12">
				<section class="panel">
				
				 <div class="row state-overview">
                  <div class="col-lg-3 col-sm-6">
                      <section class="panel">
                          <div class="symbol terques">
                              <i class="fa fa-microphone"></i>
                          </div>
                          <div class="value">
                              <h1 class="count">
                                  <span id="al1"></span>                                  
                              </h1>
                              <p>Session</p>
                          </div>
                      </section>
                  </div>
                  <div class="col-lg-3 col-sm-6">
                      <section class="panel">
                          <div class="symbol red">
                              <i class="fa fa-group"></i>
                          </div>
                          <div class="value">
                              <h1 class="count2">
                                  <span id="al2"></span>
                              </h1>
                              <p>Login Employee</p>
                          </div>
                      </section>
                  </div>
                  <div class="col-lg-3 col-sm-6">
                      <section class="panel">
                          <div class="symbol yellow">
                              <i class="fa fa-puzzle-piece"></i>
                          </div>
                          <div class="value">                          
                              <h1 class="count3">
                                <span id="al3"></span>
                              </h1>
                              <p>Enquires</p>                              
                          </div>
                      </section>
                  </div>
                  <div class="col-lg-3 col-sm-6">
                      <section class="panel">
                          <div class="symbol blue">
                              <i class="fa fa-sitemap"></i>
                          </div>
                          <div class="value">
                              <h1 class="count4">
                                 <span id="al4"></span> 
                              </h1>
                              <p>Batch Count</p>
                          </div>
                      </section>
                  </div>
              </div>					
			</section>
		</div>
	</div>
	
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Enquiries for today</h4>
						<span><%=td%></span>
					</header>
					 <div class="adv-table">
                        <table class="table table-striped m-b-none text-small datatable" id="sample_1" >
                            <thead>					
								<tr class="odd">
									<th width="10%">Follow on</th>
									<th width="10%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>																		
									<th width="10%">Done</th>
									<th width="10%">Work</th>
								</tr>
							</thead>
							<tbody>
								<%
								SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");								
								String todayd = ddmm.format(today);								
								Statement s = con.createStatement();
										String sql = "SELECT `enquiry`.`id`,`enquiry`.`source`,`enquiry`.`name`,`enquiry`.`email`,`enquiry`.`courseinterested`,`enquiry`.`status`, `enquiry_data`.`donebyempid`, `enquiry_data`.`followon`,`enquiry_data`.`message` FROM enquiry, enquiry_data WHERE ( `enquiry_data`.`enquiry_id`=`enquiry`.`id`) AND ( `enquiry_data`.`followon`= CURDATE()) AND (`enquiry`.`status`!='COMPLETED') AND (`enquiry`.`status`!='NOT INTERESTED') AND (`enquiry`.`status` LIKE 'NEW')  AND (`enquiry_data`.`donebyempid` IS NULL) ORDER BY `enquiry`.`id` DESC";
										rs = null;										
										rs = s.executeQuery(sql);										
										ResultSet rrrs;
										while (rs.next()) {
											//Enquiry id
											int id = rs.getInt("id");											
											// Get Last Message
											String sq2 = "SELECT message from enquiry_data where `enquiry_id` = '"+id+"' ORDER BY id DESC LIMIT 1,1";
											Statement s44 = con.createStatement();
											rrrs = s44.executeQuery(sq2);																													
											// Employee Id
											String emp_id = rs.getString("donebyempid");
								%>
								<tr>
									<td><%=rs.getString("followon")%></td>
									<td><%=rs.getString("source") %></td>									
									<td><%=rs.getString("name") %></td>
									<td><%=rs.getString("courseinterested") %></td>
									<td><%=rs.getString("status") %></td>																											
									<td>
										<%
											if (emp_id == null)
												out.print("NO");
											else
												out.print("YES");
										%>
									</td>
									
									<td><a class="btn btn-info btn-xs"
										href="../TIMS/Enquiry/details.jsp?id=<%=id%>"><i
											class="icon-wrench"></i> More...</a></td>
								</tr>
								<%
									}										
								%>
							</tbody>
						</table>
					</div>
				</section>
			</div>
		</div>
	
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Follow up for today</h4>
						<span><%=td%></span>
					</header>
			 		<div class="adv-table">
            <!--            <table class="table table-striped m-b-none text-small datatable" id="sample_1" > -->
			<!-- 		<div class="table-responsive"> -->
						<table class="table table-striped m-b-none text-small datatable dtable" id="sample_1">
							<thead>
								<tr class="odd">
									<th width="10%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>
									<th width="10%">Message</th>									
									<th width="10%">Done</th>
									<th width="10%">Work</th>
								</tr>
							</thead>
							<tbody>
								<%
								/* 	SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
										Date today33 = new Date();
										String todayd = ddmm.format(today33); 
										Connection dbc = DbConnection.getConnection(); */
										s = con.createStatement();
										sql = "SELECT `enquiry`.`id`,`enquiry`.`source`,`enquiry`.`name`,`enquiry`.`email`,`enquiry`.`courseinterested`,`enquiry`.`status`, `enquiry_data`.`donebyempid`, `enquiry_data`.`followon`,`enquiry_data`.`message` FROM enquiry, enquiry_data WHERE ( `enquiry_data`.`enquiry_id`=`enquiry`.`id`) AND ( `enquiry_data`.`followon`=CURDATE()) AND ( `enquiry`.`status`!='COMPLETED') AND ( `enquiry`.`status`!='NOT INTERESTED') AND ( `enquiry`.`status` LIKE 'FOLLOWUP') AND (`enquiry_data`.`donebyempid` IS NULL) ORDER BY `enquiry`.`id` DESC";
										
										rs = null;										
										rs = s.executeQuery(sql);										
										/* ResultSet rrrs; */
										while (rs.next()) {
											//Enquiry id
											int id = rs.getInt("id");											
											// Get Last Message
											String sq2 = "SELECT message from enquiry_data where `enquiry_id` = '"+id+"' ORDER BY id DESC LIMIT 1,1";
											Statement s44 = con.createStatement();
											rrrs = s44.executeQuery(sq2);																													
											// Employee Id
											String emp_id = rs.getString("donebyempid");
								%>
								<tr>
									<td><%=rs.getString("source") %></td>									
									<td><%=rs.getString("name") %></td>
									<td><%=rs.getString("courseinterested") %></td>
									<td><%=rs.getString("status") %></td>	
									<td>
										<%
											if(rrrs.next()){
										%>
												<%=rrrs.getString("message")%>
										<%
											}
										%>
									</td>									
									<td>
										<%
											if (emp_id == null)
												out.print("NO");
											else
												out.print("YES");
										%>
									</td>									
									<td><a class="btn btn-info btn-xs"
										href="../TIMS/Enquiry/details.jsp?id=<%=id%>"><i
											class="icon-wrench"></i> More...</a></td>
								</tr>
								<%
									}										
								%>
							</tbody>
						</table>
					</div>
				</section>
			</div>
		</div>
	
	
			
		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4>Batches for Today</h4>
						<span><%=td%></span>
					</header>
					<div class="adv-table">					
                        <table class="table table-striped m-b-none text-small datatable" id="sample_1">						
							<thead>
								<tr>
									<th>Batch Id</th>
									<th>Date</th>
									<th>Session</th>
									<th>Trainer</th>
									<th>Session Status</th>
									<th>More...</th>
								</tr>
							</thead>
							<tbody>
								<%
							/* 		SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
										Date today33 = new Date();
										String todayd = ddmm.format(today33); */

										String userid = request.getAttribute("userid").toString();
										st = con.createStatement();
										//Get Batches Today
										sqlq = "SELECT `batchsession`.`id`,`batchdetails`.`session`,`batchdetails`.`TrainerId`,`batchsession`.`batchid`,`batchsession`.`status` FROM batchsession,batchdetails where (`batchsession`.`date` = '"
												+ todayd
												+ "') AND (`batchsession`.`batchid`=`batchdetails`.`id`)";
										rs = st.executeQuery(sqlq);
										while (rs.next()) {
											int bid = rs.getInt("batchid");
								%>
								<tr>
									<td><%=rs.getString("batchid") %></td>
									<td><%=todayd%></td>
									<td><%=rs.getString("session") %></td>										
									<td><%=GetInfoAbout.gettrainername(rs.getString("TrainerId"))	%></td>
									<td><%=rs.getString("status") %></td>										
									<td>
										<a class="btn btn-info btn-xs" href="Batch/details.jsp?id=<%=bid%>">
										<i class="fa fa-wrench"></i> More...</a>
									</td>
								</tr>
								<%
									}
									//Close DbConnection
									DbConnection.close();
								%>
							</tbody>
						</table>
					</div>
				</section>
			</div>
		</div>		
	</section>
</section>
<!--main content end-->

<%@include file="Common/Footer.jsp"%>