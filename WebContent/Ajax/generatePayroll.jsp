

<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	String id = request.getParameter("empid");
	String pday = request.getParameter("PresentD");
	String tday = request.getParameter("totaldaysthism");
	String ltaken = request.getParameter("Leavetaken");
	String aleave = request.getParameter("Approvedleave");
	String cleave = request.getParameter("Compensatoryleave");
	String pr = request.getParameter("pr");

	if (id == null || pday == null || tday == null || ltaken == null
			|| aleave == null || cleave == null) {
		out.print("33");
	} else if (id.isEmpty() || pday.isEmpty() || tday.isEmpty()
			|| ltaken.isEmpty() || aleave.isEmpty() || cleave.isEmpty()) {
		out.print("22");
	} else {
		try {
			int ipday = Integer.parseInt(pday);
			int itday = Integer.parseInt(tday);
			int iltaken = Integer.parseInt(ltaken);
			int ialeave = Integer.parseInt(aleave);
			int icleave = Integer.parseInt(cleave);

			int nwdays = (ialeave + icleave + ipday);
			
			float bpay = Integer.parseInt(GetInfoAbout.getbasicpay(id));
			
			float pay_break = bpay/itday;
			
			float calc_ctc = pay_break*nwdays;

			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con
					.prepareStatement("UPDATE `payroll_info` SET `total_working`=?,`total_leave`=?,`appr_leave`=?,`comp_leave`=?,`net_wdays`=?,`payroll_status`='COMPLETED',`calc_ctc`=? WHERE `id`=?");
			ps.setInt(1, itday);
			ps.setInt(2, iltaken);
			ps.setInt(3, ialeave);
			ps.setInt(4, icleave);
			ps.setInt(5, nwdays);
			ps.setFloat(6, calc_ctc);
			ps.setString(7, pr);
			int res = ps.executeUpdate();
			if(res>0){
				out.println("1");
			}else{
				out.println("0");
			}
		} catch (Exception e) {

		}

	}
%>