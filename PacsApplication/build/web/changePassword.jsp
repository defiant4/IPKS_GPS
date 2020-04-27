<%-- 
    Document   : ChangePassword
    Created on : Aug 7, 2015, 6:02:29 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="/PacsApplication/css/ButtonAndText.css" />
        <title>Change Password</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        <script type="text/javascript">
            function passwordCheck(changePassword)
            {
                var newPass=document.getElementById("newPass").value;
                var conNewPass=document.getElementById("conNewPass").value;
                if(newPass==conNewPass)
                {
                    document.forms[0].action='/PacsApplication/ChangeUserPasswordServlet';
                    changePassword.submit();
                   
                }
                else
                {
                    alert('Passwords does not match');
                    document.getElementById("newPass").focus();
                    return false;
                }
            }
        </script>
        
    </head>
    <body style="background-image: url('/PacsApplication/img/download.jpg');" onload="noBack();">
        <script type="text/javascript">
            function noBack()
                 {
                    window.history.forward();
                 }
        </script>
        
        <br><br><br>
        <center>
            <fieldset style="border-color: black; background-image: url('/PacsApplication/img/download.jpg'); border-width: 3px">
            <div><p><font face="Trebuchet MS" color="#0000FF" size="6">This is either your first login or your password has been reset, please change your password to proceed</font></p></div>
            <br>
            <form name="changePassword" method="post" action="ChangeUserPasswordServlet">
                <table border="0" cellspacing="1" cellpadding="2">
                    <tbody>
                        
                        <tr>
                            <td align="left">New Password</td>
                            <td align="left"><input type="password" name="newpass" id="newPass" /></td>
                        </tr>
                        <tr>
                            <td align="left">Confirm New Password</td>
                            <td align="left"><input type="password" name="connewpass" id="conNewPass" /></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="button" value="Submit" onclick="javascript:passwordCheck(changePassword)"/>
                                <input type="reset" value="Reset" name="reset" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
            </fieldset>
        </center>
    </body>
</html>
