/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JasperReportController;

import DataEntryBean.JasperReportBean;
import LoginDb.DbHandler;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;
import org.apache.commons.beanutils.BeanUtils;

public class jasperReportServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String pacsId = (String) session.getAttribute("pacsId");

        JasperReportBean Bean = new JasperReportBean();

        try {
            BeanUtils.populate(Bean, request.getParameterMap());
        } catch (IllegalAccessException ex) {
            Logger.getLogger(jasperReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InvocationTargetException ex) {
            Logger.getLogger(jasperReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        Bean.setPacs_id(pacsId);

        Map reportParams = null;
        if (null != Bean) {
            reportParams = prepareReportInput(request, Bean);
        }

        String download = (String) request.getParameter("DOWNLOAD");
        String memberId = (String) request.getParameter("memberId");
        //String from_Date = (String) request.getParameter("from_Date");
        //String to_Date = (String) request.getParameter("to_Date");
        request.setAttribute("DOWNLOAD", download);
        request.setAttribute("memberId", memberId);
        //request.setAttribute("from_Date", from_Date);
        //request.setAttribute("to_Date", to_Date);
        
        request.setAttribute("reportBody", createJasperPrint(request, reportParams));
        request.getRequestDispatcher("Reports.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    protected JasperPrint createJasperPrint(HttpServletRequest req, Map reportParams) {
        HttpSession session = req.getSession();
        createReportFileName(req, reportParams);

        System.out.println(reportParams.get("pacs_id"));
        System.out.println(reportParams.get("txn_date"));

        String repPath = (String) req.getParameter("reportPath");
        System.out.println("Report Path is .." + repPath);
        File reportFile = new File(req.getSession(false).getServletContext().getRealPath(repPath));
        if (!reportFile.exists()) {
            throw new JRRuntimeException("File WebappReport.jasper not found. The report design must be compiled first.");
        }
        JasperReport jasperReport = null;
        try {
            jasperReport = (JasperReport) JRLoader.loadObject(reportFile.getPath());
            System.out.println("REPORT_DIR - " + reportFile.getPath());
        } catch (JRException e) {
            e.printStackTrace();
            throw new RuntimeException("Exception while loading the report", e);
        }
        if (null == jasperReport) {
            throw new RuntimeException("Report not found in Path " + repPath);
        }
        if (null == reportParams) {
            reportParams = new HashMap(2, 1.0f);
        }

        reportParams.put("SUBREPORT_DIR", reportFile.getParentFile().getAbsolutePath());

        Connection conn = null;
        JasperPrint jasperPrint = null;
        try {
            conn = DbHandler.getDBConnection();
            jasperPrint = JasperFillManager.fillReport(jasperReport, reportParams, conn);
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Exception while filling the report with data", e);
        } finally {
            if (null != conn) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    throw new RuntimeException("Exception while closing Connection ", e);
                }
            }
        }
        return jasperPrint;
    }

    private void createReportFileName(HttpServletRequest req, Map reportParams) {
        StringBuffer fileName = new StringBuffer("attachment; filename=\"");

        String reportName = (String) req.getParameter("reportName");
        String memberId = (String) req.getParameter("memberId");
        if(memberId== null){
            memberId = "";
        }
        String from_Date = (String) req.getParameter("from_Date");
        String to_Date = (String) req.getParameter("to_Date");
        String report_Date = "";
        String dccb_code = "";
        Connection connection = null;

        try {
            ResultSet resultset = null;
            Statement statement = null;
            connection = DbHandler.getDBConnection();
            statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("select to_char(system_date,'ddmmyyyy') as report_Date from system_date");
            while (rs.next()) {

                report_Date = rs.getString("report_Date");

            }
            statement.close();
            connection.close();

        } catch (SQLException ex) {
            Logger.getLogger(jasperReportServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (reportName.equalsIgnoreCase("P2P_I2I")) {

            dccb_code=reportParams.get("dccb_code").toString();
            String dccb_name="";
            
            try {
                ResultSet resultset = null;
                Statement statement = null;
                connection = DbHandler.getDBConnection();
                statement = connection.createStatement();

                ResultSet rs = statement.executeQuery("select distinct dccb_name from dccb_br_map where dccb_code='" + dccb_code + "' ");
                while (rs.next()) {

                    dccb_name = rs.getString("dccb_name");

                }
                statement.close();
                connection.close();

            } catch (SQLException ex) {
                Logger.getLogger(jasperReportServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

          fileName.append(dccb_name);
          fileName.append("_");
        
        }

        if ("E".equalsIgnoreCase(req.getParameter("DOWNLOAD"))) {
            fileName.append(reportName);
            fileName.append("_");
            fileName.append(report_Date);
            fileName.append(".xls\"");
        }
        else if ("P".equalsIgnoreCase(req.getParameter("DOWNLOAD")) && !memberId.equals("")) {
            fileName.append(memberId);
            fileName.append("_");
            fileName.append(reportName);
            fileName.append("_");
            fileName.append(report_Date);
            fileName.append(".pdf\"");
        }else if ("P".equalsIgnoreCase(req.getParameter("DOWNLOAD"))) {
            fileName.append(reportName);
            fileName.append("_");
            fileName.append(report_Date);
            fileName.append(".pdf\"");
        }
        
        req.setAttribute("fileName", fileName.toString());
    }

    protected Map prepareReportInput(HttpServletRequest req, JasperReportBean Bean) {
        Map reportInput = (Map) Bean.getData(req);
        return reportInput;
    }

}
