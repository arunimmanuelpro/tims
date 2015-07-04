<%@page import="java.sql.PreparedStatement"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
	int adv_id = 0;
	int adv_amt = 0;
	int count = 0;
	String id = request.getParameter("id");
	String eid = request.getParameter("eid");
	String sql = "";
	
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.HOUR_OF_DAY, 0);
	cal.set(Calendar.MINUTE, 0);   
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);
	
	String month = new SimpleDateFormat("MMMMMMMMMMMMMMMMMMM").format(cal.getTime());
	String year = new SimpleDateFormat("yyyy").format(cal.getTime());

	PreparedStatement ps;
	Connection con = DbConnection.getConnection();
	Statement s = con.createStatement();
	sql = "SELECT * FROM `payroll_info` WHERE `empid`='"+eid+"' LIMIT 1";
	ResultSet rs = s.executeQuery(sql);
	if (rs.next()) {
		if (rs.getString("payroll_status").equalsIgnoreCase("COMPLETED")
				&& rs.getString("my").equals(month + year)
				&& eid!= null && rs.getString("payslip_status").equalsIgnoreCase("NOT GENERATED")) {
			float ctc = Float.parseFloat(rs.getString("calc_ctc"));
			float bpay = ctc * 0.5f;
			float hra = bpay * 0.5f;
			float acca = hra * 0.4f;
			float cca = acca * 0.5f;
			float conv = cca * 0.5f;
			float lta = acca * 0.5f;
			float chedu = lta * 0.5f;
			float gross = bpay + hra + acca + cca + conv + lta + chedu;
			float pf;
			if (gross >= 13000) {
				pf = 780;
			} else {
				pf = 0;
			}
			float ptax;
			float b_pay = Float.parseFloat(GetInfoAbout.getbasicpay(rs
					.getString("empid")));
			if (b_pay > 1999 && b_pay <= 2999) {
				ptax = 17;
			} else if (b_pay > 2999 && b_pay <= 3999) {
				ptax = 39;
			} else if (b_pay > 3999 && b_pay <= 5499) {
				ptax = 85;
			} else if (b_pay > 5499 && b_pay <= 6499) {
				ptax = 127;
			} else if (b_pay > 6499) {
				ptax = 183;
			} else {
				ptax = 0;
			}
			s = con.createStatement();
			sql = "SELECT * FROM `advance` WHERE `my`='" + month + year	+ "' and empid='"+eid+"'";
			ResultSet rs1 = s.executeQuery(sql);
			if (rs1.next()) {
				if (rs1.getString("empid")!=null
						&& rs1.getString("my").equals(month + year) && rs1.getString("status").equalsIgnoreCase("ISSUED")) {
					adv_id = Integer.parseInt(rs1.getString("id"));
					adv_amt = Integer.parseInt(rs1.getString("adv_amount"));
				}else{					
					adv_amt = 0;
				}
			}
			
			float tds;
			if(b_pay>=35000){
				tds = 405;
			}else{
				tds = 0;
			}
			try{
				if(rs.getString("payroll_status").equalsIgnoreCase("COMPLETED") && rs.getString("payslip_status").equalsIgnoreCase("NOT GENERATED")){
				int ictc = (int)ctc;
				int ibpay = (int)bpay;
				int ihra = (int)hra;
				int iacca = (int)acca;
				int icca = (int)cca;
				int iconv = (int)conv;
				int ilta = (int)lta;
				int ichedu = (int)chedu;
				int igross = (int)gross;
				int ipf = (int)pf;
				int iptax = (int)ptax;
				int esi = 0;
				int itds = (int)tds;
				int ded = ipf+iptax+adv_amt+itds+esi;
				int netpay = igross - ded;
				
				ps = con.prepareStatement("INSERT INTO `pay_slip`(`empid`,`my`,`basicpay`,`hra`,`a_cca`,`cca`,`conv`,`lta`,`ch_edu`,`gross`,`pf`,`esi`,`p_tax`,`adv_id`,`adv_amt`,`tds`,`deduction`,`netpay`) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps.setString(1, rs.getString("empid"));
				ps.setString(2, rs.getString("my"));
				ps.setInt(3, ibpay);
				ps.setInt(4, ihra);
				ps.setInt(5, iacca);
				ps.setInt(6, icca);
				ps.setInt(7, iconv);
				ps.setInt(8, ilta);
				ps.setInt(9, ichedu);
				ps.setInt(10, igross);
				ps.setInt(11, ipf);
				ps.setInt(12, esi);
				ps.setInt(13, iptax);
				ps.setInt(14, adv_id);
				ps.setInt(15, adv_amt);
				ps.setInt(16, itds);
				ps.setInt(17, ded);
				ps.setInt(18, netpay);
				int res = ps.executeUpdate();
				if(res>0){
					response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYSLIP HAS BEEN GENERATED");
				}else{
					response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYROLL HAS NOT BEEN GENERATED");
				}
				}
				
				ps = con.prepareStatement("UPDATE `payroll_info` SET `payslip_status`='GENERATED' WHERE `id`=?");
				ps.setString(1, id);
				int ress = ps.executeUpdate();
				if(ress>0){
					response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYSLIP HAS BEEN GENERATED");
				}else{
					response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=PAYSLIP HAS NOT BEEN GENERATED");
				}
				
			}catch(Exception e){
				
			}
		}
	} else {
		response.sendRedirect(request.getContextPath()+"/Payroll/index.jsp?msg=INFORMATION INVALID");
	}
%>