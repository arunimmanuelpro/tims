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
	String whattoget = request.getParameter("i");	
	if(whattoget!=null && (!whattoget.isEmpty())){
		if(whattoget.equals("batch")){
			sql = "SELECT count(*) FROM `batchsession` WHERE `date` = curdate()";			
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if(batchsess.next())
				out.print(batchsess.getString(1));
			//out.println(500);
			else
				out.print(0);
		}else if(whattoget.equals("present")){
			sql = "SELECT count(*) FROM `attendance` WHERE `Date` = curdate()";
			
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if(batchsess.next())
				out.print(batchsess.getString(1));
			//out.println(400);
			else
				out.print(0);
		}else if(whattoget.equals("enquiry")){
			sql = "SELECT Count(*) FROM `enquiry` WHERE `date` = curdate()";			
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if(batchsess.next())
				out.print(batchsess.getString(1));
				//out.println(300);
			else
				out.print(0);
		}else if(whattoget.equals("batchCnt")){
			sql = "SELECT COUNT(*) FROM batchdetails WHERE enddate >= CURDATE()";			
			s = con.createStatement();
			ResultSet batchsess = s.executeQuery(sql);
			if(batchsess.next())
				out.print(batchsess.getString(1));
			else
				out.print(0);
		}
	}	
	con.close();	
	%>