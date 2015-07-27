<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>

<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" data-keyboard="false" data-backdrop="static"
	tabindex="-1" id="notificationsm" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Notifications</h4>
			</div>

			<div class="modal-body">
				<section class="panel">
					<div class="list-group" id="al2556"></div>
				</section>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
		$(document).ready(function() {			
			$("#al2556").load('<%=request.getContextPath()%>/Ajax/getNotifications.jsp?e=list');
		});
		</script>

<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="Attendance" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Todays Attendance</h4>
			</div>

			<div class="modal-body">
				<h3>
					Status Information :
					<%
					Connection attcon = DbConnection.getConnection();
					Statement atts = attcon.createStatement();
					String empid = request.getAttribute("userid").toString();
					boolean profile_empty = false;
					ResultSet res = atts
							.executeQuery("SELECT `Picture`,`WorkEmail`,`DateofBirth`,`Nationality`,`Pancardnumber`,`AddressLine1`,`AddressLine2`,`City`,`State`,`ZipCode`,`Country` FROM `employee` WHERE `id`='"
									+ empid + "'");
					res.next();
					String pic = res.getString(1);
					if (res.getString(2) == null
							|| res.getString(3) == null || res.getString(4) == null
							|| res.getString(5) == null || res.getString(6) == null
							|| res.getString(7) == null || res.getString(8) == null
							|| res.getString(9) == null || res.getString(10) == null
							|| res.getString(11) == null) {
						profile_empty = true;
					}
					SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
					Date cDate = new Date();
					String cDat = sd.format(cDate);
					boolean punchin = false;
					boolean punchout = false;
					boolean overtime = false;
					ResultSet attrs = atts
							.executeQuery("SELECT * FROM attendance WHERE `empid` = '"
									+ empid + "' AND `Date` = '" + cDat + "' LIMIT 1");
					if (profile_empty) {
						out.print("PLEASE COMPLETE YOUR PROFILE");
// 					}else if(pic == null ){
// 						out.print("Please Upload your Profile Picture");
					}else{
						if (attrs.next()) {

							//check if alreay punched out
							String pouttime = attrs.getString("logouttime");
							if (pouttime != null) {
								if (!pouttime.isEmpty()) {
									out.print("Todays Session is Complete");
									overtime = true;
								}
							} else {
								out.print("You Have Punched in");
								punchout = true;
				%>
					<a href="<%=request.getContextPath()%>/Ajax/PunchOut.jsp"
						class="btn btn-info btn-lg">Punch Out Now</a>
					<%
						}
							} else {
								out.print("Please Punch Now");
								punchin = true;
					%>
					<a href="<%=request.getContextPath()%>/Ajax/Punchin.jsp"
						class="btn btn-info btn-lg">Punch in Now</a>
					<%
						}
						}
					%>
					<script type="text/javascript" charset="utf-8">
		$(document).ready(function() {
			
			$("#al2556").load('<%=request.getContextPath()%>/Ajax/getNotifications.jsp?e=list');
			
			$( "p" ).click(function() {
				  $( this ).slideUp();
				});
			
			//Modal Box Close only on button close
			$(".modal").modal({
				  backdrop: 'static',
				  keyboard: false,
				  show : false
				});
			
			$('.dtable').dataTable();
			$('#sample_1').DataTable();
			 /* $('#sample_2').DataTable({
               
				aaSorting : [[0, 'desc']]  
                          
            }); */ 	
			 
			 $(".datepicker").attr("placeholder","click to change");
			$(".datepicker").datepicker({
				dateFormat : "yy-mm-dd",
				minDate : 0,
		        changeMonth: true,
		        changeYear: true
			});
		<%-- 	<%if (punchin) {%>
			$.gritter.add({
					title : 'Attendance',
					sticky : true,
					text : 'Please Punchin to get Paid'
				});
		<%}%> --%>
	<%-- 	<%if (overtime) {%>
		$.gritter.add({
				title : 'Attendance',
				sticky : true,
				text : 'Working Overtime Great.'
			});
	<%}%> --%>
		<%-- <%if (punchout) {%>
		$.gritter.add({
				title : 'Attendance',
				text : 'Please Punchout before today'
			});
	<%}%> --%>
	<%if (request.getParameter("msg") != null) {%>
		$.gritter.add({
				title : 'Message',
				text : '<%=request.getParameter("msg")%>'
					});
					<%}%>
						});
					</script>

				</h3>
			</div>
		</div>
	</div>
</div>