<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";

	String whattoget = request.getParameter("e");

	if (whattoget != null && (!whattoget.isEmpty())) {
		if (whattoget.equals("count")) {
			sql = "SELECT count(*) FROM `notifications` WHERE `userid` = '"
					+ request.getAttribute("userid") + "' AND `read`=0";
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if (batchsess.next())
				out.print(batchsess.getString(1));
		} else if (whattoget.equals("list")) {
			sql = "SELECT * FROM `notifications` WHERE `userid` = '"
					+ request.getAttribute("userid")
					+ "' ORDER BY `id` DESC";
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if (batchsess.next()) {
				batchsess.beforeFirst();
				while (batchsess.next()) {
					if (batchsess.getBoolean("read") == true) {
%>
<a href="#" class="usernoti list-group-item	"
	id="<%=batchsess.getInt(1)%>"><b><%=batchsess.getString(2)%></b><i
	class="icon-remove pull-right r-activity"></i></a>
<%
	} else {
%>
<a href="#" class="usernoti list-group-item active"
	id="<%=batchsess.getInt(1)%>"><b><%=batchsess.getString(2)%></b><i
	class="icon-remove pull-right r-activity"></i></a>
<%
	}
				}
%>
<div id="success" style="display:none"></div>
<script type="text/javascript">
	$(document).ready(function() {

		$(".usernoti").click(function() {
			var toolt = $(this).attr("id");
			$("#success").load("<%=request.getContextPath() %>/Ajax/setNotifications.jsp?id=" + toolt, function( response, status, xhr ) {
				  if(status="success"){
					  $("#"+toolt).toggleClass("active");
				  }
					});
		});
	});
</script>
<%
	} else {
%>
<li><a href="#">NO NOTIFICATIONS FOUND</a></li>
<%
	}
		}
	}
	con.close();
%>