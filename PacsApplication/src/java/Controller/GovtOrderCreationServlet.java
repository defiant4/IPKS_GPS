/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DataEntryBean.GovtOrderCreationBean;
import DataEntryBean.GovtOrderCreationDetailBean;
import DataEntryBean.GovtOrderCreationExpenseBean;
import DataEntryBean.GovtOrderCreationHeaderBean;
import LoginDb.DbHandler;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.StringTokenizer;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;
import org.apache.commons.beanutils.BeanUtils;

/**
 *
 * @author 590685
 */
public class GovtOrderCreationServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {

        HttpSession session = request.getSession(false);
        Connection con = null;
        Connection con1 = null;
        Connection con2 = null;
        CallableStatement stmt = null;
        CallableStatement proc = null;
        String message = "";
        String orderId = "";
        String pacsId = (String) session.getAttribute("pacsId");
        String user = (String) session.getAttribute("user");
        String ServletName = request.getParameter("handle_id");

        ArrayList<GovtOrderCreationDetailBean> alGovtOrderCreationDetailBean = new ArrayList<GovtOrderCreationDetailBean>();
        ArrayList<GovtOrderCreationExpenseBean> alGovtOrderCreationExpenseBean = new ArrayList<GovtOrderCreationExpenseBean>();
        ArrayList<GovtOrderCreationDetailBean> alGovtOrderCreationDetailBeanNew = new ArrayList<GovtOrderCreationDetailBean>();
        ArrayList<GovtOrderCreationDetailBean> alGovtOrderCreationDetailUpdated = new ArrayList<GovtOrderCreationDetailBean>();
         ArrayList<GovtOrderCreationDetailBean> alGovtOrderCreationDetailDeleted = new ArrayList<GovtOrderCreationDetailBean>();

        GovtOrderCreationHeaderBean oGovtOrderCreationHeaderBeanBean = new GovtOrderCreationHeaderBean();
        try {
            BeanUtils.populate(oGovtOrderCreationHeaderBeanBean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        GovtOrderCreationDetailBean oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
        try {
            BeanUtils.populate(oGovtOrderCreationDetailBean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        GovtOrderCreationExpenseBean oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
        try {
            BeanUtils.populate(oGovtOrderCreationExpenseBean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(AccountCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if ("Create".equalsIgnoreCase(ServletName)) {

            //START HEADER PART
            try {

                con = DbHandler.getDBConnection();
                try {

                    stmt = con.prepareCall("{ call GPS_Operation.govt_proc_head(?,?,?,?,?,?,?) }");

                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                stmt.setString(1, oGovtOrderCreationHeaderBeanBean.getGovtOrderCodeCreate());
                stmt.setString(2, oGovtOrderCreationHeaderBeanBean.getGovtOrderDesc());
                stmt.setString(3, oGovtOrderCreationHeaderBeanBean.getProcStartDate());
                stmt.setString(4, oGovtOrderCreationHeaderBeanBean.getProcEndDate());
                stmt.setString(5, pacsId);
                stmt.setString(6, oGovtOrderCreationHeaderBeanBean.getGovtCommission());
                stmt.registerOutParameter(7, java.sql.Types.VARCHAR);
                stmt.execute();
                orderId = stmt.getString(7);
                message = "Order Code Already Exsist";

            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                System.out.println(ex.toString());
            }

            //END HEADER PART
            //START DETAIL PART
            if (!orderId.equals("Order Code Already Exsist")) {
                int counter = Integer.parseInt(request.getParameter("rowCounter"));

                for (int i = 1; i <= counter; i++) {
                    try {

                        String item_type = request.getParameter("item_type" + i);
                        String item_subtype = request.getParameter("item_subtype" + i);
                        String item_unit = request.getParameter("item_unit" + i);
                        String qty = request.getParameter("qty" + i);
                        String item_rateperunit = request.getParameter("item_rateperunit" + i);
                        String total = request.getParameter("total" + i);
                        String commodityId = request.getParameter("commodityId" + i);

                        if (commodityId != null) {
                            oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                            oGovtOrderCreationDetailBean.setCommodityId(commodityId);
                            oGovtOrderCreationDetailBean.setItem_type(item_type);
                            oGovtOrderCreationDetailBean.setItem_subtype(item_subtype);
                            oGovtOrderCreationDetailBean.setItem_unit(item_unit);
                            oGovtOrderCreationDetailBean.setQty(qty);
                            oGovtOrderCreationDetailBean.setItem_rateperunit(item_rateperunit);
                            oGovtOrderCreationDetailBean.setTotal(total);

                            alGovtOrderCreationDetailBean.add(oGovtOrderCreationDetailBean);
                        }
                    } catch (Exception e) {
                    }
                }

                if (alGovtOrderCreationDetailBean.size() > 0) {
                    try {
                        con1 = DbHandler.getDBConnection();
                        stmt = con1.prepareCall("{ call GPS_Operation.govt_proc_detail(?,?,?,?,?) }");
                        for (int j = 0; j < alGovtOrderCreationDetailBean.size(); j++) {
                            oGovtOrderCreationDetailBean = alGovtOrderCreationDetailBean.get(j);
                            stmt.setString(1, orderId);
                            stmt.setString(2, oGovtOrderCreationDetailBean.getCommodityId());
                            stmt.setString(3, oGovtOrderCreationDetailBean.getQty());
                            stmt.setString(4, oGovtOrderCreationDetailBean.getItem_rateperunit());
                            stmt.setString(5, oGovtOrderCreationDetailBean.getTotal());
                            stmt.addBatch();

                        }

                        stmt.executeBatch();

                    } catch (SQLException ex) {
                        String delete = "Delete from gps_govt_proc_header where id = '" + orderId + "' ";
                        Connection conn = DbHandler.getDBConnection();
                        PreparedStatement pstmt = conn.prepareCall(delete);
                        pstmt.executeQuery();
                        if (conn != null) {
                            conn.commit();
                            conn.close();
                        }
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }

                }

                // END DETAIL PART
                // START EXPENSE PART
                int counter1 = Integer.parseInt(request.getParameter("rowCounter1"));

                for (int i = 1; i <= counter1; i++) {
                    try {

                        String expense_head = request.getParameter("expense_head" + i);
                        String expense_unit = request.getParameter("expense_unit" + i);
                        String expense_rate_per_unit = request.getParameter("expense_rate_per_unit" + i);

                        oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
                        oGovtOrderCreationExpenseBean.setExpense_head(expense_head);
                        oGovtOrderCreationExpenseBean.setExpense_unit(expense_unit);
                        oGovtOrderCreationExpenseBean.setExpense_rate_per_unit(expense_rate_per_unit);

                        alGovtOrderCreationExpenseBean.add(oGovtOrderCreationExpenseBean);

                    } catch (Exception e) {
                    }
                }

                if (alGovtOrderCreationExpenseBean.size() > 0) {

                    try {
                        con2 = DbHandler.getDBConnection();
                        stmt = con2.prepareCall("{ call GPS_Operation.expense_detail(?,?,?,?) }");
                        for (int j = 0; j < alGovtOrderCreationExpenseBean.size(); j++) {
                            oGovtOrderCreationExpenseBean = alGovtOrderCreationExpenseBean.get(j);
                            stmt.setString(1, orderId);
                            stmt.setString(2, oGovtOrderCreationExpenseBean.getExpense_head());
                            stmt.setString(3, oGovtOrderCreationExpenseBean.getExpense_unit());
                            stmt.setString(4, oGovtOrderCreationExpenseBean.getExpense_rate_per_unit());
                            stmt.addBatch();

                        }
                        stmt.executeBatch();
                        message = "Order Created Successfully. Order Id is " + orderId;
                    } catch (SQLException ex) {
                        String deleteHead = "Delete from gps_govt_proc_header where id = '" + orderId + "' ";
                        String deleteDetail = "Delete from gps_govt_proc_detail where order_id = '" + orderId + "' ";
                        Connection conn = DbHandler.getDBConnection();
                        Connection conn1 = DbHandler.getDBConnection();
                        PreparedStatement pstmt = conn.prepareCall(deleteHead);
                        PreparedStatement pstmt1 = conn1.prepareCall(deleteDetail);
                        pstmt.executeQuery();
                        pstmt1.executeQuery();
                        if (conn != null) {
                            conn.commit();
                            conn.close();
                        }
                        if (conn1 != null) {
                            conn1.commit();
                            conn1.close();
                        }
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    } finally {
                        try {
                            stmt.close();
                        } catch (SQLException e) {
                            System.out.println(e.toString());
                        }
                        try {
                            con2.close();
                        } catch (SQLException ex) {
                            con.rollback();
                            con1.rollback();
                            con2.rollback();
                            Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                            System.out.println(ex.toString());
                        }
                    }

                }
            }

        }

        if ("Search".equalsIgnoreCase(ServletName)) {

            try {
                BeanUtils.populate(oGovtOrderCreationHeaderBeanBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Connection connection = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            int SeachFound = 0;

            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select id,order_code,order_desc,to_char(proc_start_dt,'DD/MM/YYYY'),to_char(proc_end_dt,'DD/MM/YYYY'),commissionrate from gps_govt_proc_header t where t.id= '" + oGovtOrderCreationHeaderBeanBean.getGovtOrderId() + "' ");

                while (rs.next()) {

                    oGovtOrderCreationHeaderBeanBean.setGovtOrderId(rs.getString("id"));
                    oGovtOrderCreationHeaderBeanBean.setGovtOrderCodeCreate(rs.getString("order_code"));
                    oGovtOrderCreationHeaderBeanBean.setGovtOrderDesc(rs.getString("order_desc"));
                    oGovtOrderCreationHeaderBeanBean.setProcStartDate(rs.getString(4));
                    oGovtOrderCreationHeaderBeanBean.setProcEndDate(rs.getString(5));
                    oGovtOrderCreationHeaderBeanBean.setGovtCommission(rs.getString("commissionrate"));

                    SeachFound = 1;
                    request.setAttribute("displayFlag", "Y");

                }

                statement.close();

            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            if (SeachFound == 0) {
                message = "Order not exists in the system";
                request.setAttribute("message", message);
            }

            //For Details Part Populate
            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                String query = "select t.order_id,g.ITEM_TYPE,g.type_desc,g.ITEM_SUBTYPE,g.subtype_desc,g.unit,t.rate_unit,t.total,t.quantity_available "
                        + " from gps_govt_proc_detail t,gps_commodity_master g"
                        + " where t.commodity_id=g.id"
                        + " and t.order_id= '" + oGovtOrderCreationHeaderBeanBean.getGovtOrderId() + "' ";
                ResultSet rs = statement.executeQuery(query);

                while (rs.next()) {

                    oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                    oGovtOrderCreationDetailBean.setGovtOrderId_Dtl(rs.getString("order_id"));
                    oGovtOrderCreationDetailBean.setItem_type(rs.getString("ITEM_TYPE"));
                    oGovtOrderCreationDetailBean.setItem_subtype(rs.getString("ITEM_SUBTYPE"));
                    oGovtOrderCreationDetailBean.setItem_unit(rs.getString("unit"));
                    oGovtOrderCreationDetailBean.setItem_rateperunit(rs.getString("rate_unit"));
                    oGovtOrderCreationDetailBean.setTotal(rs.getString("total"));
                    oGovtOrderCreationDetailBean.setQty(rs.getString("quantity_available"));
                    oGovtOrderCreationDetailBean.setItem_desc(rs.getString("type_desc"));
                    oGovtOrderCreationDetailBean.setSubtype_desc(rs.getString("subtype_desc"));

                    alGovtOrderCreationDetailBean.add(oGovtOrderCreationDetailBean);

                }

                statement.close();

            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            //start of expense part
            try {
                statement = connection.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                String query = "select expense_head,expense_unit,expense_rate from order_expense_detail t"
                        + " where t.order_id= '" + oGovtOrderCreationHeaderBeanBean.getGovtOrderId() + "' ";
                ResultSet rs = statement.executeQuery(query);

                while (rs.next()) {

                    oGovtOrderCreationExpenseBean = new GovtOrderCreationExpenseBean();
                    oGovtOrderCreationExpenseBean.setExpense_head(rs.getString("expense_head"));
                    oGovtOrderCreationExpenseBean.setExpense_unit(rs.getString("expense_unit"));
                    oGovtOrderCreationExpenseBean.setExpense_rate_per_unit(rs.getString("expense_rate"));

                    alGovtOrderCreationExpenseBean.add(oGovtOrderCreationExpenseBean);

                }

                statement.close();

            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("GovtOrderCreationHeaderBeanObj", oGovtOrderCreationHeaderBeanBean);
            request.setAttribute("alGovtOrderCreationDetailBean", alGovtOrderCreationDetailBean);
            request.setAttribute("alGovtOrderCreationExpenseBean", alGovtOrderCreationExpenseBean);

            request.getRequestDispatcher("/GPS_JSP/GovtOrderCreation.jsp").forward(request, response);

        }
        
        if ("Update".equalsIgnoreCase(ServletName)) {
            
            String OrderId_for_Amend = null;
            String rowStatus = null;
            String detailID = null;
            String deletedRows = null;


            try {
                BeanUtils.populate(oGovtOrderCreationHeaderBeanBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                con = DbHandler.getDBConnection();
                try {
                    proc = con.prepareCall("{ call GPS_Operation.Upsert_govOrder_hdr(?,?,?,?,?,?,?,?,?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, oGovtOrderCreationHeaderBeanBean.getOrderidAmend());
                proc.setString(2, oGovtOrderCreationHeaderBeanBean.getGovtOrderCodeCreateAmend());
                proc.setString(3, oGovtOrderCreationHeaderBeanBean.getGovtOrderDescAmend());
                proc.setString(4, oGovtOrderCreationHeaderBeanBean.getProcStartDateAmend());
                proc.setString(5, oGovtOrderCreationHeaderBeanBean.getProcEndDateAmend());
                proc.setString(6, oGovtOrderCreationHeaderBeanBean.getGovtCommissionAmend());
                proc.setString(7, ServletName);
                proc.setString(8, pacsId);
                proc.registerOutParameter(9, java.sql.Types.VARCHAR);
                proc.registerOutParameter(10, java.sql.Types.VARCHAR);

                proc.execute();

                message = proc.getString(9);
                orderId = proc.getString(10);



            } catch (SQLException ex) {
                Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    con.commit();
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
            int counter = Integer.parseInt(request.getParameter("rowCounterAmend"));

            for (int i = 1; i <= counter; i++) {
                try {

                   OrderId_for_Amend = request.getParameter("orderidAmend");
                    rowStatus = request.getParameter("rowStatus" + i);
                    detailID = request.getParameter("detailIDAmend" + i);


                    if (OrderId_for_Amend != null && rowStatus != null) {
                        oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                        oGovtOrderCreationDetailBean.setOrderId_for_Amend(OrderId_for_Amend);
                        oGovtOrderCreationDetailBean.setDetailID(detailID);

                        if (rowStatus.equals("A")) {
                            alGovtOrderCreationDetailBeanNew.add(oGovtOrderCreationDetailBean);
                        } else {
                            alGovtOrderCreationDetailUpdated.add(oGovtOrderCreationDetailBean);
                        }


                    }
                } catch (Exception e) {
                }
            }



            //For Deletion

            deletedRows = request.getParameter("deletedRows");

            if ((!deletedRows.equalsIgnoreCase(null)) || (!deletedRows.equalsIgnoreCase("")))
            {
                StringTokenizer tokenizer = new StringTokenizer(deletedRows, ",");

                while (tokenizer.hasMoreTokens()) {

                  oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                  oGovtOrderCreationDetailBean.setDetailID(tokenizer.nextToken());

                  alGovtOrderCreationDetailDeleted.add(oGovtOrderCreationDetailBean);

                }
            }




            if ((alGovtOrderCreationDetailUpdated.size() > 0) && (!message.equalsIgnoreCase(""))) {

                try {
                    con = DbHandler.getDBConnection();
                    try {
                        proc = con.prepareCall("{ call parameter.Upsert_vendor_dtl(?,?,?,?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }


                    for (int j = 0; j < alGovtOrderCreationDetailUpdated.size(); j++) {

                        oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();

                        oGovtOrderCreationDetailBean = alGovtOrderCreationDetailUpdated.get(j);


                        proc.setString(1, orderId);
                        proc.setString(2, oGovtOrderCreationDetailBean.getDetailID());
                        proc.setString(3, oGovtOrderCreationDetailBean.getOrderId_for_Amend());
                        proc.setString(4, ServletName);
                        proc.addBatch();


                    }

                    proc.executeBatch();

                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }
                }
            }

            //for deletion

            if ((alGovtOrderCreationDetailDeleted.size() > 0) && (!message.equalsIgnoreCase(""))) {

                try {
                    con = DbHandler.getDBConnection();
                    try {
                        proc = con.prepareCall("{ call parameter.Upsert_vendor_dtl(?,?,?,?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }


                    for (int j = 0; j < alGovtOrderCreationDetailDeleted.size(); j++) {

                        oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();

                        oGovtOrderCreationDetailBean = alGovtOrderCreationDetailDeleted.get(j);


                        proc.setString(1, orderId);
                        proc.setString(2, oGovtOrderCreationDetailBean.getDetailID());
                        proc.setString(3, null);
                        proc.setString(4, "Delete");
                        proc.addBatch();


                    }

                    proc.executeBatch();

                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }
                }
            }


            //For New Insertion


            if ((alGovtOrderCreationDetailBeanNew.size() > 0) && (message.equalsIgnoreCase(""))) {

                try {
                    con = DbHandler.getDBConnection();
                    try {
                        proc = con.prepareCall("{ call parameter.Upsert_vendor_dtl(?,?,?,?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }


                    for (int j = 0; j < alGovtOrderCreationDetailBeanNew.size(); j++) {

                        oGovtOrderCreationDetailBean = new GovtOrderCreationDetailBean();
                        oGovtOrderCreationDetailBean = alGovtOrderCreationDetailBeanNew.get(j);


                        proc.setString(1, orderId);
                        proc.setString(2, oGovtOrderCreationDetailBean.getDetailID());
                        proc.setString(3, oGovtOrderCreationDetailBean.getOrderId_for_Amend());
                        proc.setString(4, "Create");
                        proc.addBatch();


                    }

                    proc.executeBatch();

                } catch (SQLException ex) {
                    Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
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
                        Logger.getLogger(GovtOrderCreationServlet.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println(ex.toString());
                    }
                }
            }


            request.setAttribute("message", message);
            request.getRequestDispatcher("/GPS_JSP/GovtOrderCreation.jsp").forward(request, response);
            
        }

        

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
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(GovtOrderCreationServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(GovtOrderCreationServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
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
