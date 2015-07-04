<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
HttpSession ses = request.getSession();

boolean allow = true;

//Check if allowed
String isitallowed = (String) ses.getAttribute("ope_allow");
if(ses.getAttribute("ope_allow")==null || !isitallowed.equalsIgnoreCase("true")){
	out.println("Access Denied");
	allow = false;
}else{
	allow = true;
	ses.removeAttribute("ope_allow");
}

if(request.getParameter("sid")==null || request.getParameter("operation")==null || !allow){
	out.println("<br>Invalid Operation / Access Denied");
}else{
	
	int sid = Integer.parseInt(request.getParameter("sid"));
	int bid = Integer.parseInt(request.getParameter("bid"));
	String ope = request.getParameter("operation");
	
	SimpleDateFormat ddmm = new SimpleDateFormat("HH:mm:ss");
	Date today = new Date();
	String todayd = ddmm.format(today);
	
	Connection con3 = DbConnection.getConnection();
	Statement st;
	String sqlq;
	ResultSet rs;
	st = con3.createStatement();
	
	if(ope.equalsIgnoreCase("START")){
		sqlq="UPDATE  `batchsession` SET  `starttime` =  '"+todayd+"', `status` = 'STARTED',`trainerid` = '"+request.getAttribute("userid")+"' WHERE  `id` = '"+sid+"' ";
		int res = st.executeUpdate(sqlq);
		if(res > 0){
			out.print("START success");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Session "+sid+" for Batch "+bid+" was started" ,"INFO",user);
			sqlq="UPDATE  `batchdetails` SET  `status` = 'RUNNING' WHERE  `id` = '"+bid+"' ";
			res = st.executeUpdate(sqlq);
			response.sendRedirect("details.jsp?id="+bid);
			return;
		}
	}else if(ope.equalsIgnoreCase("END")){
		String topics = request.getParameter("topics");
		if(request.getParameterValues("sids")!=null){
			String[] stu = request.getParameterValues("sids");
			
			//out.println(stu.length);
			for ( int i=0; i < stu.length; i++ ) {
				sqlq = "INSERT INTO `session_attendance`(`sessionid`, `studentid`) VALUES ('"+sid+"','"+stu[i]+"')";
				st.executeUpdate(sqlq);
			}
			sqlq="UPDATE  `batchsession` SET  `topic` = '"+topics+"' , `endtime` =  '"+todayd+"' , `status` = 'COMPLETED',`trainerid` = '"+request.getAttribute("userid")+"' WHERE  `id` = '"+sid+"' ";
		}else{
			sqlq="UPDATE  `batchsession` SET  `topic` = '"+topics+"' ,`endtime` =  '"+todayd+"' , `status` = 'COMPLETED',`trainerid` = '"+request.getAttribute("userid")+"' WHERE  `id` = '"+sid+"' ";
		}
		int res = st.executeUpdate(sqlq);
		if(res > 0){
			out.print("END success");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Session "+sid+" for Batch "+bid+" was Ended" ,"INFO",user);
			sqlq="UPDATE  `batchdetails` SET  `status` = 'STARTED' WHERE  `id` = '"+bid+"' ";
			res = st.executeUpdate(sqlq);
			response.sendRedirect("details.jsp?id="+bid);
			return;
		}
	}else if(ope.equalsIgnoreCase("CANCEL")){
		sqlq="UPDATE  `batchsession` SET  `status` =  'CANCELLED', `endtime` =  '00:00:00', `starttime` =  '00:00:00',`trainerid` = '"+request.getAttribute("userid")+"' WHERE  `id` = '"+sid+"' ";
		int res = st.executeUpdate(sqlq);
		if(res > 0){
			out.print("CANCEL success");
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("Session for Batch "+bid+" was cancelled" ,"INFO",user);
			response.sendRedirect("details.jsp?id="+bid);
			return;
		}
	}

}
%>