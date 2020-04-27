<%-- 
    Document   : pds_raise_requisition
    Created on : May 2, 2016, 6:36:27 PM
    Author     : 590685
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>

    <head>
        <script src="${pageContext.request.contextPath}/jquery-ui-1.10.4.custom/development-bundle/jquery-1.10.2.js"></script>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/TableCSSCode.css" />
        <script>
           
            function noBack()
            {
                window.history.forward();
            }

           
        </script>

    </head>
    <body>

        <%          int count = 1;
                    String error_msg = "";
                    Object error = request.getAttribute("message");
                    if (error != null) {
                        error_msg = error.toString();
                    }
        %>

        <jsp:include page="MenuHead_PDS.jsp" flush="true" />
        <br>
        <fieldset style="border-color: black;  background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">

            <legend style="padding: 8px; border-radius: 20px; background-color: #006600; color: white">
                Raise Requisition
            </legend>

            <form id="validationform" name="validationform" method="post" action="">

                <%if (!error_msg.equalsIgnoreCase("")) {%>
                <center><div class="info" id="errorMessage"><center><%= error_msg%></center></div></center>
                <% }%>
                <br>

                <div id="amend" style="display: block;">
                    <center>
                        <table>
                            <tr>
                                <td>Name: </td>
                                <td> <input type="text" name="custName" id="custName" /></td>
                                <td><input type="button"  value="Search" onclick="javascript:popup_member(220, 180,document.validationform.custId.value, document.validationform.custName.value)" /></td>
                            </tr>
                            <tr>
                                <td>Member ID: </td>
                                <td><input type="text" name="custId" id="custId" /></td>

                                <td><input type="button"  value="Search" onclick="javascript:popup_member(220, 180, document.validationform.custId.value, document.validationform.custName.value);" /></td>
                            </tr>
                        </table>
                </div>

                <br>
                <br>

                <div id="create" style="display:block;">
                    <hr>
                    <center>
                        <table id="order-list" style="margin-left: 95px;">
                            <thead class="CSSTableGenerator" >
                                <tr>
                                    <td></td>
                                    <td>Product Name</td>
                                    <td>Price</td>
                                    <td></td>
                                    <td>Quantity</td>
                                    <td>Total</td>

                                </tr>
                            </thead>

                            <tbody>
                                <tr>
                                    <td align="center"><input type="checkbox" name="check<%=count%>" id="check<%=count%>"></td>
                                    <td><input type="text" id="product<%=count%>" name="product<%=count%>"></td>
                                    <td><input type="text" readonly ="true" name="price<%=count%>" id="price<%=count%>" onchange="Total(<%=count%>);"></td>
                                    <td><input type="button" name="SearchProduct<%=count%>" id="SearchProduct<%=count%>" value="Search"  onclick="SearchProduct(600,200,<%=count%>)" /></td>
                                    <td><input type="text" name="quantity<%=count%>" id="quantity<%=count%>" onchange="Total(<%=count%>);"></td>
                                    <td><input type="text" readonly="readonly" id="linetotal<%=count%>" name="linetotal<%=count%>"></td>
                                    <td><input type="hidden" readonly="textIndex" name="textIndex" value="<%=count%>"></td>
                                    <input type="hidden" name="product_id<%=count%>" id="product_id<%=count%>"/>
                                    <input type="hidden" name="stock_id<%=count%>" id="stock_id<%=count%>"/>
                                    <input type="hidden" name="stock_quantity<%=count%>" id="stock_quantity<%=count%>"/>
                            </tr>
                            </tbody>
                        </table>
                    </center>
                    <br/><br/>
                    <center>
                        <input type="button" id="addRow" value="Add Row"/>
                        <input type="button" id="deleteRow" value="Delete Row"/>
                        <input type="button" value="Submit" onclick="submitform(validationform)"/>


                    </center>
                </div>
                <input type="hidden" name="rowCounter" id="rowCounter" value="<%=count%>">
                <input type="hidden" name="handle_id" id="handle_id" value="<%=count%>">

            </form>

            <script>

                $("#addRow").click(function(){

                    var counter = $("#rowCounter").val();
                    counter++;
                    $('#order-list tr:last').after('<tr> <td align="center"><input type="checkbox" name="check'+counter+'" id="check'+counter+'"/></td><td><input type="text" id="product'+counter+'" name="product'+counter+'"/></td><td><input type="text" id="price'+counter+'" readonly ="true" name="price'+counter+'" onchange="Total('+counter+')"/></td><td><input type="button" name="SearchProduct'+counter+'" id="SearchProduct'+counter+'" value="Search"  onclick="SearchProduct(600,200,'+counter+');" /></td><td><input type="text" id="quantity'+counter+'" name="quantity'+counter+'" onchange="Total('+counter+');"/><td><input type="text" id="linetotal'+counter+'" name="linetotal'+counter+'" readonly="readonly"/></td><td><input type="hidden" name="textIndex" value="'+counter+'"/></td><td><input type="hidden" name="product_id'+counter+'" id="product_id'+counter+'"/></td> <td><input type="hidden" name="stock_id'+counter+'" id="stock_id'+counter+'"/></td> <td><input type="hidden" name="stock_quantity'+counter+'" id="stock_quantity'+counter+'"/></td></tr>');
                    $("#rowCounter").val(counter);

                });



                $("#deleteRow").click(function () {

                    var rowcount = $("#rowCounter").val();
                    if (rowcount == 1) {

                        return false;
                    }
                    var value = $('input:checkbox:checked').length;
                    rowcount = rowcount - value;
                    if (rowcount == 0) {
                        
                        return false;
                    }
                    $("#rowCounter").val(rowcount);
                    $('input:checkbox:checked').closest('tr').remove();




                });

                function submitform(validationform)
                {
                    if (checkDiv(validationform))
                    {
                        document.forms[0].handle_id.value="Create";
                        document.forms[0].action='/PacsApplication/RaiseRequisitionServlet';
                        document.forms[0].submit();
                    }
                }

                function checkDiv(validationform)
                {

                    var counter = document.forms[0].rowCounter.value;


                    for(var i=1; i<=counter; i++){

                        var productDetails = document.getElementById("product"+i).value;
                        var priceDetails = document.getElementById("price"+i).value;
                        var quantityDetails = document.getElementById("quantity"+i).value;
                        var quantityAvailable = document.getElementById("stock_quantity"+i).value;
                        var linetotalDetails = document.getElementById("linetotal"+i).value;
                        var restQuantity = quantityAvailable - quantityDetails;
                    if(restQuantity<=0){
                         alert(quantityDetails +" Items Is Not Available");
                         return false;
                    }


                        if(productDetails=="" || priceDetails=="" || quantityDetails=="" || linetotalDetails==""){

                            alert("All Fields are mandetory");
                            return false;
                        }

                    }

                    return true;

                }

                function popup_member(width, height, cifNumber,cifName) {
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
                    var screenName = "raiseRequisition.jsp";
                    var  lovKey="memberDetails"
                    popWin = open('CommonSearchInformationLOV.jsp?cifNumber=' + cifNumber + '&cifName=' + cifName +'&screenName=' + screenName+'&lovKey='+lovKey, 'memberDetails', attr);
                    popWin.focus();

                }

                function Total(i){

                    var priceDetails = document.getElementById("price"+i).value;
                    var quantityDetails = document.getElementById("quantity"+i).value;

                    document.getElementById("linetotal"+i).value=priceDetails*quantityDetails;

                }

                function SearchProduct(width, height,i)
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
                    var screenName = "raiseRequisition.jsp";
                    var  lovKey="PdsProductSearch"
                    popWin = open('CommonSearchInformationLOV.jsp?screenName=' + screenName+'&lovKey='+lovKey+'&textIndex='+i , 'ProductSearch', attr);
                    popWin.focus();

                }

            </script>
        </fieldset>
    </body>
</html>