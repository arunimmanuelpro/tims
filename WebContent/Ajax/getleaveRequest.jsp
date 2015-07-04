
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	DateFormat aFormat = new SimpleDateFormat("yyyy-MM-dd");
	DateFormat eFormat = new SimpleDateFormat("dd-MM-yyyy");
	int id = Integer.parseInt(request.getParameter("id"));	
	Connection con = DbConnection.getConnection();
	String csql = "SELECT * FROM `leavemaster` where id="+id+" AND creationdate BETWEEN CONCAT(YEAR(CURDATE( )),'-01-01') AND CONCAT(YEAR(CURDATE( )),'-12-31')";
	PreparedStatement s = con.prepareStatement(csql);
	ResultSet rs = s.executeQuery();	
	JSONObject json = new JSONObject();
	int entitle = 0, useddays = 0, balance = 0;
	if(rs.next()) {		
		System.out.println("Leave Id: "+rs.getString(1));
		String fdate = rs.getString("fromdate"); Date f = aFormat.parse(fdate);
		String tdate = rs.getString("todate"); Date t = aFormat.parse(tdate);		
		String einfo = "";
		String empName = (GetInfoAbout.getManagerName(rs.getString("empid"))==null?"":GetInfoAbout.getManagerName(rs.getString("empid")));
		if(fdate.equals(tdate)){
			einfo = "Mr./Ms. "+empName+"(EO"+rs.getString("empid")+") Request Leave on "+eFormat.format(f);			
		}else {
			String ndate = eFormat.format(f)+" to "+eFormat.format(t);
			einfo = "Mr./Ms. "+empName+"(EO"+rs.getString("empid")+") Request Leave on "+ndate;			
		}	
		json.put("id",rs.getString(1));
		json.put("einfo", einfo);
		json.put("ltype", (GetInfoAbout.getleavetype(rs.getString("leavetypeid"))==null?"":GetInfoAbout.getleavetype(rs.getString("leavetypeid"))));
		json.put("lbalance", GetInfoAbout.getLeaveBalance(rs.getString("empid"), rs.getString("leavetypeid")));		
		json.put("lreqdays", rs.getString("noofdays"));
		json.put("ecomments",rs.getString("leaveremarks"));
	}
	rs.close();
	s.close();
	con.close();
	out.println(json);	
%>