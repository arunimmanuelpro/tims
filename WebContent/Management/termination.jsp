
<%
	request.setAttribute("title", "New Termination");
%>
<%@include file="../Common/Header.jsp"%>

<!--main content start-->
<section id="main-content">
	<section class="wrapper">

		<section class="panel">

			<div class="panel-body">


				<a href="#Termination" data-toggle="modal"
					class="btn btn-xs btn-success"></a>


				<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
					tabindex="-1" id="Termination" class="modal fade">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button data-dismiss="modal" class="close" type="button">×</button>
								<h4 class="modal-title">Add New Termination</h4>
							</div>



							<div class="modal-body">
								<form class="form-horizontal" role="form"
									data-validate="parsley">
									<div class="form-group">
										<label for="reason">Reason</label> <select id="reason"
											name="reason" class="form-control" data-required="true"
											data-notblank="true">
											<option value="">---select---</option>
										</select>
									</div>
									<div class="form-group">
										<label for="date">Date</label> <input type="text"
											class="form-control datepicker" id="date" name="date"
											placeholder="Date" data-required="true" data-type="dateIso"
											data-notblank="true" readonly>
									</div>
									<div class="form-group">
										<label for="notes">Notes</label> <input type="text"
											class="form-control" id="notes" name="notes"
											placeholder="Notes" data-required="true" data-notblank="true">
									</div>

									<div class="form-group">
										<div class="col-lg-offset-2 col-lg-10">
											<button type="submit" class="btn btn-default">Create
											</button>
										</div>
									</div>
								</form>

							</div>

						</div>
					</div>
				</div>
			</div>
		</section>
	</section>
</section>
<%@include file="../Common/Footer.jsp"%>