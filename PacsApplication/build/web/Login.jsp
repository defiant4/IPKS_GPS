<%--
    Document   : Login
    Created on : Oct 29, 2009, 1:33:35 PM
    Author     : 590685
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<% try {
%>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge">
        <title>Integrated PACS KCC Solution</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <link type="text/css" rel="stylesheet" href="/PacsApplication/css/loginpage.css"/>
        <META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <%
             String changePasswordFlag = "";
             Object display = request.getAttribute("changePasswordFlag");
             if (display != null) {
                 changePasswordFlag = display.toString();
             }
        %>

    </head>

    <body  style="align:center" valign="center" onLoad="ChangePassword(<%=changePasswordFlag%>);
               do_Load();" >

        <%
             String error_msg = "";
             Object error = request.getAttribute("error");
             if (error != null) {
                 error_msg = error.toString();
             }
        %>


        <script language="JavaScript" type="text/javascript">

            function ChangePassword(changePasswordFlag) {

                if (changePasswordFlag!=null) {

                    alert("Your Password has been changed successfully");

                }

            }



            var inAttempt = 0;
            rnumber = rnumber =<%= session.getAttribute("rnumber")%>;
            function submitform(formT)
            {
                //alert("rnumber "+rnumber);
                if (validateForm(formT))
                {
                    if (inAttempt == 0)
                    {

                        formT.target = "_top";
                        formT.submit();
                    }
                    else
                        alert("Already submited...");
                    inAttempt++;
                }

            }


            function validateForm()
            {

                if (!checkText("User ID", document.form1.UID)) {
                    document.form1.UID.focus();

                    return false;
                }

                if (!checkText("Password", document.form1.PWD))
                {
                    document.form1.PWD.focus();

                    return false;
                }

                if (!checkText("PACSID", document.form1.PACSID))
                {
                    document.form1.PACSID.focus();

                    return false;
                }

                if (!checkText("MODULE NAME", document.form1.moduleName))
                {
                    document.form1.moduleName.focus();

                    return false;
                }

                return true;

            }


            function checkText(ale, alfanumeric)
            {
                if (isBlank(alfanumeric.value))
                {
                    alert(ale + "  cannot be blank. Enter " + ale);
                    alfanumeric.focus();
                    alfanumeric.select();
                    return false;
                }
                return true;
            }


            function checkNumberAlone(ale, amt)
            {
                var len = amt.value.length;
                if (isBlank(amt.value))
                {
                    alert(ale + " cannot be blank. Enter " + ale);
                    return false;
                }
                for (i = 0; i < len; i++)
                {
                    if (amt.value.charAt(i) < '0' || amt.value.charAt(i) > '9')
                    {
                        alert(ale + " cannot contain Characters other than Numbers");
                        return false;
                    }
                }
                return true;
            }

            function isBlank(s)
            {

                var len = s.length;
                var i;
                if (len == 0)
                    return true;

                for (i = 0; i < len; ++i)
                {
                    if (s.charAt(i) != " ")
                        return false;
                }
                return true;
            }

            function showtip2(current, e, text)
            {
                if (document.all && document.readyState == "complete")
                {
                    document.all.tooltip2.innerHTML = '<font color="BLACK"><b>' + text + '</b></font>'
                    document.all.tooltip2.style.pixelLeft = event.clientX + document.body.scrollLeft + 0
                    document.all.tooltip2.style.pixelTop = event.clientY + document.body.scrollTop + 20
                    document.all.tooltip2.style.visibility = "visible"
                }
                else if (document.layers)
                {
                    document.tooltip2.document.nstip.document.write('<font color="BLACK"><b>' + text + '</b></font>')
                    document.tooltip2.document.nstip.document.close()
                    document.tooltip2.document.nstip.left = 0
                    document.tooltip2.left = e.pageX + 10
                    document.tooltip2.top = e.pageY + 10
                    document.tooltip2.visibility = "show"
                }
            }
            function hidetip2()
            {
                if (document.all)
                    document.all.tooltip2.style.visibility = "hidden"
                else if (document.layers)
                {
                    clearInterval(currentscroll)
                    document.tooltip2.visibility = "hidden"
                }
            }
            function checkCapsLock(e)
            {
                document.all.btClear.disabled = false;
                var myKeyCode = 0;
                var myShiftKey = false;

                // Internet Explorer 4+
                if (document.all)
                {
                    myKeyCode = e.keyCode;
                    myShiftKey = e.shiftKey;
                }

                // Netscape 4
                else if (document.layers)
                {
                    myKeyCode = e.which;
                    myShiftKey = (myKeyCode == 16) ? true : false;
                }

                // Netscape 6
                else if (document.getElementById)
                {
                    myKeyCode = e.which;
                    myShiftKey = (myKeyCode == 16) ? true : false;
                }

                // Upper case letters are seen without depressing the Shift key, therefore Caps Lock is on
                if ((myKeyCode >= 65 && myKeyCode <= 90) && !myShiftKey)
                {
                    //alert( myMsg );
                    showtip2(this, event, 'Caps Lock is On');
                }
                else
                {
                    hidetip2();
                }
            }
            function add(a)
            {
                document.all.btClear.disabled = false;
                document.form1.pwd.value += a.value.substring(1, 2);
            }


        </script>

        <script language="javascript" type="text/javascript">
            window.history.forward();
            function add(a)
            {
                document.all.btClear.disabled = false;
                document.form1.pwd.value += a.value.substring(1, 2);
            }

            function toggle(fRef)
            {
                capsLock = !capsLock;
                if (capsLock)
                {
                    fRef.caps.value = ' SHIFT ';

                    fRef.n1.value = ' ! ';
                    fRef.n2.value = ' @ ';
                    fRef.n3.value = ' # ';
                    fRef.n4.value = ' $ ';
                    fRef.n5.value = ' % ';
                    fRef.n6.value = ' ^ ';
                    fRef.n7.value = ' & ';
                    fRef.n8.value = ' * ';
                    fRef.n9.value = ' ( ';
                    fRef.n0.value = ' ) ';
                    fRef.s0.value = ' ~ ';
                    fRef.s1.value = ' _ ';
                    fRef.s2.value = ' + ';
                    fRef.s3.value = ' { ';
                    fRef.s4.value = ' } ';
                    fRef.s5.value = ' | ';
                    fRef.s6.value = ' : ';
                    fRef.s7.value = ' " ';
                    fRef.s8.value = ' < ';
                    fRef.s9.value = ' > ';
                    fRef.s10.value = ' ? ';

                    for (var i = 0; i < letters.length; i++)
                    {
                        var letter = letters.substring(i, i + 1)
                        fRef[letter].value = ' ' + letter.toUpperCase() + ' ';
                    }
                }
                else
                {
                    fRef.caps.value = ' Shift ';

                    fRef.n1.value = ' 1 ';
                    fRef.n2.value = ' 2 ';
                    fRef.n3.value = ' 3 ';
                    fRef.n4.value = ' 4 ';
                    fRef.n5.value = ' 5 ';
                    fRef.n6.value = ' 6 ';
                    fRef.n7.value = ' 7 ';
                    fRef.n8.value = ' 8 ';
                    fRef.n9.value = ' 9 ';
                    fRef.n0.value = ' 0 ';
                    fRef.s0.value = ' ` ';
                    fRef.s1.value = ' - ';
                    fRef.s2.value = ' = ';
                    fRef.s3.value = ' [ ';
                    fRef.s4.value = ' ] ';
                    fRef.s5.value = ' \\ ';
                    fRef.s6.value = ' ; ';
                    fRef.s7.value = " ' ";
                    fRef.s8.value = ' , ';
                    fRef.s9.value = ' . ';
                    fRef.s10.value = ' / ';

                    for (var i = 0; i < letters.length; i++)
                    {
                        var letter = letters.substring(i, i + 1)
                        fRef[letter].value = ' ' + letter + ' ';
                        alert(fRef[letter].value);
                    }
                }

            }

            function noBack()
            {
                window.history.forward();
            }

            function do_Load()
            {
                noBack();
                document.form1.UID.value = "";
                if (document.form1.UID.value == "")
                {
                    document.form1.UID.focus();
                }
                else
                {                    document.form1.PWD.focus();

                }

            }

            function del()
            {
                var input = document.form1.PWD.value;
                if (input.length > 0)
                    document.form1.PWD.value = input.substring(0, input.length - 1);
            }



            function clearform(dumForm)
            {
                dumForm.reset();
            }

            function gotoProductsandServices()
            {
                document.form2.HandleID.value = "I_LOGPROD";

            }
        </script>

        <div id="tooltip2" style="VISIBILITY: hidden; WIDTH: 120px; CLIP: rect(0px 150px 50px 0px); POSITION: absolute; BACKGROUND-COLOR: #FFFFFF" ></div>

        <form id="form1" name="form1" method="post" action="/PacsApplication/LoginServlet">
            <header>Enter Your Credentials</header>

            <label>User Id <span>*</span></label>
            <input type="text" maxlength="8" name="UID" id="UID" placeholder="Login ID"/>

            <label>Password <span>*</span></label>
            <input type="password" onkeypress="checkCapsLock(event)" id="PWD"  name="PWD" placeholder="Login Password"/>

            <label>Pacs Id <span>*</span></label>
            <input type="text" maxlenth="5" id="PACSID" name="PACSID" placeholder="PACS"/>

            <!--Added For Module Integration-->
            <label>Module Name <span>*</span></label>

            <select style="width: auto" name="moduleName" id="moduleName" placeholder="MODULE">

                <option value="">Please Select</option>
                <option value="kcc">KCC Module</option>
                <option value="trading">Trading Module</option>
                <option value="asset">Asset Module</option>
                <option value="pds">Public Distribution System Module</option>
                <option value="borrowing">DCCB Borrowing Module</option>
                <option value="shg">Self Help Group Module</option>
                <option value="govt">Govt. Procurement System</option>

            </select>

            <!--Added For Module Integration Ends Here-->
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red" ><b><%= error_msg%> </b></font><br>

            <button type=button onclick="javascript:submitform(form1)" id="loginbtn" target="_top">Login</button>  <button type="reset" id="resetbtn">Reset</button>

        </form>  

    </body>

</HTML>

<% 	} catch (Exception e) {
                System.out.println("EX in " + e);
            }
%>
