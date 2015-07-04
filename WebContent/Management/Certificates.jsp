
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<div aria-hidden="true" aria-labelledby="Certificates" role="dialog"
	tabindex="-1" id="newcertificate" class="modal fade">

	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button aria-hidden="true" data-dismiss="modal" class="close"
					type="button">×</button>
				<h4 class="modal-title">New Certificate</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-lg-12">
						<form class="form-horizontal" id="newcertificateadd" role="form"
							data-validate="parsley">
							<div class="form-group">
								<label for="name">Name</label> <input type="text"
									class="form-control" id="name" name="name" placeholder="Name"
									data-required="true" data-notblank="true"
									data-rangelength="[4,15]">
							</div>
							<div class="form-group">
								<label for="courseid">Course Id</label> <select id="courseid"
									name="courseid" class="form-control" data-required="true"
									data-notblank="true">
									<option value="">---select----</option>
									<%
										Connection con13 = DbConnection.getConnection();
										Statement s13 = con13.createStatement();
										ResultSet rs13 = s13
												.executeQuery("SELECT * FROM `coursedetails` ORDER BY `id`");
										while (rs13.next()) {
									%>
									<option value="<%=rs13.getString(1)%>"><%=rs13.getString(2)%></option>
									<%
										}
									%>
								</select>
							</div>
							<div class="form-group">
								<div class="col-lg-offset-2 col-lg-10">
									<button type="submit" class="btn btn-default">submit</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function() {

		$("#newcertificateadd").submit(function() {

			$('#newcertificateadd').parsley('validate');

			if ($('#newcertificateadd').parsley('isValid')) {

			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}

			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newCertificate.jsp",
				type : "POST",
				data : str,
				success : function(data, textStatus, jqXHR) {
					if (data == 1) {
						$.gritter.add({
							title : 'Success',
							text : 'All Data Saved'
						});
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
	});
</script>