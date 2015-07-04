<%@page import="org.json.JSONArray"%>
<%@page import="security.SecureNew"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String id = request.getParameter("id");
	if(id==null || id.isEmpty()){}
	else{
		String empid [] = id.split(",");
		Connection con = DbConnection.getConnection();
		String temp  ="";
		for(int i=1;i<empid.length;i++){
			temp+=",?";
		}
		PreparedStatement ps=  con.prepareStatement("select WorkEmail from employee where id in (?"+temp+")");
		for(int i=1;i<=empid.length;i++){
			ps.setInt(i, Integer.parseInt(empid[i-1]));
		}
		ResultSet rs = ps.executeQuery();
		JSONArray ja = new JSONArray();
		while(rs.next()){
			JSONObject jo = new JSONObject();
			jo.put("email", new SecureNew().decrypt(rs.getString(1)));	
			ja.put(jo);
		}
		con.close();
		out.println(ja);
	}
%>