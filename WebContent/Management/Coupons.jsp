
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="Couponsm" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">New Coupon</h4>
			</div>
			<div class="modal-body">

				<form class="form-horizontal" id="newcouponadd"
					data-validate="parsley">
					<div class="form-group">
						<label for="name">Name</label> <input type="text"
							class="form-control" id="name" name="name" placeholder="Name"
							data-required="true" data-notblank="true" data-length="[4,15]">
					</div>
					<div class="form-group">
						<label for="value">Value</label> <input type="text"
							class="form-control" id="value" name="value" placeholder="Value"
							data-required="true" data-notblank="true" data-type="number">
					</div>
					<div class="form-group">
						<label for="stardate">Start Date</label> <input type="text"
							class="form-control datepicker" id="startdate" name="startdate"
							placeholder="Start Date" data-required="true" readonly>
					</div>
					<div class="form-group">
						<label for="enddate">End Date</label> <input type="text"
							class="form-control datepicker" id="enddate" name="enddate"
							placeholder="enddate" data-required="true" readonly>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<input type="submit" class="btn btn-info" value="Add One">
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
		$("#newcouponadd").submit(function() {

			$('#newcouponadd').parsley('validate');

			if ($('#newcouponadd').parsley('isValid')) {

			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}

			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newCoupon.jsp",
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