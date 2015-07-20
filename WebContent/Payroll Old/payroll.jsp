<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.HOUR_OF_DAY, 0);
	cal.set(Calendar.MINUTE, 0);
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);

	String month = new SimpleDateFormat("MMMMMMMMMMMMMMMMMMM")
			.format(cal.getTime());
	String year = new SimpleDateFormat("yyyy").format(cal.getTime());

	Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	String sql = "SELECT `id` FROM `employee` WHERE `TerminationId` IS NULL";
	ResultSet rs = s.executeQuery(sql);
	int count = 0;
	while (rs.next()) {
		
		int empid = rs.getInt(1);
		out.print(empid);
		sql = "SELECT * FROM `payroll_info` WHERE `empid`='" + empid
				+ "' AND `month`='" + month + "'  AND `year`='" + year
				+ "'";
		Statement s1 = con.createStatement();
		ResultSet rs1 = s1.executeQuery(sql);
		if (rs1.next()) {
			
		} else {
			sql = "INSERT INTO `payroll_info`(`empid`,`month`,`year`,`payroll_status`,`payslip_status`,`my`) VALUES('"
					+ empid
					+ "','"
					+ month
					+ "','"
					+ year
					+ "','PENDING','NOT GENERATED', '"+month+year+"')";
			int s11 = s1.executeUpdate(sql);
			if(s11 > 0){
				count++;
			}
		}
	}
	if(count==0){
		response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYROLL ALREADY BEEN GENERATED");
	}else{
		response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYROLL HAS BEEN GENERATED");
	}
%>