
				<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>



					<div class="table-responsive">
						<table class="table table-striped border-top datatable" id="sample_2"
							class="dtable">
							<thead>
								<tr>
									<th width = "15%">Id</th>
									<th width="15%">Source</th>
									<th width="15%">Name</th>
									<th width="15%">Email</th>
									<th width="15%">Course Interested</th>
									<th width="10%">Status</th>
									<th width="10%">Follow on</th>
									<th width="10%">Done</th>
									<th width="10%">Work</th>
								</tr>
							</thead>
							<tbody>
								<%
									Connection dbc = DbConnection.getConnection();
										Statement s = dbc.createStatement();
										String sql = "";
										if(request.getParameter("completed")==null)
											sql = "SELECT * FROM enquiry WHERE `status` LIKE 'NEW' OR `status` LIKE 'FOLLOW UP' order by id DESC";
										else
											sql = "SELECT * FROM enquiry WHERE `status` = 'COMPLETED' OR `status` LIKE 'NOT INTERESTED' OR `status` LIKE 'DUPLICATE' order by id DESC";
										ResultSet rs = s.executeQuery(sql);
										while (rs.next()) {
											int id = rs.getInt("id");
											
											
											Connection con3 = DbConnection.getConnection();
											Statement st;
											String sqlq;
											ResultSet rss;
											st = con3.createStatement();

											SimpleDateFormat ddmm = new SimpleDateFormat("dd/MM/yyyy");
											Date today = new Date();
											String todayd = ddmm.format(today);

											HttpSession ses3 = request.getSession();
											 String ses_user_id = ses3.getAttribute("id").toString();
											
											sqlq = "SELECT * FROM enquiry_data where `enquiry_id` = '" + id
													+ "' ORDER BY id DESC LIMIT 1";
											rss = st.executeQuery(sqlq);
											String emp_id = "",followon="";
											if (rss.next()) {
											 	emp_id = rss.getString("donebyempid");
											 	followon = rss.getString("followon");
																																	}
								%>
								<tr>
								<td>
									<%=rs.getInt("id") %>
								</td>
									<td>
										<%
											out.print(rs.getString("source"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("name"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("email"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("courseinterested"));
										%>
									</td>
									<td>
										<%
											out.print(rs.getString("status"));
										%>
									</td>
									<td><%=followon%></td>
									<td>
										<%
											if(emp_id==null)
																																													out.print("NO");
																																												else
																																													out.print("YES");
										%>
									</td>
									<td><a class="btn btn-info btn-xs"
										href="details.jsp?id=<%=id%>"><i class="icon-wrench"></i>
											More...</a></td>
								</tr>
								<%
									}
																																//Close DbConnection
																																DbConnection.close();
								%>
							</tbody>
						</table>
					</div>
			
				<%@include file="../Common/Footer.jsp"%>