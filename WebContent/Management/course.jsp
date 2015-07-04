
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="newCourse" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Course</h4>
			</div>

			<div class="modal-body">
				<form class="form-horizontal" id="newcourseadd"
					data-validate="parsley">
					<div class="form-group">
						<label for="name">Name</label> <label for="topic">Topic</label> <input
							type="text" class="form-control" id="name" name="name"
							data-required="true" data-notblank="true"
							data-rangelength="[4,15]" placeholder="Name">
					</div>
					<div class="form-group">
						<label for="description">Description</label> <input type="text"
							data-required="true" class="form-control" id="description"
							name="description" data-notblank="true" placeholder="Description">
					</div>
					<div class="form-group">
						<label for="duration">Duration</label> <input type="text"
							data-required="true" data-notblank="true" data-type="number"
							data-rangelength="[1,3]" class="form-control" id="duration"
							name="duration" placeholder="Duration">
					</div>
					<div class="form-group">
						<label for="fees">Fees</label> <input type="text"
							data-required="true" data-notblank="true" data-type="number"
							data-rangelenght="[3,8]" class="form-control" id="fees"
							name="fees" placeholder="Fees">
					</div>

					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<input type="submit" class="btn btn-default" value="New">
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
		$("#newcourseadd").submit(function() {

			$('#newcourseadd').parsley('validate');

			if ($('#newcourseadd').parsley('isValid')) {

			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}

			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newCourse.jsp",
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