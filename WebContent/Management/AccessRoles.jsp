
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="access.AccessRoles"%>
<%
	request.setAttribute("title", "Access Roles");
%>
<%@include file="../Common/Header.jsp"%>
<%
	Connection con = DbConnection.getConnection();
	Statement s;
	PreparedStatement ps;
	String sql = "";

	//Get Emp
	sql = "SELECT * FROM `roles`";
	s = con.createStatement();
	ResultSet empdetails = s.executeQuery(sql);
%>
<%
		if(userroles.contains("add_management")){
			
		}else{
			response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
			return;
		}
		%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="icon-folder-open"> Access Roles</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="<%=request.getContextPath() %>/Management/assignScreen.jsp">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
					<% } %>
				</div>
				<section class="panel">
					<table class="table">
						<thead>
							<tr>
								<th>#</th>
								<th>Name</th>
								<th>Permissions</th>
								<th>Delete</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (empdetails.next()) {
							%>
							<tr>
								<td><%=empdetails.getString(1)%></td>
								<td><%=empdetails.getString(2)%></td>
								<td><%=AccessRoles.get_permissons(empdetails.getString(1)) %></td>
								<td><a
									href="deleterole.jsp?role=<%=empdetails.getString(1)  %>"><i
										class="icon-remove">Remove</i></a></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
			</div>
		</div>
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog"
			tabindex="-1" id="empcontact" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">Access Roles</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading"> New Role </header>
									<div class="panel-body">
										<form class="form-horizontal" data-validate="parsley"
											method="POST" action="newRole.jsp">
											<div class="form-group">
												<label for="pancard" class="col-lg-3 control-label"> Select Job Title:</label>
												<div class="col-lg-8">													
													<select id="roleid" class="form-control" name="roleid"
														data-required="true" data-notblank="true">
														<option value="">---select---</option>
														<%
															ps = con.prepareStatement("SELECT * FROM `jobtitles` ORDER BY `id`");
													        ResultSet rs = ps.executeQuery();
															while (rs.next()) {
														%>
														         <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
														<%	}	%>
													</select>											
												</div>
											</div>
											
								<div class="form-group">
                                  <label class="control-label col-md-3">Select Permissions</label>
                                  <div class="col-md-8">
                                      <select multiple="multiple" class="multi-select" id="my_multi_select2" name="my_multi_select2[]">
                                          <optgroup label="NFC EAST">
                                              <option>Dallas Cowboys</option>
                                              <option>New York Giants</option>
                                              <option>Philadelphia Eagles</option>
                                              <option>Washington Redskins</option>
                                          </optgroup>
                                          <optgroup label="NFC NORTH">
                                              <option>Chicago Bears</option>
                                              <option>Detroit Lions</option>
                                              <option>Green Bay Packers</option>
                                              <option>Minnesota Vikings</option>
                                          </optgroup>
                                          <optgroup label="NFC SOUTH">
                                              <option>Atlanta Falcons</option>
                                              <option>Carolina Panthers</option>
                                              <option>New Orleans Saints</option>
                                              <option>Tampa Bay Buccaneers</option>
                                          </optgroup>
                                          <optgroup label="NFC WEST">
                                              <option>Arizona Cardinals</option>
                                              <option>St. Louis Rams</option>
                                              <option>San Francisco 49ers</option>
                                              <option>Seattle Seahawks</option>
                                          </optgroup>
                                      </select>
                                  </div>
                              </div>
							  				<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<button type="submit" class="btn btn-danger">Create</button>
												</div>
											</div>
										</form>
									</div>
								</section>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</section>
<!--main content end-->

<script type="text/javascript" src="<%=request.getContextPath()%>/assets/jquery-multi-select/js/jquery.multi-select.js"></script>


<%@include file="../Common/Footer.jsp"%>