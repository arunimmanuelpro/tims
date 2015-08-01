package mailing;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Address;
import javax.mail.BodyPart;
import javax.mail.Flags;
import javax.mail.Flags.Flag;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.NoSuchProviderException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.search.FlagTerm;

import access.DbConnection;

import com.sun.mail.util.MailSSLSocketFactory;
public class ReadJustDial {
	Properties properties = null;
	private Session session = null;
	private Store store = null;
	private Folder inbox = null;
	boolean gotdata = false;
	private String userName ;// provide user
																	// name
	private String password;// provide password
	private StringBuilder parsedcontent;

	public ReadJustDial() {

	}

	public void readMails() throws IOException, Exception {
		Connection con = DbConnection.getConnection();
		PreparedStatement ps0 = con.prepareStatement("select * from emailaccounts where id = 4");
		ResultSet rs0 = ps0.executeQuery();
		if(rs0.next()){
			userName = rs0.getString("email");
			password = rs0.getString("password");
		}
		properties = new Properties();
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


				int msgno = message.getMessageNumber();

					try {
						Object content = message.getContent();
					
						if (content instanceof String) {
							content = ((String) content).replaceAll(
									"(\r\n|\n)", "<br>");
							CharSequence c = (CharSequence) content;
							String conn =content.toString();
							
						String [] contentarray =conn.split("\n");
						/*for(int ij = 0;ij<contentarray.length;ij++){
							System.out.println(contentarray[ij]);
						}*/
						PreparedStatement ps = con.prepareStatement("insert into enquiry(source,name,email,mobile,currentlyin,status)values(?,?,?,?,?,?)");
						ps.setString(1, "JUST DIAL");
						ps.setString(2, contentarray[0]);	
						ps.setString(3, contentarray[6]);
						ps.setString(4, contentarray[5]);
						ps.setString(5, contentarray[4]);
						ps.setString(6, "NEW");
					System.out.println(ps);
						ps.executeUpdate();
						
						
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

			

				ArrayList<String> details2 = new ArrayList<String>();
				if (parsedcontent != null ) {
					if (parsedcontent.length() > 0) {
						Pattern pattern = Pattern
								.compile("<td valign=\"top\">(.*?)</td>");
						Matcher matcher = pattern.matcher(parsedcontent);
						List<String> maillist = new LinkedList<String>();
						while (matcher.find()) {
						maillist.add(matcher.group(1));
						
						
						}
						System.out.println(maillist);
						PreparedStatement ps = con.prepareStatement("insert into enquiry(source,name,courseinterested,currentlyin,email,mobile,status,donebyid,date,month,year)values(?,?,?,?,?,?,?,?,?,?,?)");
						ps.setString(1, "JUST DIAL");
						if(maillist.size()>=0+1){
						ps.setString(2, maillist.get(0));
						}else{
							ps.setString(2, null);
						}
						if(maillist.size()>=1+1){
							ps.setString(3, maillist.get(1));
							}else{
								ps.setString(3, null);
							}
						if(maillist.size()>=3+1){
							ps.setString(4, maillist.get(3));
							}else{
								ps.setString(4, null);
							}
						if(maillist.size()>=6+1){
							ps.setString(5, maillist.get(6));
							}else{
								ps.setString(5, null);
							}
						
						
						if(maillist.size()>=5+1){
							ps.setString(6, maillist.get(5));
							}else{
								ps.setString(6, null);
							}
						ps.setString(7, "NEW");
						ps.setInt(8, 0);
						DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
						Date date = new Date();
						ps.setString(9, dateFormat.format(date));
						Calendar cal = Calendar.getInstance();
						cal.setTime(date);
						ps.setString(10, String.valueOf(cal.get(Calendar.MONTH)+1));
						ps.setString(11, String.valueOf(cal.get(Calendar.YEAR)));
					
						ps.executeUpdate();
					} else {
						System.out.println("Sorry No Data Found");
					}
				}

			}	
			inbox.close(true);
			store.close();
		} catch (NoSuchProviderException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		
		}finally{
			con.close();
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