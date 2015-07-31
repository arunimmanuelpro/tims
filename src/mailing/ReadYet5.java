package mailing;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Flags.Flag;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMultipart;
import javax.mail.search.FlagTerm;

import access.DbConnection;

public class ReadYet5 {
	Properties properties = null;
	private Session session = null;
	private Store store = null;
	private Folder inbox = null;
	boolean gotdata = false;
	private String userName = "yet5@eyeopentechnologies.com";// provide user
																// name
	private String password = "WinWin1940";// provide password

	public ReadYet5() {
	}

	public void readMails() throws IOException, Exception {
		Connection con = DbConnection.getConnection();
		properties = new Properties();
		properties.setProperty("mail.host", "bh-17.webhostbox.net");
		properties.setProperty("mail.port", "143");
		properties.setProperty("mail.transport.protocol", "imaps");
		session = Session.getInstance(properties,
				new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(userName, password);
					}
				});
		try {
			store = session.getStore("imaps");
			store.connect();
			// System.out.println(store);
			inbox = store.getFolder("INBOX");
			inbox.open(Folder.READ_WRITE);
			Message messages[] = inbox.search(new FlagTerm(
					new Flags(Flag.SEEN), false));
			for (int i = 0; i < messages.length; i++) {
				Message message = messages[i];
				Address[] from = message.getFrom();
				/*
				 * System.out.println("-------------------------------");
				 * System.out.println("Date : " + message.getSentDate());
				 * System.out.println("From : " + from[0]);
				 * System.out.println("Subject: " + message.getSubject());
				 */
				Object content = message.getContent();
				if (content instanceof String) {
					String body = (String) content;
					System.out.println("String");
				} else if (content instanceof MimeMultipart) {
					MimeMultipart multipart = (MimeMultipart) content;
					if (multipart.getCount() > 0) {
						BodyPart part = multipart.getBodyPart(0);
						content = part.getContent();
					}
				}
				if (content != null) {
					String messagebody = content.toString();

					// Get Name
					int startindex = 0;
					String ref = "Name : ";
					int endindex = messagebody.indexOf(ref);
					StringBuilder str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					String name = str.toString();
					// System.out.println("Name" + str);

					// Get City
					startindex = 0;
					ref = "City : ";
					endindex = messagebody.indexOf(ref);
					str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					// System.out.println("City" + str);
					String city = str.toString();
					// Get Area
					startindex = 0;
					ref = "Area : ";
					endindex = messagebody.indexOf(ref);

					str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					System.out.println("Area" + str);
					String area = str.toString();

					// Get Contact No
					startindex = 0;
					ref = "Contact No.: ";
					endindex = messagebody.indexOf(ref);
					str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					ref = str.toString();
					if (ref.contains(" - [Mobile Number Verified]")) {
						ref = ref.replace(" - [Mobile Number Verified]", "");
					}
					if (ref.contains("</strong>")) {
						ref = ref.replace("</strong>", "");
					}
					System.out.println("Contact No" + ref);
					String mobile = ref.toString();

					// Get Email
					startindex = 0;
					ref = "Email : ";
					endindex = messagebody.indexOf(ref);
					str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					ref = str.toString();
					String email = ref;
					// System.out.println("Email " + ref);

					// Get Course Interested in
					startindex = 0;
					ref = "Course Interested in: ";
					endindex = messagebody.indexOf(ref);
					str = new StringBuilder(messagebody);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("\n");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					ref = str.toString();
					String course = ref.toString();
					// System.out.println("Course Interested in " + ref);

					PreparedStatement ps = con
							.prepareStatement("insert into enquiry(source,name,courseinterested,currentlyin,email,mobile,status,donebyid,date,month,year)values(?,?,?,?,?,?,?,?,?,?,?)");
					ps.setString(1, "YET5");
					ps.setString(2, name);
					ps.setString(3, course);
					ps.setString(4, area + ", " + city);
					ps.setString(5, email);
					ps.setString(6, mobile);
					ps.setString(7, "NEW");
					ps.setInt(8, 0);
					DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
					Date date = new Date();
					ps.setString(9, dateFormat.format(date));
					Calendar cal = Calendar.getInstance();
					cal.setTime(date);
					ps.setString(10,
							String.valueOf(cal.get(Calendar.MONTH) + 1));
					ps.setString(11, String.valueOf(cal.get(Calendar.YEAR)));

					ps.executeUpdate();
					con.close();
				}

				int msgno = message.getMessageNumber();
				boolean ignore = false;
				boolean already_read = false;

				if (!already_read) {

					String email = from == null ? null
							: ((InternetAddress) from[0]).getAddress();

					if (email.equalsIgnoreCase("enq@ypleads.sulekha.com")) {
						System.out.println("Sulekha Mail :" + email);
					} else {
						System.out.println("Mail Ignored :" + email);
						ignore = true;
					}

				} else {
					System.out.println("Mail Already Read. Ignored");
					message.setFlag(Flags.Flag.SEEN, true);
					ignore = true;

				}

				if (!ignore) {

					gotdata = false;

				}
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		store.close();
	}

	public static void main(String[] args) throws IOException {
		ReadYet5 sample = new ReadYet5();
		try {
			sample.readMails();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}