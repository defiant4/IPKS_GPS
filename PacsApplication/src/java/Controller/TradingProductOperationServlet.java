/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

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
import org.apache.commons.beanutils.BeanUtils;
import DataEntryBean.tradingProductCreationBean;

/**
 *
 * @author 590685
 */
public class TradingProductOperationServlet extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Connection con = null;
        CallableStatement proc = null;
        String message = "";

        String ServletName = request.getParameter("handle_id");

        tradingProductCreationBean tradingProductCreationBeanObj=new tradingProductCreationBean();


        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(tradingProductCreationBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call Trading_parameter.Upsert_trading_parameter(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, tradingProductCreationBeanObj.getStatus());
                proc.setString(2, tradingProductCreationBeanObj.getProductCode());
                proc.setString(3, tradingProductCreationBeanObj.getProductName());
                proc.setString(4, tradingProductCreationBeanObj.getUnit());
                proc.setString(5, tradingProductCreationBeanObj.getProfitFactor());
                proc.setString(6, tradingProductCreationBeanObj.getProduct_id());
                proc.setString(7, ServletName);

                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

            } catch (SQLException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/Trading_JSP/tradingProductCreation.jsp").forward(request, response);

            }

        }else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(tradingProductCreationBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select ID,PRODUCT_NAME,PRODUCT_CODE,UNIT,STATUS,PROFIT_FACTOR from trading_product_mst where product_code= '" + tradingProductCreationBeanObj.getInventorySearch() + "'");

                while (rs.next()) {

                    tradingProductCreationBeanObj.setProduct_id(rs.getString("ID"));
                    tradingProductCreationBeanObj.setProductName(rs.getString("PRODUCT_NAME"));
                    tradingProductCreationBeanObj.setProductCode(rs.getString("PRODUCT_CODE"));
                    tradingProductCreationBeanObj.setUnit(rs.getString("UNIT"));
                    tradingProductCreationBeanObj.setStatus(rs.getString("STATUS"));
                    tradingProductCreationBeanObj.setProfitFactor(rs.getString("PROFIT_FACTOR"));
                    
                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Trading Product Code not exists in the system";
                request.setAttribute("message", message);
            }
            request.setAttribute("tradingProductCreationBeanObj", tradingProductCreationBeanObj);
            
            request.getRequestDispatcher("/Trading_JSP/tradingProductCreation.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(tradingProductCreationBeanObj, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call Trading_parameter.Upsert_trading_parameter(?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, tradingProductCreationBeanObj.getStatusAmend());
                proc.setString(2, tradingProductCreationBeanObj.getProductCodeAmend());
                proc.setString(3, tradingProductCreationBeanObj.getProductNameAmend());
                proc.setString(4, tradingProductCreationBeanObj.getUnitAmend());
                proc.setString(5, tradingProductCreationBeanObj.getProfitFactorAmend());
                proc.setString(6, tradingProductCreationBeanObj.getProduct_id());
                proc.setString(7, ServletName);

                proc.registerOutParameter(8, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(8);

            } catch (SQLException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/Trading_JSP/tradingProductCreation.jsp").forward(request, response);

            }

        } else if ("StatusSearch".equalsIgnoreCase(ServletName)) {

            String productCodeActivation = request.getParameter("productCodeActivation");
            String vFlag = request.getParameter("productStatusFlag");

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call Trading_parameter.Trading_parameter_Activation(?,?,?)}");
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, productCodeActivation);
                proc.setString(2, vFlag);
                proc.registerOutParameter(3, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(3);

            } catch (SQLException ex) {
                Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(TradingProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/Trading_JSP/tradingProductCreation.jsp").forward(request, response);

            }

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
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
