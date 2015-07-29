<%@page import="java.sql.ResultSet"%>
<%@page import="general.ActivityLog"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String cn = null,cdate=null,cbank=null,cbranch = null,cardtype = null,cardbank = null;

String amount = request.getParameter("amount");
String paymode = request.getParameter("paymode");
String nextduedate = request.getParameter("nextduedate");
String studentid = request.getParameter("studentid");
int towards = Integer.parseInt(request.getParameter("towards"));
cn= request.getParameter("cno");
cdate  =request.getParameter("cdate");
cbank =request.getParameter("cbank");
cbranch =request.getParameter("cbranch");
cardtype =request.getParameter("ctype");
cardbank  =request.getParameter("cardbank");
if(paymode.equals("CASH")||paymode.equals("CHEQUE")){
	cardtype=null;
}

if(amount==null || paymode==null || nextduedate==null  || studentid==null){
	out.print("33");
}else{
	if(amount.isEmpty() || paymode.isEmpty() || studentid.isEmpty()){
		out.print("22");
	}else{
		//Actual Processing
		
		String userid = request.getAttribute("userid").toString();
		
		SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
		Date cDate = new Date();
		String cDat = sd.format(cDate);
		
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = con.prepareStatement("INSERT INTO `payments`(`studentid`, `amount`, `method`, `date`, `collectedbyid`, `nextdue`,`towards`,`cno`,`cdate`,`cbank`,`cbranch`,`ctype`,`cardbank`) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)");
		ps.setString(1, studentid);
		ps.setString(2, amount);
		ps.setString(3, paymode);
		ps.setString(4, cDat);
		ps.setString(5, userid);
		ps.setString(6, (nextduedate.equalsIgnoreCase("")?null:nextduedate));
		ps.setInt(7, towards);
		ps.setString(8, cn);
		ps.setString(9, cdate);
		ps.setString(10, cbank);
		ps.setString(11, cbranch);
		ps.setString(12, cardtype);
		ps.setString(13, cardbank);
		int res = ps.executeUpdate();
		if(res > 0){
			out.print("1");
			
			Statement sbook1 = con.createStatement();
			String bsql1 = "SELECT * FROM `payments` WHERE `studentid`= '"+studentid+"'";
			ResultSet rsb1 = sbook1.executeQuery(bsql1);
			if(rsb1.next()){
				String sql33 = "UPDATE `students` SET `status`='JOINED' WHERE `id`='"+studentid+"' ";
				sbook1 = con.createStatement();
				sbook1.executeUpdate(sql33);
			}else{
				String sql33 = "UPDATE `students` SET `status`='JOINED' WHERE `id`='"+studentid+"' ";
				sbook1 = con.createStatement();
				sbook1.executeUpdate(sql33);
			}
			
			String user = request.getAttribute("userid").toString();
			ActivityLog.log("New Payment of "+amount+" via "+paymode+" has been received.","PAYMENT",user);
		}else
			out.print("0");
		//Actual End
		con.close();
	}
}


%>