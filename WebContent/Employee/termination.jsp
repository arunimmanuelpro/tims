
<%
	request.setAttribute("title", "New Termination");
%>
<%@include file="../Common/Header.jsp"%>
<%
	String emid = request.getParameter("id");
if(emid==null){
	response.sendRedirect("../error.jsp");
	return;
}else if(emid.isEmpty()){
	response.sendRedirect("../error.jsp");
	return;
}else{
	
}
%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">

		<div class="row">
			<div class="col-lg-12">
				<section class="panel">
					<header class="panel-heading"> Employee Termination </header>
					<div class="panel-body">
						<form class="form-horizontal" id="editempdet" role="form"
							data-validate="parsley">
							<div class="form-group">
								<label for="reason">Reason</label> <select id="reason"
									name="reason" class="form-control" data-required="true"
									data-notblank="true">
									<option value="">---select---</option>
									<option value="PERSONAL REASON">Personal Reason</option>
									<option value="CONTRACT END">End of Contract</option>
									<option value="CONTRACT VIOLATION">Violation of	Contract</option>
									<option value="TERMINATED">Terminated</option>
									<option value="OTHER">Other</option>
								</select>
							</div>
							<div class="form-group">
								<label for="date">Date</label> <input type="text"
									class="form-control datepicker" id="date" name="date"
									placeholder="Date" data-required="true" data-type="dateIso"	data-notblank="true" readonly>
							</div>
							<div class="form-group">
								<label for="notes">Notes</label> <input type="text"
									class="form-control" id="notes" name="notes"
									placeholder="Notes" data-required="true" data-notblank="true">
							</div>
							<input type="hidden" name="empid" value="<%=emid%>">
							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<button type="submit" class="btn btn-default">Terminate
									</button>
								</div>
							</div>
						</form>
					</div>
				</section>
			</div>
		</div>


		<script type="text/javascript">
	$(document).ready(function() {
		

		//Contact Details Update Start
		$("#editempdet").submit(function() {

			$('#editempdet').parsley('validate');
			
			if ($('#editempdet').parsley('isValid')) {
				
			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}
			
			
			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newTermination.jsp",
				type : "POST",
				data : str,
				success : function(data, textStatus, jqXHR) {
					if (data == 1) {
						$.gritter.add({
							title : 'Success',
							text : 'Employee Terminated'
						});
						$(location).attr('href','profile.jsp?id=<%=emid%>');
																	} else {
																		$.gritter
																				.add({
																					title : 'Sorry',
																					text : 'Some Error Occured, Please Try Again.'
																							+ data
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
								//End Contact Details Update
							});
		</script>
	</section>
</section>

<%@include file="../Common/Footer.jsp"%>