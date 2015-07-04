<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@page import="java.io.OutputStream"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="java.sql.Blob"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
	ResultSet rows = null;
	//ServletOutputStream out1 = response.getOutputStream();  
	try {
		Connection conn = DbConnection.getConnection();
		PreparedStatement preparedStatement = null;

		String select = "Select picture from `employee` where id = ? limit 1";
		preparedStatement = conn.prepareStatement(select); // create a statement 
		String idd;
		//Get userid from Parameter
		String pid = request.getParameter("empid");
		if(pid==null || pid.isEmpty()){
			//No Specified Parameter
			//Current Loggedin user id
			idd = request.getAttribute("userid").toString();
		}else{
			//Get id from parameter
			//Set parameter id to sql id
			idd = pid;
		}
		
		//Get Current Logged in userid
		
		
		preparedStatement.setString(1, idd);
		rows = preparedStatement.executeQuery();
		if (rows.next()) {
			Blob blob = rows.getBlob("picture");
			response.setContentType("image/jpeg");
			byte[] image = blob.getBytes(1, (int) blob.length());
			OutputStream outputStream = response.getOutputStream();
			outputStream.write(image);
		} else {
			File f = new File(application.getRealPath("img/temp.png"));
			FileInputStream fis = new FileInputStream(f);
			byte[] imgData = new byte[(int) f.length()];
			fis.read(imgData);
			response.setContentType("image/gif");
			OutputStream o = response.getOutputStream();
			o.write(imgData);
			o.flush();
			o.close();
			fis.close();
		}

	} catch (Exception e) {
		File f = new File(application.getRealPath("temp.png"));
		FileInputStream fis = new FileInputStream(f);
		byte[] imgData = new byte[(int) f.length()];
		fis.read(imgData);
		response.setContentType("image/gif");
		OutputStream o = response.getOutputStream();
		o.write(imgData);
		o.flush();
		o.close();
		fis.close();
	}
%>