
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	int id = Integer.parseInt(request.getParameter("id"));
	Connection con1 = DbConnection.getConnection();
	Statement s = con1.createStatement();
	s = con1.createStatement();
	String csql = "SELECT * FROM `leavetype` where typeid="+id;
	ResultSet rs2 = s.executeQuery(csql);
	//JSONArray jsonarray = new JSONArray();
	JSONObject json = new JSONObject();
	while (rs2.next()) {		
		json.put("id", rs2.getString(1));
		json.put("type", rs2.getString(2));
		json.put("min", rs2.getString(3));
		json.put("max", rs2.getString(4));
		//jsonarray.put(json);
	}
	out.println(json);
	con1.close();
%>