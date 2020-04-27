/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.adhocReportBean;
import LoginDb.DbHandler;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import jxl.Workbook;
import jxl.*;
import jxl.write.*;

/**
 *
 * @author Tcs Helpdesk10
 */
public class HrmAdhocReportServlet extends HttpServlet {

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

        String handle_id = request.getParameter("handle_id");
        String report_ID = request.getParameter("reportID");
        Connection con = null;
        Statement statement = null;

        adhocReportBean oadhocReportBean = new adhocReportBean();

        if (handle_id.equalsIgnoreCase("Get Data")) {

            try {
                con = DbHandler.getDBConnection();
                statement = con.createStatement();
            } catch (SQLException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {

                ResultSet rs = statement.executeQuery("select REPORT_ID,REPORT_NAME,REPORT_QUERY,PARAMETER1,PARAMETER2,PARAMETER3,PARAMETER4,PARAMETER5,PARAMETER6,PARAMETER7,PARAMETER8,PARAMETER9,PARAMETER10 from pacs_adhoc_report where report_id= '" + report_ID + "' ");

                while (rs.next()) {

                    oadhocReportBean.setReportID(rs.getString("REPORT_ID"));
                    oadhocReportBean.setReportName(rs.getString("REPORT_NAME"));
                    oadhocReportBean.setReportQuery(rs.getString("REPORT_QUERY"));
                    oadhocReportBean.setParameter1(rs.getString("PARAMETER1"));
                    oadhocReportBean.setParameter2(rs.getString("PARAMETER2"));
                    oadhocReportBean.setParameter3(rs.getString("PARAMETER3"));
                    oadhocReportBean.setParameter4(rs.getString("PARAMETER4"));
                    oadhocReportBean.setParameter5(rs.getString("PARAMETER5"));
                    oadhocReportBean.setParameter6(rs.getString("PARAMETER6"));
                    oadhocReportBean.setParameter7(rs.getString("PARAMETER7"));
                    oadhocReportBean.setParameter8(rs.getString("PARAMETER8"));
                    oadhocReportBean.setParameter9(rs.getString("PARAMETER9"));
                    oadhocReportBean.setParameter10(rs.getString("PARAMETER10"));

                }

                statement.close();
                con.close();

            } catch (SQLException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            request.setAttribute("oadhocReportBeanObj", oadhocReportBean);

            request.getRequestDispatcher("/AdhocReport.jsp").forward(request, response);

        } else if (handle_id.equalsIgnoreCase("Download Report")) {

            try {
                BeanUtils.populate(oadhocReportBean, request.getParameterMap());
            } catch (IllegalAccessException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (InvocationTargetException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            response.setContentType("application/vnd.ms-excel");
            WorkbookSettings ws = new WorkbookSettings();
            ws.setLocale(new Locale("en", "EN"));
            OutputStream out = response.getOutputStream();

            String reportName = oadhocReportBean.getReportName();
            StringBuffer fileName = new StringBuffer("\\");
            fileName.append(reportName);
            fileName.append(".xls");
            response.setHeader("Content-disposition", "attachment; filename=\"" + fileName.toString() + "\"");

            try {
                WritableWorkbook workbook
                        = Workbook.createWorkbook(out, ws);
                WritableSheet s = workbook.createSheet(reportName, 0);
                downloadAdhocReport(oadhocReportBean, s);
                workbook.write();
                workbook.close();
                out.flush();
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

    }

    public void downloadAdhocReport(adhocReportBean oadhocReportBean, WritableSheet s) {

        int count = 0;
        ArrayList arylstOutArray; //Output
        Connection con = null;
        CallableStatement proc = null;
        String query = null;

        try {
            con = DbHandler.getDBConnection();
            try {
                proc = con.prepareCall("{ call proc_ExecuteAdhocreport(?,?,?,?,?,?,?,?,?,?,?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            proc.setString(1, oadhocReportBean.getReportID());
            proc.setString(2, oadhocReportBean.getValue1());
            proc.setString(3, oadhocReportBean.getValue2());
            proc.setString(4, oadhocReportBean.getValue3());
            proc.setString(5, oadhocReportBean.getValue4());
            proc.setString(6, oadhocReportBean.getValue5());
            proc.setString(7, oadhocReportBean.getValue6());
            proc.setString(8, oadhocReportBean.getValue7());
            proc.setString(9, oadhocReportBean.getValue8());
            proc.setString(10, oadhocReportBean.getValue9());
            proc.setString(11, oadhocReportBean.getValue10());

            proc.registerOutParameter(12, java.sql.Types.VARCHAR);

            proc.execute();

            query = proc.getString(12);

        } catch (SQLException ex) {
            Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                proc.close();
            } catch (SQLException e) {
            }
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(HrmAdhocReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        Statement stmt = null;
        Connection conn = null;
        ResultSet rs = null;

        try {

            conn = DbHandler.getDBConnection();
            stmt = conn.createStatement();

            // This is for testing purpose to check the query
            //System.out.println(query);
            rs = stmt.executeQuery(query);
            // Get result set meta data
            ResultSetMetaData rsmd = rs.getMetaData();
            int numColumns = rsmd.getColumnCount();

            int rowPos = 0;
            int colPos;
            WritableFont wf;
            WritableCellFormat cf;

            // This is for Heading 
            wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD);
            cf = new WritableCellFormat(wf);
            cf.setWrap(false);
            cf.setBackground(jxl.format.Colour.LIGHT_GREEN);
            cf.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            CellView cv = new CellView();
            cv.setAutosize(true);
            ArrayList heading = new ArrayList(numColumns);

            // Get the column names; column indices start from 1
            for (int i = 1; i < numColumns + 1; i++) {
                String columnName = rsmd.getColumnName(i);
                s.addCell(new Label(i - 1, rowPos, columnName, cf));
                heading.add(i - 1, columnName);
                s.setColumnView(i, cv);
                /*
                 // Get the name of the column's table name
                 String tableName = rsmd.getTableName(i);
                 */
            }
            // This is for Results
            //Reset Fonts for results section
            wf = new WritableFont(WritableFont.ARIAL, 11, WritableFont.NO_BOLD);

            //Looping For results  
            while (rs.next()) {
                rowPos++;
                colPos = -1;
                Iterator itrHeading = heading.iterator();
                while (colPos + 1 < heading.size()) {
                    colPos++;
                    String sHeading = heading.get(colPos).toString();
                    cf = new WritableCellFormat(wf);
                    cf.setWrap(false);
                    cf.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
                    cv.setAutosize(true);
                    s.addCell(new Label(colPos, rowPos, rs.getString(sHeading), cf));
                    s.setColumnView(colPos, cv);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {

                if (stmt != null) {
                    stmt.close();
                }
                if (rs != null) {
                    rs.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
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
