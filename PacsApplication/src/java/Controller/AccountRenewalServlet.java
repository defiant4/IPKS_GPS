package Controller;

import DataEntryBean.AccountRenewalBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class AccountRenewalServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Connection con = null;
        CallableStatement proc = null;
        ResultSet rs = null;
        String message = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");

        String handle_id = request.getParameter("handle_id");

        AccountRenewalBean oAccountRenewalBean = new AccountRenewalBean();

        if (handle_id.equalsIgnoreCase("search")) {

            try {
                BeanUtils.populate(oAccountRenewalBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call operations.account_renewal(?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, pacsId);
                proc.setString(2, oAccountRenewalBean.getCifNumber());
                proc.setString(3, oAccountRenewalBean.getCcAccount());
                proc.setString(4, handle_id);

                proc.registerOutParameter(5, OracleTypes.CURSOR);
                proc.registerOutParameter(6, java.sql.Types.VARCHAR);

                proc.execute();

                rs = (ResultSet) proc.getObject(5);

                while (rs.next()) {
                    oAccountRenewalBean = new AccountRenewalBean();
                    oAccountRenewalBean.setDep_product_id(rs.getString("id"));
                    oAccountRenewalBean.setProductName(rs.getString("product"));
                    oAccountRenewalBean.setInttDescription(rs.getString("interest_desc"));
                    oAccountRenewalBean.setSegmentCode(rs.getString("segment_code"));
                    oAccountRenewalBean.setCifNumber(rs.getString("customer_no"));
                    oAccountRenewalBean.setAccNumber(rs.getString("key_1"));
                    oAccountRenewalBean.setCbsSavingsAccount(rs.getString("link_accno"));
                    oAccountRenewalBean.setActivityCode(rs.getString("activity_code"));
                    oAccountRenewalBean.setCustomerType(rs.getString("cust_type"));
                    oAccountRenewalBean.setProductCode(rs.getString("prod_code"));
                    oAccountRenewalBean.setInttCategory(rs.getString("int_cat"));
                    request.setAttribute("displayFlag", "Y");

                }

            } catch (SQLException ex) {
                Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                    //System.out.println(e.toString());
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
                    //System.out.println(ex.toString());
                }

                request.setAttribute("message", message);
                request.setAttribute("oAccountRenewalBeanObj", oAccountRenewalBean);
                request.getRequestDispatcher("/accountRenewal.jsp").forward(request, response);

            }
        } else if (handle_id.equalsIgnoreCase("update")) {

            try {
                BeanUtils.populate(oAccountRenewalBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(AccountRenewalServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call operations.renewal_dep_account(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, pacsId);
                proc.setString(2, oAccountRenewalBean.getProductCode());
                proc.setString(3, oAccountRenewalBean.getInttCategory());
                proc.setString(4, oAccountRenewalBean.getCifNumber());
                proc.setString(5, oAccountRenewalBean.getCustomerType());
                proc.setString(6, oAccountRenewalBean.getLimit());
                proc.setString(7, oAccountRenewalBean.getLimitExpiryDate());
                proc.setString(8, oAccountRenewalBean.getCollateralType());
                proc.setString(9, oAccountRenewalBean.getLandinAcres());
                proc.setString(10, oAccountRenewalBean.getDescription());
                proc.setString(11, oAccountRenewalBean.getCurrentValuation());
                proc.setString(12, oAccountRenewalBean.getSafeLendingMargin());
                proc.setString(13, user);
                proc.setString(14, oAccountRenewalBean.getSegmentCode());
                proc.setString(15, oAccountRenewalBean.getCbsSavingsAccount());
                proc.setString(15, oAccountRenewalBean.getCbsSavingsAccount());
                proc.setString(16, oAccountRenewalBean.getActivityCode());
                proc.setString(17, oAccountRenewalBean.getAccNumber());
                proc.registerOutParameter(18, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(18);

            } catch (SQLException ex) {
                Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                    System.out.println(e.toString());
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    System.out.println(ex.toString());
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/accountRenewal.jsp").forward(request, response);

            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
