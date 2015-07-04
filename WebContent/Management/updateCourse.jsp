

<%@page import="security.SecureNew"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	Connection con1 = DbConnection.getConnection();

	Statement s = con1.createStatement();
	String sql = "SELECT * FROM `employee` where `id` = '"
	+ request.getAttribute("userid") + "' LIMIT 1";
	ResultSet rs1 = s.executeQuery(sql);
	rs1.next();
	SecureNew sn = new SecureNew();

	//Get Proof Details
	sql = "SELECT * FROM `proof` WHERE `empid` = '"
	+ request.getAttribute("userid") + "' order by id";
	s = con1.createStatement();
	ResultSet proofdetails = s.executeQuery(sql);

	//Get Bank Details
	sql = "SELECT * FROM `bankdetails` WHERE `empid` = '"
	+ request.getAttribute("userid") + "' order by id";
	s = con1.createStatement();
	ResultSet bankdetails = s.executeQuery(sql);
%>

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