<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>    
<%
	String empId = request.getParameter("empid");
	String leavetype = request.getParameter("ltype");
	String noOfLeaves = request.getParameter("leaves");	
	System.out.println("Leave type: "+leavetype+" No.of Leave: "+noOfLeaves);
	if(leavetype==null||noOfLeaves==null||leavetype.isEmpty()||noOfLeaves.isEmpty()){
		out.println("Check Leave Allotment..");
	}else{
		String[] ltype = leavetype.trim().split(" ");
		String[] lcount = noOfLeaves.trim().split(" ");	
		Map<Integer,Integer> leaveMap = new HashMap<Integer,Integer>();
		int typeCnt = ltype.length;
		int leaveCnt = lcount.length;
		int diff=0;
		if(typeCnt>leaveCnt){
			String[] leaveInfo = new String[typeCnt];	
			diff=typeCnt-leaveCnt;
			for(int i=0;i<leaveCnt;i++){
				leaveInfo[i]=lcount[i];
			}
			for(int i=leaveCnt;i<typeCnt;i++){
				leaveInfo[i]="0";					
			}
			for(int i=0;i<typeCnt;i++){
				leaveMap.put(Integer.parseInt(ltype[i]), Integer.parseInt(leaveInfo[i]));
			}
		}else{
			for(int i=0;i<ltype.length;i++){			
				leaveMap.put(Integer.parseInt(ltype[i]), Integer.parseInt(lcount[i]));			
			}	
		}		 
		System.out.println(typeCnt+" "+leaveCnt);
		System.out.println(leaveMap);
		boolean flag=false;
		Connection con = DbConnection.getConnection();
		PreparedStatement ps = null;
		PreparedStatement pst = con.prepareStatement("select * from leaverec where empid=?");
		pst.setInt(1, Integer.parseInt(empId));
		ResultSet rs = pst.executeQuery();
		if(rs.next()){
			flag=true;			
		}else{
	 		ps = con.prepareStatement("insert into leaverec(empid,leavetype,noofdays) values(?,?,?)");
	 		for (Map.Entry<Integer, Integer> e : leaveMap.entrySet()) {
	 			ps.setString(1, empId);
		 		ps.setInt(2, e.getKey().intValue());
		 		ps.setInt(3, e.getValue().intValue());
		 		ps.executeUpdate(); 	 		
	 		}	 		
		}
		if(flag){
			ps = con.prepareStatement("update leaverec set noofdays=? where empid=? and leavetype=?");
	 		for (Map.Entry<Integer, Integer> e : leaveMap.entrySet()) {	 			
		 		ps.setInt(1, e.getValue().intValue());	
		 		ps.setString(2, empId);
		 		ps.setInt(3, e.getKey().intValue());
		 		ps.executeUpdate(); 	 		
	 		}
		}
		ps.close();
		pst.close();
		con.close();
		out.println("Updated Successfully");		
	}
%>