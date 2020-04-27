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
public class IdenticationEntryServet extends HttpServlet {
   
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
            out.println("<title>Servlet IdenticationEntryServet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet IdenticationEntryServet at " + request.getContextPath () + "</h1>");
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

        CustomerIdentificationBean oCustomerIdentificationBean=new CustomerIdentificationBean();

        if ("Search".equalsIgnoreCase(ServletName))

        {

            try {
                    BeanUtils.populate(oCustomerIdentificationBean, request.getParameterMap());
                } catch (IllegalAccessException ex) {
                    Logger.getLogger(IdenticationEntryServet.class.getName()).log(Level.SEVERE, null, ex);
                } catch (InvocationTargetException ex) {
                    Logger.getLogger(IdenticationEntryServet.class.getName()).log(Level.SEVERE, null, ex);
                }


                Connection connection = null;
                ResultSet resultset = null;
                Statement statement = null;
                connection =DbHandler.getDBConnection();
                try {
                    statement = connection.createStatement();
                } catch (SQLException ex) {
                    Logger.getLogger(IdenticationEntryServet.class.getName()).log(Level.SEVERE, null, ex);
                }
                try {
                    //look at " for table name
                    ResultSet rs = statement.executeQuery("select CIF,FIRST_ID_TYPE,ID_ISSUED_AT,REMARK,FIRST_ID_NO,to_char(FIRST_ID_ISSUE_DATE,'DD-MON-YYYY') as FIRST_ID_ISSUE_DATE,SECOND_ID_TYPE,SECOND_ID_NO,RELATIONSHIP_MANAGER,HOME_BRANCH,CUST_EVALUATION_RATE,INTRODUCER,INB_REQUEST,EMAIL_ID,EMAIL_ADDRESS,INB_REF,VISA_DTLS,VISA_ISSUED_BY,to_char(VISA_ISSUE_DATE,'DD-MON-YYYY') as VISA_ISSUE_DATE,to_char(VISA_EXPIRY_DATE,'DD-MON-YYYY') as VISA_EXPIRY_DATE,DOMESTIC_RISK,COUNTRY_RISK,CROSS_BORDER_RISK,SEGMENT_CODE,LOCKER_CODE,CIS_CODE,TFN_INDICATOR from CUSTOMER_IDENTITY_DTLS where cif= '" + oCustomerIdentificationBean.getCif() + "'");
                    while (rs.next())
            {

                        oCustomerIdentificationBean.setBankref(rs.getString("INB_REF"));
                        oCustomerIdentificationBean.setBorderrisk(rs.getString("CROSS_BORDER_RISK"));
                        oCustomerIdentificationBean.setCif(rs.getString("CIF"));
                        oCustomerIdentificationBean.setCis(rs.getString("CIS_CODE"));
                        oCustomerIdentificationBean.setCountryrisk(rs.getString("COUNTRY_RISK"));
                        oCustomerIdentificationBean.setCusevltn(rs.getString("CUST_EVALUATION_RATE"));
                        oCustomerIdentificationBean.setDomrisk(rs.getString("DOMESTIC_RISK"));
                        oCustomerIdentificationBean.setEmailadd(rs.getString("EMAIL_ADDRESS"));
                        oCustomerIdentificationBean.setEmailid(rs.getString("EMAIL_ID"));
                        oCustomerIdentificationBean.setFidno(rs.getString("FIRST_ID_NO"));
                        oCustomerIdentificationBean.setHomebr(rs.getString("HOME_BRANCH"));
                        oCustomerIdentificationBean.setIdissuedate(rs.getString("FIRST_ID_ISSUE_DATE"));
                        oCustomerIdentificationBean.setIdype(rs.getString("FIRST_ID_TYPE"));
                        oCustomerIdentificationBean.setInb(rs.getString("INB_REQUEST"));
                        oCustomerIdentificationBean.setIntro(rs.getString("INTRODUCER"));
                        oCustomerIdentificationBean.setIssueat(rs.getString("ID_ISSUED_AT"));
                        oCustomerIdentificationBean.setLocker(rs.getString("LOCKER_CODE"));
                        oCustomerIdentificationBean.setRemark(rs.getString("REMARK"));
                        oCustomerIdentificationBean.setRmanager(rs.getString("RELATIONSHIP_MANAGER"));
                        oCustomerIdentificationBean.setSecondid(rs.getString("SECOND_ID_TYPE"));
                        oCustomerIdentificationBean.setSecondidno(rs.getString("SECOND_ID_NO"));
                        oCustomerIdentificationBean.setSegment(rs.getString("SEGMENT_CODE"));
                        oCustomerIdentificationBean.setTfn(rs.getString("TFN_INDICATOR"));
                        oCustomerIdentificationBean.setVisadet(rs.getString("VISA_DTLS"));
                        oCustomerIdentificationBean.setVisaexpr(rs.getString("VISA_EXPIRY_DATE"));
                        oCustomerIdentificationBean.setVisaissueby(rs.getString("state_code"));
                        oCustomerIdentificationBean.setVisaissuedate(rs.getString("VISA_ISSUED_BY"));
                        

            }
                statement.close();
                connection.close();

                } catch (SQLException ex) {
                    Logger.getLogger(CifEntryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }



        }
           request.setAttribute("oCustomerIdentificationBeanObj", oCustomerIdentificationBean);
           (request.getRequestDispatcher("/ShowIdentificationDetails.jsp")).forward(request, response);

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
