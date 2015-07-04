<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="security.SecureNew"%>

<%
	request.setAttribute("title", "Current Timesheet");
%>

<%@include file="../Common/Header.jsp"%>

<%

	String [] month = new String[]{"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
	Connection con1 = DbConnection.getConnection();
	Statement s = con1.createStatement();
	String sql = "SELECT * FROM `employee` where `id` = '" + request.getAttribute("userid") + "' LIMIT 1";
	ResultSet rs1 = s.executeQuery(sql);
	rs1.next();
	
	s = con1.createStatement();																																			ResultSet rs = s.executeQuery("SELECT * FROM `roles` ORDER BY `role_id`");
		
	SecureNew sn = new SecureNew();
	String fName = rs1.getString("FirstName");
	String lName = rs1.getString("LastName");
	String eName = fName+" "+lName;
	String wMail = sn.decrypt(rs1.getString("WorkEmail"));	
	
	Calendar calc = Calendar.getInstance();	
	
	String fromdate = request.getParameter("fromdate");
	String enddate = request.getParameter("todate");
		
%>

	<!--main content start-->
	<section id="main-content">
          <section class="wrapper">
              <!-- page start-->
              <div class="row">
					<div class="col-lg-12">
					<section class="panel">
                                    		
						<header class="panel-heading summary-head">
						<%Connection con = DbConnection.getConnection();
						PreparedStatement ps2 = con.prepareStatement("select FirstName,LastName from employee where id =?");
						ps2.setInt(1, Integer.parseInt(request.getParameter("empid")));
						ResultSet rs3 = ps2.executeQuery();
						rs3.next();
						%>
							<h4><%=rs3.getString("FirstName")+" "+rs3.getString("LastName") %> Time Sheet</h4>
							<span><%=fromdate +" - "+ enddate%></span>
						</header>
						
						<div class="table-responsive">
						<table class="table table-striped m-b-none text-small datatable " id="sample1" >
							<thead style="background-color: #F3F781; color: #000000;">
								<tr>
									<th>#</th>
									<th>Category</th>
									<% SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
									Calendar c = Calendar.getInstance();
									c.setTime(sdf.parse(fromdate));
									
									
									%>
									<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>
									<%
									c.add(Calendar.DATE, 1);  
									
									c.setTime(sdf.parse(sdf.format(c.getTime())));
									%>
										<th><%=c.get(Calendar.DATE) %>-<%=month[c.get(Calendar.MONTH)] %></th>				
									<th>Total</th>
								</tr>
							</thead>
							<tbody>	
							<%
							boolean old = false;
							int count = 0;
							
							PreparedStatement ps  = con.prepareStatement("select * from timesheetmaster where empid = ? and fromdate = ? and todate = ?");
							ps.setInt(1, Integer.parseInt(request.getParameter("empid")));
							ps.setString(2, fromdate);
							ps.setString(3, enddate);
								
							
							ResultSet rs2 = ps.executeQuery();
							int rowcount = 0;
							while(rs2.next()){
							old = true;	
							count = rs2.getInt("count");

							
							%>
							
															
							<tr>																									
							<td>
								
									<input type="checkbox"
									 <% if(rowcount>0){out.println("name='chkbox[]'");}else{out.println("name='categoryid' id='categoryid'");}%>
									 class="form-control contract">
																											
							</td>	
							<td>
								
										<select  class="form-control"<% if(rowcount>0){out.println("id='category"+rowcount+"'name='category"+rowcount+"'");}else{out.println("id ='category' name = 'category'");}%>
														data-required="true" data-notblank="true" disabled>
											<option value="">---Select---</option>			
											<%			
											PreparedStatement ps1 = con.prepareStatement("select CategoryId,CategoryName from tscategory");
												ResultSet categorySet = ps1.executeQuery();
												while (categorySet.next()) {
													
											%>																										
													<option value="<%=categorySet.getString(1)%>" <%if(rs2.getString("cat").equals(categorySet.getString(1))){ out.println("selected");} %>><%=categorySet.getString(2)%></option>																										
											<%
												}
											%>	
										</select>
								
							</td>								
							<td>
								
									<input class="form-control" <%if(rowcount>0){out.print("id='mon"+rowcount+"' name ='mon[]'" );}else{out.print("id='mon' name ='mon'"); }%> value = "<%=rs2.getString("d1") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" onkeyup="checkInput(this)" size="2" onblur="Totalhrsperday()"  readonly/>
								
							</td>
							<td>
								
									<input class="form-control" <%if(rowcount>0){out.print("id='tue"+rowcount+"' name ='tue[]'" );}else{out.print("id='tue' name ='tue'"); }%>  value = "<%=rs2.getString("d2") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" readonly/>
								
							</td>
							<td>
								
									<input class="form-control"
									<%if(rowcount>0){out.print("id='wed"+rowcount+"' name ='wed[]'" );}else{out.print("id='wed' name ='wed'"); }%> 
									 value = "<%=rs2.getString("d3") %>" 
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" readonly/>
								
							</td>
							<td>
								
									<input class="form-control" 
										<%if(rowcount>0){out.print("id='thu"+rowcount+"' name ='thu[]'" );}else{out.print("id='thu' name ='thu'"); }%>
 											value = "<%=rs2.getString("d4") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()"readonly/>
								
							</td>
							<td>
								
									<input class="form-control" 
									<%if(rowcount>0){out.print("id='fri"+rowcount+"' name ='fri[]'" );}else{out.print("id='fri' name ='fri'"); }%>
									value = "<%=rs2.getString("d5") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()"readonly/>
								
							</td>
							<td>
								
									<input class="form-control" 
									<%if(rowcount>0){out.print("id='sat"+rowcount+"' name ='sat[]'" );}else{out.print("id='sat' name ='sat'"); }%>
									 value = "<%=rs2.getString("d6") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" readonly/>
								
							</td>
							<td>
								
									<input class="form-control" 
									<%if(rowcount>0){out.print("id='sun"+rowcount+"' name ='sun[]'" );}else{out.print("id='sun' name ='sun'"); }%>
									 value = "<%=rs2.getString("d7") %>"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" readonly />
								
							</td>
							<td>
								
									<input class="form-control" 
									<%if(rowcount>0){out.print("id='tot"+rowcount+"' name ='tot[]'" );}else{out.print("id='tot' name ='total'"); }%>
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" readonly />
								
							</td>
							</tr>	
							<%
							rowcount++;
							} %>	
							<%if(!old){ %>																									
							
							<tr>																									
							<td>
								<div class="form-group">
									<input type="checkbox" name="categoryid" id="categoryid" class="form-control contract">
								</div>																				
							</td>	
							<td>
								<div class="form-group">
									<div>
										<select id="category" class="form-control" name="category"
														data-required="true" data-notblank="true">
											<option value="">---Select---</option>			
											<%				
											PreparedStatement ps1 = con.prepareStatement("select CategoryId,CategoryName from tscategory");
											ResultSet categorySet = ps1.executeQuery();
												while (categorySet.next()) {
											%>																										
													<option value="<%=categorySet.getString(1)%>"><%=categorySet.getString(2)%></option>																										
											<%
												}
											%>	
										</select>
									</div>
								</div>
							</td>								
							<td>
								<div>
									<input class="form-control" id="mon" name="mon"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" onkeyup="checkInput(this)" size="2" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="tue" name="tue"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="wed" name="wed"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="thu" name="thu"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="fri" name="fri"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="sat" name="sat"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="sun" name="sun"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" onkeyup="checkInput(this)" onblur="Totalhrsperday()" />
								</div>
							</td>
							<td>
								<div>
									<input class="form-control" id="tot" name="total"
										type="text" data-requried="true" data-notblank="true"
										data-type="text" size="2" readonly />
								</div>
							</td>
							</tr>	
							<%} %>
						</tbody>
						</table>
						</div>
						<div class="table-responsive">
						<table class="table table-striped m-b-none text-small datatable " id="sample1">
							<thead>
								<tr>								
								<th>
									<div>
										<input class="form-control" id="thours" name="thours"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="14" value="Total Work Hours in Day" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_mon" name="h_mon"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_tue" name="h_tue"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_wed" name="h_wed"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_thu" name="h_thu"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_fri" name="h_fri"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_sat" name="h_sat"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="h_sun" name="h_sun"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>
								<th>
									<div>
										<input class="form-control" id="weektot" name="weektot"
											type="text" data-requried="true" data-notblank="true"
											data-type="text" size="2" readonly />
									</div>
								</th>		
								</tr>
							</thead>
						</table>	
													
						</div>						
					<!-- </aside> -->
					<header class="panel-heading summary-head">
					<h4>Time Sheet Log</h4>
					</header>
						<table class="table table-striped m-b-none text-small datatable " id="sample1">
						<thead>
							<tr>
								<th>User</th>
								<th>Comment</th>
								<th>Updated By</th>
								<th>Time Stamp</th>
							</tr>
							<%PreparedStatement ps3 = con.prepareStatement("select * from timesheetlog where empid = ? and fromdate = ? and todate = ?");
							ps3.setInt(1, Integer.parseInt(request.getParameter("empid")));
							ps3.setString(2, fromdate);
							ps3.setString(3, enddate);
							ResultSet rs4 = ps3.executeQuery();
							while(rs4.next()){
							%>
						<tr>
							<td><%=rs4.getInt("empid") %></td>
							<td><%=rs4.getString("comment") %></td>
							<td><%=rs4.getString("updatedby") %></td>
							<td><%=rs4.getString("timest") %></td>
						
						</tr>
						<%} %>
						</thead>
						
						
						</table>
					</section>	
				</div>
				</div>
			</section>
		</section>		
		

	<script src="<%=request.getContextPath()%>/assets/jquery-knob/js/jquery.knob.js"></script>  	
  	<script>
	      //knob
	      $(".knob").knob();	      
  	</script>
  	
	<script type="text/javascript">
	<% if(old){%>
	var count = <%=count%>;
	<%}else{ %>
	var count =1;
	<% } %>
	
	var element10;
	var id;
	var c=count;
	function checkInput(ob) {	 
	  var invalidChars = /[^0-9]/gi;
	  if(invalidChars.test(ob.
		value)) {
				ob.value = ob.value.replace(invalidChars, "");
			}

			var sel = document.getElementById("category").value;
			if (sel < 1) {
				alert("Select Category First");
				ob.value = "";

			} else if (ob.value > 24) {
				alert("You cannot Work more than 24 hours per day");
				ob.value = "";

			}
			if (count != 1) {
				for (var i = 1; i < count; i++) {
					var temp = "category" + i;
					sel = document.getElementById(temp).value;
					if (sel < 1) {
						alert("Select Category First");
						ob.value = "";

					}
				}
			}
		}
		function Totalhrsperday() {
			var els_mon = [ 'mon' ];
			var els_tue = [ 'tue' ];
			var els_wed = [ 'wed' ];
			var els_thu = [ 'thu' ];
			var els_fri = [ 'fri' ];
			var els_sat = [ 'sat' ];
			var els_sun = [ 'sun' ];
			var els_tot = [ 'tot' ];

			for (var i = 1; i <= count; i++) {
				els_mon.push('mon' + i);
				els_tue.push('tue' + i);
				els_wed.push('wed' + i);
				els_thu.push('thu' + i);
				els_fri.push('fri' + i);
				els_sat.push('sat' + i);
				els_sun.push('sun' + i);
				els_tot.push('tot' + i);
			}
			var per_montot = 0;
			var per_tuetot = 0;
			var per_wedtot = 0;
			var per_thutot = 0;
			var per_fritot = 0;
			var per_sattot = 0;
			var per_suntot = 0;
			
			for (var i_tem = 0; i_tem < count; i_tem++) {

				var mon1 = document.getElementById(els_mon[i_tem]).value;
			
				var tue1 = document.getElementById(els_tue[i_tem]).value;
				var wed1 = document.getElementById(els_wed[i_tem]).value;
				var thu1 = document.getElementById(els_thu[i_tem]).value;
				var fri1 = document.getElementById(els_fri[i_tem]).value;
				var sat1 = document.getElementById(els_sat[i_tem]).value;
				var sun1 = document.getElementById(els_sun[i_tem]).value;

				if (mon1 == "") {
					mon1 = 0;
				} else {
					mon1;
				}

				if (tue1 == "") {
					tue1 = 0;
				} else {
					tue1;
				}

				if (wed1 == "") {
					wed1 = 0;
				} else {
					wed1;
				}

				if (thu1 == "") {
					thu1 = 0;
				} else {
					thu1;
				}

				if (fri1 == "") {
					fri1 = 0;
				} else {
					fri1;
				}

				if (sat1 == "") {
					sat1 = 0;
				} else {
					sat1;
				}

				if (sun1 == "") {
					sun1 = 0;
				} else {
					sun1;
				}

				var totalhrs1 = parseFloat(mon1) + parseFloat(tue1)
						+ parseFloat(wed1) + parseFloat(thu1)
						+ parseFloat(fri1) + parseFloat(sat1)
						+ parseFloat(sun1);
				
				document.getElementById(els_tot[i_tem]).value = totalhrs1;
				
				if(per_montot + parseFloat(mon1) > 24){
					
					document.getElementById(els_mon[i_tem]).value = 0;
					break;
				}else{
					per_montot = per_montot + parseFloat(mon1);
					document.getElementById("h_mon").value = per_montot;	
				}
				
				
			
				
				
				if(per_tuetot + parseFloat(tue1) > 24){
					
					document.getElementById(els_tue[i_tem]).value = 0;
					
				}else{
					per_tuetot = per_tuetot + parseFloat(tue1);
					document.getElementById("h_tue").value = per_tuetot;	
				} 
				
				
				
				
				if(per_wedtot + parseFloat(wed1) > 24){
					
					document.getElementById(els_wed[i_tem]).value = 0;
					
				}else{
					per_wedtot = per_wedtot + parseFloat(wed1);
					document.getElementById("h_wed").value = per_wedtot;	
				} 
				
				
				
		
				
				if(per_thutot + parseFloat(thu1) > 24){
					
					document.getElementById(els_thu[i_tem]).value = 0;
					
				}else{
					per_thutot = per_thutot + parseFloat(thu1);
					document.getElementById("h_thu").value = per_thutot;	
				} 
				
				
				
				if(per_fritot + parseFloat(fri1) > 24){
					
					document.getElementById(els_fri[i_tem]).value = 0;
					
				}else{
					per_fritot = per_fritot + parseFloat(fri1);
					document.getElementById("h_fri").value = per_fritot;	
				} 
				
				
			
				
				if(per_sattot + parseFloat(sat1) > 24){
					
					document.getElementById(els_sat[i_tem]).value = 0;
					
				}else{
					per_sattot = per_sattot + parseFloat(sat1);
					document.getElementById("h_sat").value = per_sattot;	
				} 
				
				
				
			if(per_suntot + parseFloat(sun1) > 24){
					
					document.getElementById(els_sun[i_tem]).value = 0;
					
				}else{
					per_suntot = per_suntot + parseFloat(sun1);
					document.getElementById("h_sun").value = per_suntot;	
				}	

			}
		}
		
	</script>
	
  	<script>
Totalhrsperday();
</script>

	<%con.close(); %>
 	<!--script for this page only-->
    <script src="<%=request.getContextPath()%>/js/gritter.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/pulstate.js" type="text/javascript"></script>

<%@include file="../Common/Footer.jsp"%>