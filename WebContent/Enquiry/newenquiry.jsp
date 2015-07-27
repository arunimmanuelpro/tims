<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	request.setAttribute("title", "New Enquiries");
%>
    <%@include file="../Common/Header.jsp"%>
    
<div aria-hidden="true" 
			tabindex="-1" >
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close" type="button">×</button>
						<h4 class="modal-title">New Walkin</h4>
					</div>

					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<section class="panel">
									<header class="panel-heading">Enquiry details</header>
									<div class="panel-body">
										<form class="form-horizontal" id="newempdetadd"
											data-validate="parsley">
											<div class ="form-group">
												
												<div class = "col-lg-8" align ="center">
												<input type= "radio"  name = "type" value ="Student" id = "type"/>  Student
												<input type= "radio"  name = "type" value ="Professional" id = "type"/>  Professional
												<input type= "radio"  name = "type" value ="Project" id = "type"/>  Project
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Enquiry Source</label>
												<div class="col-lg-8">
													<select name="source" id="source" data-required="true" class = "form-control" >
														<option value="">Please Choose</option>
														<!-- <option value="db">DB</option>
														<option value="walkin">Walkin</option>
														<option value="walkin-emp-ref">Walkin Employee
															Referal</option>
														<option value="walkin-stu-ref">Walkin Student
															Referal</option>
														<option value="phone">Phone Enquiry</option>
														<option value="sulekha-manual">Sulekha Manual</option>
														<option value="justdial-manual">JustDial Manual</option>
														<option value="yet5-manual">Yet5 Manual</option> -->
														<option value="Sulekha">Sulekha</option>
														<option value="Sulekha-ref">Sulekha Ref</option>
														<option value="Sulekha 2">Sulekha 2</option>
														<option value="Sulekha 2 Ref">Sulekha 2 Ref</option>
														<option value="Just Dial">Just Dial</option>
														<option value="Just Dial ref">Just Dial Ref</option>
														<option value="yet5">Yet5</option>
														<option value="yet5-ref">Yet5 Ref</option>
														<option value="direct">Direct</option>
														<option value="oc">OC</option>
														<option value="oc-ref">OC Ref</option>
														<option value="student-ref">Sudent Ref</option>
														<option value="staff-ref">Staff Ref</option>
														<option value="iv-tracker">IV Tracker</option>
														<option value="email-enq">Email Enq</option>
														<option value="iis-ref">IIS Ref</option>
													</select>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Name</label>
												<div class="col-lg-8">
													<input type="text" name="name" id="name"
														data-required="true"
														class="form-control parsley-validated">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Email</label>
												<div class="col-lg-8">
													<input type="text" name="email" id="email"
														data-type="email" class="form-control parsley-validated" onchange = "getemail(this.value);">
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Mobile</label>
												<div class="col-lg-8">
													<input type="text" name="mobile" id="mobile"
														data-required="true" data-type="phone"
														class="form-control parsley-validated" onchange= "getmobilenumber(this.value);">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Qualification</label>
												<div class="col-lg-8">
													<input type="text" name="qualification" id="qualification"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Stream</label>
												<div class="col-lg-8">
													<input type="text" name="designation" id="designation"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">School /
													College / Company in</label>
												<div class="col-lg-8">
													<input type="text" name="currentlyin" id="currentlyin"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Home Phone /
													Alt contact</label>
												<div class="col-lg-8">
													<input type="text" name="homephone" id="homephone"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Course
													Interested</label>
												<div class="col-lg-8">
												<select name = "courseinterestedin"  id = "courseinterestedin" class = "form-control">
													<option value = "Code Java" >Core Java</option>
													<option value=  "Android" >Android</option>
													<option value=  "Other">Other</option>
												
												</select>
												<div id = "other" style = "display:none;">
												<input type = "text" name= "courseinterestedino" class = "form-control"/>
												</div>
												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Address /
													Location</label>
												<div class="col-lg-8">
													<input type="text" name="address" id="address"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Tele caller</label>
												<div class="col-lg-8">
													<input type="text" name="telecaller" id="telecaller"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Counsiller</label>
												<div class="col-lg-8">
													<input type="text" name="counsiller" id="counsiller"
														class="form-control parsley-validated">

												</div>
											</div>											
																					
											<div class="form-group">
												<label class="col-lg-3 control-label">Notes for
													staff</label>
												<div class="col-lg-8">
													<input type="text" name="notes" id="notes"
														class="form-control parsley-validated">

												</div>
											</div>
											<div class="form-group">
												<label class="col-lg-3 control-label">Status</label>
												<div class="col-lg-8">
													<select name="status" id="status" data-required="true" class = "form-control">
														<option value="">Please Choose</option>
														<option value="NEW">Enquiry Only</option>
														<option value="REGISTERED">Registered</option>
														<option value="NI">Not Interested</option>
													</select>
												</div>
											</div> 
											<div class="form-group">
												<label class="col-lg-3 control-label">Follow on (if
													enquiry only)</label>
												<div class="col-lg-8">
													<input type="text" name="date" id="date"
														class="form-control parsley-validated datepicker">
												</div>
											</div>
											<div class="form-group">
												<div class="col-lg-offset-2 col-lg-10">
													<input type="submit" value="Save"
														class="btn btn-success">
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
		
		<script>
		function getmobilenumber(mn){
			loadold(mn,"mobile");
		}
		function getemail(e){
			loadold(e,"email");
		}
		function loadold(d,t){
			var xmlhttp;
			xmlhttp = new XMLHttpRequest();
			xmlhttp.onreadystatechange=function(){
				if(xmlhttp.readyState==4&&xmlhttp.status==200){
					console.log($.trim(xmlhttp.responseText));
					var jsontext  = JSON.parse($.trim(xmlhttp.responseText));
					for (var i = 0; i < jsontext.enq.length; i++) {
						 var counter = jsontext.enq[i];
						 document.getElementById("name").value = counter.name;
						 document.getElementById("email").value = counter.email;
						 document.getElementById("qualification").value = counter.qualification;
						 
						 document.getElementById("designation").value = counter.stream;
						 document.getElementById("currentlyin").value = counter.currentlyin;
						 document.getElementById("homephone").value = counter.homephone;
						 document.getElementById("address").value = counter.address;
						 document.getElementById("mobile").value = counter.mobile;
						
					}
				}
			}
			if(t=="mobile"){
			xmlhttp.open("GET","getoldenq.jsp?mobile="+d,true);
			}else if(t=="email")
				{
				xmlhttp.open("GET","getoldenq.jsp?email="+d,true);
				}
			
			xmlhttp.send();
			
		
		}
		
		</script>
<script>
$(document).ready(function(){
	//Contact Details Update Start
	$("#newempdetadd")
			.submit(
					function() {
						
						
							if($('input[name=type]:checked').length<=0)
						{
							 alert("Kindly Select Radio button")
							}
						
						$('#newempdetadd').parsley('validate');

						if ($('#newempdetadd')
								.parsley('isValid')) {

						} else {
							$.gritter
									.add({
										title : 'Fill Fields',
										text : 'Oops Please Fill All Fields'
									});
							return false;
						}

						var str = $(this)
								.serialize();

						$
								.ajax({
									url : "../Ajax/newenquiry.jsp",
									type : "POST",
									data : str,
									success : function(
											data,
											textStatus,
											jqXHR) {
										if (data == 1) {
											$.gritter
													.add({
														title : 'Success',
														text : 'new Enquiry Added'
													});
											window.location
													.reload();
										} else {
											$.gritter
													.add({
														title : 'Sorry',
														text : 'Some Error Occured, Please Try Again.'
													});
										}
									},
									error : function(
											jqXHR,
											textStatus,
											errorThrown) {
										alert("Sorry, Error.");
										$.gritter
												.add({
													title : 'Sorry',
													text : 'Some Error Occured, Please Try Again.'
												});

									}
								});
						return false;

					});
	//End Contact Details Update

});


</script>
<%@include file="../Common/Footer.jsp"%>