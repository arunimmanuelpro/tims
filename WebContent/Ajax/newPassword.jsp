<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	String curp = request.getParameter("currpass");
	String newp = request.getParameter("newpass");
	String conp = request.getParameter("confpass");
	Integer empid = (Integer)session.getAttribute("id");
	Connection con=null; PreparedStatement ps=null;
	System.out.println("Password Change: "+"in "+empid+" from "+curp+" to "+conp+" "+newp);
	if(newp==null || conp==null || curp==null){
		out.print("11");
	}else if(newp.isEmpty() || conp.isEmpty() || curp.isEmpty()){
		out.print("22");
	}else{
		if(newp.equalsIgnoreCase(conp)){
			con = DbConnection.getConnection();
			ps = con.prepareStatement("UPDATE `employee` SET `password`=? WHERE `id`="+empid);
			ps.setString(1, conp);
			int res = ps.executeUpdate();
			if(res > 0){
				out.print("1");
			}else
				out.print("0");
		}else{
			response.sendRedirect(request.getContextPath()+"profile.jsp?msg=New password and Confirm password should be same");
		}
		ps.close();
		con.close();
	}

%>