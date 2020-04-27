/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.io.File;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.io.*;
import java.sql.*;
import LoginDb.DbHandler;

/**
 *
 * @author Administrator
 */
public class UploadServlet extends HttpServlet {

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
            out.println("<title>Servlet UploadServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UploadServlet at " + request.getContextPath () + "</h1>");
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

        /** -----------------
         * File Save Code
         * -----------------*/
        boolean isMultipart = ServletFileUpload.isMultipartContent(request);
        String content = "";
        Connection con = null;
        CallableStatement proc = null;
        


        if (isMultipart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            List items = null;
            try {
                items = upload.parseRequest(request);
            } catch (FileUploadException ex) {
                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

            Iterator iter = items.iterator();
            while (iter.hasNext()) {
                FileItem item = (FileItem) iter.next();
                if (!item.isFormField()) {
                    BufferedReader bReader = new BufferedReader(new InputStreamReader(item.getInputStream()));
                    while (true) {
                        content = bReader.readLine();
                        if (null == content) {
                            bReader.close();
                            break;
                        }
                        System.out.println("Writing line..." + content);
                        try {
                            con = DbHandler.getDBConnection();
                            try {
                                proc = con.prepareCall("{ call post_filetodb(?) }");
                            } catch (SQLException ex) {
                                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                            proc.setString(1, content);
                            
                            proc.execute();
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
                        }
                    }
                }
            }
        }


        (request.getRequestDispatcher("/pacsFileUpload.jsp")).forward(request, response);
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
