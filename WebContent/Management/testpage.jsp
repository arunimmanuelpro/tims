<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="access.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%
	request.setAttribute("title", "Course Information");
%>
<%@include file="../Common/Header.jsp"%>
<%
		if(userroles.contains("view_management") || userroles.contains("add_management")){
			
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
				<section class="panel">					
  					<div class="adv-table editable-table ">
                          <div class="clearfix">
                              <div class="btn-group">
                                  <button id="editable-sample_new" class="btn green">
                                      Add New Course <i class="fa fa-plus"></i>
                                  </button>
                              </div>
                         
                          </div>
                          <div class="space15"></div>
  
   <table class="table table-striped table-hover table-bordered" id="editable-sample">
                              <thead>
                              <tr>
                                  <th>Course Name</th>
                                  <th>Course Description</th>
                                  <th>Duration in Hours</th>
                                  <th>Fees</th>
                                  <th>Edit</th>
                                  <th>Delete</th>
                              </tr>
                              </thead>
                              <tbody>
                              <%
                              	Connection con = DbConnection.getConnection();
    							PreparedStatement ps=  con.prepareStatement("select * from coursedetails");
    							ResultSet rs = ps.executeQuery();
    							while(rs.next()){
    						  %>
                              <tr class="">
                                  <td><%=rs.getString("Name") %></td>
                                  <td><%=rs.getString("Description") %></td>
                                  <td><%=rs.getInt("Duration") %></td>
                                  <td class="center"><%=rs.getInt("Fees") %></td>
                                  <td><a class="edit" href="javascript:;">Edit</a></td>
                                  <td><a class="delete" href="javascript:;">Delete</a></td>
                              </tr>
                       		<%}
    							con.close();
    						%>     
                              </tbody>
                          </table>  
  						</div>
 					</section>
 				</div>
 			</div>
 		</section>
 </section> 
  
  
  
  
  
  
   <!-- js placed at the end of the document so the pages load faster -->
    <script src="<%=request.getContextPath()%>/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-ui-1.9.2.custom.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.dcjqaccordion.2.7.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.scrollTo.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.nicescroll.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/assets/data-tables/jquery.dataTables.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/assets/data-tables/DT_bootstrap.js"></script>
    <script src="<%=request.getContextPath()%>/js/respond.min.js" ></script>

  <!--right slidebar-->
  <script src="<%=request.getContextPath()%>/js/slidebars.min.js"></script>

  <!--common script for all pages-->
  <script src="<%=request.getContextPath()%>/js/common-scripts.js"></script>

<script>


	var EditableTable = function () {

	    return {

	        //main function to initiate the module
	        init: function () {
	            function restoreRow(oTable, nRow) {
	                var aData = oTable.fnGetData(nRow);
	                var jqTds = $('>td', nRow);

	                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
	                    oTable.fnUpdate(aData[i], nRow, i, false);
	                }

	                oTable.fnDraw();
	            }

	            function editRow(oTable, nRow) {
	                var aData = oTable.fnGetData(nRow);
	                var jqTds = $('>td', nRow);
	                jqTds[0].innerHTML = '<input type="text" class="form-control small" value="' + aData[0] + '">';
	                jqTds[1].innerHTML = '<input type="text" class="form-control small" value="' + aData[1] + '">';
	                jqTds[2].innerHTML = '<input type="text" class="form-control small" value="' + aData[2] + '">';
	                jqTds[3].innerHTML = '<input type="text" class="form-control small" value="' + aData[3] + '">';
	                jqTds[4].innerHTML = '<a class="edit" href="">Save</a>';
	                jqTds[5].innerHTML = '<a class="cancel" href="">Cancel</a>';
	            }

	            function saveRow(oTable, nRow) {
	                var jqInputs = $('input', nRow);
	                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
	                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
	                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
	                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
	                oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 4, false);
	                oTable.fnUpdate('<a class="delete" href="">Delete</a>', nRow, 5, false);
	                oTable.fnDraw();
	            }

	            function cancelEditRow(oTable, nRow) {
	                var jqInputs = $('input', nRow);
	                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
	                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
	                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
	                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
	                oTable.fnUpdate('<a class="edit" href="">Edit</a>', nRow, 4, false);
	                oTable.fnDraw();
	            }

	            var oTable = $('#editable-sample').dataTable({
	                "aLengthMenu": [
	                    [5, 15, 20, -1],
	                    [5, 15, 20, "All"] // change per page values here
	                ],
	                // set the initial value
	                "iDisplayLength": 5,
	                "sDom": "<'row'<'col-lg-6'l><'col-lg-6'f>r>t<'row'<'col-lg-6'i><'col-lg-6'p>>",
	                "sPaginationType": "bootstrap",
	                "oLanguage": {
	                    "sLengthMenu": "_MENU_ records per page",
	                    "oPaginate": {
	                        "sPrevious": "Prev",
	                        "sNext": "Next"
	                    }
	                },
	                "aoColumnDefs": [{
	                        'bSortable': false,
	                        'aTargets': [0]
	                    }
	                ]
	            });

	            jQuery('#editable-sample_wrapper .dataTables_filter input').addClass("form-control medium"); // modify table search input
	            jQuery('#editable-sample_wrapper .dataTables_length select').addClass("form-control xsmall"); // modify table per page dropdown

	         

	            $('#editable-sample a.delete').live('click', function (e) {
	                e.preventDefault();

	                if (confirm("Are you sure to delete this row ?") == false) {
	                    return;
	                }

	                var nRow = $(this).parents('tr')[0];
	                oTable.fnDeleteRow(nRow);
	                var jqInputs = $('td', nRow);
	                var course = jqInputs[0].innerHTML;
                    var desc = jqInputs[1].innerHTML;
                    var duration = jqInputs[2].innerHTML;
                    var fees = jqInputs[3].innerHTML;
              
                  callAjax(getContextPath()+"/Ajax/deletecourse.jsp?course="+course+"&desc="+desc+"&duration="+duration+"&fees="+fees);
                  
	                
	                
	                
	            });

	            $('#editable-sample a.cancel').live('click', function (e) {
	                e.preventDefault();
	                if ($(this).attr("data-mode") == "new") {
	                    var nRow = $(this).parents('tr')[0];
	                    oTable.fnDeleteRow(nRow);
	                } else {
	                    restoreRow(oTable, nEditing);
	                    nEditing = null;
	                }
	            });
	            var nEditing = null;
	        	var edit = 1;
	            $('#editable-sample_new').click(function (e) {
	                e.preventDefault();
	                var aiNew = oTable.fnAddData(['', '', '', '',
	                        '<a class="edit" href="">Edit</a>', '<a class="cancel" data-mode="new" href="">Cancel</a>'
	                ]);
	                edit=0;
	                var nRow = oTable.fnGetNodes(aiNew[0]);
	               editRow(oTable, nRow);
	                nEditing = nRow;
	            });
	            $('#editable-sample a.edit').live('click', function (e) {
	            
	            	e.preventDefault();
	
	                /* Get the row as a parent of the link that was clicked on */
	                var nRow = $(this).parents('tr')[0];
	                var jqInputs = $('input', nRow);
	                if (nEditing !== null && nEditing != nRow) {
	                    /* Currently editing - but not this row - restore the old before continuing to edit mode */
	                    restoreRow(oTable, nEditing);
	                    editRow(oTable, nRow);
	                    nEditing = nRow;
	                } else if (nEditing == nRow && this.innerHTML == "Save") {
	                    /* Editing this row and want to save it */
	                    saveRow(oTable, nEditing);
	                    nEditing = null;
	                  
	                    var course = escape(jqInputs[0].value);
	                
	                    var desc = jqInputs[1].value;
	                    var duration = jqInputs[2].value;
	                    var fees = jqInputs[3].value;
	              if(edit==1){
	                  callAjax(getContextPath()+"/Ajax/editcourse.jsp?course="+course+"&desc="+desc+"&duration="+duration+"&fees="+fees);
	              }else{
	            	  callAjax(getContextPath()+"/Ajax/addcourse.jsp?course="+course+"&desc="+desc+"&duration="+duration+"&fees="+fees);
	              }
	                } else {
	                    /* No edit in progress - let's start one */
	                    editRow(oTable, nRow);
	                    nEditing = nRow;
	                }
	            });
	            function getContextPath() {
	         	   return window.location.pathname.substring(0, window.location.pathname.indexOf("/",2));
	         	}
	            function callAjax(url){
	        		var serverresponse;
	        		
	        		var xmlhttp;
	        		
	        		if (window.XMLHttpRequest)
	        		  {
	        		  xmlhttp=new XMLHttpRequest();
	        		  }
	        		else
	        		  {
	        		  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	        		  }
	        		xmlhttp.onreadystatechange=function()
	        		  {
	        		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	        		    {
	        			  serverresponse=xmlhttp.responseText;
	        			serverresponse = serverresponse.replace(/\s+/g,' ').trim();
	        			alert(serverresponse);
	        		    }
	        		  };
	        		xmlhttp.open("GET",url,true);
	        		xmlhttp.send();
	        	
	        	}
	        }
	    

	    };

	}();

</script>

      <!-- END JAVASCRIPTS -->
      <script>
          jQuery(document).ready(function() {
              EditableTable.init();
          });
      </script>
 
 <%@include file="../Common/footerinclude.jsp"%>
 </body>
</html>