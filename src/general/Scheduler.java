package general;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import access.DbConnection;
import mailing.ReadJustDial;
import mailing.ReadSulekha;
import mailing.ReadSulekha2;
import mailing.ReadSulekhaOld;
import mailing.ReadYet5;

public class Scheduler implements Runnable {

	static Timer timer, timer2;

	public static void start() throws Exception {

		if (timer == null) {
			// timer = new Timer("MyTimer1");// create a new Timer
			// Schedules every 1 minutes
			// General Timer
			// System.out.println("Timer 1 Created");
			// timer.scheduleAtFixedRate(timerTask1, new Date(), 60000*5);
		}

		if (timer2 == null) {
			timer2 = new Timer("MyTimer2");// create a new Timer
			// Schedules every 2 Seconds
			// Mail Read Timer
			System.out.println("Timer 2 Created");
			timer2.scheduleAtFixedRate(timerTask2, new Date(), 5000);
		}
	}

	static TimerTask timerTask1 = new TimerTask() {

		@Override
		public void run() {
			// System.out.println("TimerTask");
			try {
				threadtask();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	};

	static TimerTask timerTask2 = new TimerTask() {

		@Override
		public void run() {
			try {
				
				/*  new ReadSulekha().readMails(); new
				  ReadSulekha2().readMails(); ReadJustDial jus = new
				  ReadJustDial(); jus.readMails();
				
				 ReadYet5 yet = new ReadYet5(); yet.readMails();*/
			
			} catch (Exception e) {
			
				e.printStackTrace();
			}
		}
	};

	static void threadtask() throws Exception {
		Connection con = null;
		SimpleDateFormat ddmm = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		String todayd = ddmm.format(today);
		PreparedStatement s1 = null;
		PreparedStatement s2 = null;
		PreparedStatement s3 = null;
		PreparedStatement s4 = null;
		PreparedStatement s5 = null;
		try {
			String url = "jdbc:mysql://localhost:3306/tims";
			String driver = "com.mysql.jdbc.Driver";
			String userName = "root";
			String password = "";
			if (con == null) {
				Class.forName(driver).newInstance();
			}
			con = DriverManager.getConnection(url, userName, password);
			// Set batch session to cancelled if not ended
			// s1 = con.createStatement();
			// con = DbConnection.getConnection();
			String sql = "UPDATE  `batchsession` SET  `status` =  'CANCELLED',`starttime` =  null,`endtime` =  null WHERE `status` = 'STARTED' AND `date`<'"
					+ todayd + "'";
			s1 = con.prepareStatement(sql);
			s1.executeUpdate();

			// Set batch session to cancelled if not started
			// s2 = con.createStatement();
			sql = "UPDATE  `batchsession` SET  `status` =  'CANCELLED',`starttime` =  null,`endtime` =  null WHERE `status` = 'PENDING' AND `date`<'"
					+ todayd + "'";
			s2 = con.prepareStatement(sql);
			s2.executeUpdate();

			// Set batch session to cancelled if not ended
			// s3 = con.createStatement();
			sql = "UPDATE  `enquiry_data` SET  `followon` =  '" + todayd
					+ "' WHERE `callout` IS NULL AND`followon`<'" + todayd
					+ "'";
			s3 = con.prepareStatement(sql);
			s3.executeUpdate();

			// Set leave status
			// s3 = con.createStatement();
			sql = "UPDATE  `leavemaster` SET  `status` =  '5' WHERE `fromdate` < '"
					+ todayd + "'";
			s5 = con.prepareStatement(sql);
			s5.executeUpdate();

			// Delete attendance automatically
			sql = "DELETE FROM `attendance` WHERE `logouttime`  IS NULL  AND `date`<'"
					+ todayd + "'";
			s4 = con.prepareStatement(sql);
			s4.executeUpdate();

		} catch (Exception e) {
			System.out.println("Some Error in Scheduling");
			e.printStackTrace();
		} finally {
			try {
				s1.close();
				s2.close();
				s3.close();
				s4.close();
				s5.close();
				con.close();
			} catch (Exception se) {
				se.printStackTrace();
			}
		}
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
	}
}
