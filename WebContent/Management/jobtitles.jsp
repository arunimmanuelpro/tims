<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="newJobtitle" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Add New Job Title</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="newjobtitleadd"
					data-validate="parsley" role="form">
					<div class="form-group">
						<label for="title">Title</label> <input type="text"
							class="form-control" id="title" name="title" placeholder="Title"
							data-required="true" data-notblank="true"
							data-rangelength="[4,15]">
					</div>
					<div class="form-group">
						<label for="description">Description</label> <input type="text"
							class="form-control" id="description" name="description"
							placeholder="Description" data-required="true"
							data-notblank="true">
					</div>
					<div class="form-group">
						<label for="payrange">Pay Range</label> <input type="text"
							class="form-control" id="payrange" name="payrange"
							placeholder="Payrange" data-requried="true" data-notblank="true"
							data-rangelength="[3,10]">
					</div>

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<input type="submit" class="btn btn-default" value="Add New Job">
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
		$("#newjobtitleadd").submit(function() {

			$('#newjobtitleadd').parsley('validate');

			if ($('#newjobtitleadd').parsley('isValid')) {

			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}

			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newJobTitle.jsp",
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