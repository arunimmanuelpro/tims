<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
	request.setAttribute("title", "Timesheet");
%>

<%
	Connection con1 = DbConnection.getConnection();
	Statement s = con1.createStatement();
	String sql = "SELECT * FROM `employee` where `id` = '" + request.getAttribute("userid") + "' LIMIT 1";
	ResultSet rs1 = s.executeQuery(sql);
	rs1.next();
	SecureNew sn = new SecureNew();
	String fName = rs1.getString("FirstName");
	String lName = rs1.getString("LastName");
	String eName = fName+" "+lName;
	String wMail = sn.decrypt(rs1.getString("WorkEmail"));
	
	s = con1.createStatement();
	String csql = "SELECT * FROM `tscategory` order by CategoryId";
	ResultSet rs2 = s.executeQuery(csql); 
	
%>

<%@include file="../Common/Header.jsp"%>
 <!--main content start-->
	<section id="main-content">
          <section class="wrapper">
              <!-- page start-->
              <div class="row">
                  <div class="col-lg-4">
                      <!--widget start-->
                      <aside class="profile-nav alt green-border">
                          <section class="panel">
                              <div class="user-heading alt green-bg">
                                  <a href="#">
                                      <img alt="" src="<%=request.getContextPath() %>/GetPicture.jsp">
                                  </a>
                                  <h1><%=eName %></h1>
                                  <p><%=(GetInfoAbout.getjobtitlename(rs1.getString("JobTitleId"))==null?"":GetInfoAbout.getjobtitlename(rs1.getString("JobTitleId"))) %></p>
                              </div>

                              <ul class="nav nav-pills nav-stacked">
                              	  <li class="active"><a href="javascript:;"> <i class="fa fa-user"></i> Admin <span class="label label-primary pull-right r-activity" id="categorycnt"></span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Timesheet/cntTimeSheet.jsp"> <i class="fa fa-clock-o"></i> Current Sheet <span class="label label-info pull-right r-activity">11</span></a></li>
                                  <li><a href="javascript:;"> <i class="fa fa-bell-o"></i> View Sheet <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="javascript:;"> <i class="fa fa-envelope-o"></i> Status <span class="label label-success pull-right r-activity">10</span></a></li>
                              </ul>
                     	   </section>
                  	  </aside>
                  	  <!--widget end-->
                   	  <!--widget start-->
                      <div class="panel">
                          <div class="panel-body">
                              <div class="bio-chart">
                                  <input class="knob" data-width="101" data-height="101" data-displayPrevious=true  data-thickness=".2" value="80" data-fgColor="#4CC5CD" data-bgColor="#e8e8e8">
                              </div>
                              <div class="bio-desk">
                                  <h4 class="terques">Timesheet Completion </h4>
                                  <p>Month: </p>
                                  <p>Start: </p>
                                  <p>End: </p>
                              </div>
                          </div>
                      </div>
                    </div>
                      <!--widget end-->	  
                   	<!--  One Management Topic Start -->
                   	<aside class="profile-info col-lg-8">                   		
						<div class="inbox-head">
						<h3>
							<i class="fa fa-book">Category List</i>
						</h3>
						<form class="pull-right position" action="#">
							<div class="input-append">
								<a href="#addnewcategory" data-toggle="modal">
									<button type="button" class="btn sr-btn">
										<i class="fa fa-plus"></i>
									</button>
								</a>
							</div>
						</form>
					</div>
					<br/>
			 		<section class="panel">			 		
			 			<form action="#">
							<div class="input-append">
								<a href="#" data-toggle="modal">
									<button type="button" class="btn btn-warning">
										Review Employee Timesheet
									</button>
								</a>
							</div>
						</form>
						<div class="adv-table">
						<table class="table table-striped m-b-none text-small datatable  dataTable" id="sample_1" >						
							<thead style="background-color: #F3F781; color: #000000;">
								<tr>
									<th>#</th>
									<th>Category</th>
									<th>Description</th>	
									<th>Update</th>							
								</tr>
							</thead>
							<tbody>
								<%
									int count=0;
									while (rs2.next()) {
								%>
								<tr>
									<td><%=(rs2.getString(1)==null?"":rs2.getString(1))%></td>
									<td><%=(rs2.getString(2)==null?"":rs2.getString(2))%></td>
									<td><%=(rs2.getString(3)==null?"":rs2.getString(3))%></td>
									<td><a class="btn btn-info btn-xs"
										href="../TIMS/Timesheet/editSheet.jsp?id=<%=rs2.getString(1)%>"><i
											class="fa fa-wrench"></i>Edit..</a></td>								
								</tr>
								<%
									count++;
									}
								%>
								<script>
									document.getElementById("categorycnt").innerHTML = "<%=count%>";
								</script>
							</tbody>						
						</table>
						</div>
					</section> 					
               </aside>
               <!--  One Management Topic End -->
            </div>               
		</section>		
	</section>
	
	 <!-- Modal -->
     <div class="modal fade " id="addnewcategory" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
           <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">Add New Category</h4>
               </div>
               <div class="modal-body">
                   <form class="form-horizontal" id="newcategory" data-validate="parsley">
						<div class="form-group">
							<label class="col-lg-4 control-label">Category</label>
								<div class="col-lg-8">
									<input class="form-control" id="Category" name="Category"
										type="text" data-requried="true" data-notblank="true" data-rangelength="[5,50]">
								</div>					
						</div>
						<div class="form-group">
							<label class="col-lg-4 control-label">Category Description</label>
								<div class="col-lg-8">
									<input class="form-control" id="CategoryDesc" name="CategoryDesc"
										type="text" data-requried="true" data-notblank="true" data-rangelength="[5,200]">
								</div>			
						</div>	
		           	    <div class="modal-footer">
		               		<button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
		               		<button class="btn btn-success" type="submit">Create</button>
		                </div>
	           		</form> 	              
           		</div>
        	</div>
     	</div>
     </div>
     <!-- modal -->
	
	<script type="text/javascript">
	//Personal Details Update Start
	$("#newcategory")
			.submit(
					function() {
						$('#newcategory').parsley(
								'validate');
				 		if (!$('#newcategory').parsley(
								'isValid')) {
							$.gritter
									.add({
										title : 'Fill Fields',
										text : 'Oops Please Fill All Fields'
									});
							return false;
						} else {

						} 

						var str = $(this)
								.serialize();

						$
								.ajax({
									url: "<%=request.getContextPath()%>/Ajax/newCategoryDetails.jsp",
									type: "POST",
									data: str,
									success : function(
											data,
											textStatus,
											jqXHR) {
										if (data == 1) {
											$.gritter
													.add({
														title : 'Success',
														text : 'All Data Saved'
													});
											window.location
													.reload();
										} else {
											$.gritter
													.add({
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
										$.gritter
												.add({
													title : 'Sorry',
													text : 'Some Error Occured, Please Try Again.'
												});

									}
								});
						return false;

					});
	//End Personal Details Update
	
	</script>
	
	<script src="<%=request.getContextPath()%>/assets/jquery-knob/js/jquery.knob.js"></script>  	
  	<script>
	      //knob
	      $(".knob").knob();
  	</script>


 	<!--script for this page only-->
    <script src="<%=request.getContextPath()%>/js/gritter.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/pulstate.js" type="text/javascript"></script>

<%@include file="../Common/Footer.jsp"%>