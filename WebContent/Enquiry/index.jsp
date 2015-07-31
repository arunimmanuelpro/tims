
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
						<i class="icon-folder-open"> <%
 	if(request.getParameter("completed")!=null){out.println("Closed Enquires");}
 	else if(request.getParameter("Follow")!=null){out.println("Follow Up");}
 	else if(request.getParameter("Duplicate")!=null){out.println("Duplicate");}
 	
 	else{out.println("All Enquires");}
 %>
						</i>
					</h3>
					<%
						if(userroles.contains("add_enquiry")){
					%>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="newenquiry.jsp">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<%
						}
					%>
				</div>


				<section class="panel" id="enqtable">
					<div class="table-responsive">
						<table class="table table-striped border-top datatable"
							id="sample_2" class="dtable">
							<thead>
								<tr>
									<th width="15%">Id</th>
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
								var oTable = $('#sample_2').DataTable({

									aaSorting : [ [ 0, 'desc' ] ]

								});
								$("#courseinterestedin")
										.change(
												function() {

													if ($("#courseinterestedin")
															.val() == "Other") {
														$("#other").show();
													} else {
														$("#other").hide();
													}
												});
								addElements();
								drawTable();
								setInterval(function() {

									if ($('#sample_2').size() > 0) {
										addElements();
										oTable.fnClearTable();							
									drawTable();
									}
								}, 10000); 
								function addElements() {
									var xmlhttp;

									xmlhttp = new XMLHttpRequest();
									xmlhttp.onreadystatechange = function() {
										if (xmlhttp.readyState == 4
												&& xmlhttp.status == 200) {

											//Parse JSON
											var jsontext = JSON
													.parse(xmlhttp.responseText);
										
											for ( var i = 0; i < jsontext.enq.length; i++) {
												var counter = jsontext.enq[i];
												var loc = "details.jsp?id="+counter.id;
												var aiNew = oTable
														.fnAddData([
																counter.id,
																counter.source,
																counter.name,
																counter.email,
																counter.course,
																counter.status,
																counter.followon,
																counter.done,
																"<a class='btn btn-info btn-xs '	 href="+loc+"><i class='icon-wrench'></i>More...</a>" ]);
												 var nRow = oTable.fnGetNodes(aiNew[0]);
											
												
												
											}
										}

									}
									
									<%if(request.getParameter("completed")!=null){%>
									xmlhttp.open("GET", "enqcompletedtable.jsp", true);
									
									<%}else if(request.getParameter("Follow")!=null){
									%>
									xmlhttp.open("GET", "enqfollowuptable.jsp", true);
									<%
									}else if(request.getParameter("Duplicate")!=null){
										
										%>
										xmlhttp.open("GET", "enqduplicatetable.jsp", true);
										<%}else{%>
									xmlhttp.open("GET", "enqtable.jsp", true);
									<%}%>
									xmlhttp.send();
								}
								function drawTable(){
									 oTable.fnDraw();
									
								}
		
							});
		</script>

	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>