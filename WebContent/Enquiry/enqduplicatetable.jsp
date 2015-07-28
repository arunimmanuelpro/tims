<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>

<%
JSONArray ja = new JSONArray();
Connection con  = DbConnection.getConnection();
String sql = "SELECT * FROM enquiry WHERE `status` LIKE 'DUPLICATE'  order by id";
PreparedStatement ps = con.prepareStatement(sql);
ResultSet rs = ps.executeQuery();
while (rs.next()) {
	JSONObject jo = new JSONObject();
	
	int id = rs.getInt("id");

	Connection con3 = DbConnection.getConnection();
	Statement st;
	String sqlq;
	ResultSet rss;
	st = con3.createStatement();

	SimpleDateFormat ddmm = new SimpleDateFormat("dd/MM/yyyy");
	Date today = new Date();
	String todayd = ddmm.format(today);

	HttpSession ses3 = request.getSession();
	 String ses_user_id = ses3.getAttribute("id").toString();
	
	sqlq = "SELECT * FROM enquiry_data where `enquiry_id` = '" + id
			+ "' ORDER BY id DESC LIMIT 1";
	rss = st.executeQuery(sqlq);
	String emp_id = "",followon="";
	if (rss.next()) {
	 	emp_id = rss.getString("donebyempid");
	 	followon = rss.getString("followon");
					}



	jo.put("id", rs.getInt("id"));
	jo.put("source",rs.getString("source"));

	jo.put("name",rs.getString("name"));
jo.put("email",rs.getString("email"));
jo.put("course",rs.getString("courseinterested"));
jo.put("status",rs.getString("status"));
jo.put("followon",followon);
if(emp_id==null)
	jo.put("done","NO");
else
	jo.put("done","YES");

ja.put(jo);

}
JSONObject jo = new JSONObject();
jo.put("enq", ja);
out.println(jo);
con.close();
%>