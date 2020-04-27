package Controller;

import DataEntryBean.pacsProductOperationBean;
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
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author Tcs Helpdesk10
 */
public class pacsProductOperationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*response.setContentType("text/html;charset=UTF-8");
         PrintWriter out = response.getWriter();
         try {
             
         out.println("<!DOCTYPE html>");
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet GlProductOperationServlet</title>");            
         out.println("</head>");
         out.println("<body>");
         out.println("<h1>Servlet GlProductOperationServlet at " + request.getContextPath() + "</h1>");
         out.println("</body>");
         out.println("</html>");
         } finally {
         out.close();
         }*/
    }

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
        processRequest(request, response);
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
        //processRequest(request, response);

        Connection con = null;
        CallableStatement proc = null;
        String message = "";

        String ServletName = request.getParameter("handle_id");

        pacsProductOperationBean oPacsProductOperationBean = new pacsProductOperationBean();

        if ("Create".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_dep_product(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oPacsProductOperationBean.getProductcode());
                proc.setString(2, oPacsProductOperationBean.getInttcategory());
                proc.setString(3, oPacsProductOperationBean.getProductname());
                proc.setString(4, oPacsProductOperationBean.getProductdescription());
                proc.setString(5, oPacsProductOperationBean.getIntcatdescription());
                proc.setString(6, oPacsProductOperationBean.getSegmentCode());
                proc.setString(7, oPacsProductOperationBean.getGlCode());
                proc.setString(8, oPacsProductOperationBean.getStatus());
                proc.setString(9, oPacsProductOperationBean.getIntrate());
                proc.setString(10, oPacsProductOperationBean.getInttfrequency());
                proc.setString(11, oPacsProductOperationBean.getInttmethod());
                proc.setString(12, oPacsProductOperationBean.getMinbal());
                proc.setString(13, oPacsProductOperationBean.getMaxbal());
                proc.setString(14, oPacsProductOperationBean.getOdindicator());
                proc.setString(15, oPacsProductOperationBean.getPenalinttrate());
                proc.setString(16, oPacsProductOperationBean.getPenalinttfrequency());
                proc.setString(17, oPacsProductOperationBean.getPenalinttmethod());
                proc.setString(18, oPacsProductOperationBean.getMaxlimit());
                proc.setString(19, oPacsProductOperationBean.getDrawingpower());
                proc.setString(20, oPacsProductOperationBean.getDebitComp1());
                proc.setString(21, oPacsProductOperationBean.getDebitComp2());
                proc.setString(22, oPacsProductOperationBean.getCreditComp1());
                proc.setString(23, oPacsProductOperationBean.getCreditComp2());
                proc.setString(24, ServletName);
                proc.registerOutParameter(25, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(25);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/pacsProductOperation.jsp").forward(request, response);

            }

        } else if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select dp.id, prod_code,int_cat,prod_name,prod_desc,"
                        + "intt_cat_desc,segment_code,gl_prod_id as Gl_Description,status,"
                        + "intt_rate,intt_freq,int_method,min_bal,max_bal,"
                        + "to_char(effec_dt,'dd/mm/yyyy') as eff_date, od_indicator,"
                        + "od_pen_int_rate,od_pen_intt_freq,od_pen_int_method,max_limit,dp_flag,debit_comp1,debit_comp2,credit_comp1,credit_comp2 from dep_product dp"
                        + " where  int_cat= '" + oPacsProductOperationBean.getIntcatSearch() + "' AND prod_code='" + oPacsProductOperationBean.getProductcodeSearch() + "'");

                while (rs.next()) {

                    oPacsProductOperationBean.setDep_product_id(rs.getString("id"));
                    oPacsProductOperationBean.setProductcode(rs.getString("prod_code"));
                    oPacsProductOperationBean.setInttcategory(rs.getString("int_cat"));
                    oPacsProductOperationBean.setProductname(rs.getString("prod_name"));
                    oPacsProductOperationBean.setProductdescription(rs.getString("prod_desc"));
                    oPacsProductOperationBean.setIntcatdescription(rs.getString("intt_cat_desc"));
                    oPacsProductOperationBean.setSegmentCode(rs.getString("segment_code"));
                    oPacsProductOperationBean.setGlCode(rs.getString("Gl_Description"));
                    oPacsProductOperationBean.setStatus(rs.getString("status"));
                    oPacsProductOperationBean.setIntrate(rs.getString("intt_rate"));
                    oPacsProductOperationBean.setInttfrequency(rs.getString("intt_freq"));
                    oPacsProductOperationBean.setInttmethod(rs.getString("int_method"));
                    oPacsProductOperationBean.setMinbal(rs.getString("min_bal"));
                    oPacsProductOperationBean.setMaxbal(rs.getString("max_bal"));
                    oPacsProductOperationBean.setEffectDate(rs.getString("eff_date"));
                    oPacsProductOperationBean.setOdindicator(rs.getString("od_indicator"));
                    oPacsProductOperationBean.setPenalinttrate(rs.getString("od_pen_int_rate"));
                    oPacsProductOperationBean.setPenalinttfrequency(rs.getString("od_pen_intt_freq"));
                    oPacsProductOperationBean.setPenalinttmethod(rs.getString("od_pen_int_method"));
                    oPacsProductOperationBean.setMaxlimit(rs.getString("max_limit"));
                    oPacsProductOperationBean.setDrawingpower(rs.getString("dp_flag"));
                    oPacsProductOperationBean.setDebitComp1(rs.getString("debit_comp1"));
                    oPacsProductOperationBean.setDebitComp2(rs.getString("debit_comp2"));
                    oPacsProductOperationBean.setCreditComp1(rs.getString("credit_comp1"));
                    oPacsProductOperationBean.setCreditComp2(rs.getString("credit_comp2"));

                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");
                }
                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Product Code or Interest Category not exists in the system";
                request.setAttribute("message", message);
            }

            request.setAttribute("oPacsProductOperationBeanObj", oPacsProductOperationBean);
            request.getRequestDispatcher("/pacsProductOperation.jsp").forward(request, response);

        } else if ("Update".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oPacsProductOperationBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.Upsert_dep_product(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                proc.setString(1, oPacsProductOperationBean.getProductcodeAmend());
                proc.setString(2, oPacsProductOperationBean.getInttcategoryAmend());
                proc.setString(3, oPacsProductOperationBean.getProductnameAmend());
                proc.setString(4, oPacsProductOperationBean.getProductdescriptionAmend());
                proc.setString(5, oPacsProductOperationBean.getIntcatdescriptionAmend());
                proc.setString(6, oPacsProductOperationBean.getSegmentCodeAmend());
                proc.setString(7, oPacsProductOperationBean.getGlCodeAmend());
                proc.setString(8, oPacsProductOperationBean.getStatusAmend());
                proc.setString(9, oPacsProductOperationBean.getIntrateAmend());
                proc.setString(10, oPacsProductOperationBean.getInttfrequencyAmend());
                proc.setString(11, oPacsProductOperationBean.getInttmethodAmend());
                proc.setString(12, oPacsProductOperationBean.getMinbalAmend());
                proc.setString(13, oPacsProductOperationBean.getMaxbalAmend());
                proc.setString(14, oPacsProductOperationBean.getOdindicatorAmend());
                proc.setString(15, oPacsProductOperationBean.getPenalinttrateAmend());
                proc.setString(16, oPacsProductOperationBean.getPenalinttfrequencyAmend());
                proc.setString(17, oPacsProductOperationBean.getPenalinttmethodAmend());
                proc.setString(18, oPacsProductOperationBean.getMaxlimitAmend());
                proc.setString(19, oPacsProductOperationBean.getDrawingpowerAmend());
                proc.setString(20, oPacsProductOperationBean.getDebitComp1Amend());
                proc.setString(21, oPacsProductOperationBean.getDebitComp2Amend());
                proc.setString(22, oPacsProductOperationBean.getCreditComp1Amend());
                proc.setString(23, oPacsProductOperationBean.getCreditComp2Amend());
                proc.setString(24, ServletName);

                proc.registerOutParameter(25, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(25);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/pacsProductOperation.jsp").forward(request, response);

            }

        } else if ("StatusSearch".equalsIgnoreCase(ServletName)) {

            String inttCategoryActivation = request.getParameter("inttCategoryActivation");
            String productCodeActivation = request.getParameter("productCodeActivation");
            String vFlag = request.getParameter("PacsproductstatusFlag");

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call parameter.pacs_product_Activation(?,?,?,?)}");
                } catch (SQLException ex) {
                    Logger.getLogger(pacsProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, inttCategoryActivation);
                proc.setString(2, productCodeActivation);
                proc.setString(3, vFlag);
                proc.registerOutParameter(4, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(4);

            } catch (SQLException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                request.setAttribute("message", message);
                request.getRequestDispatcher("/pacsProductOperation.jsp").forward(request, response);

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
