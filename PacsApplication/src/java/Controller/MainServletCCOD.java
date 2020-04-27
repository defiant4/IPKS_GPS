/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.*;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.beanutils.*;
import org.apache.commons.logging.*;
import org.apache.commons.collections.*;
import java.sql.*;
import LoginDb.DbHandler;


/**
 *
 * @author Administrator
 */
public class MainServletCCOD extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MainServletCCOD</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MainServletCCOD at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
            */
        } finally { 
            out.close();
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Taking the servlet name from JSP
        String ServletName=request.getParameter("action");

        CcOdBean oCcOdBean=new CcOdBean();

        if ("Search".equalsIgnoreCase(ServletName))

        {

            try {
                    BeanUtils.populate(oCcOdBean, request.getParameterMap());
                } catch (IllegalAccessException ex) {
                    Logger.getLogger(MainServletCCOD.class.getName()).log(Level.SEVERE, null, ex);
                } catch (InvocationTargetException ex) {
                    Logger.getLogger(MainServletCCOD.class.getName()).log(Level.SEVERE, null, ex);
                }


                Connection connection = null;
                ResultSet resultset = null;
                Statement statement = null;
                connection =DbHandler.getDBConnection();
                try {
                    statement = connection.createStatement();
                } catch (SQLException ex) {
                    Logger.getLogger(MainServletCCOD.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    //look at " for table name
                    ResultSet rs = statement.executeQuery("select acct_no,cust_name, acc_type, product_desc, sub_category, outstanding, leading_status, intt_accured, per_day_intt, limit_amount, to_char(date_of_limit,'DD-MON-YYYY') as date_of_limit, to_char(npa_date,'DD-MON-YYYY') as npa_date, to_char(limit_expr_date,'DD-MON-YYYY') as limit_expr_date, amt_irregularity, effec_dp, intt_rate, expiry_rate, new_irca_status,LAND_REGISTER from CUST_CC_OD_DTLS where acct_no= '" + oCcOdBean.getAccount_no() + "'");

                    while (rs.next())
                  {

                        oCcOdBean.setAcc_type(rs.getString("acc_type"));
                        oCcOdBean.setAccount_no(rs.getString("acct_no"));
                        oCcOdBean.setAmt_irr(rs.getString("amt_irregularity"));
                        oCcOdBean.setCust_name(rs.getString("cust_name"));
                        oCcOdBean.setDaily_int(rs.getString("per_day_intt"));
                        oCcOdBean.setEff_DP(rs.getString("effec_dp"));
                        oCcOdBean.setExp_rate(rs.getString("expiry_rate"));
                        oCcOdBean.setIntt_accrd(rs.getString("intt_accured"));
                        oCcOdBean.setIntt_rate(rs.getString("intt_rate"));
                        oCcOdBean.setLend_status(rs.getString("leading_status"));
                        oCcOdBean.setLim_amt(rs.getString("limit_amount"));
                        oCcOdBean.setLim_date(rs.getString("date_of_limit"));
                        oCcOdBean.setLim_exp_dt(rs.getString("limit_expr_date"));
                        oCcOdBean.setNPA_date(rs.getString("npa_date"));
                        oCcOdBean.setNew_IRAC(rs.getString("new_irca_status"));
                        oCcOdBean.setOutstanding(rs.getString("outstanding"));
                        oCcOdBean.setProd_desc(rs.getString("product_desc"));
                        oCcOdBean.setSub_cat(rs.getString("sub_category"));
                        oCcOdBean.setLandRegister(rs.getString("LAND_REGISTER"));
                        
                                                

            }
                statement.close();
                connection.close();

                } catch (SQLException ex) {
                    Logger.getLogger(MainServletCCOD.class.getName()).log(Level.SEVERE, null, ex);
                }



        }
           request.setAttribute("oCcOdBeanObj", oCcOdBean);
           (request.getRequestDispatcher("/ShowCCODDetails.jsp")).forward(request, response);

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
