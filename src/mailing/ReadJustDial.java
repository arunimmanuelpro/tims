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
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.Flags.Flag;
import javax.mail.internet.InternetAddress;
import javax.mail.search.FlagTerm;

import access.DbConnection;

import com.sun.mail.util.MailSSLSocketFactory;

public class ReadJustDial {
	Properties properties = null;
	private Session session = null;
	private Store store = null;
	private Folder inbox = null;
	boolean gotdata = false;
	private String userName = "justdial@eyeopentechnologies.com";// provide user
																	// name
	private String password = "WinWin1940";// provide password
	private StringBuilder parsedcontent;

	public ReadJustDial() {

	}

	public void readMails() throws IOException, Exception {
		properties = new Properties();
		//properties.setProperty("mail.host", "imap.eyeopentechnologies.com");
		properties.setProperty("mail.host", "bh-17.webhostbox.net");
		properties.setProperty("mail.port", "143");	
		properties.setProperty("mail.transport.protocol", "imaps");
		MailSSLSocketFactory socketFactory = new MailSSLSocketFactory();
		socketFactory.setTrustAllHosts(true);
		properties.put("mail.smtp.ssl.socketFactory", socketFactory);
		properties.put("mail.smtp.ssl.checkserveridentity", "false");
		properties.put("mail.smtp.ssl.trust", "*");
		properties.put("mail.smtps.ssl.socketFactory", socketFactory);
		properties.put("mail.smtps.ssl.checkserveridentity", "false");
		properties.put("mail.smtps.ssl.trust", "*");
		properties.put("mail.imap.ssl.socketFactory", socketFactory);
		properties.put("mail.imap.ssl.checkserveridentity", "false");
		properties.put("mail.imap.ssl.trust", "*");
		properties.put("mail.pop3s.ssl.socketFactory", socketFactory);
		properties.put("mail.pop3s.ssl.checkserveridentity", "false");
		properties.put("mail.pop3s.ssl.trust", "*");
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
			inbox = store.getFolder("INBOX");
			inbox.open(Folder.READ_WRITE);
			
			Message messages[] = inbox.search(new FlagTerm(
					new Flags(Flag.SEEN), false));
			System.out.println("Just Dail Mail Count : "+messages.length);
			for (int i = 0; i < messages.length; i++) {
				Message message = messages[i];
				Address[] from = message.getFrom();
				System.out.println("-------------------------------");
				// System.out.println("Date : " + message.getSentDate());
				// System.out.println("From : " + from[0]);
				// System.out.println("Subject: " + message.getSubject());
				// System.out.println("Content :");

				int msgno = message.getMessageNumber();

				boolean already_read = false;
				boolean ignore = false;

				
				Statement s = con.createStatement();
				String checksql = "SELECT * FROM `enquiry` WHERE `source`='JUSTDIAL' AND `mailid`='"
						+ msgno + "' ";
				ResultSet rs2 = s.executeQuery(checksql);
				if (rs2.next()) {
					already_read = true;
				}

				if (!already_read) {

					String email = from == null ? null
							: ((InternetAddress) from[0]).getAddress();

					if (email.equalsIgnoreCase("chnfeedback@justdial.com")) {
						System.out.println("JUSTDIAL Mail :" + email);
					} else {

						System.out.println("Not a JUSTDIAL Mail Ignored :"
								+ email);
						ignore = true;
					}
				} else {
					System.out.println("Mail Already Read. Ignored");
					message.setFlag(Flags.Flag.SEEN, true);
					ignore = true;

				}

				ArrayList<String> details4 = new ArrayList<String>();
				if (!ignore) {

					gotdata = false;
					try {
						Object content = message.getContent();
						// check for string
						// then check for multipart
						if (content instanceof String) {
							content = ((String) content).replaceAll(
									"(\r\n|\n)", "<br>");
							CharSequence c = (CharSequence) content;
							// System.out.println(c);
							// Pattern pattern = Pattern.compile(":(.*?)<br>");
							// Matcher matcher = pattern.matcher(c);
							// while(matcher.find()){
							// details4.add(matcher.group(1));
							// System.out.println("Matcher :"+matcher.group(1));
							// }

						}
						if (content instanceof Multipart) {
							Multipart multiPart = (Multipart) content;
							parsedcontent = procesMultiPart(multiPart);
						}
					} catch (IOException e) {
						e.printStackTrace();
					} catch (MessagingException e) {
						e.printStackTrace();
					}

				}

				boolean gotyet5 = false;

				ArrayList<String> details2 = new ArrayList<String>();
				if (parsedcontent != null && !already_read) {
					if (parsedcontent.length() > 0) {
						Pattern pattern = Pattern
								.compile("<td valign=\"top\">(.*?)</td>");
						Matcher matcher = pattern.matcher(parsedcontent);

						while (matcher.find()) {
							details2.add(matcher.group(1));
						
							gotdata = false;
						}
					} else {
						System.out.println("Sorry No Data Found");
					}
				}

				if ((details2.size() > 0) && !already_read) {
					try {

						SimpleDateFormat ddmm = new SimpleDateFormat(
								"yyyy-MM-dd");
						SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
						Calendar calender = Calendar.getInstance();
						Date currentdate = new Date();
						calender.setTime(currentdate);
						int month = calender.get(Calendar.MONTH) + 1;
						String cDate = ddmm.format(currentdate);
						String year = yyyy.format(currentdate);

						s = con.createStatement();

						String sql = "";

						if (details2.size() == 4) {
							String mobilen = details2.get(1);
							sql = "INSERT INTO `enquiry`(`source`, `name`, `email`, `mobile`, `qualification`, `stream`, `currentlyin`, `homephone`, `courseinterested`, `address`,`donebyid`,`date`,`month`,`year`,`status`,`mailid`) VALUES ('JUSTDIAL','"
									+ details2.get(0)
									+ "','','"
									+ mobilen
									+ "','','','','','','"
									+ details2.get(3)
									+ "','0','"
									+ cDate
									+ "','"
									+ month
									+ "','"
									+ year + "','NEW','" + msgno + "')";
						} else if (details2.size() == 5) {
							String mobilen = details2.get(2);
							sql = "INSERT INTO `enquiry`(`source`, `name`, `email`, `mobile`, `qualification`, `stream`, `currentlyin`, `homephone`, `courseinterested`, `address`,`donebyid`,`date`,`month`,`year`,`status`,`mailid`) VALUES ('JUSTDIAL','"
									+ details2.get(0)
									+ "','','"
									+ mobilen
									+ "','','','','','','"
									+ details2.get(4).replace("'", "\\'")
									+ "','0','"
									+ cDate
									+ "','"
									+ month
									+ "','"
									+ year + "','NEW','" + msgno + "')";
						}

						// System.out.println(sql);
						s.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
						ResultSet rs = s.getGeneratedKeys();
						if (rs.next()) {
							// Retrieve the auto generated key(s).
							int key = rs.getInt(1);

							sql = "INSERT INTO `enquiry_data`(`enquiry_id`, `followon`) VALUES ('"
									+ key + "','" + cDate + "')";
							s.executeUpdate(sql);

							ArrayList<String> users = GetInfoAbout
									.getuserswithrole("4");
							SimpleDateFormat ddm = new SimpleDateFormat(
									"yyyy-MM-dd HH:mm:ss");
							Date cdd = new Date();
							String cDatet = ddm.format(cdd);
							for (String tuser : users) {
								int userid = Integer.parseInt(tuser);
								sql = "INSERT INTO `notifications`(`msg`, `read` , `userid`,`ReceivedAt`) VALUES ('NEW ENQUIRY from JUSTDIAL :"
										+ details2.get(0)
										+ "',0,'"
										+ userid
										+ "','" + cDatet + "')";
								s.executeUpdate(sql);
							}
							gotyet5 = true;

						} else {
							// Actual End
						}

					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					System.out.println("Sorry No Data Found");
				}

				if (gotyet5) {
					// Set Message as Read

					message.setFlag(Flag.FLAGGED, true);

					inbox.setFlags(new Message[] { messages[i] }, new Flags(
							Flags.Flag.SEEN), true);

					System.out.println("JUSTDIAL Mail Details Read Successful");
				} else {
					System.out.println("JUSTDIAL Mail Details Read Failed");
					// Set Message as Read
					inbox.setFlags(new Message[] { messages[i] }, new Flags(
							Flags.Flag.SEEN), false);
				}

				if (gotdata) {
					int detailcount = 0;
					for (String s3 : details2) {
						System.out.println("Detail : " + s3);
						detailcount++;
					}
					if (detailcount == 5) {
						// Set Message as Read
						System.out.println("Mail Details Read Successfully");
						message.setFlag(Flag.FLAGGED, true);
					} else {
						System.out.println("Mail Details Read Failed");
						// Set Message as Read
						message.setFlag(Flag.FLAGGED, false);
					}
				} else {
					message.setFlag(Flag.FLAGGED, false);
				}

				System.out.println("--------------------------------");

			}
			inbox.close(true);
			store.close();
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}finally{
			if(con!=null){
				con.close();
			}
		}
		store.close();
	}

	public StringBuilder procesMultiPart(Multipart content) {
		StringBuilder sb = new StringBuilder();
		try {
			int multiPartCount = content.getCount();
			for (int i = 0; i < multiPartCount; i++) {
				BodyPart bodyPart = content.getBodyPart(i);
				Object o;
				o = bodyPart.getContent();
				if (o instanceof String) {
					sb.append(o);
				} else if (o instanceof Multipart) {
					procesMultiPart((Multipart) o);
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return sb;

	}

	public static void main(String[] args) throws Exception {
		ReadJustDial sample = new ReadJustDial();
		sample.readMails();
	}

}