<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
	request.setAttribute("title", "Leave Management");
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
	String csql = "SELECT * FROM `leavetype` order by typeid";
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
                              	  <li class="active"><a href="javascript:;"> <i class="fa fa-user"></i>Leave Type<span class="label label-primary pull-right r-activity" id="typecount"></span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/assignLeave.jsp"> <i class="fa fa-calendar"></i>Assign Leave<span class="label label-primary pull-right r-activity">19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/"> <i class="fa fa-clock-o"></i> Leave Request <span class="label label-info pull-right r-activity">11</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/myLeave.jsp"> <i class="fa fa-bell-o"></i> My Leave <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/"> <i class="fa fa-envelope-o"></i> Leave Report  <span class="label label-success pull-right r-activity">10</span></a></li>
                              	</ul>
                               </div>                                                               
                              </section> 
                         </aside>                             
                              <!--widget end-->
                   </div>
                   <!-- twd feet is over -->
                   	<!--  One Management Topic Start -->
                   	<aside class="profile-info col-lg-8">                   		
						<div class="inbox-head">
						<h3>
							<i class="fa fa-book">Leave Types</i>
						</h3>
						<form class="pull-right position" action="#">
							<div class="input-append">
								<a href="#newleavetypes" data-toggle="modal">
									<button type="button" class="btn sr-btn">
										<i class="fa fa-plus"></i>
									</button>
								</a>
							</div>
						</form>
					</div>
			 		<section class="panel">
						<div class="adv-table">
						<table class="display table table-bordered table-striped" id="dynamic-table">
							<thead>
								<tr>
									<th width="5%">#</th>
									<th width="20%">Leave Type</th>
									<th width="10%">Minimum Leave</th>	
									<th width="10%">Maximum Leave</th>
									<th width="5%"></th>							
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
									<td><%=(rs2.getString(4)==null?"":rs2.getString(4))%></td>
									<td>
										<button type="button" class="btn btn-info btn-xs edit" data-id="<%=(rs2.getString(1)==null?"":rs2.getString(1))%>">
										<i class="fa fa-wrench" ></i>Edit..</button></td>																
								</tr>
								<%
									count++;
									}
								%> 
						 		<script>
									document.getElementById("typecount").innerHTML = "<%=count%>";
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
	<!-- End Main Content -->
	
	<!-- Edit Button Script -->
	<script >
	$(document).ready(function(){
		 $('#editleaveTypes')
         .hide();    
	});
$('.edit').on('click',function(){
var id = $(this).attr('data-id');
$.ajax({
    url: "<%= request.getContextPath()%>/Ajax/getleavetype.jsp?id=" + id,
    method: 'GET'
}).success(function(response) {
	var obj = jQuery.parseJSON($.trim(response));
	
    // Populate the form fields with the data returned from server
    $('#editleaveTypes')
    	.find('[name="cid"]').val(obj.id).end()
        .find('[name="emindays"]').val(obj.min).end()
        .find('[name="emaxdays"]').val(obj.max).end()
        .find('[name="eleavetype"]').val(obj.type).end();
    bootbox
    .dialog({
        title: 'Edit Leave Types',
        message: $('#editleaveTypes'),
        show: false 
    })
    .on('shown.bs.modal', function() {
                    $('#editleaveTypes')
                        .show();                       
                        
                })
                 .on('hide.bs.modal', function(e) {
                    
                    $('#editleaveTypes').hide().appendTo('body');
                })
    .modal('show');
   // $("#editleavetypes").attr("aria-hidden",false);
});
});

</script>
<!-- Edit script is over -->
	
	<!-- Edit Modal is Start -->
<!-- 	     <div class="modal fade " id="editleaveTypes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
           <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">Edit Leave Types</h4>
               </div>
               <div class="modal-body"> -->
	 <form class="form-horizontal" id="editleaveTypes" data-validate="parsley">
		<div class="form-group">
			<label class="col-lg-4 control-label">Leave Type</label>
				<div class="col-lg-8">
					<input class="form-control" id="eleavetype" name="eleavetype"
						type="text" data-requried="true" data-notblank="true" data-rangelength="[3,50]">
				</div>					
		</div>
		<div class="form-group">
			<label class="col-lg-4 control-label">Minimum Days</label>
			<div class="col-lg-8">
				<input class="form-control" id="emindays" name="emindays"
					type="number" data-requried="true" data-notblank="true" data-rangelength="[1,2]">
			</div>			
		</div>
		<div class="form-group">
			<label class="col-lg-4 control-label">Maximum Days</label>
			<div class="col-lg-8">
				<input class="form-control" id="emaxdays" name="emaxdays"
					type="number" data-requried="true" data-notblank="true" data-rangelength="[1,3]">
			</div>			
		</div>		
		<div class="modal-footer">
			<input type="hidden" name="cid" id ="cid"/>
		   	<button id ="editCancel" data-dismiss="modal" class="btn btn-default" type="button">Close</button>
		   	<button class="btn btn-success" type="submit" onclick="editLeave()">Update</button>
		</div>
	 </form>
	<!-- </div>
	</div>
	</div>
	</div>	 -->
	<!-- Edit Modal is End -->
	
	 <!-- Modal -->
     <div class="modal fade " id="newleavetypes" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
           <div class="modal-content">
               <div class="modal-header">
                  <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                     <h4 class="modal-title">Add New Leave Types</h4>
               </div>
               <div class="modal-body">
                   <form class="form-horizontal" id="leaveTypes" data-validate="parsley">
						<div class="form-group">
							<label class="col-lg-4 control-label">Leave Type</label>
								<div class="col-lg-8">
									<input class="form-control" id="leavetype" name="leavetype"
										type="text" data-requried="true" data-notblank="true" data-rangelength="[3,50]">
								</div>					
						</div>
						<div class="form-group">
							<label class="col-lg-4 control-label">Minimum Days</label>
								<div class="col-lg-8">
									<input class="form-control" id="mindays" name="mindays"
										type="number" data-requried="true" data-notblank="true" data-rangelength="[1,2]">
								</div>			
						</div>
						<div class="form-group">
							<label class="col-lg-4 control-label">Maximum Days</label>
								<div class="col-lg-8">
									<input class="form-control" id="maxdays" name="maxdays"
										type="number" data-requried="true" data-notblank="true" data-rangelength="[1,3]">
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
	$("#leaveTypes")
			.submit(
					function() {
						$('#leaveTypes').parsley(
								'validate');
				 		if (!$('#leaveTypes').parsley(
								'isValid')) {
							$.gritter
									.add({
										title : 'Fill Fields',
										text : 'Oops Please Fill All Fields'
									});
							return false;
						} else {

						} 
						var str = $(this).serialize();

						$
								.ajax({
									url: "<%=request.getContextPath()%>/Ajax/newLeaveTypes.jsp",
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
	
	
	</script>
	<script>
	function editLeave(){
		var xmlhttp;
		var cid = document.getElementById("cid").value;
	
		var eleavetype = document.getElementById("eleavetype").value;
		
		var emindays = document.getElementById("emindays").value;
		//console.log(eleavetype);
		var emaxdays = document.getElementById("emaxdays").value;
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
			  document.location.reload(true);
		    }
		  }
		xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/editLeaveTypes.jsp?cid="+cid+"&eleavetype="+eleavetype+"&emindays="+emindays+"&emaxdays="+emaxdays,true);
		xmlhttp.send();
	}
	
	</script>
     
<%@include file="../Common/Footer.jsp"%>