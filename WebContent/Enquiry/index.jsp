
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "All Enquiries");
%>
<%@include file="../Common/Header.jsp"%>
<%
		if(userroles.contains("view_enquiry") || userroles.contains("add_enquiry")){			
		}else{
			response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
			return;
		}
%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="icon-folder-open"><%if(request.getParameter("completed")!=null){out.println("Closed Enquires");}else{out.println("All Enquires");} %> </i>
					</h3>
					<% if(userroles.contains("add_enquiry")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="newenquiry.jsp" >
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%} %>
				</div>


<section class="panel" id = "enqtable">
<div class="table-responsive">
						<table class="table table-striped border-top datatable" id="sample_2"
							class="dtable">
							<thead>
								<tr>
									<th width = "15%">Id</th>
									<th width="15%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Email</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>
									<th width="10%">Follow on</th>
									<th width="10%">Done</th>
									<th width="10%">Work</th>
								</tr>
							</thead>
							<tbody>
													</tbody>
						</table>
					</div>
			


</section>



			</div>
		</div>
				<script type="text/javascript">
	
		
	
		
			$(document)
					.ready(
							function() {		
						
					
						
						 callAjax();
								 setInterval(    function (){
									
									 callAjax(); 
									 }, 5000); // refresh every 5000 milliseconds
							     
								$("#courseinterestedin").change(function(){

									if($("#courseinterestedin").val()=="Other"){
										$("#other").show();
									}else{
										$("#other").hide();
									}
								});
								
								
														});
			
			
			function callAjax(){
				var xmlhttp;
			//	var  table = $("#sample_2").dataTable();
				xmlhttp = new XMLHttpRequest();
				xmlhttp.onreadystatechange=function()
				  {
				  if (xmlhttp.readyState==4 && xmlhttp.status==200)
				    {
						//Remove Rows from Table
					  var x = document.getElementById("sample_2").rows.length;
							
							x=x-1;
							
						for(var i = x;i>=1;i-- ){
						   document.getElementById("sample_2").deleteRow(i);
						}
						
						//Parse JSON
					var jsontext  = JSON.parse(xmlhttp.responseText);
						//console.log(jsontext.enq.length);
						for (var i = 0; i < jsontext.enq.length; i++) {
							 var counter = jsontext.enq[i];
							
							var table = document.getElementById("sample_2");
							var row = table.insertRow(1);
							var cell1 = row.insertCell(0);
							var cell2 = row.insertCell(1);
							var cell3 = row.insertCell(2);
							var cell4 = row.insertCell(3);
							var cell5 = row.insertCell(4);
							var cell6 = row.insertCell(5);
							var cell7 = row.insertCell(6);
							var cell8 = row.insertCell(7);
							var cell9 = row.insertCell(8);
							cell1.innerHTML = counter.id;
							cell2.innerHTML = counter.source;
							cell3.innerHTML = counter.name;
							cell4.innerHTML = counter.email;
							cell5.innerHTML = counter.course;
							cell6.innerHTML = counter.status;
							cell7.innerHTML = counter.followon;
							cell8.innerHTML = counter.done;
							var loc = "details.jsp?id="+counter.id;
							
							cell9.innerHTML = "<a class='btn btn-info btn-xs'	 href="+loc+"><i class='icon-wrench'></i>More...</a>";
					
							
						}
						
						
					/* 	$("#sample_2").fnDestroy();
						 table = $("#sample_2").DataTable();
						 
						  */
				    }
				  }
				xmlhttp.open("GET","enqtable.jsp",true);
				xmlhttp.send();
			
			/* 	$('#sample_2').DataTable({
		               
					aaSorting : [[0, 'desc']]  
	                          
	            }); */
	         /*  var oTable; 
	            if ($('#sample_2').size() > 0)
	                {
	            	console.log($('#sample_2').size());
	                   oTable = $('#sample_2').dataTable({
	                        "sPaginationType": "bootstrap"   //storing the instance of the dataTable for futher use in the future
	                    });
	                   if (oTable != undefined) {
	                	   console.log("Undefined");
	                        oTable.fnClearTable();
	                   }         
	           
	                }*/
		
			}
		</script>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>