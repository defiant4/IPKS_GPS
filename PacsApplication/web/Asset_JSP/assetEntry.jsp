<%-- 
    Document   : assetentry
    Created on : Jun 24, 2016, 2:34:00 PM
    Author     : Tcs Helpdesk10
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="DataEntryBean.pdsStockRegisterBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="LoginDb.DbHandler"%>


<html>

    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script src="${pageContext.request.contextPath}/js/Calendar.js"></script>
        <script>

            function noBack()
            {
                window.history.forward();
            }
            function submitform(assetentry)
            {
                if (checkDiv(assetentry))
                {
                    
                    document.forms[0].action='/PacsApplication/AssetEntryServlet';
                    document.forms[0].submit();
                }
            }
            
            function checkDiv(assetentry)
            {

                var counter = document.forms[0].rowCounter.value;
                
                for(var i=1; i<=counter; i++){
                   
                    
                    
                    var description = document.getElementById("description"+i).value; 
                    var current_valuation= document.getElementById("curr_val"+i).value; 
                    var mode_of_aquirement= document.getElementById("mode_of_aqr"+i).value;
                   
                    if(description=="" || current_valuation==""||mode_of_aquirement==""){

                        alert("All Fields are mandatory");
                        return false;
                    }
                    
                    re = /^\d+$/; //this checks whether field contains digits   
                    if (!re.test(document.getElementById("curr_val"+i).value))
                    {
                    alert("!! current valuation rate could only contain numbers !!");
                    
                    return false;
                     }

                }
                
                return true;

            }
            
            
        </script>
    </head>
    <body onload="noBack()">

        <%          int count = 1;
                    String error_msg = "";
                    Object error = request.getAttribute("message");
                    if (error != null) {
                        error_msg = error.toString();
                    }
        %>
        <%!
            String blankNull(String s) {
                return (s == null) ? "" : s;
            }
        %>

        <%
                    Object alpdsStockRegisterBeanApendObj = request.getAttribute("alpdsStockRegisterBeanApend");
                    ArrayList<pdsStockRegisterBean> alpdsStockRegisterBeanApend = new ArrayList<pdsStockRegisterBean>();
                    if (alpdsStockRegisterBeanApendObj != null) {
                        alpdsStockRegisterBeanApend = (ArrayList<pdsStockRegisterBean>) request.getAttribute("alpdsStockRegisterBeanApend");
                    }
        %>

        <%
                    String displayFlag = "";
                    Object display = request.getAttribute("displayFlag");
                    if (display != null) {
                        displayFlag = display.toString();
                    }
        %>

        <jsp:include page="MenuHead_ASSET.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                ASSET ENTRY
            </legend>

            <form id="assetentry" name="assetentry" method="post">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                <% }%>
                <br>

                
                <br>
                <div id="enterStock">
                    <center>
                    <table id="order-list"  >
                        <thead  class="CSSTableGenerator" >
                            <tr>
                                <td></td>
                                <td colspan="2">Asset Type</td>
                                <td>Asset SubType</td>
                                <td>Asset ID</td>
                                <td>Description</td>
                                <td>Current Valuation</td>
                                <td>Mode of Aquirement</td>
                                

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="chckbox<%=count%>" id="chckbox<%=count%>" /></td>
                                <td><input type="text" name="asset_type<%=count%>" id="asset_type<%=count%>"/></td>
                                <td><input type="button" name="SearchAsset<%=count%>" id="SearchAsset<%=count%>" value="Search"  onclick="SearchAsset(220,180,<%=count%>)" /></td>
                                <td><input type="text" name="asset_subtype<%=count%>" id="asset_subtype<%=count%>"/></td>
                                <td><input type="text" name="asset_id<%=count%>" id="asset_id<%=count%>"/></td>
                                <td><input type="text" name="description<%=count%>" id="description<%=count%>"/></td>
                                <td><input type="text" name="curr_val<%=count%>" id="curr_val<%=count%>" onchange="Total(<%=count%>);"/></td>
                                <td><select style="width: 153px;" name="mode_of_aqr<%=count%>" id="mode_of_aqr<%=count%>"><option disabled selected>please select</option>
                                    <option value="P">purchase</option>
                                    <option value="D">donation</option>
                                    <option value="O">others</option>
                                    </select></td>
                                
                                <td><input type="hidden" name="asset_mst_id<%=count%>" id="asset_mst_id<%=count%>"/></td>
                                <td><input type="hidden" readonly="textIndex" name="textIndex" value="<%=count%>"/></td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="javascript:submitform(assetentry)"/>
                        <input type="button" value="Reset" onclick="ShowParent();" />


                    </center>
                    <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                    </center>
                </div>
                <br>
                
            </form>
            <script>

                $("#addRow").click(function(){

                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td align="center"><input type="checkbox" name="chckbox'+counter+'" id="chckbox'+counter+'"/></td><td><input type="text" id="asset_type'+counter+'" name="asset_type'+counter+'"/></td><td><input type="button" name="SearchAsset'+counter+'" id="SearchAsset'+counter+'" value="Search"  onclick="SearchAsset(220,180,'+counter+');" /></td><td><input type="text" name="asset_subtype'+counter+'" id="asset_subtype'+counter+'"/></td><td><input type="text" name="asset_id'+counter+'" id="asset_id'+counter+'" /></td><td><input type="text" id="description'+counter+'" name="description'+counter+'"/></td><td><input type="text" id="curr_val'+counter+'" name="curr_val'+counter+'"/></td><td><select style="width: 153px;" name="mode_of_aqr'+counter+'" id="mode_of_aqr'+counter+'"><option disabled selected>please select</option><option value="p">purchase</option><option value="d">donation</option><option value="o">others</option></select></td><td><input type="hidden" name="asset_mst_id'+counter+'" id="asset_mst_id'+counter+'"/></td> </tr>');
                    $("#rowCounter").val(counter);

                });
                $( "#deleteRow" ).click(function() {

                    $('input:checkbox:checked').closest('tr').remove();

                });


                
                function ShowCalender(i){

                    getCalendar(document.getElementById("purchaseDate"+i));
                }

                function SearchAsset(width, height,i)
                {

                    if (window.innerWidth) {
                        LeftPosition = (window.innerWidth - width) / 2;
                        TopPosition = ((window.innerHeight - height) / 2) - 20;
                    }
                    else {
                        LeftPosition = (parseInt(window.screen.width) - width) / 2;
                        TopPosition = ((parseInt(window.screen.height) - height) / 2) - 20;
                    }
                    attr = 'resizable=yes,scrollbars=yes,width=' + width + ',height=' +
                        height + ',screenX=300,screenY=200,left=' + LeftPosition + ',top=' +
                        TopPosition + '';
                    var screenName = "assetEntry.jsp";
                    var  lovKey="AssetCodeSearch"
                    popWin = open('${pageContext.request.contextPath}/CommonSearchInformation_ASSET_LOV.jsp?screenName=' + screenName+'&lovKey='+lovKey+'&textIndex='+i , 'ProductSearch', attr);
                    popWin.focus();

                }

                function ShowParent()
                {
                    document.forms[0].action="${pageContext.request.contextPath}/Asset_JSP/assetEntry.jsp";
                    document.forms[0].submit();
                }
            </script>
        </fieldset>
    </body>
</html>

