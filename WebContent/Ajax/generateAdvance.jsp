

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	String id = request.getParameter("empid");
	String mall = request.getParameter("maxallow");
	String pamt = request.getParameter("paidamt");
	String pr = request.getParameter("pr");

	SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd");
	Date today = new Date();
	String todayd = s.format(today);
	if (id == null || mall== null || pamt == null) {
		out.print("33");
	} else if (id.isEmpty() || mall.isEmpty() || pamt.isEmpty()) {
		out.print("22");
	} else {
		try{
			int ipamt = Integer.parseInt(pamt);
			Connection con = DbConnection.getConnection();
			PreparedStatement ps = con
					.prepareStatement("UPDATE `advance` SET `empid`=?,`adv_date`=?,`adv_amount`=?,`status`='ISSUED' WHERE `id`=?");
			ps.setString(1, id);
			ps.setString(2, todayd);
			ps.setInt(3, ipamt);
			ps.setString(4, pr);
			int res = ps.executeUpdate();
			if(res>0){
				out.println("1");
			}else{
				out.println("0");
			}
	}catch(Exception e){
		
	}
	}
	
%>