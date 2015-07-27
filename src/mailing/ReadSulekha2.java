package mailing;

import general.GetInfoAbout;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Flags.Flag;
import javax.mail.internet.InternetAddress;
import javax.mail.search.FlagTerm;

import access.DbConnection;

public class ReadSulekha2 {
	Properties properties = null;
	private Session session = null;
	private Store store = null;
	private Folder inbox = null;
	boolean gotdata = false;
	private String userName = "sulekha2@eyeopentechnologies.com";// provide user name
	private String password = "WinWin1940";// provide password

	public ReadSulekha2() {
	}

	public void readMails() throws IOException, Exception {
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
		Connection con = DbConnection.getConnection();
		try {
			store = session.getStore("imaps");
			store.connect();
			//System.out.println(store);
			inbox = store.getFolder("INBOX");
			inbox.open(Folder.READ_WRITE);
			Message messages[] = inbox.search(new FlagTerm(new Flags(Flag.SEEN), false));
			System.out.println("Sulekha2 Mail Count : "+messages.length);
			for (int i = 0; i < messages.length; i++) {
				Message message = messages[i];
				Address[] from = message.getFrom();
				System.out.println("-------------------------------");
				System.out.println("Date : " + message.getSentDate());
				System.out.println("From : " + from[0]);
				System.out.println("Subject: " + message.getSubject());
				
				int msgno = message.getMessageNumber();
				boolean ignore = false;
				boolean already_read = false;

				Statement sd = con.createStatement();
				String checksql = "SELECT * FROM `enquiry` WHERE `source`='SULEKHA2' AND `mailid`='"	+ msgno + "'";
				ResultSet rs2 = sd.executeQuery(checksql);
				if (rs2.next()) {
					already_read = true;
				}
				if (!already_read) {
					String email = from == null ? null : ((InternetAddress) from[0]).getAddress();
					if (email.equalsIgnoreCase("enq@ypleads.sulekha.com")) {
						System.out.println("Sulekha2 Mail :" + email);
					} else {
						System.out.println("Mail Ignored :" + email);
						ignore = true;
					}
				} else {
					System.out.println("Mail Already Read. Ignored");
					message.setFlag(Flags.Flag.SEEN, true);					
					ignore = true;
				}
				ArrayList<String> details4 = new ArrayList<String>();				
				if (!ignore) {

					String html = message.getContent().toString();
					int startindex = html.indexOf("<");
					// To get Name
					String ref = "Customer's name: ";
					int endindex = html.indexOf(ref);
					StringBuilder str = new StringBuilder(html);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("</td>");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					//System.out.println("Name" + str);
					details4.add(str.toString());

					// To get Looking For
					ref = "Looking for: ";
					endindex = html.indexOf(ref);
					str = new StringBuilder(html);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("</td>");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					//System.out.println("Looking For" + str);
					details4.add(str.toString());

					// To get Service preference
					ref = "Service preference: ";
					endindex = html.indexOf(ref);
					str = new StringBuilder(html);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("</td>");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					//System.out.println("Service preference" + str);
					details4.add(str.toString());

					// To get Email ID:
					ref = "Email ID: ";
					endindex = html.indexOf(ref);
					str = new StringBuilder(html);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("</td>");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");

					startindex = str.indexOf("<a");
					endindex = str.indexOf(">");
					str.replace(startindex, endindex, "");
					startindex = 0;
					endindex = 1;
					str.replace(startindex, endindex, "");

					ref = str.toString();
					ref = ref.replace(">", "");
					ref = ref.replace("</a", "");
					//System.out.println("Email ID:" + ref);
					details4.add(ref);

					// To get Mobile number:
					ref = "Mobile number: ";
					endindex = html.indexOf(ref);
					str = new StringBuilder(html);
					str.replace(startindex, endindex, "");
					str = new StringBuilder(str);
					startindex = str.indexOf(ref);
					endindex = str.indexOf("</td>");
					str = new StringBuilder(str.substring(startindex, endindex));
					str.replace(0, ref.indexOf(":"), "");
					str.replace(0, 1, "");
					//System.out.println("Mobile number:" + str);
					details4.add(str.toString());					
					gotdata = false;
				}
				
				boolean gotsulekha = false;

				if ((details4.size() > 0)) {
					try {
						SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
						SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
						Calendar calender = Calendar.getInstance();
						Date currentdate = new Date();
						calender.setTime(currentdate);
						int month = calender.get(Calendar.MONTH) + 1;
						String cDate = ddmm.format(currentdate);
						String year = yyyy.format(currentdate);						
						Statement s = con.createStatement();
						String mobilen = details4.get(4);
						String sql = "INSERT INTO `enquiry`(`source`, `name`, `email`, `mobile`, `qualification`, `stream`, `currentlyin`, `homephone`, `courseinterested`, `address`,`donebyid`,`date`,`month`,`year`,`status`,`mailid`) VALUES ('SULEKHA2','"
								+ details4.get(0)
								+ "','"
								+ details4.get(3)
								+ "','"
								+ mobilen
								+ "','','','','','"
								+ details4.get(1).replace("'","\\'")
								+ ","
								+ details4.get(2).replace("'", "\\'")
								+ "','','0','"
								+ cDate
								+ "','"
								+ month
								+ "','"
								+ year + "','NEW','" + msgno + "')";
						//System.out.println(sql);
						s.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
						ResultSet rs = s.getGeneratedKeys();
						if (rs.next()) {
							// Retrieve the auto generated key(s).
							int key = rs.getInt(1);
							sql = "INSERT INTO `enquiry_data`(`enquiry_id`, `followon`) VALUES ('"	+ key + "','" + cDate + "')";
							s.executeUpdate(sql);
							ArrayList<String> users = GetInfoAbout.getuserswithrole("3");
							SimpleDateFormat ddm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
							Date cdd = new Date();
							String cDatet = ddm.format(cdd);
							for (String tuser : users) {
								int userid = Integer.parseInt(tuser);
								sql = "INSERT INTO `notifications`(`msg`, `read` , `userid`,`ReceivedAt`) VALUES ('NEW ENQUIRY from SULEKHA2 :"
										+ details4.get(0)
										+ "',0,'"
										+ userid
										+ "','" + cDatet + "')";
								s.executeUpdate(sql);
							}							
							gotsulekha = true;
						} else {
							// Actual End
						}
						if (gotsulekha) {					
							System.out.println("1 SULEKHA2 Mail Details Read Successfully");
							try {
								message.setFlag(Flags.Flag.SEEN, true);
							} catch (Exception e) {
								e.printStackTrace();
							}
						} else {
							System.out.println("SULEKHA2 Mail Details Read Failed");					
							message.setFlag(Flag.SEEN, false);
						}
					}catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					System.out.println("Sorry No Data Found");
				}					
			}		
			store.close();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		
	}

	public static void main(String[] args) throws IOException {
		/*ReadSulekha sample = new ReadSulekha();
		try {
			sample.readMails();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
	}

}