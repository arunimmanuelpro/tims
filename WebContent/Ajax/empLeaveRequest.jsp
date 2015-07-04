<%@page import="constant.InfoConstant"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%	
	Connection con = DbConnection.getConnection();
	PreparedStatement ps = null;
	String status = request.getParameter("status");	
	int suc = 0;
	if(status.equalsIgnoreCase("new")){
		String fdate = request.getParameter("fromdate");
		String tdate = request.getParameter("todate");
		String empId = request.getAttribute("userid").toString();
		String ltypeid = request.getParameter("leavetype");		
		DateFormat dFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = dFormat.parse(fdate);
		Date date2 = dFormat.parse(tdate);
		int[] diff = GetInfoAbout.getDateDifferenceInDDMMYYYY(date1, date2);
		int noofdays = diff[0]+1;		
	  	ps = con.prepareStatement("insert into leavemaster(empid,leavetypeid,fromdate,todate,noofdays,leaveremarks,status,updationdate) values(?,?,?,?,?,?,?,now())");
			ps.setString(1, empId);
			ps.setString(2, request.getParameter("leavetype"));
			ps.setString(3, fdate);
			ps.setString(4, tdate);
			ps.setInt(5, noofdays);
			ps.setString(6, request.getParameter("comments"));
			ps.setInt(7, 3);
		suc = ps.executeUpdate();
		ps.close();
		con.close();
		if(suc>0){
			out.println("1");
		}else{
			out.println("0");
		}	  
	}else if(status.equalsIgnoreCase("mupdate")){	
		String leaveid = request.getParameter("leaveid");	
		String action = request.getParameter("actionid");		
		if(action.equals("0")){
			out.println("0");
		}else {
			if(action.equals("3")){
				action = GetInfoAbout.checkCurrentDate(leaveid);
			}
			ps = con.prepareStatement("update leavemaster set status=?, managerid=?, managerremarks=?, updationdate=now() where id=?");
			ps.setString(1, action);
			ps.setString(2, InfoConstant.loginEmpId);
			ps.setString(3, request.getParameter("mcomments"));
			ps.setString(4, request.getParameter("leaveid"));
			suc = ps.executeUpdate();
			ps.close(); con.close();
			if(suc>0){
				out.println("1");
			}else{
				out.println("0");
			}	  
		}
	}	
%>