package general;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import access.DbConnection;

public class GetInfoAbout {

	private static String sql;
	private static Statement s;
	private static PreparedStatement ps;
	
	
	public static int[] getDateDifferenceInDDMMYYYY(Date date1, Date date2) {

		int[] monthDay = { 31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };
		Calendar fromDate;
		Calendar toDate;
		int increment = 0;
		int[] ageDiffArr = new int[3];

		int year;
		int month;
		int day;

		Calendar d1 = new GregorianCalendar().getInstance();
		d1.setTime(date1);

		Calendar d2 = new GregorianCalendar().getInstance();
		d2.setTime(date2);

		if (d1.getTime().getTime() > d2.getTime().getTime()) {
			fromDate = d2;
			toDate = d1;
		} else {
			fromDate = d1;
			toDate = d2;
		}

		if (fromDate.get(Calendar.DAY_OF_MONTH) > toDate.get(Calendar.DAY_OF_MONTH)) {
			increment = monthDay[fromDate.get(Calendar.MONTH)];
		}

		GregorianCalendar cal = new GregorianCalendar();
		boolean isLeapYear = cal.isLeapYear(fromDate.get(Calendar.YEAR));

		if (increment == -1) {
			if (isLeapYear) {
				increment = 29;
			} else {
				increment = 28;
			}
		}

		// DAY CALCULATION
		if (increment != 0) {
			day = (toDate.get(Calendar.DAY_OF_MONTH) + increment) - fromDate.get(Calendar.DAY_OF_MONTH);
			increment = 1;
		} else {
			day = toDate.get(Calendar.DAY_OF_MONTH) - fromDate.get(Calendar.DAY_OF_MONTH);
		}

		// MONTH CALCULATION
		if ((fromDate.get(Calendar.MONTH) + increment) > toDate.get(Calendar.MONTH)) {
			month = (toDate.get(Calendar.MONTH) + 12) - (fromDate.get(Calendar.MONTH) + increment);
			increment = 1;
		} else {
			month = (toDate.get(Calendar.MONTH)) - (fromDate.get(Calendar.MONTH) + increment);
			increment = 0;
		}

		// YEAR CALCULATION
		year = toDate.get(Calendar.YEAR) - (fromDate.get(Calendar.YEAR) + increment);

		ageDiffArr[0] = day;
		ageDiffArr[1] = month;
		ageDiffArr[2] = year;

		return ageDiffArr;      // RESULT AS DAY, MONTH AND YEAR in form of Array
	}

	public static String getManagerName(String id)throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT id, FirstName, LastName  from `employee` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(2)+" "+rs.getString(3);
		}
		s.close();
		con.close();
		return "Employee Id Not Found";
	}
	
	public static String checkCurrentDate(String leaveid)throws Exception{
		String status = "5";
		System.out.println("Default Leave Status: "+status);
		Connection con = DbConnection.getConnection();
		String sql = "SELECT status  from `leavemaster` WHERE curdate()<=(select fromdate from `leavemaster` where id='"+leaveid+"') and id='"+leaveid+"'";
		PreparedStatement pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();		
		if(rs.next()){
			status = "4";
		}		
		System.out.println("Leave Status: "+status);
		rs.close();
		pstmt.close();
		con.close();
		return status;
	}
	
	public static int getLeaveBalance(String empid,String leavetype)throws Exception{
		int entitle = 0, useddays = 0, balance = 0;
		Connection con = DbConnection.getConnection();
		String query = "SELECT noofdays,useddays FROM `leaverec` WHERE empid=? and leavetype=?";
		PreparedStatement pstmt = con.prepareStatement(query);
		pstmt.setString(1, empid);
		pstmt.setString(2, leavetype);
		ResultSet rsm = pstmt.executeQuery();		
		if(rsm.next()){
			entitle = Integer.parseInt(rsm.getString(1));
			useddays = Integer.parseInt(rsm.getString(2)!=null?rsm.getString(2):"0");			
			if(entitle>=useddays){
				balance = entitle - useddays;
			}
		}
		rsm.close();
		pstmt.close();	
		con.close();
		return balance;
	}
	
	public static String getleavestatus(String status)throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT status from `leavestatus` WHERE `id`='"+status+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Status is Not Found";
	}
	
	public static String getleavetype(String id)throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT LeaveType from `leavetype` WHERE `typeid`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Leave Type Not Found";
	}
	
	
	public static String getcoursename(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT Name from `coursedetails` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Course Not Found";
	}
	
	public static String gettrainername(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT FirstName,LastName from `employee` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1)+" "+rs.getString(2);
		}
		s.close();
		con.close();
		return "Employee Not Found";
	}
	
	public static String getbasicpay(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT BasicPay from `employee` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return null;
	}
	
	public static String getrolename(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT role_name from `roles` WHERE `role_id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Role Not Found";
	}
	
	public static String getjobtitlename(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT Title from `jobtitles` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Job Not Found";
	}
	
	
	public static String getempstatusname(String id) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT Status from `employmentstatus` WHERE `id`='"+id+"' LIMIT 1";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			return rs.getString(1);
		}
		s.close();
		con.close();
		return "Status Not Found";
	}
	
	public static ResultSet getEmpStatus() throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		sql = "SELECT id, Status from `employmentstatus`";
		ResultSet rs = s.executeQuery(sql);
		s.close();
		con.close();
		return rs;		
	}	
	
	
	public static ArrayList<String> getuserswithrole(String roleid) throws Exception{
		Connection con = DbConnection.getConnection();
		s = con.createStatement();
		ArrayList<String> users = new ArrayList<>();
		sql = "SELECT id from `employee` WHERE `roleid`='"+roleid+"'";
		ResultSet rs = s.executeQuery(sql);
		if(rs.next()){
			rs.beforeFirst();
			while(rs.next()){
				users.add(rs.getString(1));
			}
			return users;
		} 
		s.close();
		con.close();
		return null;		
	}	
	
}