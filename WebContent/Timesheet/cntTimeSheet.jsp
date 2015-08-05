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
Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	String sql = "SELECT * FROM `employee` where `id` = '" + request.getAttribute("userid") + "' LIMIT 1";
	ResultSet rs1 = s.executeQuery(sql);
	rs1.next();
	
	s = con.createStatement();																																			ResultSet rs = s.executeQuery("SELECT * FROM `roles` ORDER BY `role_id`");
		
	SecureNew sn = new SecureNew();
	String fName = rs1.getString("FirstName");
	String lName = rs1.getString("LastName");
	String eName = fName+" "+lName;
	String wMail = sn.decrypt(rs1.getString("WorkEmail"));	
	Calendar calc = Calendar.getInstance();	
	Calendar calc1 = Calendar.getInstance();
	Calendar calc2 = Calendar.getInstance();	
	int day = calc.get(Calendar.DAY_OF_WEEK);
	String cntMonth = new SimpleDateFormat("MMM").format(calc.getTime());
	String cntYear = new SimpleDateFormat("YYYY").format(calc.getTime());	
	DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
	String fromdate = null;
	String enddate = null;
	String cntsheet = null;
	Date frdate = null;
	Date todate = null;
	
	switch(day){
	case 1:
		 calc1.add(Calendar.DATE, 1);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 7);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate;   	     
		 break;
	case 2:
		calc1.add(Calendar.DATE, 0);
	    frdate = calc1.getTime();   
	    fromdate = dateFormat.format(frdate); 
		calc2.add(Calendar.DAY_OF_WEEK, 6);
	    todate = calc2.getTime();   
	    enddate = dateFormat.format(todate);
	    cntsheet = fromdate+" to "+enddate;   	  
		break;
	case 3:
		calc1.add(Calendar.DATE, -1);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 5);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate; 
		break;
	case 4:
		calc1.add(Calendar.DATE, -2);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 4);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate; 
		break;
	case 5:
		calc1.add(Calendar.DATE, -3);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 3);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate;  
		break;
	case 6:
		 calc1.add(Calendar.DATE, -4);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 2);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate; 
		 break;		
	case 7:
		calc1.add(Calendar.DATE, -5);
	     frdate = calc1.getTime();   
	     fromdate = dateFormat.format(frdate); 
		 calc2.add(Calendar.DAY_OF_WEEK, 1);
	     todate = calc2.getTime();   
	     enddate = dateFormat.format(todate);
	     cntsheet = fromdate+" to "+enddate; 
		break;	
	default:
		break;
	}

%>

<!--main content start-->
	<section id="main-content">
          <section class="wrapper">
              <!-- page start-->
              <div class="row">
					<div class="col-lg-12">
					<section class="panel">
                    <!--Current Timesheet  -->                   
                    <!-- <aside class="profile-info">   -->                		
						<header class="panel-heading summary-head">
							<h4>Current Time Sheet</h4>
							<span><%=cntsheet%></span>
						</header>
						<div class="table-responsive">
						<table class="table table-striped m-b-none text-small datatable" >
							<thead>
								<tr>
								<th>
		               			<button class="btn btn-info" type="button" onclick="add()">Add Row</button>
		               			<button class="btn btn-danger" type="button"  disabled id = "btndeleterow" >Delete Row</button>
		               			<button class="btn btn-primary" type="button" onclick = "saveTimeSheet(); ">Save</button>
		               			<button class="btn btn-success" type="button" onclick = "submitTimeSheet();">Submit</button>
		               			<button class="btn btn-warning" type="button" onclick = "resetTimeSheet();">Reset</button></th>	
		               			<th>Comments:</th><th><textarea style="resize: none;" rows="1" cols="25" name ="comment" id ="comment"></textarea></th>							
								</tr>								
							</thead>
						</table>								
						</div>
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
							</section>
							</div>
							</div>
							</section>
							</section>
		<script>
		var c = 0;
		var count = 0;
		
		function add() {
			
			var table = document.getElementById("sample1");
			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);

			var cell1 = row.insertCell(0);
			var element1 = document.createElement("input");
			element1.type = "checkbox";
			element1.id="chkbox";
			element1.name="chkbox";
			element1.value="";
			element1.setAttribute('class', 'form-control input-sm m-bot15 case');
			cell1.appendChild(element1);

			var cell2 = row.insertCell(1);
			var element11 = document.createElement("select");
			//element11.type="text";
			element11.hasOwnProperty("form-control");
			element11.name = "category";
			element11.size = "";
			element11.id = "category" + c;
			element11.setAttribute('class', 'form-control');
			c++;

			//element11.setAttribute('onchange','checkSelectedValue()');
			var op0 = document.createElement("option");
			op0.text = "---Select---";
			op0.value = "";
			element11.add(op0);
	<%
		 		
				Statement st = con.createStatement();
				ResultSet rset = st.executeQuery("select CategoryId,CategoryName from tscategory");
				
				while (rset.next()){
		%>		 
					 var op1 = document.createElement("option");
					 op1.text = "<%=rset.getString(2)%>";
					 op1.value ="<%=rset.getString(1)%>";
					 

					 
					 element11.add(op1);					 
		<%		
				}
		%>		
			cell2.appendChild(element11);
			
			var cell3 = row.insertCell(2);
			var element2 = document.createElement("input");
			element2.type = "text";
			element2.name = "mon[]";
			element2.id = "mon" + count;
			element2.size = "2";
			element2.setAttribute('class', 'form-control');
			element2.setAttribute('onkeyup', 'checkInput(this)');
			element2.setAttribute('onblur', 'Totalhrsperday()');
			cell3.appendChild(element2);

			var cell4 = row.insertCell(3);
			var element4 = document.createElement("input");
			element4.type = "text";
			element4.name = "tue[]";
			element4.id = "tue" + count;
			element4.size = "2";
			element4.setAttribute('class', 'form-control');
			element4.setAttribute('onkeyup', 'checkInput(this)');
			element4.setAttribute('onblur', 'Totalhrsperday()');
			cell4.appendChild(element4);

			var cell5 = row.insertCell(4);
			var element5 = document.createElement("input");
			element5.type = "text";
			element5.name = "wed[]";
			element5.id = "wed" + count;
			element5.size = "2";
			element5.setAttribute('class', 'form-control');
			element5.setAttribute('onkeyup', 'checkInput(this)');
			element5.setAttribute('onblur', 'Totalhrsperday()');
			cell5.appendChild(element5);

			var cell6 = row.insertCell(5);
			var element6 = document.createElement("input");
			element6.type = "text";
			element6.name = "thu[]";
			element6.id = "thu" + count;
			element6.size = "2";
			element6.setAttribute('class', 'form-control');
			element6.setAttribute('onkeyup', 'checkInput(this)');
			element6.setAttribute('onblur', 'Totalhrsperday()');
			cell6.appendChild(element6);

			var cell7 = row.insertCell(6);
			var element7 = document.createElement("input");
			element7.type = "text";
			element7.name = "fri[]";
			element7.id = "fri" + count;
			element7.size = "2";
			element7.setAttribute('class', 'form-control');
			element7.setAttribute('onkeyup', 'checkInput(this)');
			element7.setAttribute('onblur', 'Totalhrsperday()');
			cell7.appendChild(element7);

			var cell8 = row.insertCell(7);
			var element8 = document.createElement("input");
			element8.type = "text";
			element8.name = "sat[]";
			element8.id = "sat" + count;
			element8.size = "2";
			element8.setAttribute('class', 'form-control');
			element8.setAttribute('onkeyup', 'checkInput(this)');
			element8.setAttribute('onblur', 'Totalhrsperday()');
			cell8.appendChild(element8);

			var cell9 = row.insertCell(8);
			var element9 = document.createElement("input");
			element9.type = "text";
			element9.name = "sun[]";
			element9.id = "sun" + count;
			element9.size = "2";
			element9.setAttribute('class', 'form-control');
			element9.setAttribute('onkeyup', 'checkInput(this)');
			element9.setAttribute('onblur', 'Totalhrsperday()');
			cell9.appendChild(element9);

			var cell10 = row.insertCell(9);
			element10 = document.createElement("input");
			element10.type = "text";
			element10.name = "tot[]";
			element10.id = "tot" + count;
			element10.size = "2";
		
			element10.setAttribute('class', 'form-control');
			element10.setAttribute("readOnly", "true");			
			cell10.appendChild(element10);
			count++;
			checkboxcheck();
	}
		
		</script>			
		
		<script>
		function Totalhrsperday() {
			
		
			var per_montot = 0;
			var per_tuetot = 0;
			var per_wedtot = 0;
			var per_thutot = 0;
			var per_fritot = 0;
			var per_sattot = 0;
			var per_suntot = 0;
			
			for (var i_tem = 0; i_tem < count; i_tem++) {

				var mon1 = document.getElementById("mon"+i_tem).value;
			
				var tue1 = document.getElementById("tue"+i_tem).value;
				var wed1 = document.getElementById("wed"+i_tem).value;
				var thu1 = document.getElementById("thu"+i_tem).value;
				var fri1 = document.getElementById("fri"+i_tem).value;
				var sat1 = document.getElementById("sat"+i_tem).value;
				var sun1 = document.getElementById("sun"+i_tem).value;

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
			
				document.getElementById("tot"+i_tem).value = totalhrs1;
				
				if(per_montot + parseFloat(mon1) > 24){
					
					document.getElementById("mon"+i_tem).value = 0;
					break;
				}else{
					per_montot = per_montot + parseFloat(mon1);
					document.getElementById("h_mon").value = per_montot;	
				}
				
				
			
				
				
				if(per_tuetot + parseFloat(tue1) > 24){
					
					document.getElementById("tue"+i_tem).value = 0;
					
				}else{
					per_tuetot = per_tuetot + parseFloat(tue1);
					document.getElementById("h_tue").value = per_tuetot;	
				} 
				
				
				
				
				if(per_wedtot + parseFloat(wed1) > 24){
					
					document.getElementById("wed"+i_tem).value = 0;
					
				}else{
					per_wedtot = per_wedtot + parseFloat(wed1);
					document.getElementById("h_wed").value = per_wedtot;	
				} 
				
				
				
		
				
				if(per_thutot + parseFloat(thu1) > 24){
					
					document.getElementById("thu"+i_tem).value = 0;
					
				}else{
					per_thutot = per_thutot + parseFloat(thu1);
					document.getElementById("h_thu").value = per_thutot;	
				} 
				
				
				
				if(per_fritot + parseFloat(fri1) > 24){
					
					document.getElementById("fri"+i_tem).value = 0;
					
				}else{
					per_fritot = per_fritot + parseFloat(fri1);
					document.getElementById("h_fri").value = per_fritot;	
				} 
				
				
			
				
				if(per_sattot + parseFloat(sat1) > 24){
					
					document.getElementById("sat"+i_tem).value = 0;
					
				}else{
					per_sattot = per_sattot + parseFloat(sat1);
					document.getElementById("h_sat").value = per_sattot;	
				} 
				
				
				
			if(per_suntot + parseFloat(sun1) > 24){
					
					document.getElementById("sun"+i_tem).value = 0;
					
				}else{
					per_suntot = per_suntot + parseFloat(sun1);
					document.getElementById("h_sun").value = per_suntot;	
				}	

			}
			
			document.getElementById("weektot").value = parseFloat(document.getElementById("h_mon").value)+
			parseFloat(document.getElementById("h_tue").value)+
			parseFloat(document.getElementById("h_wed").value)+
			parseFloat(document.getElementById("h_thu").value)+
			parseFloat(document.getElementById("h_fri").value)+
			parseFloat(document.getElementById("h_sat").value)+
			parseFloat(document.getElementById("h_sun").value);
		}
		</script>
		<script>
		function checkInput(ob) {	 
			
			  var invalidChars = /[^0-9]/gi;
			  if(invalidChars.test(ob.
				value)) {
						ob.value = ob.value.replace(invalidChars, "");
					}

				
					if (ob.value > 24) {
						alert("You cannot Work more than 24 hours per day");
						ob.value = "";

					}
			
						for (var i = 0; i < count; i++) {
							
							var temp = "category" + i;
							try{
							sel = document.getElementById(temp).value;
						}catch(err){
							console.log(err);
						}
							if (sel < 1) {
								alert("Select Category First");
								ob.value = "";

							}
							
						}
		
					
				}
		</script>
		<script>
  	function saveTimeSheet(){
  		  	
  		
  		  		var param = "";
  		  	param = "from=<%= fromdate%>&todate=<%= enddate%>&count="+count;
  		  param += "&comment="+document.getElementById('comment').value;
  	
		  		for(var i = 0;i<count;i++){
		  			
			  		var j = i+1;
		  			param += "&"+j+"cat="+document.getElementById('category'+i).value;
			  		param += "&"+j+"r1="+document.getElementById('mon'+i).value;
	    		  	param += "&"+j+"r2="+document.getElementById('tue'+i).value;
	    		  	param += "&"+j+"r3="+document.getElementById('wed'+i).value;
	    		  	param += "&"+j+"r4="+document.getElementById('thu'+i).value;
	    		  	param += "&"+j+"r5="+document.getElementById('fri'+i).value;
	    		  	param += "&"+j+"r6="+document.getElementById('sat'+i).value;
	    		  	param += "&"+j+"r7="+document.getElementById('sun'+i).value;
		  		}
		  		
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
		  		$.gritter.add({
					title : 'Save Time Sheet',
					text :$.trim(xmlhttp.responseText)
				});
		  	    	window.location.reload(true);
		  	    }
		   }
		  	
		  	xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/addtimesheet.jsp?"+param,true);
		  	xmlhttp.send();
	 
  		  	
  	}
  	</script>
  	
  	<script>
  //Load Data From Database 
  	<%
	PreparedStatement ps =con.prepareStatement("select * from timesheetmaster where empid = ? and fromdate = ? and todate = ?");
	ps.setInt(1,(Integer)request.getAttribute("userid"));
	ps.setString(2, fromdate);
	ps.setString(3, enddate);
	
	ResultSet rs5 = ps.executeQuery();
	while(rs5.next()){
	%>

	addfromdb(<%= rs5.getInt("id")%>,<%=rs5.getString("cat")%>,<%if(rs5.getString("d1").isEmpty()||rs5.getString("d1")==null){out.println(0);}else{out.println(rs5.getString("d1"));}%>
	,<%if(rs5.getString("d2").isEmpty()||rs5.getString("d2")==null){out.println(0);}else{out.println(rs5.getString("d2"));}%>
	,<%if(rs5.getString("d3").isEmpty()||rs5.getString("d3")==null){out.println(0);}else{out.println(rs5.getString("d3"));}%>
	,<%if(rs5.getString("d4").isEmpty()||rs5.getString("d4")==null){out.println(0);}else{out.println(rs5.getString("d4"));}%>
	,<%if(rs5.getString("d5").isEmpty()||rs5.getString("d5")==null){out.println(0);}else{out.println(rs5.getString("d5"));}%>
	,<%if(rs5.getString("d6").isEmpty()||rs5.getString("d6")==null){out.println(0);}else{out.println(rs5.getString("d6"));}%>
	,<%if(rs5.getString("d7").isEmpty()||rs5.getString("d7")==null){out.println(0);}else{out.println(rs5.getString("d7"));}%>
	);
	Totalhrsperday();
	<%}%>
	
	function addfromdb(id,catno,d1,d2,d3,d4,d5,d6,d7) {
		var table = document.getElementById("sample1");
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);

		var cell1 = row.insertCell(0);
		var element1 = document.createElement("input");
		element1.type = "checkbox";
		
		element1.value = id;
		element1.name="chkbox";
		
		element1.setAttribute('class', 'form-control input-sm m-bot15 case');
		cell1.appendChild(element1);

		var cell2 = row.insertCell(1);
		var element11 = document.createElement("select");
		//element11.type="text";
		element11.hasOwnProperty("form-control");
		element11.name = "category";
		element11.size = "";
		element11.id = "category" + c;
		element11.setAttribute('class', 'form-control');
		c++;

		//element11.setAttribute('onchange','checkSelectedValue()');
		var op0 = document.createElement("option");
		op0.text = "---Select---";
		op0.value = "";
		element11.add(op0);
<%
	 		
			Statement st1 = con.createStatement();
			ResultSet rset1 = st1.executeQuery("select CategoryId,CategoryName from tscategory");
			
			while (rset1.next()){
	%>		 
				 var op1 = document.createElement("option");
				 op1.text = "<%=rset1.getString(2)%>";
				 op1.value ="<%=rset1.getString(1)%>";
				 
				 if(<%=rset1.getInt("CategoryId")%>==catno){
				
				 op1.selected=true;
				 
				 }
				 
				 element11.add(op1);					 
	<%		
			}
	%>		
		cell2.appendChild(element11);
		
		var cell3 = row.insertCell(2);
		var element2 = document.createElement("input");
		element2.type = "text";
		element2.name = "mon[]";
		element2.id = "mon" + count;
		element2.size = "2";
		element2.value = d1;
		element2.setAttribute('class', 'form-control');
		element2.setAttribute('onkeyup', 'checkInput(this)');
		element2.setAttribute('onblur', 'Totalhrsperday()');
		cell3.appendChild(element2);

		var cell4 = row.insertCell(3);
		var element4 = document.createElement("input");
		element4.type = "text";
		element4.name = "tue[]";
		element4.id = "tue" + count;
		element4.size = "2";
		element4.value = d2;
		element4.setAttribute('class', 'form-control');
		element4.setAttribute('onkeyup', 'checkInput(this)');
		element4.setAttribute('onblur', 'Totalhrsperday()');
		cell4.appendChild(element4);

		var cell5 = row.insertCell(4);
		var element5 = document.createElement("input");
		element5.type = "text";
		element5.name = "wed[]";
		element5.id = "wed" + count;
		element5.size = "2";
		element5.value = d3;
		element5.setAttribute('class', 'form-control');
		element5.setAttribute('onkeyup', 'checkInput(this)');
		element5.setAttribute('onblur', 'Totalhrsperday()');
		cell5.appendChild(element5);

		var cell6 = row.insertCell(5);
		var element6 = document.createElement("input");
		element6.type = "text";
		element6.name = "thu[]";
		element6.id = "thu" + count;
		element6.size = "2";
		element6.value = d4;
		element6.setAttribute('class', 'form-control');
		element6.setAttribute('onkeyup', 'checkInput(this)');
		element6.setAttribute('onblur', 'Totalhrsperday()');
		cell6.appendChild(element6);

		var cell7 = row.insertCell(6);
		var element7 = document.createElement("input");
		element7.type = "text";
		element7.name = "fri[]";
		element7.id = "fri" + count;
		element7.size = "2";
		element7.value = d5;
		element7.setAttribute('class', 'form-control');
		element7.setAttribute('onkeyup', 'checkInput(this)');
		element7.setAttribute('onblur', 'Totalhrsperday()');
		cell7.appendChild(element7);

		var cell8 = row.insertCell(7);
		var element8 = document.createElement("input");
		element8.type = "text";
		element8.name = "sat[]";
		element8.id = "sat" + count;
		element8.size = "2";
		element8.value = d6;
		element8.setAttribute('class', 'form-control');
		element8.setAttribute('onkeyup', 'checkInput(this)');
		element8.setAttribute('onblur', 'Totalhrsperday()');
		cell8.appendChild(element8);

		var cell9 = row.insertCell(8);
		var element9 = document.createElement("input");
		element9.type = "text";
		element9.name = "sun[]";
		element9.id = "sun" + count;
		element9.size = "2";
		element9.value = d7;
		element9.setAttribute('class', 'form-control');
		element9.setAttribute('onkeyup', 'checkInput(this)');
		element9.setAttribute('onblur', 'Totalhrsperday()');
		cell9.appendChild(element9);

		var cell10 = row.insertCell(9);
		element10 = document.createElement("input");
		element10.type = "text";
		element10.name = "tot[]";
		element10.id = "tot" + count;
		element10.size = "2";
	
		element10.setAttribute('class', 'form-control');
		element10.setAttribute("readOnly", "true");			
		cell10.appendChild(element10);
		count++;
}
	
  	
  	</script>
  	<script>
  	function submitTimeSheet(){
  		saveTimeSheet();
		var param = "";
		  	param = "from=<%= fromdate%>&todate=<%= enddate%>";
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
	  		$.gritter.add({
				title : 'Submit Time Sheet',
				text :$.trim(xmlhttp.responseText)
			});
	  	    	
	  	    }
	  	  }
	  	
	  	xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/submittimesheet.jsp?"+param,true);
	  	xmlhttp.send();
 
  	}
  	</script>
  	<script>
  	function resetTimeSheet(){
  	
  		var con = confirm("Are You Sure Want to Reset Time Sheet ? ");
  		if(con){
  			var param = "";
		  	param = "from=<%= fromdate%>&todate=<%= enddate%>";
  			
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
	  		$.gritter.add({
				title : 'Reset Time Sheet',
				text :$.trim(xmlhttp.responseText)
			});
	  		window.location.reload(true);
	  	    }
	  	  }
	  	
	  	xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/resettimesheet.jsp?"+param,true);
	  	xmlhttp.send();
 
  			
  			
  			
  		}
  	}
  	
  	</script>
  	<script>
  	$(document).ready(function(){	
  		checkboxcheck();
  	});
  	function checkboxcheck(){

  		$(".case").change(function(){
  			
  			if ($('.case:checked').length >0) {
  				$('#btndeleterow').removeAttr('disabled');
  		    }else{
  		    	 $("#btndeleterow").attr("disabled", "disabled");
  		    }
  		});
  		
  		$("#btndeleterow").click(function(){
  			var conf = confirm("Are you sure want to delete Row");
  			if(conf){
  			var value ="";
  		$('input:checkbox[name=chkbox]').each(function() 
  				{    
  				    if($(this).is(':checked'))
  				     value += $(this).val()+",";
  				});
  		value=value.slice(0,-1);
  	
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
  		$.gritter.add({
			title : 'Delete Row',
			text :$.trim(xmlhttp.responseText)
		});
  		window.location.reload(true);
  	    }
  	  }
  	
  	xmlhttp.open("GET","<%=request.getContextPath()%>/Ajax/deleterowtimesheet.jsp?rowno="+value,true);
  	xmlhttp.send();
winndow.location.reload(true);
  		
  		
  			}
  		});
  	
  	
  	}
  	
  	
  	</script>

		<%con.close(); %>		
<%@include file="../Common/Footer.jsp"%>