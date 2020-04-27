
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.EnquiryBean;
import DataEntryBean.GLTransactionEnquiryBean;
import DataEntryBean.GlAccountEnquiryBean;
import DataEntryBean.TransactionEnquiryBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import oracle.jdbc.OracleTypes;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author Tcs Helpdesk10
 */
public class EnquiryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Connection connection = null;
        ResultSet rs = null;
        Statement statement = null;
        CallableStatement proc = null;
        int searchFound = 0;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");

        String JSP_Name = request.getParameter("screenName");

        if ("accountEnquiry".equalsIgnoreCase(JSP_Name)) {

            EnquiryBean oEnquiryBean = new EnquiryBean();
            EnquiryBean oEnquiryBeanSearch = new EnquiryBean();
            ArrayList<EnquiryBean> alEnquiryBean = new ArrayList<EnquiryBean>();
            try {
                BeanUtils.populate(oEnquiryBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call Enquiry.Account_Enquiry(?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oEnquiryBean.getAccountNo());
                proc.setString(2, oEnquiryBean.getFromDate());
                proc.setString(3, oEnquiryBean.getToDate());
                proc.setString(4, oEnquiryBean.getProductName());
                proc.setString(5, oEnquiryBean.getFromAmount());
                proc.setString(6, oEnquiryBean.getToAmount());
                proc.setString(7, oEnquiryBean.getLinkedSbAccount());
                proc.setString(8, pacsId);

                proc.registerOutParameter(9, OracleTypes.CURSOR);
                proc.registerOutParameter(10, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                rs = (ResultSet) proc.getObject(9);

                while (rs.next()) {
                    searchFound = 1;
                    oEnquiryBean = new EnquiryBean();
                    oEnquiryBean.setAccountNo(rs.getString("KEY_1"));
                    oEnquiryBean.setAccountOpenDate(rs.getString("ACCT_OPEN_DT"));
                    oEnquiryBean.setAvailBalance(rs.getString("AVAIL_BAL"));
                    oEnquiryBean.setCustomerNo(rs.getString("CUSTOMER_NO"));
                    oEnquiryBean.setSanctionAmount(rs.getString("SANCTION_AMT"));
                    oEnquiryBean.setPrinOutstanding(rs.getString("PRIN_OUTST"));
                    oEnquiryBean.setInttOutstanding(rs.getString("INTT_OUTST"));
                    oEnquiryBean.setPenalIntt(rs.getString("PENAL_INTT_PAID"));
                    oEnquiryBean.setCustomerName(rs.getString("cust_name"));
                    
                    //added later
                    oEnquiryBean.setProductNameDisplay(rs.getString("PROD_NAME"));
                    oEnquiryBean.setLimitExpiryDate(rs.getString("LIMIT_EXP_DATE"));
                    oEnquiryBean.setPrinPaid(rs.getString("PRIN_PAID"));
                    oEnquiryBean.setInttPaid(rs.getString("INTT_PAID"));
                    oEnquiryBean.setPenalInttOutstanding(rs.getString("PENAL_INTT_OUTST"));
                    oEnquiryBean.setLinkAccNo(rs.getString("LINK_ACCNO"));
                    alEnquiryBean.add(oEnquiryBean);
                    request.setAttribute("displayFlag", "Y");

                }

                try {
                    connection = DbHandler.getDBConnection();
                    String productName = request.getParameter("productName");
                    statement = connection.createStatement();
                    ResultSet rs1 = statement.executeQuery("select prod_name from dep_product where id='" + productName + "'");
                    while (rs1.next()) {
                        oEnquiryBeanSearch.setProductName(rs1.getString(1));

                    }
                } catch (Exception e) {
                }

                oEnquiryBeanSearch.setProductId(request.getParameter("productName"));
                oEnquiryBeanSearch.setAccountNo(request.getParameter("accountNo"));
                oEnquiryBeanSearch.setFromDate(request.getParameter("fromDate"));
                oEnquiryBeanSearch.setToDate(request.getParameter("toDate"));
                oEnquiryBeanSearch.setFromAmount(request.getParameter("fromAmount"));
                oEnquiryBeanSearch.setToAmount(request.getParameter("toAmount"));
                oEnquiryBeanSearch.setLinkedSbAccount(request.getParameter("linkedSbAccount"));

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (searchFound == 0) {
                message = "No data exists for selected item";
                request.setAttribute("message", message);
            }
            request.setAttribute("oEnquiryBeanSearchObj", oEnquiryBeanSearch);
            request.setAttribute("alEnquiryBean", alEnquiryBean);
            request.setAttribute("message", message);

            request.getRequestDispatcher("/accountEnquiry.jsp").forward(request, response);

        } else if ("transactionEnquiry".equalsIgnoreCase(JSP_Name)) {

            TransactionEnquiryBean oTransactionEnquiryBeanSearch = new TransactionEnquiryBean();
            TransactionEnquiryBean oTransactionEnquiryBean = new TransactionEnquiryBean();

            ArrayList<TransactionEnquiryBean> alTransactionEnquiryBean = new ArrayList<TransactionEnquiryBean>();
            try {
                BeanUtils.populate(oTransactionEnquiryBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call Enquiry.Transaction_Enquiry(?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oTransactionEnquiryBean.getAccountNo());
                proc.setString(2, oTransactionEnquiryBean.getFromDate());
                proc.setString(3, oTransactionEnquiryBean.getToDate());
                proc.setString(4, oTransactionEnquiryBean.getProductName());
                proc.setString(5, oTransactionEnquiryBean.getFromAmount());
                proc.setString(6, oTransactionEnquiryBean.getToAmount());
                proc.setString(7, oTransactionEnquiryBean.getLinkedSbAccount());
                proc.setString(8, pacsId);

                proc.registerOutParameter(9, OracleTypes.CURSOR);
                proc.registerOutParameter(10, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                rs = (ResultSet) proc.getObject(9);

                while (rs.next()) {
                    searchFound = 1;
                    oTransactionEnquiryBean = new TransactionEnquiryBean();
                    oTransactionEnquiryBean.setAccountNo(rs.getString("KEY_1"));
                    oTransactionEnquiryBean.setCbs_Ref_No(rs.getString("cbs_ref_no"));
                    oTransactionEnquiryBean.setTransactionDate(rs.getString("tran_date"));
                    oTransactionEnquiryBean.setJournalNumber(rs.getString("jrnl_no"));
                    oTransactionEnquiryBean.setTransactionType(rs.getString("txn_type"));
                    oTransactionEnquiryBean.setTransactionAmount(rs.getString("txn_amt"));
                    
                    //added later
                    oTransactionEnquiryBean.setProductNameDisplay(rs.getString("PROD_NAME"));
                    oTransactionEnquiryBean.setLimitExpiryDate(rs.getString("LIMIT_EXP_DATE"));
                    oTransactionEnquiryBean.setAvailableBalance(rs.getString("END_BAL"));
                    oTransactionEnquiryBean.setLinkAccNo(rs.getString("LINK_ACCNO"));
                    alTransactionEnquiryBean.add(oTransactionEnquiryBean);

                    request.setAttribute("displayFlag", "Y");

                }

                try {
                    String productName;
                    connection = DbHandler.getDBConnection();
                    productName = request.getParameter("productName");
                    statement = connection.createStatement();
                    ResultSet rs1 = statement.executeQuery("select prod_name from dep_product where id='" + productName + "'");
                    while (rs1.next()) {
                        oTransactionEnquiryBeanSearch.setProductName(rs1.getString(1));

                    }
                } catch (Exception e) {
                }

                oTransactionEnquiryBeanSearch.setAccountNo(request.getParameter("accountNo"));
                oTransactionEnquiryBeanSearch.setFromDate(request.getParameter("fromDate"));
                oTransactionEnquiryBeanSearch.setToDate(request.getParameter("toDate"));
                oTransactionEnquiryBeanSearch.setProductId(request.getParameter("productName"));
                oTransactionEnquiryBeanSearch.setFromAmount(request.getParameter("fromAmount"));
                oTransactionEnquiryBeanSearch.setToAmount(request.getParameter("toAmount"));
                oTransactionEnquiryBeanSearch.setLinkedSbAccount(request.getParameter("linkedSbAccount"));

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (searchFound == 0) {
                message = "No data exists for selected item";
                request.setAttribute("message", message);
            }
            request.setAttribute("oTransactionEnquiryBeanSearchObj", oTransactionEnquiryBeanSearch);
            request.setAttribute("alTransactionEnquiryBean", alTransactionEnquiryBean);
            request.setAttribute("message", message);

            request.getRequestDispatcher("/transactionEnquiry.jsp").forward(request, response);

        } else if ("glTransactionEnquiry".equalsIgnoreCase(JSP_Name)) {

            GLTransactionEnquiryBean oGLTransactionEnquiryBeanSearch = new GLTransactionEnquiryBean();
            GLTransactionEnquiryBean oGLTransactionEnquiryBean = new GLTransactionEnquiryBean();

            ArrayList<GLTransactionEnquiryBean> alGlTransactionEnquiryBean = new ArrayList<GLTransactionEnquiryBean>();
            try {
                BeanUtils.populate(oGLTransactionEnquiryBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call Enquiry.GL_Transaction_Enquiry(?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oGLTransactionEnquiryBean.getAccountNo());
                proc.setString(2, oGLTransactionEnquiryBean.getFromDate());
                proc.setString(3, oGLTransactionEnquiryBean.getToDate());
                proc.setString(4, oGLTransactionEnquiryBean.getProductName());
                proc.setString(5, oGLTransactionEnquiryBean.getFromAmount());
                proc.setString(6, oGLTransactionEnquiryBean.getToAmount());
                proc.setString(7, pacsId);

                proc.registerOutParameter(8, OracleTypes.CURSOR);
                proc.registerOutParameter(9, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                rs = (ResultSet) proc.getObject(8);

                while (rs.next()) {
                    searchFound = 1;
                    oGLTransactionEnquiryBean = new GLTransactionEnquiryBean();
                    oGLTransactionEnquiryBean.setAccountNo(rs.getString("KEY_1"));
                    oGLTransactionEnquiryBean.setCbs_Ref_No(rs.getString("cbs_ref_no"));
                    oGLTransactionEnquiryBean.setTransactionDate(rs.getString("tran_date"));
                    oGLTransactionEnquiryBean.setJournalNumber(rs.getString("jrnl_no"));
                    oGLTransactionEnquiryBean.setTransactionType(rs.getString("txn_type"));
                    oGLTransactionEnquiryBean.setTransactionAmount(rs.getString("txn_amt"));

                    alGlTransactionEnquiryBean.add(oGLTransactionEnquiryBean);

                    request.setAttribute("displayFlag", "Y");

                }

                try {
                    String productName;
                    connection = DbHandler.getDBConnection();
                    productName = request.getParameter("productName");
                    statement = connection.createStatement();
                    ResultSet rs1 = statement.executeQuery("select gl_name from gl_product where id='" + productName + "'");
                    while (rs1.next()) {
                        oGLTransactionEnquiryBeanSearch.setProductName(rs1.getString(1));

                    }
                } catch (Exception e) {
                }

                oGLTransactionEnquiryBeanSearch.setAccountNo(request.getParameter("accountNo"));
                oGLTransactionEnquiryBeanSearch.setFromDate(request.getParameter("fromDate"));
                oGLTransactionEnquiryBeanSearch.setToDate(request.getParameter("toDate"));
                oGLTransactionEnquiryBeanSearch.setProductId(request.getParameter("productName"));
                oGLTransactionEnquiryBeanSearch.setFromAmount(request.getParameter("fromAmount"));
                oGLTransactionEnquiryBeanSearch.setToAmount(request.getParameter("toAmount"));

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (searchFound == 0) {
                message = "No data exists for selected item";
                request.setAttribute("message", message);
            }
            request.setAttribute("oGlTransactionEnquiryBeanSearchObj", oGLTransactionEnquiryBeanSearch);
            request.setAttribute("alGlTransactionEnquiryBean", alGlTransactionEnquiryBean);
            request.setAttribute("message", message);

            request.getRequestDispatcher("/glTransactionEnquiry.jsp").forward(request, response);

        } else if ("glAccountEnquiry".equalsIgnoreCase(JSP_Name)) {

            GlAccountEnquiryBean oGlAccountEnquiryBeanSearch = new GlAccountEnquiryBean();
            GlAccountEnquiryBean oGlAccountEnquiryBean = new GlAccountEnquiryBean();

            ArrayList<GlAccountEnquiryBean> alGlAccountEnquiryBean = new ArrayList<GlAccountEnquiryBean>();
            try {
                BeanUtils.populate(oGlAccountEnquiryBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call Enquiry.Gl_Account_Enquiry(?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(EnquiryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oGlAccountEnquiryBean.getAccountNo());
                proc.setString(2, oGlAccountEnquiryBean.getFromDate());
                proc.setString(3, oGlAccountEnquiryBean.getToDate());
                proc.setString(4, oGlAccountEnquiryBean.getProductName());
                proc.setString(5, oGlAccountEnquiryBean.getFromAmount());
                proc.setString(6, oGlAccountEnquiryBean.getToAmount());
                proc.setString(7, pacsId);

                proc.registerOutParameter(8, OracleTypes.CURSOR);
                proc.registerOutParameter(9, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                rs = (ResultSet) proc.getObject(8);

                while (rs.next()) {
                    searchFound = 1;
                    oGlAccountEnquiryBean = new GlAccountEnquiryBean();
                    oGlAccountEnquiryBean.setAccountNo(rs.getString("KEY_1"));
                    oGlAccountEnquiryBean.setLedgerName(rs.getString("LEDGER_NAME"));
                    oGlAccountEnquiryBean.setAccountOpenDate(rs.getString("ACCT_OPEN_DT"));
                    oGlAccountEnquiryBean.setCumulativeBalance(rs.getString("cum_curr_val"));
                    oGlAccountEnquiryBean.setStatus(rs.getString("status"));
                    oGlAccountEnquiryBean.setCglCode(rs.getString("gl_code"));
                    oGlAccountEnquiryBean.setCglName(rs.getString("gl_name"));

                    alGlAccountEnquiryBean.add(oGlAccountEnquiryBean);

                    request.setAttribute("displayFlag", "Y");

                }

                try {
                    String productName;
                    connection = DbHandler.getDBConnection();
                    productName = request.getParameter("productName");
                    statement = connection.createStatement();
                    ResultSet rs1 = statement.executeQuery("select gl_name from gl_product where id='" + productName + "'");
                    while (rs1.next()) {
                        oGlAccountEnquiryBeanSearch.setProductName(rs1.getString(1));

                    }
                } catch (Exception e) {
                }

                oGlAccountEnquiryBeanSearch.setAccountNo(request.getParameter("accountNo"));
                oGlAccountEnquiryBeanSearch.setFromDate(request.getParameter("fromDate"));
                oGlAccountEnquiryBeanSearch.setToDate(request.getParameter("toDate"));
                oGlAccountEnquiryBeanSearch.setProductId(request.getParameter("productName"));
                oGlAccountEnquiryBeanSearch.setFromAmount(request.getParameter("fromAmount"));
                oGlAccountEnquiryBeanSearch.setToAmount(request.getParameter("toAmount"));

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (searchFound == 0) {
                message = "No data exists for selected item";
                request.setAttribute("message", message);
            }
            request.setAttribute("oGlAccountEnquiryBeanSearchObj", oGlAccountEnquiryBeanSearch);
            request.setAttribute("alGlAccountEnquiryBean", alGlAccountEnquiryBean);
            request.setAttribute("message", message);

            request.getRequestDispatcher("/glAccountEnquiry.jsp").forward(request, response);

        }

    }
}
