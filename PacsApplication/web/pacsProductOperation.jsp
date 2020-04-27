<%-- 
    Document   : IdentificationDetails
    Created on : Aug 3, 2015, 2:25:40 PM
    Author     : Administrator
--%>
<%@page import="DataEntryBean.pacsProductOperationBean" %>
<%@page import="java.sql.SQLException"%>
<%@page import="LoginDb.DbHandler"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Identification Details</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />

    </head>
    <body  onload="noBack()">
        <script type="text/javascript">
            function noBack()
            {
                window.history.forward();
            }


            function checkCreateDiv(pacsOperation)
            {
                if (pacsOperation.productname.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.productname.focus();
                    return false;
                }
                if (pacsOperation.productdescription.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.productdescription.focus();
                    return false;
                }
                if (pacsOperation.productcode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.productcode.focus();
                    return false;
                }
                if (pacsOperation.inttcategory.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.inttcategory.focus();
                    return false;
                }
                if (pacsOperation.intcatdescription.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.intcatdescription.focus();
                    return false;
                }
                if (pacsOperation.segmentCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.segmentCode.focus();
                    return false;
                }
                if (pacsOperation.status.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.status.focus();
                    return false;
                }
                if (pacsOperation.minbal.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.minbal.focus();
                    return false;
                }
                if (pacsOperation.maxbal.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.maxbal.focus();
                    return false;
                }
                if (pacsOperation.intrate.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                if (pacsOperation.inttmethod.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.inttmethod.focus();
                    return false;
                }
                if (pacsOperation.inttfrequency.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.inttfrequency.focus();
                    return false;
                }
                if (pacsOperation.glCode.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.glCode.focus();
                    return false;
                }
                if (pacsOperation.odindicator.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.odindicator.focus();
                    return false;
                }
                if (pacsOperation.maxlimit.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.maxlimit.focus();
                    return false;
                }
                if (pacsOperation.drawingpower.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.drawingpower.focus();
                    return false;
                }
                if (pacsOperation.penalinttrate.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.penalinttrate.focus();
                    return false;
                }
                if (pacsOperation.penalinttmethod.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.penalinttmethod.focus();
                    return false;
                }
                if (pacsOperation.penalinttfrequency.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.penalinttfrequency.focus();
                    return false;
                }
                if (pacsOperation.creditComp1.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.creditComp1.focus();
                    return false;
                }
                if (pacsOperation.creditComp2.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.creditComp2.focus();
                    return false;
                }
                if (pacsOperation.debitComp1.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.debitComp1.focus();
                    return false;
                }
                if (pacsOperation.debitComp2.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.debitComp2.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.productcode.value))
                {
                    alert("!! ProductType could only contain numbers !!");
                    pacsOperation.productcode.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.inttcategory.value))
                {
                    alert("!! INTT Category could only contain numbers !!");
                    pacsOperation.inttcategory.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.minbal.value))
                {
                    alert("!! minbal could only contain numbers !!");
                    pacsOperation.minbal.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.maxbal.value))
                {
                    alert("!! maxbal could only contain numbers !!");
                    pacsOperation.maxbal.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.penalinttrate.value))
                {
                    alert("!! penalinttrate could only contain numbers !!");
                    pacsOperation.penalinttrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.maxlimit.value))
                {
                    alert("!! maxlimit could only contain numbers !!");
                    pacsOperation.maxlimit.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.intrate.value))
                {
                    alert("!! intrate could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.creditComp1.value))
                {
                    alert("!! Credit Comp1 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.creditComp2.value))
                {
                    alert("!! Credit Comp2 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.debitComp1.value))
                {
                    alert("!! Debit Comp1 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.debitComp2.value))
                {
                    alert("!! Debit Comp2 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                return true;
            }


            function checkUpdateDiv(pacsOperation)
            {   
                if (pacsOperation.productnameAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.productnameAmend.focus();
                    return false;
                }
                if (pacsOperation.productdescriptionAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.productdescriptionAmend.focus();
                    return false;
                }
                if (pacsOperation.productcodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.productcodeAmend.focus();
                    return false;
                }
                if (pacsOperation.inttcategoryAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    pacsOperation.inttcategoryAmend.focus();
                    return false;
                }
                if (pacsOperation.intcatdescriptionAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.intcatdescriptionAmend.focus();
                    return false;
                }
                if (pacsOperation.segmentCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.segmentCodeAmend.focus();
                    return false;
                }
                if (pacsOperation.statusAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.statusAmend.focus();
                    return false;
                }
                if (pacsOperation.effectDateAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.effectDateAmend.focus();
                    return false;
                }
                if (pacsOperation.minbalAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.minbalAmend.focus();
                    return false;
                }
                if (pacsOperation.maxbalAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.maxbalAmend.focus();
                    return false;
                }
                if (pacsOperation.intrateAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.intrateAmend.focus();
                    return false;
                }
                if (pacsOperation.inttmethodAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.inttmethodAmend.focus();
                    return false;
                }
                if (pacsOperation.inttfrequencyAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.inttfrequencyAmend.focus();
                    return false;
                }
                if (pacsOperation.glCodeAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.glCodeAmend.focus();
                    return false;
                }
                if (pacsOperation.odindicatorAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.odindicatorAmend.focus();
                    return false;
                }
                if (pacsOperation.maxlimitAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.maxlimitAmend.focus();
                    return false;
                }
                if (pacsOperation.drawingpowerAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.drawingpowerAmend.focus();
                    return false;
                }
                if (pacsOperation.penalinttrateAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.penalinttrateAmend.focus();
                    return false;
                }
                if (pacsOperation.penalinttmethodAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.penalinttmethodAmend.focus();
                    return false;
                }
                if (pacsOperation.penalinttfrequencyAmend.value == "")
                {
                    alert("!! All fields must be filled !!");
                   
                    pacsOperation.penalinttfrequencyAmend.focus();
                    return false;
                }
                if (pacsOperation.creditComp1Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.creditComp1Amend.focus();
                    return false;
                }
                if (pacsOperation.creditComp2Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.creditComp2Amend.focus();
                    return false;
                }
                if (pacsOperation.debitComp1Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.debitComp1Amend.focus();
                    return false;
                }
                if (pacsOperation.debitComp2Amend.value == "")
                {
                    alert("!! All fields must be filled !!");
                    
                    pacsOperation.debitComp2Amend.focus();
                    return false;
                }

                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.minbalAmend.value))
                {
                    alert("!! minbal could only contain numbers !!");
                    pacsOperation.minbalAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.maxbalAmend.value))
                {
                    alert("!! maxbal could only contain numbers !!");
                    pacsOperation.maxbalAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.penalinttrateAmend.value))
                {
                    alert("!! penalinttrate could only contain numbers !!");
                    pacsOperation.penalinttrateAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.maxlimitAmend.value))
                {
                    alert("!! maxlimit could only contain numbers !!");
                    pacsOperation.maxlimitAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.intrateAmend.value))
                {
                    alert("!! intrate could only contain numbers !!");
                    pacsOperation.intrateAmend.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.creditComp1Amend.value))
                {
                    alert("!! Credit Comp1 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.creditComp2Amend.value))
                {
                    alert("!! Credit Comp2 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.debitComp1Amend.value))
                {
                    alert("!! Debit Comp1 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                re = /^(?=.*\d)\d*(?:\.\d*)?$/; //this checks whether field contains digits
                if (!re.test(pacsOperation.debitComp2Amend.value))
                {
                    alert("!! Debit Comp2 could only contain numbers !!");
                    pacsOperation.intrate.focus();
                    return false;
                }
                return true;
            }

            function submitform(pacsOperation)
            {
                if (checkCreateDiv(pacsOperation))
                {
                    document.forms[0].handle_id.value = "Create";
                    pacsOperation.submit();
                }

            }

            function updateform(pacsOperation)
            {

                if (checkUpdateDiv(pacsOperation))
                {
                    document.forms[0].handle_id.value = "Update";
                    pacsOperation.submit();

                }

            }

            function searchProduct() {

                document.forms[0].handle_id.value = "Search";
                document.forms[0].action = '/PacsApplication/pacsProductOperationServlet';
                document.forms[0].submit();

            }

            function checkop()
            {
                if (document.getElementById("checkOption").value == "create")
                {
                    document.getElementById('create').style.display = 'block';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';



                }
                if (document.getElementById("checkOption").value == "amend")
                {
                    document.getElementById('amend').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('active').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';



                }
                if (document.getElementById("checkOption").value == "active")
                {
                    document.getElementById('active').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }
                if (document.getElementById("checkOption").value == "deactive")
                {
                    document.getElementById('active').style.display = 'block';
                    document.getElementById('create').style.display = 'none';
                    document.getElementById('amend').style.display = 'none';
                    document.getElementById('amend2').style.display = 'none';


                }

            }
            function ActvDeactv() {

                document.forms[0].handle_id.value = "StatusSearch";
                document.forms[0].action = '/PacsApplication/pacsProductOperationServlet';
                document.forms[0].submit();

            }



        </script>
        <jsp:include page="MenuHead.jsp" flush="true" />
        <br>

        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
            Object PacsProductOperationBeanobj = request.getAttribute("oPacsProductOperationBeanObj");
            pacsProductOperationBean oPacsProductOperationBean = new pacsProductOperationBean();
            if (PacsProductOperationBeanobj != null) {
                oPacsProductOperationBean = (pacsProductOperationBean) request.getAttribute("oPacsProductOperationBeanObj");

            }
        %>

        <%
            String error_msg = "";
            Object error = request.getAttribute("message");
            if (error != null) {
                error_msg = error.toString();
            }
        %>

        <%
            String displayFlag = "";
            Object display = request.getAttribute("displayFlag");
            if (display != null) {
                displayFlag = display.toString();
            }
        %>

        <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">PACS PRODUCT OPERATION</legend>

            <form name="pacsOperation" method="post" action="pacsProductOperationServlet">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>       
                            <% }%>
                <br>
                <br>

                <center><lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Operation Selection</lable>
                    <select id="checkOption" onchange="checkop()" name="checkOption" >
                        <option value="" disabled selected style="display:none;" >--select--</option>
                        <option value="create" >Create</option>
                        <option value="amend" >Amend</option>
                        <option value="active" >Active/De-Active </option>
                    </select>
                </center>
                <br>

                <div id="create" style="display:none;">

                    <table>
                        <tbody>
                            <tr>
                                <td>Product Name:</td>
                                <td><input type="text"  name="productname" size="20" /></td>
                            </tr>
                            <tr>
                                <td>Product Description:</td>
                                <td><input type="text"  name="productdescription" size="20" /></td>
                            </tr>
                            <tr>
                                <td>Product Code:</td>
                                <td><input type="text"  name="productcode" maxlength="4" size="10"  /></td>
                            </tr>
                            <tr>
                                <td>INTT Category:</td>
                                <td><input type="text"  name="inttcategory" maxlength="4" size="10" /></td>
                            </tr>
                            <tr>
                                <td>INTCAT Description:</td>
                                <td><input type="text"  name="intcatdescription" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Segment Code:</td>
                                <td>
                                    <select id="segmentCode" name="segmentCode">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="0706">0706:INDIVIDUAL</option>
                                        <option value="0306">0306:STAFF</option>
                                        <option value="5003">5003:SENIOR CITIZEN</option>
                                        <option value="5010">5010:SHG</option>
                                        <option value="5000">5000:BANKS</option>
                                        <option value="5009">5009:INSTITUTIONS</option>
                                        <option value="5050">5050:OTHERS</option>
                                        <option value="5007">5007:SOCIETY</option>
                                        <option value="5011">5011:GOV/SEMI GOV</option>
                                        <option value="5012">5012:PACS</option>
                                        <option value="5013">5013:UCB</option>
                                        <option value="5014">5014:SCB</option>
                                        <option value="5015">5015:CCB</option>
                                    </select>
                                </td>

                            </tr>
                            <tr>
                                <td>Credit Comp1:</td>
                                <td><input type="text"  name="creditComp1" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Credit Comp2:</td>
                                <td><input type="text"  name="creditComp2" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Debit Comp1:</td>
                                <td><input type="text"  name="debitComp1" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Debit Comp2:</td>
                                <td><input type="text"  name="debitComp2" size="15" /></td>
                            </tr>
                            <tr>
                                <td>Status:</td>
                                <td><select name="status" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="A">Active</option>
                                        <option value="I">Inactive</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>MIN BAL:</td>
                                <td><input type="text"  name="minbal"  size="10"/></td>
                            </tr>
                            <tr>
                                <td>MAX BAL:</td>
                                <td><input type="text"  name="maxbal" size="10" /></td>
                            </tr>
                            <tr>
                                <td>INTT Rate:</td>
                                <td><input type="text" name="intrate" size="10" /></td>
                            </tr>
                            <tr>
                                <td>INTT Method: </td>
                                <td>
                                    <select name="inttmethod">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="S">Simple</option>
                                        <option value="C">Compound</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>INTT Frequency: </td>
                                <td>
                                    <select name="inttfrequency" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="D">Daily</option>
                                        <option value="M">Monthly</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>GL Code:</td>
                                <td>
                                    <select name="glCode" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <%
                                            Connection connection = null;
                                            ResultSet rs = null;
                                            Statement statement = null;
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select gl_code,gl_name,id from gl_product");
                                                while (rs.next()) {%>
                                        <option value="<%=rs.getString(3)%>"><%=rs.getString(1) + ":" + rs.getString(2)%></option>
                                        <%}
                                                statement.close();
                                                connection.close();
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>OD Indicator:</td>
                                <td>
                                    <select name="odindicator" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Max Limit:</td>
                                <td><input type="text" name="maxlimit" size="10" /></td>
                            </tr>
                            <tr>
                                <td>Drawing Power:</td>
                                <td>
                                    <select name="drawingpower">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Penal INTT Rate:</td>
                                <td><input type="text" name="penalinttrate" size="10" /></td>
                            </tr>
                            <tr>
                                <td>Penal INTT Method: </td>
                                <td>
                                    <select name="penalinttmethod">                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="S">Simple</option>
                                        <option value="C">Compound</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Penal INTT Frequency: </td>
                                <td>
                                    <select name="penalinttfrequency" >                
                                        <option value="" disabled selected style="display:none;">--Select--</option>
                                        <option value="D">Daily</option>
                                        <option value="M">Monthly</option>
                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table><br><br>
                    <center>
                        <input type="button" value="Submit" onclick="javascript:submitform(pacsOperation)">
                        <input type="reset" value="Reset" name="reset" />
                    </center>
                    <p style=" font-family: Berlin Sans FB; font-weight:  normal;"> All fields are mandatory </p>

                </div>

                <div id="amend" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter Product Code: </lable>
                        <input type="text" name="productcodeSearch"/>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter INTT Category: </lable>
                        <input type="text" name="intcatSearch"/>
                        <input type="button"  value="Search" onclick="javascript:searchProduct()" />
                    </center><br>
                </div>

                <%if (displayFlag.equalsIgnoreCase("Y")) {%>                

                <div id="amend2" >

                    <table>
                        <tbody>
                            <tr>
                                <td>Product Name:</td>
                                <td><input type="text"  name="productnameAmend" size="20" value="<%=blankNull(oPacsProductOperationBean.getProductname())%>" /></td>
                            </tr>
                            <tr>
                                <td>Product Description:</td>
                                <td><input type="text" readonly="true"  name="productdescriptionAmend" size="20" value="<%=blankNull(oPacsProductOperationBean.getProductdescription())%>"/></td>
                            </tr>
                            <tr>
                                <td>Product Code:</td>
                                <td><input type="text" raedonly="true"  name="productcodeAmend" maxlength="4" size="10"  value="<%=blankNull(oPacsProductOperationBean.getProductcode())%>" /></td>
                            </tr>
                            <tr>
                                <td>INTT Category:</td>
                                <td><input type="text" readonly="true"  name="inttcategoryAmend" maxlength="4" size="10" value="<%=blankNull(oPacsProductOperationBean.getInttcategory())%>"/></td>
                            </tr>
                            <tr>
                                <td>INTCAT Description:</td>
                                <td><input type="text" readonly="true"  name="intcatdescriptionAmend" size="15" value="<%=blankNull(oPacsProductOperationBean.getIntcatdescription())%>" /></td>
                            </tr>
                            <tr>
                                <td>Segment Code:</td>
                                <td><select id="segmentCodeAmend" name="segmentCodeAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getSegmentCode().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="0706" <%if (oPacsProductOperationBean.getSegmentCode().equals("0706")) {%> selected <%}%>>0706:INDIVIDUAL</option>
                                        <option value="0306" <%if (oPacsProductOperationBean.getSegmentCode().equals("0306")) {%> selected <%}%>>0306:STAFF</option>
                                        <option value="5003" <%if (oPacsProductOperationBean.getSegmentCode().equals("5003")) {%> selected <%}%>>5003:SENIOR CITIZEN</option>
                                        <option value="5010" <%if (oPacsProductOperationBean.getSegmentCode().equals("5010")) {%> selected <%}%>>5010:SHG</option>
                                        <option value="5000" <%if (oPacsProductOperationBean.getSegmentCode().equals("5000")) {%> selected <%}%>>5000:BANKS</option>
                                        <option value="5009" <%if (oPacsProductOperationBean.getSegmentCode().equals("5009")) {%> selected <%}%>>5009:INSTITUTIONS</option>
                                        <option value="5050" <%if (oPacsProductOperationBean.getSegmentCode().equals("5050")) {%> selected <%}%>>5050:OTHERS</option>
                                        <option value="5007" <%if (oPacsProductOperationBean.getSegmentCode().equals("5007")) {%> selected <%}%>>5007:SOCIETY</option>
                                        <option value="5011" <%if (oPacsProductOperationBean.getSegmentCode().equals("5011")) {%> selected <%}%>>5011:GOV/SEMI GOV</option>
                                        <option value="5012" <%if (oPacsProductOperationBean.getSegmentCode().equals("5012")) {%> selected <%}%>>5012:PACS</option>
                                        <option value="5013" <%if (oPacsProductOperationBean.getSegmentCode().equals("5013")) {%> selected <%}%>>5013:UCB</option>
                                        <option value="5014" <%if (oPacsProductOperationBean.getSegmentCode().equals("5014")) {%> selected <%}%>>5014:SCB</option>
                                        <option value="5015" <%if (oPacsProductOperationBean.getSegmentCode().equals("5015")) {%> selected <%}%>>5015:CCB</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Credit Comp1:</td>
                                <td><input type="text"  name="creditComp1Amend" size="15" value="<%=blankNull(oPacsProductOperationBean.getCreditComp1())%>"/></td>
                            </tr>
                            <tr>
                                <td>Credit Comp2:</td>
                                <td><input type="text"  name="creditComp2Amend" size="15" value="<%=blankNull(oPacsProductOperationBean.getCreditComp2())%>"/></td>
                            </tr>
                            <tr>
                                <td>Debit Comp1:</td>
                                <td><input type="text"  name="debitComp1Amend" size="15" value="<%=blankNull(oPacsProductOperationBean.getDebitComp1())%>"/></td>
                            </tr>
                            <tr>
                                <td>Debit Comp2:</td>
                                <td><input type="text"  name="debitComp2Amend" size="15" value="<%=blankNull(oPacsProductOperationBean.getDebitComp2())%>"/></td>
                            </tr>
                            <tr>
                                <td>Status:</td>
                                <td><select name="statusAmend" id="statusAmend"  readonly="true" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getStatus().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="A" <%if (oPacsProductOperationBean.getStatus().equals("A")) {%> selected <%}%>>Active</option>
                                        <option value="I" <%if (oPacsProductOperationBean.getStatus().equals("I")) {%> selected <%}%>>Inactive</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Effective Date:</td>
                                <td><input type="text"  name="effectDateAmend" maxlength="11" size="10" readonly="true" value="<%=blankNull(oPacsProductOperationBean.getEffectDate())%>"/></td>
                            </tr>
                            <tr>
                                <td>MIN BAL:</td>
                                <td><input type="text" size="10"  name="minbalAmend" value="<%=blankNull(oPacsProductOperationBean.getMinbal())%>" /></td>
                            </tr>
                            <tr>
                                <td>MAX BAL:</td>
                                <td><input type="text" size="10"  name="maxbalAmend" value="<%=blankNull(oPacsProductOperationBean.getMaxbal())%>" /></td>
                            </tr>
                            <tr>
                                <td>INTT Rate:</td>
                                <td><input type="text" size="10"  name="intrateAmend" value="<%=blankNull(oPacsProductOperationBean.getIntrate())%>" /></td>
                            </tr>
                            <tr>
                                <td>INTT Method: </td>
                                <td>
                                    <select name="inttmethodAmend" id="inttmethodAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getInttmethod().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="S" <%if (oPacsProductOperationBean.getInttmethod().equals("S")) {%> selected <%}%>>Simple</option>
                                        <option value="C" <%if (oPacsProductOperationBean.getInttmethod().equals("C")) {%> selected <%}%>>Compound</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>INTT Frequency: </td>
                                <td>
                                    <select name="inttfrequencyAmend" id="inttfrequencyAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getInttfrequency().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="D" <%if (oPacsProductOperationBean.getInttfrequency().equals("D")) {%> selected <%}%>>Daily</option>
                                        <option value="M" <%if (oPacsProductOperationBean.getInttfrequency().equals("M")) {%> selected <%}%>>Monthly</option>

                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>GL Code:</td>
                                <td>
                                    <select name="glCodeAmend" id="glcodeAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getGlCode().equals("")) {%> selected <%}%>>--Select--</option>
                                        <%
                                            connection = DbHandler.getDBConnection();
                                            try {
                                                statement = connection.createStatement();
                                                rs = statement.executeQuery("select distinct(gl_code),gl_name,id from gl_product where id='" + oPacsProductOperationBean.getGlCode() + "'");
                                        %>       
                                        <option value="<%=oPacsProductOperationBean.getGlCode()%>" selected ><%while (rs.next()) {%>
                                            <%=rs.getString(1) + ":" + rs.getString(2)%>
                                            <%}%></option>
                                            <%
                                                    statement.close();
                                                    connection.close();
                                                } catch (Exception e) {
                                                }
                                            %>
                                            <%
                                                connection = DbHandler.getDBConnection();
                                                try {
                                                    statement = connection.createStatement();
                                                    rs = statement.executeQuery("select distinct(gl_code),gl_name,id from gl_product");
                                                    while (rs.next()) {%>
                                        <option value="<%=rs.getString(3)%>"><%=rs.getString(1) + ":" + rs.getString(2)%></option>
                                        <%}
                                                statement.close();
                                                connection.close();
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </select>
                                </td>
                            </tr>
                            <tr> 
                                <td>OD Indicator:</td>
                                <td>
                                    <select name="odindicatorAmend" id="odindicatorAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getOdindicator().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="Y" <%if (oPacsProductOperationBean.getOdindicator().equals("Y")) {%> selected <%}%>>Yes</option>
                                        <option value="N" <%if (oPacsProductOperationBean.getOdindicator().equals("N")) {%> selected <%}%>>No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Max Limit:</td>
                                <td><input type="text" name="maxlimitAmend"  size="10" value="<%=blankNull(oPacsProductOperationBean.getMaxlimit())%>"/></td>
                            </tr>
                            <tr>
                                <td>Drawing Power:</td>
                                <td>
                                    <select name="drawingpowerAmend" id="drawingpowerAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getDrawingpower().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="Y" <%if (oPacsProductOperationBean.getDrawingpower().equals("Y")) {%> selected <%}%>>Yes</option>
                                        <option value="N" <%if (oPacsProductOperationBean.getDrawingpower().equals("N")) {%> selected <%}%>>No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Penal INTT Rate:</td>
                                <td><input type="text" name="penalinttrateAmend" size="10" value="<%=blankNull(oPacsProductOperationBean.getPenalinttrate())%>" /></td>
                            </tr>
                            <tr>
                                <td>Penal INTT Method: </td>
                                <td>
                                    <select name="penalinttmethodAmend" id="penalinttmethodAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getPenalinttmethod().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="S" <%if (oPacsProductOperationBean.getPenalinttmethod().equals("S")) {%> selected <%}%>>Simple</option>
                                        <option value="C" <%if (oPacsProductOperationBean.getPenalinttmethod().equals("C")) {%> selected <%}%>>Compound</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Penal INTT Frequency: </td>
                                <td>
                                    <select name="penalinttfrequencyAmend" id="penalinttfrequencyAmend" >                
                                        <option value="" disabled selected style="display:none;" <%if (oPacsProductOperationBean.getPenalinttfrequency().equals("")) {%> selected <%}%>>--Select--</option>
                                        <option value="D" <%if (oPacsProductOperationBean.getPenalinttfrequency().equals("D")) {%> selected <%}%>>Daily</option>
                                        <option value="M" <%if (oPacsProductOperationBean.getPenalinttfrequency().equals("M")) {%> selected <%}%>>Monthly</option>

                                    </select>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br><br>
                    <input type="hidden" name="dep_product_id" value="<%=blankNull(oPacsProductOperationBean.getDep_product_id())%>"/>
                    <center>
                        <input type="button" value="Update" onclick="javascript:updateform(pacsOperation)">
                    </center>

                </div>      
                <%}%> 

                <div id="active" style="display: none;">
                    <center>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter Product Code: </lable>
                        <input type="text" name="productCodeActivation"/>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Enter INTT Category: </lable>
                        <input type="text" name="inttCategoryActivation"/>
                        <lable style=" font-family: Berlin Sans FB; font-weight:  normal;">Status:</lable>
                        <select id="PacsproductstatusFlag" name="PacsproductstatusFlag">                
                            <option value="" >--Select--</option>
                            <option value="A">Active</option>
                            <option value="I">Inactive</option>
                        </select>
                        <input type="button" value="Sumbit" onclick="javascript:ActvDeactv()">
                    </center> 
                </div>             

                <input type="hidden" name="handle_id" value="" />
            </form>
        </fieldset>
    </body>
</html>