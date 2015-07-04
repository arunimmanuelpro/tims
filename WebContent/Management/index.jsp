
<%@page import="com.sun.corba.se.spi.orbutil.fsm.Guard.Result"%>
<%@page import="general.GetInfoAbout"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "Management");
%>
<%@include file="../Common/Header.jsp"%>
<%
		if(userroles.contains("view_management") || userroles.contains("add_management")){
			
		}else{
			response.sendRedirect(request.getContextPath()+"/accesserror.jsp");
			return;
		}
		%>
<%
	Connection con = DbConnection.getConnection();
	Statement s;
	String sql = "";
	String id = "";
	
	//Get Courses
	sql = "SELECT * FROM `coursedetails` order by id";
	s = con.createStatement();
	ResultSet coursedetails = s.executeQuery(sql);

	//Get Coupons
	sql = "SELECT * FROM `coupons` order by id";
	s = con.createStatement();
	ResultSet coupondetails = s.executeQuery(sql);

	//Get Certificates
	sql = "SELECT * FROM `certificates` order by id";
	s = con.createStatement();
	ResultSet certificatesdetails = s.executeQuery(sql);

	//Get employmentstatus
	sql = "SELECT * FROM `employmentstatus` order by id";
	s = con.createStatement();
	ResultSet empstatdetails = s.executeQuery(sql);

	//Get jobtitles
	sql = "SELECT * FROM `jobtitles` order by id";
	s = con.createStatement();
	ResultSet jobtitlesdetails = s.executeQuery(sql);

	//Get books
	sql = "SELECT * FROM `books` order by id";
	s = con.createStatement();
	ResultSet booksdetails = s.executeQuery(sql);
	

%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<section class="panel">
					<header class="panel-heading"> Management Area </header>
					<div class="panel-body">
						<div class="btn-group btn-group-justified">
							<a class="btn btn-info" href="<%=request.getContextPath()%>/Management/courseinfo.jsp">Courses</a> <a
								class="btn btn-success" href="#Coupons">Coupons</a> <a
								class="btn btn-info" href="#Books">Books</a> <a
								class="btn btn-success" href="#Certs">Certificates</a> <a
								class="btn btn-info"
								href="<%=request.getContextPath() %>/Management/courseTopics.jsp">CourseTopics</a>
							<a class="btn btn-warning"
								href="<%=request.getContextPath() %>/Management/AccessRoles.jsp">Access
								Roles</a>
						</div>
					</div>
				</section>
				<!--  One Management Topic Start -->
				<div class="inbox-head" id="Courses">
					<h3>
						<i class="icon-folder-open"> Courses</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							
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
								<th>Description</th>
								<th>Duration (hrs)</th>
								<th>Fees</th>
								<th>Edit..</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (coursedetails.next()) {									
									id = coursedetails.getString(1);
							%>
							<tr>
								<td><%=(coursedetails.getString(1)==null?"":coursedetails.getString(1))%></td>
								<td><%=(coursedetails.getString(2)==null?"":coursedetails.getString(2))%></td>
								<td><%=(coursedetails.getString(3)==null?"":coursedetails.getString(3))%></td>
								<td><%=(coursedetails.getString(4)==null?"":coursedetails.getString(4))%></td>
								<td><%=(coursedetails.getString(5)==null?"":coursedetails.getString(5))%></td>
								<td><a href="#updateCourse" data-toggle="modal" >
									<i class="icon-edit"></i></a>
									<%
										session.setAttribute("cid", coursedetails.getString(1));
									%>
								</td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
					</section>
				<!--  One Management Topic End -->
				<!--  One Management Topic Start -->
				<div class="inbox-head" id="Coupons">
					<h3>
						<i class="icon-gift"> Coupons</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#Couponsm" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Value</th>
								<th>Start Date</th>
								<th>End Date</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (coupondetails.next()) {
							%>
							<tr>
								<td><%=(coupondetails.getString(1)==null?"":coupondetails.getString(1))%></td>
								<td><%=(coupondetails.getString(2)==null?"":coupondetails.getString(2))%></td>
								<td><%=(coupondetails.getString(3)==null?"":coupondetails.getString(3))%></td>
								<td><%=(coupondetails.getString(4)==null?"":coupondetails.getString(4))%></td>
								<td><%=(coupondetails.getString(5)==null?"":coupondetails.getString(5))%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
				<!--  One Management Topic Start -->
				<div class="inbox-head" id="Books">
					<h3>
						<i class="icon-book"> Books</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#Booksm" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Publisher</th>
								<th>Course</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (booksdetails.next()) {
							%>
							<tr>
								<td><%=(booksdetails.getString(1)==null?"":booksdetails.getString(1))%></td>
								<td><%=(booksdetails.getString(2)==null?"":booksdetails.getString(2))%></td>
								<td><%=(booksdetails.getString(3)==null?"":booksdetails.getString(3))%></td>
								<td><%=GetInfoAbout.getcoursename((booksdetails.getString(4)==null?"":booksdetails.getString(4)))%></td>
							</tr>
							<%
								}
							%>
						</tbody>
					</table>
				</section>
				<!--  One Management Topic End -->
				<!--  One Management Topic Start -->
				<div class="inbox-head" id="Jobs">
					<h3>
						<i class="icon-user"> Job Titles</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newJobtitle" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Title</th>
								<th>Description</th>
								<th>Basic Pay Range</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (jobtitlesdetails.next()) {
							%>
							<tr>
								<td><%=(jobtitlesdetails.getString(1)==null?"":jobtitlesdetails.getString(1))%></td>
								<td><%=(jobtitlesdetails.getString(2)==null?"":jobtitlesdetails.getString(2))%></td>
								<td><%=(jobtitlesdetails.getString(3)==null?"":jobtitlesdetails.getString(3))%></td>
								<td><%=(jobtitlesdetails.getString(4)==null?"":jobtitlesdetails.getString(4))%></td>
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
		<div class="row" id="Emps">
			<div class="col-sm-6" id="Certs">
				<!--  One Management Topic Start -->
				<div class="inbox-head">
					<h3>
						<i class="icon-file"> Certificates</i>
					</h3>
					<%if(userroles.contains("add_management")){ %>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="#newcertificate" data-toggle="modal">
								<button type="button" class="btn sr-btn">
									<i class="icon-plus"></i>
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
								<th>Course</th>
							</tr>
						</thead>
						<tbody>
							<%
								while (certificatesdetails.next()) {
							%>
							<tr>
								<td><%=(certificatesdetails.getString(1)==null?"":certificatesdetails.getString(1))%></td>
								<td><%=(certificatesdetails.getString(2)==null?"":certificatesdetails.getString(2))%></td>
								<td><%=GetInfoAbout.getcoursename((certificatesdetails
						.getString(3)==null?"":certificatesdetails.getString(3)))%></td>
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
	</section>
</section>
<!--main content end-->
<%@include file="Coupons.jsp"%>
<%@include file="Books.jsp"%>
<%@include file="course.jsp"%>
<%@include file="jobtitles.jsp"%>
<%@include file="Certificates.jsp"%>
<%@include file="../Common/Footer.jsp"%>