
<%@page import="java.io.File"%>
<%@page import="mailing.SendMail"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="javax.sql.rowset.serial.SerialBlob"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="access.DbConnection"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Connection"%>


<%
	String saveFile = "";
	String contentType = request.getContentType();
	if ((contentType != null)
			&& (contentType.indexOf("multipart/form-data") >= 0)) {
		DataInputStream in = new DataInputStream(
				request.getInputStream());
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead,
					formDataLength);
			totalBytesRead += byteRead;
		}
		String file = new String(dataBytes);
		saveFile = file.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,
				saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,
				contentType.length());
		int pos;
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes()).length;
		int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
		File ff = new File(saveFile);
		FileOutputStream fileOut = new FileOutputStream(ff);
		fileOut.write(dataBytes, startPos, (endPos - startPos));
		fileOut.flush();
		fileOut.close();

		ResultSet rs = null;
		PreparedStatement psmnt = null;
		FileInputStream fis;
		try {
			Connection connection = DbConnection.getConnection();
			File f = new File(saveFile);

			String idd = request.getAttribute("userid").toString();
			String insert = "UPDATE `employee` SET `Picture`=? WHERE `id`='"
					+ idd + "'";

			psmnt = connection.prepareStatement(insert);
			fis = new FileInputStream(f);
			psmnt.setBinaryStream(1, (InputStream) fis,	(int) (f.length()));
			int s = psmnt.executeUpdate();
			if (s > 0) {
				System.out.println("Uploaded successfully !, Please Wait.. Redirecting...");				
				String htmlBody = "<h2>TIMS BRAIN</h2><br>Your Profile picture has been changed recently.";
				String subject = "You have a update from TIMS BRAIN";
				System.out.println(subject+" Mail ID: "+session.getAttribute("email").toString());
				SendMail.sendmail(session.getAttribute("email").toString(),subject, htmlBody);
				response.sendRedirect(request.getContextPath()+"/profile.jsp");
				return;
			} else {
				out.println("Error, Error in Upload");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
%>