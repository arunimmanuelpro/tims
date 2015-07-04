
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
	tabindex="-1" id="Booksm" class="modal fade">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button data-dismiss="modal" class="close" type="button">×</button>
				<h4 class="modal-title">Books</h4>
			</div>


			<div class="modal-body">

				<form class="form-horizontal" id="newbookadd" role="form"
					data-validate="parsley">
					<div class="form-group">
						<label for="name">Name</label> <input type="text"
							class="form-control" id="name" name="name" placeholder="Name"
							data-required="true" data-notblank="true"
							data-rangelength="[4,15]">
					</div>
					<div class="form-group">
						<label for="publisher">Publisher</label> <input type="text"
							class="form-control" id="publisher" name="publisher"
							placeholder="Publisher" data-required="true" data-notblank="true">
					</div>
					<div class="form-group">
						<label for="courseid">Course ID</label> <select id="courseid"
							name="courseid" class="form-control" data-required="true"
							data-notblank="true" >
							<option value="">---select---</option>
							<%
								Connection con12 = DbConnection.getConnection();
								Statement s12 = con12.createStatement();
								ResultSet rs12 = s12
										.executeQuery("SELECT * FROM `coursedetails` ORDER BY `id`");
								while (rs12.next()) {
							%>
							<option
								value="<%=(rs12.getString(1)==null?"":rs12.getString(1))%>"><%=(rs12.getString(2)==null?"":rs12.getString(2))%></option>
							<%
								}
							%>
						</select>
					</div>
					<div class="form-group">
						<div class="col-lg-offset-2 col-lg-10">
							<button type="submit" class="btn btn-default">Submit</button>
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
		$("#newbookadd").submit(function() {

			$('#newbookadd').parsley('validate');

			if ($('#newbookadd').parsley('isValid')) {

			} else {
				$.gritter.add({
					title : 'Fill Fields',
					text : 'Oops Please Fill All Fields'
				});
				return false;
			}

			var str = $(this).serialize();

			$.ajax({
				url : "../Ajax/newBook.jsp",
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