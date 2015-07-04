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
                  <div class="col-lg-8">
                      <!--custom chart start-->
                      <div class="border-head">
                          <h3>Earning Graph</h3>
                      </div>
                      <div class="custom-bar-chart">
                          <ul class="y-axis">
                              <li><span>100</span></li>
                              <li><span>80</span></li>
                              <li><span>60</span></li>
                              <li><span>40</span></li>
                              <li><span>20</span></li>
                              <li><span>0</span></li>
                          </ul>
                          <div class="bar">
                              <div class="title">APR</div>
                              <div class="value tooltips" data-original-title="80%" data-toggle="tooltip" data-placement="top">86%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">MAY</div>
                              <div class="value tooltips" data-original-title="50%" data-toggle="tooltip" data-placement="top">45%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">JUN</div>
                              <div class="value tooltips" data-original-title="40%" data-toggle="tooltip" data-placement="top">40%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">JUL</div>
                              <div class="value tooltips" data-original-title="55%" data-toggle="tooltip" data-placement="top">55%</div>
                          </div>
                          <div class="bar">
                              <div class="title">AUG</div>
                              <div class="value tooltips" data-original-title="20%" data-toggle="tooltip" data-placement="top">20%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">SEP</div>
                              <div class="value tooltips" data-original-title="39%" data-toggle="tooltip" data-placement="top">39%</div>
                          </div>
                          <div class="bar">
                              <div class="title">OCT</div>
                              <div class="value tooltips" data-original-title="75%" data-toggle="tooltip" data-placement="top">75%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">NOV</div>
                              <div class="value tooltips" data-original-title="45%" data-toggle="tooltip" data-placement="top">45%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">DEC</div>
                              <div class="value tooltips" data-original-title="50%" data-toggle="tooltip" data-placement="top">50%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">JAN</div>
                              <div class="value tooltips" data-original-title="42%" data-toggle="tooltip" data-placement="top">42%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">FEB</div>
                              <div class="value tooltips" data-original-title="60%" data-toggle="tooltip" data-placement="top">60%</div>
                          </div>
                          <div class="bar ">
                              <div class="title">MAR</div>
                              <div class="value tooltips" data-original-title="90%" data-toggle="tooltip" data-placement="top">90%</div>
                          </div>                         
                      </div>                      
                      <!--custom chart end-->
                  </div>
                  <div class="col-lg-4">
                      <!--new earning start-->
                      <div class="panel terques-chart">
                          <div class="panel-body chart-texture">
                              <div class="chart">
                                  <div class="heading">
                                      <span>Saturday</span>
                                      <strong><i class="fa fa-inr"></i> 57,00 | 15%</strong>
                                  </div>
                                  <div class="sparkline" data-type="line" data-resize="true" data-height="75" data-width="90%" data-line-width="1" data-line-color="#fff" data-spot-color="#fff" data-fill-color="" data-highlight-line-color="#fff" data-spot-radius="4" data-data="[200,135,667,333,526,996,564,123,890,564,455]"></div>
                              </div>
                          </div>
                          <div class="chart-tittle">
                              <span class="title">New Earning</span>
                              <span class="value">
                                  <a href="#" class="active">Market</a>
                                  |
                                  <a href="#">Referal</a>
                                  |
                                  <a href="#">Online</a>
                              </span>
                          </div>
                      </div>
                      <!--new earning end-->

                      <!--total earning start-->
                      <div class="panel green-chart">
                          <div class="panel-body">
                              <div class="chart">
                                  <div class="heading">
                                      <span>July</span>
                                      <strong>4 Days | 65%</strong>
                                  </div>
                                  <div id="barchart"></div>
                              </div>
                          </div>
                          <div class="chart-tittle">
                              <span class="title">Total Earning</span>
                              <span class="value"><i class="fa fa-inr"></i>, 76,54,678</span>
                          </div>
                      </div>
                      <!--total earning end-->
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
											class="fa fa-wrench"></i> More...</a></td>
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
            <!--            <table class="table table-striped m-b-none text-small datatable" id="sample_1" > -->
			<!-- 		<div class="table-responsive"> -->
						<table class="table table-striped m-b-none text-small datatable dtable" id="sample_1">
							<thead>
								<tr class="odd">
									<th>Batch Id</th>
									<th>Date</th>
									<th>Session</th>
									<th>Trainer</th>
									<th>Session Status</th>
									<th>More...</th>
									<!-- <th width="10%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>
									<th width="10%">Message</th>									
									<th width="10%">Done</th>
									<th width="10%">Work</th> -->
								</tr>
							</thead>
							<tbody>
								<%
										String userid = request.getAttribute("userid").toString();
										st = con.createStatement();
										//Get Batches Today
										sqlq = "SELECT `batchsession`.`id`,`batchdetails`.`session`,`batchdetails`.`TrainerId`,`batchsession`.`batchid`,`batchsession`.`status` FROM batchsession,batchdetails where (`batchsession`.`date` = CURDATE()) AND (`batchsession`.`batchid`=`batchdetails`.`id`)";
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

<script>
$(function(){
    $('select.styled').customSelect();
});
</script>

<%
	//Close DbConnection
	DbConnection.close();	
%>

<%@include file="Common/Footer.jsp"%>