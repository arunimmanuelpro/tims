<%@page import="constant.InfoConstant"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>
<%
    request.setAttribute("title", "Leave Management");
%>

<%@include file="../Common/Header.jsp"%>

<%
	String empId = request.getParameter("empid");
	Connection con = DbConnection.getConnection();
	String sql = "SELECT * FROM `employee` where `id` = ? LIMIT 1";
	PreparedStatement ps = con.prepareStatement(sql);	
	ps.setInt(1, Integer.parseInt(empId));
	ResultSet rs = ps.executeQuery();
	rs.next();
	
	sql = "SELECT * FROM `employee` where `id` = '" + request.getAttribute("userid") + "' and TerminationId is NULL LIMIT 1";
	Statement s = con.createStatement();
	ResultSet rs1 = s.executeQuery(sql);
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
                                  <li class="active"><a href="javascript:;"> <i class="fa fa-calendar"></i>Assign Leave<span class="label label-primary pull-right r-activity">19</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/myLeave.jsp"> <i class="fa fa-bell-o"></i> My Leave <span class="label label-warning pull-right r-activity">03</span></a></li>
                                  <li><a href="<%=request.getContextPath()%>/Leave/leaveList.jsp"> <i class="fa fa-envelope-o"></i> Leave List  <span class="label label-success pull-right r-activity">10</span></a></li>
                                </ul> 
                               </div>                                                               
                              </section> 
                         </aside>                             
                         <!--widget end-->
                   </div>
				<%
					DateFormat format = new SimpleDateFormat("dd-MMMM-yyyy");
					Date today = new Date();
					String td = format.format(today);
					int terminated = rs.getInt("TerminationId"); 
					String Fname = rs.getString("FirstName");
					String Lname = rs.getString("LastName");								
					String Name;							
					Name = Fname + " " + Lname;		
					sql = "SELECT noofdays FROM `leavepolicy` where `empid` = ? LIMIT 1";
					ps = con.prepareStatement(sql);	
					ps.setInt(1, Integer.parseInt(empId));
					ResultSet policySet = ps.executeQuery();	
					int noofdays = 0;
					if(policySet.next()){
						noofdays = policySet.getInt(1);
						request.setAttribute("aleave", policySet.getInt(1));											
					}else{
						request.setAttribute("nullMsg", "Enter the No.of Leave in Year");
						RequestDispatcher rd = request.getRequestDispatcher("assignLeave.jsp");
						rd.forward(request, response);											
					}	
				%>
                <aside class="profile-info col-lg-8">
				<section class="panel">
					<header class="panel-heading summary-head">
						<h4> Entitlements for Mr./Ms.<%=Name %></h4>
						<span><%=td %></span>
						<span>No.of Leave Alloted <%=noofdays %></span>
					</header>					
				</section> 
                  
                   <%--	 <section class="panel">
					 <div class="panel-body bio-graph-info">
						<h1><%=InfoConstant.companyName %> Leave Policy.</h1>
						<div class="row">
							<div class="bio-row">
								<span>
									<span>Employee Name </span>:<%=Name%>
								</span>
							</div>  --%>
							<%
								String jdate = 	rs.getString("JoinDate");	
								String manager = GetInfoAbout.getManagerName(rs.getString("ReportTo"))==null?"":GetInfoAbout.getManagerName(rs.getString("ReportTo"));
								DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
								Date date1 = sdf.parse(rs.getString("JoinDate"));								
								Date date2 = new Date();
								int exp[] = GetInfoAbout.getDateDifferenceInDDMMYYYY(date1, date2);
								int years = exp[2];int months=exp[1];int days=exp[0];
							%>
							
						<%-- 	<div class="bio-row">
								<span>
									<span>No. of Leave's Alloted</span>:
									<span>								
										<%
										
										%>
									</span>
								</span>
							</div> --%>
						<!-- 	</aside>
						</div>			 -->			
					<!-- </div>	
					</section>		 -->	 
				<!--  One Management Topic Start -->
				<!-- <section class="panel">
				<aside class="profile-info col-lg-8">
				<div class="inbox-head">
					<h3>
						<i class="fa fa-user"> Employee Leaves</i>
					</h3>
				 	<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newProof" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form> 
				</div>
				</section> -->
				<section class="panel">
					<div class="adv-table">
					<form action="">
					<input type="hidden" name="eid" id="eid" value="<%=empId %>" />
					<input type="hidden" class="aleave" id="aleave" value="<%=(request.getAttribute("aleave")==null?"":request.getAttribute("aleave").toString()) %>" />
					<table class="table">
						<thead>
							<tr>
								<th width="5%">#</th>
                                <th width="15%">Leave Type</th>                                                          
                                <th width="5%">No. of Leave Allowed</th> 
							</tr>
						</thead>
						<tbody>
						<%
								boolean flag = false;
								int count=0;
								String query = "select d1.leavetypeid,d2.noofdays from (SELECT la.leavetypeid FROM leaveassign la WHERE la.leaveassign = (SELECT leaveassign FROM employee WHERE id =?)) d1 left join (select lr.leavetype,lr.noofdays from leaverec lr where lr.empid=?) d2 on d1.leavetypeid=d2.leavetype";
	                            ps = con.prepareStatement(query);
	                            ps.setInt(1,Integer.parseInt(empId));
	                            ps.setInt(2,Integer.parseInt(empId));
	                            ResultSet leaveSet = ps.executeQuery();	                          
	                            while(leaveSet.next()){	  
	                            	++count;
	                            	if(count>2){
                                    %>   
                                    <tr>
                                    	<td colspan="3" style="color:brown;">
                                    	<div class="alert alert-info fade in">                                  
                                  			<strong>Dear HR, Mr./Ms. <%=Name %></strong> Join this concern on <strong><%=jdate %></strong>, He/She is getting work experience in this company for <strong><%=years%><%if(years>1){out.println(" Years");} else{ out.println(" Year"); }%> 
									<%=months %><%if(months>1){out.println(" Months");} else{ out.println(" Month"); }%> & 
									<%=days %><%if(days>1){out.println(" Days");} else{ out.println(" Day"); }%></strong> and He/She reporting to <strong>Mr./Ms.<%=manager%></strong>. If you required discuss with Administration/Concern Department manager then you proceed below mentioned leave policies. Thank you.
                              			</div>                                    	 
                                    	</td>
                                    </tr>
                                    <%
                                    	count=-100;
	                            	}
                                    %>
		                                    <tr>                            
		                                    <td><%=leaveSet.getInt(1) %><input type="hidden" id="ltype" class="ltype" value="<%=(leaveSet.getString(1)!=null?leaveSet.getString(1):"")%>" /></td>
		                                    <td><%=(GetInfoAbout.getleavetype(leaveSet.getString("leavetypeid"))==null?"":GetInfoAbout.getleavetype(leaveSet.getString("leavetypeid"))) %></td>                              
		                                    <td>
		                                    <input class="form-control empleave" id=empleave size="4" type="text" value="<%=(leaveSet.getString(2)!=null?leaveSet.getString(2):0)%>" onkeyup="checkInput(this)" />
		                                    </td></tr>
                                    <%
	                             }                                        
								 try{
									 rs.close();
									 leaveSet.close();			                                    	
			                     }catch(Exception e){}                            			
									%>							
						</tbody>
					</table>		
					<button type="button" class="btn btn-default" id="update_leave"><i class="fa fa-cloud-upload"></i> Update</button>	
					&nbsp;&nbsp;<a href="<%=request.getContextPath() %>/Leave/assignLeave.jsp">
					<button type="button" class="btn btn-info "><i class="fa fa-refresh"></i> Back</button>
					</a>				
					</form>
					</div>
				</section>
				</aside>
				<!-- </section> -->
		<script type="text/javascript">
			function checkInput(ob) {	 
			  var aleave = Number($('.aleave').val());
			  if(aleave<1 || aleave==null){
					alert("First Allocat No.of Leaves.");
			  }else{
				  var invalidChars = /[^0-9]/gi;
				  if(invalidChars.test(ob.value)) {
				     ob.value = ob.value.replace(invalidChars,"");
				  }
			  }
			}
		</script>		
		<script type="text/javascript">		
		
			$('#update_leave').click(function (){
				 var leaves = "";
				 var ltype="";
				 var eid=document.getElementById("eid").value;
				 alert("Employee id"+eid);
				 var count=0;
				 var lcount=0;
				 var aleave = Number($('.aleave').val());				
				 $('.empleave').each(function() {
		        	  if(++count<3){
		        		  lcount+=Number($(this).val());
		        	  }		     	  
		        	  leaves +=  this.value+" ";           			   
           		 });
		         alert("No of Leaves: "+leaves)
		         if(lcount>aleave){		        	 
		        	 alert("Allocated leave is only "+aleave+" Days..");
		        	 $('.empleave').each(function() {			        	  
			        	  this.value="";			        	          			         			   
	           		 }); 	 
		        	 
		         }else{
		        	 $('.ltype').each(function() {	      		 
		        		 ltype +=  this.value+" ";           			   
	           		 });
		        	 alert("Leave type: "+ltype);
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
		     		xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/empLeaveAssign.jsp?empid="+eid+"&ltype="+ltype+"&leaves="+leaves,true);
		     		xmlhttp.send();		
		         }
            });
		
		</script>		
               <!--  One Management Topic End -->            
       
        </section>      
   
    <!-- End Main Content -->
                   
<script src="<%=request.getContextPath()%>/js/pulstate.js" type="text/javascript"></script>
<%@include file="../Common/Footer.jsp"%>