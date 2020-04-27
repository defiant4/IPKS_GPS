/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ExcelReportController;

import Controller.EnquiryServlet;
import DataEntryBean.EnquiryBean;
import DataEntryBean.ExcelReportBean;
import DataEntryBean.GLTransactionEnquiryBean;
import DataEntryBean.GlAccountEnquiryBean;
import DataEntryBean.TransactionEnquiryBean;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

/**
 *
 * @author Tcs Helpdesk10
 */
public class ExcelReportServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String CONTENT_TYPE_EXCEL = "application/vnd.ms-excel";

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String pacsId = (String) session.getAttribute("pacsId");
        String JSP_Name="";
        JSP_Name = null==(request.getParameter("screenName"))?"":(request.getParameter("screenName"));

        response.setContentType(CONTENT_TYPE_EXCEL);

        String reportName = (String) request.getParameter("reportname");

        //To Populate Bean
        ExcelReportBean ExcelReportBeanObj = new ExcelReportBean();
        ExcelReportBeanObj = null;

        if (JSP_Name.equalsIgnoreCase("accountEnquiry")) {

            EnquiryBean oEnquiryBean = new EnquiryBean();
            oEnquiryBean = (EnquiryBean) session.getAttribute("oEnquiryBeanSearchObj");

            ExcelReportBeanObj = new ExcelReportBean();

            ExcelReportBeanObj.setAccountNo(oEnquiryBean.getAccountNo());
            ExcelReportBeanObj.setFromAmount(oEnquiryBean.getFromAmount());
            ExcelReportBeanObj.setToAmount(oEnquiryBean.getToAmount());
            ExcelReportBeanObj.setProductName(oEnquiryBean.getProductId());
            ExcelReportBeanObj.setToDate(oEnquiryBean.getToDate());
            ExcelReportBeanObj.setFromDate(oEnquiryBean.getFromDate());
            ExcelReportBeanObj.setFromDate(oEnquiryBean.getLinkedSbAccount());

           // session.removeAttribute("oEnquiryBeanSearchObj");

        } else if (JSP_Name.equalsIgnoreCase("transactionEnquiry")) {

            TransactionEnquiryBean oTransactionEnquiryBean = new TransactionEnquiryBean();
            oTransactionEnquiryBean = (TransactionEnquiryBean) session.getAttribute("oTransactionEnquiryBeanSearchObj");

            ExcelReportBeanObj = new ExcelReportBean();

            ExcelReportBeanObj.setAccountNo(oTransactionEnquiryBean.getAccountNo());
            ExcelReportBeanObj.setFromAmount(oTransactionEnquiryBean.getFromAmount());
            ExcelReportBeanObj.setToAmount(oTransactionEnquiryBean.getToAmount());
            ExcelReportBeanObj.setProductName(oTransactionEnquiryBean.getProductId());
            ExcelReportBeanObj.setToDate(oTransactionEnquiryBean.getToDate());
            ExcelReportBeanObj.setFromDate(oTransactionEnquiryBean.getFromDate());
            ExcelReportBeanObj.setFromDate(oTransactionEnquiryBean.getLinkedSbAccount());

           // session.removeAttribute("oTransactionEnquiryBeanSearchObj");

        } else if (JSP_Name.equalsIgnoreCase("glAccountEnquiry")) {

            GlAccountEnquiryBean oGlAccountEnquiryBean = new GlAccountEnquiryBean();
            oGlAccountEnquiryBean = (GlAccountEnquiryBean) session.getAttribute("oGlAccountEnquiryBeanSearchObj");

            ExcelReportBeanObj = new ExcelReportBean();

            ExcelReportBeanObj.setAccountNo(oGlAccountEnquiryBean.getAccountNo());
            ExcelReportBeanObj.setFromAmount(oGlAccountEnquiryBean.getFromAmount());
            ExcelReportBeanObj.setToAmount(oGlAccountEnquiryBean.getToAmount());
            ExcelReportBeanObj.setProductName(oGlAccountEnquiryBean.getProductId());
            ExcelReportBeanObj.setToDate(oGlAccountEnquiryBean.getToDate());
            ExcelReportBeanObj.setFromDate(oGlAccountEnquiryBean.getFromDate());

           // session.removeAttribute("oGlAccountEnquiryBeanSearchObj");

        } else if (JSP_Name.equalsIgnoreCase("glTransactionEnquiry")) {

            GLTransactionEnquiryBean oGLTransactionEnquiryBean = new GLTransactionEnquiryBean();
            oGLTransactionEnquiryBean = (GLTransactionEnquiryBean) session.getAttribute("oGlTransactionEnquiryBeanobj");

            ExcelReportBeanObj = new ExcelReportBean();

            ExcelReportBeanObj.setAccountNo(oGLTransactionEnquiryBean.getAccountNo());
            ExcelReportBeanObj.setFromAmount(oGLTransactionEnquiryBean.getFromAmount());
            ExcelReportBeanObj.setToAmount(oGLTransactionEnquiryBean.getToAmount());
            ExcelReportBeanObj.setProductName(oGLTransactionEnquiryBean.getProductId());
            ExcelReportBeanObj.setToDate(oGLTransactionEnquiryBean.getToDate());
            ExcelReportBeanObj.setFromDate(oGLTransactionEnquiryBean.getFromDate());

           // session.removeAttribute("oGlTransactionEnquiryBeanobj");

        }

//To Populate Bean Ends Here
        
        response.addHeader("content-disposition",
                "attachment; filename=" + reportName + ".xls");

        OutputStream out = response.getOutputStream();

        ExcelReport excelReport = new ExcelReport();
        WorkbookSettings ws = excelReport.getWorkBookSetting();
        String query = null;

        try {
            WritableWorkbook workbook
                    = Workbook.createWorkbook(out, ws);
            WritableSheet s = workbook.createSheet(reportName, 0);
            ExcelReportInformation ex = new ExcelReportInformation(reportName);

            if (null == ExcelReportBeanObj) {
                query = ex.getReportQuery();

            } else {

                query = ex.getReportQuery(ExcelReportBeanObj, pacsId);
            }

            ArrayList aHeader = ex.getReportHeader();
            excelReport.writeDataSheet(s, aHeader, query);

            workbook.write();
            workbook.close();
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
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
        processRequest(request, response);
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
