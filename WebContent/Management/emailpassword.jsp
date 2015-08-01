<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	request.setAttribute("title", "Email Password");
%>
<%@include file="/Common/Header.jsp"%>
<!--main content start-->
<section id="main-content">
	<section class="wrapper">
		<div class="row">
			<div class="col-sm-12">
				<!--  One Management Topic Start -->
				<div class="inbox-head" style="background-color: #F15656;">
					<h3>
						<i class="icon-folder-open">Email Accounts</i>
					</h3>
					<form class="pull-right position" action="#">
						<div class="input-append">
							<a href="newenquiry.jsp">
								<button type="button" class="btn sr-btn">
									<i class="fa fa-plus"></i>
								</button>
							</a>
						</div>
					</form>
				</div>


				<section class="panel" id="enqtable">
					<div class="table-responsive">
						<table class="table table-striped border-top datatable"
							id="sample_2" class="dtable">
							<thead>
								<tr>

									<th width="15%">Name</th>

									<th width="15%">Email</th>

									<th width="10%">Action</th>


								</tr>
							</thead>
							<tbody>
								<%
								Connection con = DbConnection.getConnection();
								PreparedStatement ps = con.prepareStatement("select * from emailaccounts");
								ResultSet rs = ps.executeQuery();
								while(rs.next()){
								%>
								<tr>
									<td width="15%"><%=rs.getString("ename") %></td>

									<td width="15%"><%=rs.getString("email") %></td>

									<td width="10%"><a href="editemail.jsp?id=<%= rs.getInt("id") %>" data-toggle="modal"><i class='icon-wrench'></i>Edit</a></td>
								</tr>
								<%} %>
							</tbody>
						</table>
					</div>



				</section>



			</div>
		</div>
	</section>
</section>



<%
	con.close();
%>
<script>
	$(document).ready(function() {
		$('#sample_2').DataTable();
	});
</script>
<%@include file="/Common/Footer.jsp"%>