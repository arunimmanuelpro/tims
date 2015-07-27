
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



</section>



			</div>
		</div>
				<script type="text/javascript">
	
		
	
		
			$(document)
					.ready(
							function() {		
								 $('#enqtable').load('enqtable.jsp').fadeIn("slow");
								 setInterval(    function ()
									     {
									          $('#enqtable').load('enqtable.jsp').fadeIn("slow");
									     }, 50000); // refresh every 5000 milliseconds
									     
								$("#courseinterestedin").change(function(){

									if($("#courseinterestedin").val()=="Other"){
										$("#other").show();
									}else{
										$("#other").hide();
									}
								});
								
								
														});
		</script>
	</section>
</section>
<!--main content end-->

<%@include file="../Common/Footer.jsp"%>