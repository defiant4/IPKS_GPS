<%--
    Document   : CC_OD
    Created on : Aug 5, 2015, 12:51:24 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="DataEntryBean.CcOdBean"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CC OD Account Details</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
        
    </head>
    <body  onload="noBack();">
        <script type="text/javascript">
            function noBack()
                 {
                    window.history.forward();
                 }
        </script>

         <script language="javascript" type="text/javascript">
            function ShowParent()
            {
                document.forms[0].action="CC_OD.jsp";
                document.forms[0].submit;
            }

        </script>

     <jsp:include page="MenuHead.jsp" flush="true" />
     <br><br>
        <%!
         String blankNull(String s){
             return(s==null)?"":s;
             }
        %>
        <%
        CcOdBean CcOdBean=(CcOdBean) request.getAttribute("oCcOdBeanObj");
        %>

        <form method="POST" action="MainServletCCOD">
            <table border="0" width="800" cellspacing="1" cellpadding="1">
                <tbody>
                    <tr>
                        <td align="left">Account Number</td>
                        <td align="left"><input type="text" name="account_no" id="account_no" value="<%=blankNull(CcOdBean.getAccount_no())%>"</td>
                        <td align="left">Customer Name</td>
                        <td align="left"><input type="text" name="cust_name" id="cust_name" value="<%=blankNull(CcOdBean.getCust_name())%>"</td>
                    </tr>
                    <tr>
                        <td>Account Type</td>
                        <td align="left"><input type="text" name="acc_type" id="acc_type"  value="<%=blankNull(CcOdBean.getAcc_type())%>"</td>
                        <td>Sub Cat</td>
                        <td align="left"><input type="text" name="sub_cat" id="sub_cat"  value="<%=blankNull(CcOdBean.getSub_cat())%>"</td>
                    </tr>
                    <tr>
                        <td align="left">Product Description</td>
                        <td align="left"><input type="text" name="prod_desc" id="prod_desc"  value="<%=blankNull(CcOdBean.getProd_desc())%>"</td>
                        <td align="left">Outstanding</td>
                        <td align="left"><input type="text" name="outstanding" id="outstanding" value="<%=blankNull(CcOdBean.getOutstanding())%>"</td>
                    </tr>
                    <tr>
                        <td>Current Status</td>
                        <td align="left"><input type="text" name="lend_status" id="lend_status" value="<%=blankNull(CcOdBean.getLend_status())%>"</td>
                        <td>Intt Accrued</td>
                        <td align="left"><input type="text" name="intt_accrd" id="intt_accrd" value="<%=blankNull(CcOdBean.getIntt_accrd())%>"</td>
                    </tr>
                    <tr>
                        <td>Per Day Interest</td>
                        <td align="left"><input type="text" name="daily_int" id="daily_int" value="<%=blankNull(CcOdBean.getDaily_int())%>"</td>
                        <td align="left">Limit Amount</td>
                        <td align="left"><input type="text" name="lim_amt" id="lim_amt" value="<%=blankNull(CcOdBean.getLim_amt())%>"</td>
                    </tr>
                    <tr>
                        <td align="left">Account Opening Date</td>
                        <td align="left"><input type="text" name="lim_date" id="lim_date" value="<%=blankNull(CcOdBean.getLim_date())%>"</td>
                        <td align="left">NPA Date</td>
                        <td align="left"><input type="text" name="NPA_date" id="NPA_date" value="<%=blankNull(CcOdBean.getNPA_date())%>"</td>
                    </tr>
                    <tr>
                        <td>Limit Expiry Date</td>
                        <td align="left"><input type="text" name="lim_exp_dt" id="lim_exp_dt" value="<%=blankNull(CcOdBean.getLim_exp_dt())%>"</td>
                        <td>Amt Of Irregularity</td>
                        <td align="left"><input type="text" name="amt_irr" id="amt_irr" value="<%=blankNull(CcOdBean.getAmt_irr())%>"</td>
                    </tr>
                    <tr>
                        <td align="left">Effective DP</td>
                        <td align="left"><input type="text" name="eff_DP" id="eff_DP" value="<%=blankNull(CcOdBean.getEff_DP())%>"</td>
                        <td align="left">Intt Rate</td>
                        <td align="left"><input type="text" name="intt_rate" id="intt_rate" value="<%=blankNull(CcOdBean.getIntt_rate())%>"</td>
                    </tr>
                    <tr>
                        <td align="left">Expiry Rate</td>
                        <td align="left"><input type="text" name="exp_rate" id="exp_rate" value="<%=blankNull(CcOdBean.getExp_rate())%>"</td>
                        <td align="left">New IRAC Status</td>
                        <td align="left"><input type="text" name="new_IRAC" id="new_IRAC" value="<%=blankNull(CcOdBean.getNew_IRAC())%>"</td>
                    </tr>

                    <tr>
                        <td align="left">Land Register(Land In Acre)</td>
                        <td align="left"><input type="text" name="landRegister" id="landRegister" value="<%=blankNull(CcOdBean.getLandRegister())%>"</td>
                    </tr>

                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="4" align="center">
                            <input type="submit" value="Search" name="action">
                            <input type="submit" value="Reset" name="reset" onclick="ShowParent();" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </body>

</html>
