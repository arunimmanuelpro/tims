<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
    request.setAttribute("title", "Leave Management");
%>

<%@include file="../Common/Header.jsp"%>
<script>
function change(noofdays,id){
	var fromdate = document.getElementById("fromvalue").value;
	var todate = document.getElementById("tovalue").value;
	days = noofdays.value;
	/* alert(fromdate+" "+todate); */
	if(days==null || days==""){
		days=0;
	} 
	var xmlhttp;
		if (window.XMLHttpRequest) {
		  xmlhttp=new XMLHttpRequest();
		}
		else {
		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}		
		xmlhttp.onreadystatechange=function()  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)  {			  
			  var someText=xmlhttp.responseText;
			  someText = someText.replace(/(\r\n|\n|\r)/gm,"");
			  alert(someText);
		    }
		};
		xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/empentitlements.jsp?days="+days+"&empid="+id+"&fdate="+fromdate+"&tdate="+todate,true);
		xmlhttp.send();		
}

</script>
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
    
    s = con1.createStatement();
    String query = "SELECT id, firstname, lastname, EmpStatusId, JobTitleId	FROM employee WHERE terminationid IS NULL ORDER BY id";
    ResultSet rs3 = s.executeQuery(query);     
    
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
                                  <li class="active"><a href="javascript:;"> <i class="fa fa-calendar"></i>Assign Leave<span class="label label-primary pull-right r-activity">19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/myLeave.jsp"> <i class="fa fa-bell-o"></i> My Leave <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leaveList.jsp"> <i class="fa fa-envelope-o"></i> Leave List  <span class="label label-success pull-right r-activity">10</span></a></li>
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
                            <i class="fa fa-user">  Assign Employee Leaves</i>
                        </h3>
                        <h6>
                            Click Employee ID and Split Leave Type
                        </h6>
                     <!--    <form class="pull-right position" action="#">
                            <div class="input-append">
                                <a href="#newleavetypes" data-toggle="modal">
                                    <button type="button" class="btn sr-btn">
                                        <i class="fa fa-plus"></i>
                                    </button>
                                </a>
                            </div>
                        </form> -->
                    </div>                  
                    <section class="panel">
                    	<div class="panel-body">                              
                    	<form action="#">
                    		 <div class="form-group">
                    		 		<button type="button" id="refreshperiod" class="btn btn-info ">
                    		 		<i class="fa fa-refresh"></i> Leave Time Period </button>																
							</div>
                    		<div class="form-group">
                    			<div class="form-group" id="fromperiod">
									<label for="fromperiod" class="col-lg-1 control-label">Period From:</label>
										<div class="col-lg-4">
											<input class="form-control datep"
															name="fromvalue" placeholder="YYYY-MM-DD" type="text"
															data-type="dateIso" id="fromvalue" readonly >
										</div>
								</div>
								<div class="form-group" id="toperiod">
									<label for="toperiod" class="col-lg-1 control-label">Period To:</label>
										<div class="col-lg-4">
											<input class="form-control datep"
															name="tovalue" placeholder="YYYY-MM-DD" type="text"
															data-type="dateIso" id="tovalue" readonly>
										</div>
								</div>
								<script>
									$(function() {
										$(".datep").datepicker(
											{
												minDate : "-1Y",
												maxDate : "1Y",
												dateFormat : "yy-mm-dd",
												changeMonth : true,
												changeYear : true
											});
									});
								</script>
							</div>
                    	</form>                    	
                    	</div>                    	
                    </section>                
                    <script type="text/javascript">
                    	 $(function(){
                    		 $("#refreshperiod").click(function(){
                    			 $("#fromvalue").placeholder="YYYY-MM-DD";                                             
                                 $("#tovalue").placeholder="YYYY-MM-DD";
                    		 });
                    	 });
                    </script>
                    <section class="panel">
                        <div class="adv-table">
                        <table class="table table-striped m-b-none text-small datatable  dataTable" id="sample_1" >
                            <thead style="background-color: #F3F781; color: #000000;">
                                <tr>
                                    <th width="5%">#</th>
                                    <th width="15%">Employee Name</th>
                                    <th width="15%">Designation</th>
                                    <th width="15%">Status</th>  
                                    <th width="5%">No. of Leave Allowed</th>                                                  
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                    int count=0;
                                    PreparedStatement ps2 = null;
                                    ResultSet rs4 = null;
                                    while (rs3.next()) {
                                    	String empName = rs3.getString("firstname")+" "+rs3.getString("lastname");
                            %>         
                               <tr>
                                    <td><a href="<%=request.getContextPath() %>/Leave/addLeaveType.jsp?empid=<%=rs3.getInt(1) %>"><%=(rs3.getString(1)==null?"":rs3.getString(1))%></a></td>
                                    <td><%=empName%></td>
                                    <td><%=(GetInfoAbout.getjobtitlename(rs3.getString("JobTitleId"))==null?"":GetInfoAbout.getjobtitlename(rs3.getString("JobTitleId")))%></td>
                                    <% String empStatus = (GetInfoAbout.getempstatusname(rs3.getString("EmpStatusId"))==null?"":GetInfoAbout.getempstatusname(rs3.getString("EmpStatusId"))); %>
                                    <td><%=empStatus %></td>
                                    <%
	                                    ps2 = con1.prepareStatement("select * from leavepolicy where empid=?");
	                                    ps2.setInt(1,rs3.getInt(1));
	                                    rs4 = ps2.executeQuery();
	                                    if(rs4.next()){
                                    %>
                                    <td><input class="form-control" size="4" type="text" value="<%=rs4.getInt(3)%>" id="<%=rs3.getInt(1) %>" onchange="change(this,<%=rs3.getInt(1)%>)"/></td>
                                    <%
                                        }else{
                                    %>
                                    <td><input class="form-control" size="4" type="text" id="<%=rs3.getInt(1) %>" onchange="change(this,<%=rs3.getInt(1)%>)" /></td>
                                    <%  } %>                                                                                             
                                </tr>
                                <%                                   
                                    }
                                    rs3.close();
                                    rs4.close();
                                    ps2.close();
                                    con1.close();
                                %>                                                                   
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
 
<%@include file="../Common/Footer.jsp"%>