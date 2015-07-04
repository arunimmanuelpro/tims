<%@page import="general.ActivityLog"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String category = request.getParameter("Category");
String categorydesc = request.getParameter("CategoryDesc");

if(category==null){
	out.println("33");
}else{
	if(category.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
						
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("insert into tscategory(CategoryName,Description,CreationDate,LastUpdation_Date) values(?,?,curdate(),curdate())");
		ps.setString(1, category);
		ps.setString(2, categorydesc);
		int res = ps.executeUpdate();
		
		if(res > 0){
			out.print("1");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Category "+category+" was Added to Store","NEW",user);
		}else
			out.print("0");
		//Actual End
	}
}
    
    
    
    
%>