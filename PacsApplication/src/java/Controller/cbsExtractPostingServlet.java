/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.CBSDataPostingBean;
import DataEntryBean.EnquiryBean;
import LoginDb.DbHandler;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author Tcs Helpdesk10
 */
public class cbsExtractPostingServlet extends HttpServlet {

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

        HttpSession session = request.getSession(false);
        String find_Status = "";
        String filePath = getServletContext().getInitParameter("cbs-extract");

        CBSDataPostingBean oCBSDataPostingBean = new CBSDataPostingBean();
        ArrayList<CBSDataPostingBean> alCBSDataPostingBean = new ArrayList<CBSDataPostingBean>();

        CallableStatement proc = null;
        String message = "";
        Connection connection = null;
        ResultSet rs = null;
        String handle_id = "";
        String screen_name = "";

        handle_id = request.getParameter("handle_id");
        screen_name = request.getParameter("screen_name");

        //For Bulk CBS Transaction Posting
        if (screen_name.equalsIgnoreCase("CBSDataPosting.jsp")) {

            if (handle_id.equalsIgnoreCase("cbsUpload")) {

                //For Listing the file name
                find_Status = getList(filePath, handle_id);

                if (find_Status.equalsIgnoreCase("Success")) {
                    //For Loading the file content in stagging table

                    find_Status = FIleUploadToStagging(handle_id);

                    if (find_Status.equalsIgnoreCase("Success")) {

                        message = "CBS File has been uploaded successfully";
                        request.setAttribute("message", message);

                    }
                }

                request.getRequestDispatcher("/CBSDataPosting.jsp").forward(request, response);

            } else if (handle_id.equalsIgnoreCase("viewStatus")) {

                try {
                    connection = DbHandler.getDBConnection();
                    try {
                        proc = connection.prepareCall("{ ?=call file_enquiry(?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proc.registerOutParameter(1, OracleTypes.CURSOR);
                    proc.setString(2, screen_name);

                    proc.executeUpdate();

                    rs = (ResultSet) proc.getObject(1);

                    while (rs.next()) {

                        oCBSDataPostingBean = new CBSDataPostingBean();

                        oCBSDataPostingBean.setFileName(rs.getString(1));
                        oCBSDataPostingBean.setDccbName(rs.getString(2));
                        oCBSDataPostingBean.setUploadStatus(rs.getString(3));

                        alCBSDataPostingBean.add(oCBSDataPostingBean);

                        request.setAttribute("displayFlag", "Y");

                    }

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

                request.setAttribute("alCBSDataPostingBean", alCBSDataPostingBean);
                request.getRequestDispatcher("/CBSDataPosting.jsp").forward(request, response);

            } else if (handle_id.equalsIgnoreCase("cbsPost")) {

                String errorlog = "";

                try {
                    connection = DbHandler.getDBConnection();
                    try {
                        proc = connection.prepareCall("{ call EODSOD.post_txn_bulk(?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proc.registerOutParameter(1, java.sql.Types.VARCHAR);

                    proc.executeUpdate();

                    errorlog = proc.getString(1);

                    message = errorlog;
                    request.setAttribute("message", message);

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
           
            (request.getRequestDispatcher("/CBSDataPosting.jsp")).forward(request, response);
            
            }

            

            //For Bulk KYC Details Posting
        } else if (screen_name.equalsIgnoreCase("CBSKycPosting.jsp")) {

            if (handle_id.equalsIgnoreCase("kycUpload")) {

                //For Listing the file name
                find_Status = getList(filePath, handle_id);

                if (find_Status.equalsIgnoreCase("Success")) {
                    //For Loading the file content in stagging table

                    find_Status = FIleUploadToStagging(handle_id);

                    if (find_Status.equalsIgnoreCase("Success")) {

                        message = "Customer Information File has been uploaded successfully";
                        request.setAttribute("message", message);

                    }
                }

                (request.getRequestDispatcher("/CBSKycPosting.jsp")).forward(request, response);

            } else if (handle_id.equalsIgnoreCase("viewStatus")) {

                try {
                    connection = DbHandler.getDBConnection();
                    try {
                        proc = connection.prepareCall("{ ?=call file_enquiry(?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proc.registerOutParameter(1, OracleTypes.CURSOR);
                    proc.setString(2, screen_name);

                    proc.executeUpdate();

                    rs = (ResultSet) proc.getObject(1);

                    while (rs.next()) {

                        oCBSDataPostingBean = new CBSDataPostingBean();

                        oCBSDataPostingBean.setFileName(rs.getString(1));
                        oCBSDataPostingBean.setDccbName(rs.getString(2));
                        oCBSDataPostingBean.setUploadStatus(rs.getString(3));

                        alCBSDataPostingBean.add(oCBSDataPostingBean);

                        request.setAttribute("displayFlag", "Y");

                    }

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

                request.setAttribute("alCBSDataPostingBean", alCBSDataPostingBean);
                request.getRequestDispatcher("/CBSKycPosting.jsp").forward(request, response);

            } else if (handle_id.equalsIgnoreCase("kycPost")) {

                String errorlog = "";

                try {
                    connection = DbHandler.getDBConnection();
                    try {
                        proc = connection.prepareCall("{ call EODSOD.post_kyc_bulk(?) }");
                    } catch (SQLException ex) {
                        Logger.getLogger(GlProductOperationServlet.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    proc.registerOutParameter(1, java.sql.Types.VARCHAR);

                    proc.executeUpdate();

                    errorlog = proc.getString(1);

                    message = errorlog;
                    request.setAttribute("message", message);

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
            }
            (request.getRequestDispatcher("/CBSKycPosting.jsp")).forward(request, response);

        }

    }

    public static String getList(String directory, String handle_id) {
        File path = new File(directory);
        String[] list = path.list();
        String element = "";
        String UploadStatus = "PENDING";

        CallableStatement proc = null;
        Connection connection = null;
        String find_Status = "Failure";

        for (int i = 0; i < list.length; i++) {
            if (!list[i].equalsIgnoreCase("Archived")) {

                if (handle_id.equalsIgnoreCase("kycUpload")) {

                    if ((list[i].substring(0, list[i].indexOf("_"))).toUpperCase().equalsIgnoreCase("depd8007")) {

                        element = list[i];
                    }
                } else if (handle_id.equalsIgnoreCase("cbsUpload")) {

                    if ((list[i].substring(0, list[i].indexOf("_"))).toUpperCase().equalsIgnoreCase("depd0721")) {

                        element = list[i];
                    }
                }

            }
            try {
                connection = DbHandler.getDBConnection();
                try {
                    proc = connection.prepareCall("{ call csv_files_dccb_map(?,?) }");
                } catch (SQLException ex) {
                    Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

                proc.setString(1, element);
                proc.registerOutParameter(2, java.sql.Types.VARCHAR);

                proc.executeUpdate();

                find_Status = proc.getString(2);

            } catch (SQLException ex) {
                Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
            } finally {
                try {
                    proc.close();
                } catch (SQLException e) {
                }
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
                }

            }
        
            try {
                TrickleFeedFileMover.CBSFileMover(element);
            } catch (IOException ex) {
                Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        
        }
        return find_Status;
    }

    public static String FIleUploadToStagging(String handle_id) {

        String errorlog = "";
        Connection connection = null;
        CallableStatement proc = null;

        //For Posting the File in Stagging table
        try {
            connection = DbHandler.getDBConnection();
            try {
                proc = connection.prepareCall("{ call load_csv(?,?) }");
            } catch (SQLException ex) {
                Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            proc.registerOutParameter(1, java.sql.Types.VARCHAR);
            proc.setString(2, handle_id);

            proc.executeUpdate();

            errorlog = proc.getString(1);

        } catch (SQLException ex) {
            Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                proc.close();
            } catch (SQLException e) {
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(cbsExtractPostingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        //Ends Here

        return errorlog;

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
