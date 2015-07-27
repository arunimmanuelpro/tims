<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%String mobile = request.getParameter("mobile");
String email = request.getParameter("email");
Connection con = DbConnection.getConnection();
PreparedStatement ps=null; 
if(mobile!=null){

ps= con.prepareStatement("select * from enquiry where mobile LIKE 	?");
ps.setString(1, mobile);
}
else if(email!=null){

	ps= con.prepareStatement("select * from enquiry where email LIKE ?");
ps.setString(1, email);
}

if(ps!=null){
ResultSet rs = ps.executeQuery();
JSONArray ja = new JSONArray();
if(rs.next()){
JSONObject jo = new JSONObject();
jo.put("stype",rs.getString("stype"));
jo.put("enqs",rs.getString("source"));
jo.put("name",rs.getString("name"));
jo.put("email",rs.getString("email"));
jo.put("qualification",rs.getString("qualification"));
jo.put("stream",rs.getString("stream"));
jo.put("currentlyin",rs.getString("currentlyin"));
jo.put("homephone",rs.getString("homephone"));
jo.put("courseinterested",rs.getString("courseinterested"));
jo.put("address",rs.getString("address"));
jo.put("telecaller",rs.getString("telecaller"));
jo.put("counsiller",rs.getString("counsiller"));
jo.put("mobile",rs.getString("mobile"));
ja.put(jo);

}

JSONObject jo = new JSONObject();
jo.put("enq", ja);
out.println(jo);


}
con.close();
%>