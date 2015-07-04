
<%@page import="security.SecureNew"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	Connection attcon = DbConnection.getConnection();
	Statement atts = attcon.createStatement();
	String empid = request.getAttribute("userid").toString();
	SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat st = new SimpleDateFormat("HH:mm:ss");
	Date cDate = new Date();
	String cDat = sd.format(cDate);
	String cTim = st.format(cDate);
	String msg;
	ResultSet attrs = atts
			.executeQuery("SELECT * FROM attendance WHERE `empid` = '"
					+ empid + "' AND `Date` = '" + cDat + "' LIMIT 1");
	if (attrs.next()) {
		msg = "You Have already Punched in";
	} else {
		//punch in now
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		
		SecureNew sn = new SecureNew();
		
		
		atts = attcon.createStatement();
		String stm = "INSERT INTO `attendance`(`empid`, `Date`, `logintime`, `login_IP`) VALUES ('"+empid+"','"+cDat+"','"+cTim+"','"+ip+"')";
		int resatt = atts.executeUpdate(stm);
		if(resatt > 0){
			msg = "Punched in at "+cTim;
		}else{
			msg = "Punch Error";
		}
	}
	response.sendRedirect(request.getHeader("referer")+"?msg="+msg);
%>