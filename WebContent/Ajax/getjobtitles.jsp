
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	
	Connection con = DbConnection.getConnection();
    PreparedStatement ps = null;
    ResultSet rs = null;
	JSONArray ja = new JSONArray();
	try{
	ps = con.prepareStatement("SELECT id, Title FROM  `jobtitles` WHERE RoleRef =?");
	ps.setInt(1, Integer.parseInt(request.getParameter("level")));
	rs = ps.executeQuery();	
	while(rs.next()){		
		JSONObject jo = new JSONObject();
		jo.put("optionValue", rs.getString(1));
		jo.put("optionDisplay", rs.getString(2));
		ja.put(jo);
	}
	out.println(ja);
	}catch(NumberFormatException e){
		e.printStackTrace();
	}
	rs.close();
	ps.close();
	con.close();
%>