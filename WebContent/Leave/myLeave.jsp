<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
    request.setAttribute("title", "Leave Management");
%>

<%@include file="../Common/Header.jsp"%>

<%
	String empId = request.getAttribute("userid").toString();
	Connection con = DbConnection.getConnection();
	String sql = "SELECT * FROM `leaverec` where `empid` = ?";
	PreparedStatement ps = con.prepareStatement(sql);	
	ps.setInt(1, Integer.parseInt(empId));
	ResultSet rs = ps.executeQuery();
	
	
	sql = "SELECT * FROM `employee` where `id` = '" + empId + "' and TerminationId is NULL LIMIT 1";
	PreparedStatement s = con.prepareStatement(sql);
	ResultSet rs1 = s.executeQuery();
	rs1.next();
	SecureNew sn = new SecureNew();
	String fName = rs1.getString("FirstName");
	String lName = rs1.getString("LastName");
	String eName = fName+" "+lName;
	String wMail = sn.decrypt(rs1.getString("WorkEmail"));	

%>

  <!--main content start-->
      <section id="main-content">       
          <section class="wrapper">
              <!-- page start-->
              <div class="row">
                  <div class="col-lg-4">
                        <!--widget start-->
                            <aside class="profile-nav alt blue-border">
                              <section class="panel">
                                  <div class="twt-feed alt blue-bg">
                                      <h1><%=eName %></h1>
                                      <p><%=wMail %></p>
                                      <a href="#">
                                          <img src="<%=request.getContextPath() %>/GetPicture.jsp" alt="">
                                      </a>
                                  </div>
                                  <div class="weather-category twt-category">
                                      <ul>
                                          <li class="active"><h5>12</h5>Earned Leave</li>
                                          <li> <h5>5</h5>Taken Leave</li>
                                          <li><h5>7</h5>Balance Leave</li>
                                      </ul>
                                  </div>   
                               <div>
                                <ul class="nav nav-pills nav-stacked">
                                <%
                                  	DateFormat df = new SimpleDateFormat("yyyy");                                  	
                                %>
                                  <li><a href="<%=request.getContextPath()%>/Leave/"><i class="fa fa-list"></i> List of Leaves (<%=df.format(new Date()) %>) <span class="label label-primary pull-right r-activity" >19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leavetype.jsp"> <i class="fa fa-user"></i>Leave Type<span class="label label-primary pull-right r-activity" id="typecount"></span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/assignLeave.jsp"> <i class="fa fa-calendar"></i>Assign Leave<span class="label label-primary pull-right r-activity">19</span></a></li>
                                  <li class="active"><a href="javascript:;"> <i class="fa fa-bell-o"></i> My Leave <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leaveList.jsp"> <i class="fa fa-envelope-o"></i> Leave List  <span class="label label-success pull-right r-activity">10</span></a></li>
                                 </ul>	                                
                               </div>                                                               
                              </section> 
                         </aside>                             
                         <!--widget end-->
                   </div>                   
				<%
					DateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
					Date today = new Date();
					String td = format.format(today);
				%>
                <aside class="profile-info col-lg-8">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4> Leave summary</h4>
						<span><%=td %></span>
					</header>					
				</section>
				<section class="panel">
					<div class="adv-table">
					<form action="">
					<input type="hidden" name="eid" id="eid" value="<%=empId %>" />
					<input type="hidden" class="aleave" id="aleave" value="<%=(request.getAttribute("aleave")==null?"":request.getAttribute("aleave").toString()) %>" />
					<table class="table">
						<thead>
							<tr>
								<th width="15%">Leave Type</th>
                                <th width="10%">Entitlements (Days)</th>
                                <th width="10%">Balance (Days)</th>   
							</tr>
						</thead>
						<tbody>
							
							<%
							while(rs.next()){	
							%>
							<tr><td><%=(GetInfoAbout.getleavetype(rs.getString("leavetype"))==null?"":GetInfoAbout.getleavetype(rs.getString("leavetype"))) %></td>
							<td><%=(rs.getString(4)!=null?rs.getString(4):"") %></td>
							<%
								int entitle = 0, useddays = 0, balance = 0;
								if(rs.getString(4)!=null){
									entitle = Integer.parseInt(rs.getString(4));
									useddays = Integer.parseInt(rs.getString(7)!=null?rs.getString(7):"0");
									if(entitle>=useddays)
										balance = entitle - useddays;
								}
							%>
							<td><%=balance %></td></tr>					
							<%}	%>							
						</tbody>
					</table>	
						<a href="#applyleave" data-toggle="modal">
						<button type="button" class="btn btn-success"><i class="fa fa-upload"></i>  Proceed My Leave </button>
						</a>
						<a href="<%=request.getContextPath() %>/Leave/" data-toggle="modal">
						<button type="button" class="btn btn-danger"><i class="fa fa-home"></i> Back </button>
						</a>					
					</form>
					</div>
			  	  </section>					
			   </aside>
            </div>
         </section>
      </section>
<!-- modal -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="applyleave" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title"> Apply My Leave </h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> Apply Leave</header>
									<div class="panel-body">
										<form class="form-horizontal" id="leaverequest"	data-validate="parsley">											
											<div class="form-group">
												<label for="roleid" class="col-lg-3 control-label">Leave Type:</label>
												<div class="col-lg-8">
													<select id="leavetype" class="form-control" name="leavetype"
														data-required="true" data-notblank="true">
														<option value="">---select---</option>
														<%		
															String query = "SELECT * FROM `leaverec` where `empid` = ?";
															PreparedStatement pstmt = con.prepareStatement(sql);	
															ps.setInt(1, Integer.parseInt(empId));
															ResultSet leaveSet = ps.executeQuery();
															while (leaveSet.next()) {
														%>
																<option value="<%=(leaveSet.getString("leavetype")==null)?"":leaveSet.getString("leavetype") %>"><%=(GetInfoAbout.getleavetype(leaveSet.getString("leavetype"))==null?"":GetInfoAbout.getleavetype(leaveSet.getString("leavetype"))) %></option>
														         
														<%	}	%>
													</select>
												</div>
											</div>											
																			
											<div class="form-group">
												<label for="fromdate" class="col-lg-3 control-label">From Date:</label>
												<div class="col-lg-8">
													<input class="form-control datep" data-required="true"
														data-notblank="true" data-type="dateIso" id="fromdate"
														name="fromdate" placeholder="YYYY-MM-DD" type="text" readonly>
												</div>
											</div>
											
											<div class="form-group">
												<label for="todate" class="col-lg-3 control-label">To Date:</label>
												<div class="col-lg-8">
													<input class="form-control datep" data-required="true"
														data-notblank="true" data-type="dateIso" id="todate"
														name="todate" placeholder="YYYY-MM-DD" type="text" readonly>
												</div>
											</div>
											<script>
											$(function() {
												$('.datep').datepicker({
													minDate : "-3M",
													maxDate : "+6M",
													dateFormat : "yy-mm-dd",
													changeMonth : true,
													changeYear : true
												}).val();
											});
											</script>
											<div class="form-group">
												<label for="Comment" class="col-lg-3 control-label">Comment:</label>
												<div class="col-lg-8">													
													<textarea rows="3" cols="8" class="form-control" id="comments" name="comments" ></textarea>
												</div>
											</div>
                                       		<div class="modal-footer">
                                				<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
                                   		 		<button class="btn btn-success" type="submit"> Apply </button>
                                			</div>	
										</form>
									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>     
		<%
			rs.close();
			ps.close();
			con.close();
		%>
		<!-- Modal content is done here -->
<script type="text/javascript">
	$(document).ready(function() {
		$("#leaverequest").submit(
			function() {
				$('#leaverequest').parsley('validate');
					if ($('#leaverequest').parsley('isValid')) {
					} else {
						$.gritter.add({
							title : 'Fill Fields',
							text : 'Oops Please Fill All Fields'
						});
						return false;
					}
					var str = $(this).serialize();
					$.ajax({
						url : "../Ajax/empLeaveRequest.jsp?status=new",
						type : "POST",
						data : str,
						success : function(
						data,
						textStatus,
						jqXHR) {
							if (data == 1) {
								$.gritter.add({
										title : 'Success',
										text : 'new Employee Created'
								});
								window.location.reload();
							} else {
								$.gritter.add({
										title : 'Sorry',
										text : 'Some Error Occured, Please Try Again.'
								});
							}
						},
						error : function(
							jqXHR,
							textStatus,
							errorThrown) {
								alert("Sorry, Error.");
								$.gritter.add({
									title : 'Sorry',
									text : 'Some Error Occured, Please Try Again.'
								});
							}
						});
						return false;
			});
		});
</script>

<%@include file="../Common/Footer.jsp"%>                 