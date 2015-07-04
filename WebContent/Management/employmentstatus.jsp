
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="Employmentstatus" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Add New Employment Status</h4>
			</div>



			<div class="modal-body">
				<form class="form-horizontal" id="newestatusadd" role="form"
					data-validate="parsley">
					<div class="form-group">
						<label for="status">Status</label> <input type="text"
							class="form-control" id="status" name="status"
							placeholder="Status" data-required="true" data-notblank="true"
							data-rangelength="[4,25]">
					</div>

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button type="submit" class="btn btn-default">Create</button>
						</div>
					</div>
				</form>

			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {
		

		//Contact Details Update Start
		$("#newestatusadd").submit(function() {

			$('#newestatusadd').parsley('validate');
			
			if ($('#newestatusadd').parsley('isValid')) {
				
			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}
			
			
			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newEStatus.jsp",
				type : "POST",
				data : str,
				success : function(data, textStatus, jqXHR) {
					if (data == 1) {
						$.gritter.add({
							title : 'Success',
							text : 'All Data Saved'
						});
						window.location.reload();
					} else {
						$.gritter.add({
							title : 'Sorry',
							text : 'Some Error Occured, Please Try Again.'
						});
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert("Sorry, Error.");
					$.gritter.add({
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