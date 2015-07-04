
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
	String msg;
	String cDat = sd.format(cDate);
	String cTim = st.format(cDate);
	ResultSet attrs = atts
			.executeQuery("SELECT * FROM attendance WHERE `empid` = '"
					+ empid + "' AND `Date` = '" + cDat
					+ "' AND `logintime` != '' LIMIT 1");

	if (!attrs.next()) {
		out.println("You Have not punched in");
		msg = "already punched in";
	} else {
		if (attrs.getString("logouttime") != null) {
			out.println("You Have already punched out");
			msg = "already punched out";
		} else {
			//punch in now
			String ip = request.getHeader("x-forwarded-for");
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			
			String logintime = attrs.getString("logintime");
			
			SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss");
			 
			Date d1 = null;
			Date d2 = null;
			
			long diffMinutes = 0;
			
			try {
				d1 = format.parse(logintime);
				d2 = format.parse(cTim);
	 
				//in milliseconds
				long diff = d2.getTime() - d1.getTime();
	 			long diffSeconds = diff / 1000 % 60;
				diffMinutes = diff / (60 * 1000) % 60;
				long diffHours = diff / (60 * 60 * 1000) % 24;
				long diffDays = diff / (24 * 60 * 60 * 1000);
	 
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			SecureNew sn = new SecureNew();
			
			
			atts = attcon.createStatement();
			String stm = "UPDATE `attendance` SET `TotalMinutes` = '"+sn.encrypt(Long.toString(diffMinutes))+"',`logouttime`='"
					+ cTim + "',`logout_IP`='" + ip
					+ "' WHERE `Date` = '" + cDat + "' AND `empid` = '"
					+ empid + "' LIMIT 1";
			int resatt = atts.executeUpdate(stm);
			if (resatt > 0) {
				out.print("Punched out at " + cTim);
				msg = "punched out at "+cTim;
			} else {
				out.print("Punch Error");
				msg = "punch error";
			}
		}
	}
	response.sendRedirect(request.getHeader("referer")+"?msg="+msg);
%>