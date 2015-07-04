<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String name = request.getParameter("roleName");
if(request.getParameterValues("permissons")!=null || name!=null){
	String[] permissons = request.getParameterValues("permissons");
	
	
	if(name.isEmpty()){
		out.print("Invalid Values");
		response.sendRedirect("AccessRoles.jsp?error=true");
	}else{
		
		//Actual Processing
				Connection con = DbConnection.getConnection();
				PreparedStatement ps = con.prepareStatement("INSERT INTO `roles`(`role_name`) VALUES (?)",Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, name);
				int res = ps.executeUpdate();
				long iid = 0;
				if(res > 0){
					out.print("1");
					ResultSet rs = ps.getGeneratedKeys();
					if (rs.next() ) {
	                    // The generated id
	                    iid = rs.getLong(1);
	                    // ok 1
	                    for ( int i=0; i < permissons.length; i++ ) {
	                        PreparedStatement s1 = con.prepareStatement("INSERT INTO `role_perm`(`role_id`, `perm_id`) VALUES (?,?)");

	                        s1.setLong(1, iid);
	                        s1.setString(2, permissons[i]);
	                        int res2 = s1.executeUpdate();
	                        if(res2 > 0){
								//ok all
	                        }else{
	                            // error
	                        }
	                
	                    }
	                }
					
					
				}else{
					out.print("0");
					response.sendRedirect("AccessRoles.jsp?error=true");
				}
				//Actual End
		response.sendRedirect("AccessRoles.jsp");
	}
}else{
	out.print("Invalid Access");
}
%>