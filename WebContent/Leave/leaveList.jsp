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
    request.setAttribute("title", "Leave List");
%>

<%@include file="../Common/Header.jsp"%>

<%
	String empId = request.getAttribute("userid").toString();
	Connection con = DbConnection.getConnection();
	String sql = "SELECT * FROM  `leavemaster` WHERE creationdate BETWEEN CONCAT(YEAR(CURDATE( )),'-01-01')	AND CONCAT(YEAR(CURDATE( ) ),'-12-31') ORDER BY creationdate desc";
	PreparedStatement ps = con.prepareStatement(sql);	
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
                  <div class="col-sm-12">                 
                                     
				<%
					DateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
					Date today = new Date();
					String td = format.format(today);
				%>                
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4> Employee Leave List</h4>
						<span><%=td %></span>
					</header>					
				</section>
				<section class="panel">
					<form action="">
					<div class="adv-table">					
						<table class="display table table-bordered table-striped" id="dynamic-table">
						<thead>
							<tr>
								<th>Date</th>
                                <th>Employee Name</th>
                                <th>Leave Type</th>
                                <th>Leave Balance (Days)</th>
                                <th>Number of Days</th>
                                <th>Status</th>
                                <th>Action</th>   
							</tr>
						</thead>
						<tbody>							
							<%
							while(rs.next()){								
							%>
							<tr>
							<%
							String fdate = rs.getString("fromdate");
							String tdate = rs.getString("todate");
							if(fdate.equals(tdate)){
							%>
							<td><%=fdate %></td>
							<%}else { %>
							<td><%=fdate %> to <%=tdate %></td>
							<%} %>
							<td><%=(GetInfoAbout.getManagerName(rs.getString("empid"))==null?"":GetInfoAbout.getManagerName(rs.getString("empid"))) %></td>
							<td><%=(GetInfoAbout.getleavetype(rs.getString("leavetypeid"))==null?"":GetInfoAbout.getleavetype(rs.getString("leavetypeid"))) %></td>
							<%
								String query = "SELECT noofdays,useddays FROM `leaverec` WHERE empid=? and leavetype=?";
								PreparedStatement pstmt = con.prepareStatement(query);
								pstmt.setString(1, rs.getString("empid"));
								pstmt.setString(2, rs.getString("leavetypeid"));
								ResultSet rsm = pstmt.executeQuery();
								int entitle = 0, useddays = 0, balance = 0;
								if(rsm.next()){
									entitle = Integer.parseInt(rsm.getString(1));
									useddays = Integer.parseInt(rsm.getString(2)!=null?rsm.getString(2):"0");
									if(entitle>=useddays)
										balance = entitle - useddays;
								}
							%>
							<td><%=balance %></td>
							<td><%=rs.getString("noofdays") %></td>
							<%
								String status = rs.getString("status");
								String color = "";
								if(status.equals("1")){
									color="red";
								}else if(status.equals("2")){
									color="brown";
								}else if(status.equals("3")){
									color="black";
								}else if(status.equals("4")){
									color="orange";
								}else if(status.equals("5")){
									color="green";
								}
							%>
							<td style="color: <%=color%>"><%=(GetInfoAbout.getleavestatus(rs.getString("status"))==null?"":GetInfoAbout.getleavestatus(rs.getString("status"))) %></td>
							<td>
                            	<button type="button" class="btn btn-info btn-xs action" data-id="<%=(rs.getString(1)==null?"":rs.getString(1))%>">
                             	<i class="fa fa-wrench" ></i> Action..</button></td>		
                            </tr>			
							<%}	%>														
						</tbody>
					</table>
					</div>									
					</form>
					</section>
					</div>
					</div>
			  	  </section>		
         </section>
         
<script type="text/javascript">
	$(document).ready(function(){
	    $('#leaveaction').hide();    
	});

	$('.action').on('click',function(){
		var id = $(this).attr('data-id');
		$.ajax({
		    url: "<%= request.getContextPath()%>/Ajax/getleaveRequest.jsp?id="+id,
		    method: 'POST'
		}).success(function(response) {
		    var obj = jQuery.parseJSON($.trim(response));
		    $('#leaveaction')
		    	.find('[name="leaveid"]').val(obj.id).end()
		        .find('[name="empinfo"]').val(obj.einfo).end()
		        .find('[name="leavetype"]').val(obj.ltype).end()
		        .find('[name="leavebalance"]').val(obj.lbalance).end()
		        .find('[name="requestdays"]').val(obj.lreqdays).end()
		    	.find('[name="ecomments"]').val(obj.ecomments).end();
		    bootbox.dialog({
		        title: 'Leave Action (Approve/Reject)',
		        message: $('#leaveaction'),
		        show: false 
		    })
		    .on('shown.bs.modal', function() {
		        $('#leaveaction').show();                 
 			})
		    .on('hide.bs.modal', function(e) {		                    
		        $('#leaveaction').hide().appendTo('body');
		    })
		    .modal('show');		  
		});
	}); 	
	
</script>

 <!-- Edit Modal is Start -->

     <form class="form-horizontal" id="leaveaction" data-validate="parsley">
        <div class="form-group">
            <input class="form-control" id="empinfo" name="empinfo"
                    type="text" data-requried="true" data-notblank="true" readonly>                              
        </div>
        <div class="form-group">
            <label class="col-lg-4 control-label">Leave Type</label>
            <div class="col-lg-8">
                <input class="form-control" id="leavetype" name="leavetype"
                    type="text" data-requried="true" data-notblank="true" readonly>
            </div>          
        </div>
        <div class="form-group">
            <label class="col-lg-4 control-label">Leave Balance (Days)</label>
            <div class="col-lg-8">
                <input class="form-control" id="leavebalance" name="leavebalance"
                    type="number" data-requried="true" data-notblank="true" readonly>
            </div>          
        </div>   
        <div class="form-group">
            <label class="col-lg-4 control-label">Requested Leave (Days)</label>
            <div class="col-lg-8">
                <input class="form-control" id="requestdays" name="requestdays"
                    type="number" data-requried="true" data-notblank="true" readonly>
            </div>          
        </div>  
        <div class="form-group">
            <label class="col-lg-4 control-label">Comments:</label>
            <div class="col-lg-8">
            	<textarea rows="3" cols="49" id="ecomments" name="ecomments" readonly></textarea>                
            </div>          
        </div>   
         <div class="modal-footer"></div>
        <div class="form-group">
			<label for="actionid" class="col-lg-4 control-label">Manager Action:</label>
			<div class="col-lg-8">
				<select id="actionid" class="form-control" name="actionid"
						data-required="true" data-notblank="true">
					<option value="0">---select---</option>
					<option value="3">Approve</option>
					<option value="1">Reject</option>
					<option value="2">Cancel</option>
				</select>
			</div>
		</div>	
		<div class="form-group">
            <label class="col-lg-4 control-label">Manager Comments:</label>
            <div class="col-lg-8">
            	<textarea rows="3" cols="49" id="mcomments" name="mcomments"></textarea>             	              
            </div>          
        </div>		   
        <div class="modal-footer">            
        	<input type="hidden" name="leaveid" id ="leaveid"/> 
            <button data-dismiss="modal" class="btn btn-default" type="button">Close</button>
            <button class="btn btn-success" type="submit" onclick="lAction()"> Action </button>
        </div>
     </form>  
<script type="text/javascript">
/* Leave action is start */
function lAction(){
	var xmlhttp;
    var leaveid = document.getElementById("leaveid").value;    
    var mcomments = document.getElementById("mcomments").value;        
    var actionid = document.getElementById("actionid").value;        //console.log(eleavetype);
    if (window.XMLHttpRequest) {
      xmlhttp=new XMLHttpRequest();
    }
    else {
      xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    xmlhttp.onreadystatechange=function() {
      if (xmlhttp.readyState==4 && xmlhttp.status==200) {
          document.location.reload(true);
      }
    }
    xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/empLeaveRequest.jsp?status=mupdate&leaveid="+leaveid+"&mcomments="+mcomments+"&actionid="+actionid,true);
    xmlhttp.send();
}

/* Leave action is End */	
</script>  
    <!-- Edit Modal is End -->
     
<%@include file="../Common/Footer.jsp"%>    