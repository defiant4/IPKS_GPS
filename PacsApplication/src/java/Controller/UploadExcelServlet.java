/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DataEntryBean.FileUploadDataBean;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.*;
import javax.servlet.http.HttpSession;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import java.util.Iterator;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import java.util.ArrayList;
import javax.servlet.*;
import jxl.Cell;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;
import java.sql.*;
import LoginDb.DbHandler;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 454222
 */
public class UploadExcelServlet extends HttpServlet {

    private boolean isMultipart;
    private int maxFileSize = 5000 * 1024;
    private int maxMemSize = 4 * 1024;
    Connection con = null;
    CallableStatement proc = null;
    

    @Override
    public void init() {
    }

    @Override
    public void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, java.io.IOException {

        HttpSession session = request.getSession(false);
        String message = "";

        String UploadName = "";
        String UploadValue = "";
        String pacsId=(String) session.getAttribute("pacsId");

        // Check that we have a file upload request
        isMultipart = ServletFileUpload.isMultipartContent(request);
        System.out.println("Check that we have a file upload request :" + isMultipart);
        response.setContentType("text/html");
        if (!isMultipart) {
            message = "Uploaded file is not in Excel Format";
            request.setAttribute("message", message);
            request.getRequestDispatcher("/pacsFileUpload.jsp").forward(request, response);
        }
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // maximum size that will be stored in memory
        factory.setSizeThreshold(maxMemSize);
        // Create a new file upload handler
        ServletFileUpload upload = new ServletFileUpload(factory);
        // maximum file size to be uploaded.
        upload.setSizeMax(maxFileSize);

        Workbook workbook = null;
        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items

            Iterator itr2 = fileItems.iterator();
            while (itr2.hasNext()) {
                FileItem fi2 = (FileItem) itr2.next();
                UploadName = fi2.getFieldName();
                
                if (UploadName.equalsIgnoreCase("UploadType")) {

                    UploadValue = fi2.getString();
                }
            }

            Iterator itr = fileItems.iterator();
            while (itr.hasNext()) {
                FileItem fi = (FileItem) itr.next();

                if (!fi.isFormField()) {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    String contentType = fi.getContentType();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();
                    //check if the uploaded file is an excel file
                    String fileExtention = fileName.substring(fileName.length() - 3, fileName.length()).toLowerCase();
                    if (!fileExtention.equals("xls")) {
                        //return to jsp with an error message
                        message = "Uploaded file is not in Excel Format";
                        throw new Exception();
                    } else {
                    }
                    FileInputStream fileXls = (FileInputStream) fi.getInputStream();
                    workbook = Workbook.getWorkbook(fileXls);


                    FileUploadDataBean FileUploadDataBeanObj = null;
                    ArrayList<FileUploadDataBean> FileUploadArrayList = new ArrayList<FileUploadDataBean>();
                    Sheet sheet = workbook.getSheet(0);

                    //Upload Type Bifurcation

                    if (UploadValue.equalsIgnoreCase("CC")) {

                        for (int i = 2; i < sheet.getRows(); i++) {
                            FileUploadDataBeanObj = new FileUploadDataBean();
                            for (int j = 0; j < sheet.getColumns(); j++) {
                                Cell cell = sheet.getCell(j, i);
                                switch (j) {
                                    case 0:
                                        FileUploadDataBeanObj.setAccount_type(cell.getContents());
                                        break;
                                    case 1:
                                        FileUploadDataBeanObj.setIntt_category(cell.getContents());
                                        break;
                                    case 2:
                                        FileUploadDataBeanObj.setSegment_code(cell.getContents());
                                        break;
                                    case 3:
                                        FileUploadDataBeanObj.setLimit(cell.getContents());
                                        break;
                                    case 4:
                                        FileUploadDataBeanObj.setRate(cell.getContents());
                                        break;
                                    case 5:
                                        FileUploadDataBeanObj.setRate_type(cell.getContents());
                                        break;
                                    case 6:
                                        FileUploadDataBeanObj.setExpiry_date(cell.getContents());
                                        break;
                                    case 7:
                                        FileUploadDataBeanObj.setApproval_amt(cell.getContents());
                                        break;
                                    case 8:
                                        FileUploadDataBeanObj.setCust_number(cell.getContents());
                                        break;
                                    case 9:
                                        FileUploadDataBeanObj.setMember_id(cell.getContents());
                                        break;
                                    case 10:
                                        FileUploadDataBeanObj.setPacs_main_acct(cell.getContents());
                                        break;
                                    case 11:
                                        FileUploadDataBeanObj.setPacs_sub_acct(cell.getContents());
                                        break;
                                    case 12:
                                        FileUploadDataBeanObj.setSecurity_indicator(cell.getContents());
                                        break;
                                    case 13:
                                        FileUploadDataBeanObj.setActivity_code(cell.getContents());
                                        break;
                                    case 14:
                                        FileUploadDataBeanObj.setScheme_code(cell.getContents());
                                        break;
                                    case 15:
                                        FileUploadDataBeanObj.setCustomer_type(cell.getContents());
                                        break;
                                    case 16:
                                        FileUploadDataBeanObj.setSector_indicator(cell.getContents());
                                        break;
                                    case 17:
                                        FileUploadDataBeanObj.setExpiry_rate(cell.getContents());
                                        break;
                                    case 18:
                                        FileUploadDataBeanObj.setExpiry_rate_type(cell.getContents());
                                        break;
                                }
                            }
                            FileUploadArrayList.add(FileUploadDataBeanObj);
                        }

                        //Now Fetch The Arraylist Data to save in databse


                        for (int i = 0; i < FileUploadArrayList.size(); i++) {

                            FileUploadDataBeanObj = FileUploadArrayList.get(i);
                            System.out.println(FileUploadDataBeanObj.getAccount_type());
                            System.out.println(FileUploadDataBeanObj.getIntt_category());
                            System.out.println(FileUploadDataBeanObj.getSegment_code());
                            System.out.println(FileUploadDataBeanObj.getLimit());
                            System.out.println(FileUploadDataBeanObj.getRate());
                            System.out.println(FileUploadDataBeanObj.getRate_type());
                            System.out.println(FileUploadDataBeanObj.getExpiry_date());
                            System.out.println(FileUploadDataBeanObj.getApproval_amt());
                            System.out.println(FileUploadDataBeanObj.getCust_number());
                            System.out.println(FileUploadDataBeanObj.getMember_id());
                            System.out.println(FileUploadDataBeanObj.getPacs_main_acct());
                            System.out.println(FileUploadDataBeanObj.getPacs_sub_acct());
                            System.out.println(FileUploadDataBeanObj.getSecurity_indicator());
                            System.out.println(FileUploadDataBeanObj.getActivity_code());
                            System.out.println(FileUploadDataBeanObj.getScheme_code());
                            System.out.println(FileUploadDataBeanObj.getCustomer_type());
                            System.out.println(FileUploadDataBeanObj.getSector_indicator());
                            System.out.println(FileUploadDataBeanObj.getExpiry_rate());
                            System.out.println(FileUploadDataBeanObj.getExpiry_rate_type());

                            try {
                                con = DbHandler.getDBConnection();
                                try {
                                    proc = con.prepareCall("{ call PACS_filetodb(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                                } catch (SQLException ex) {
                                    Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                                }

                                proc.setString(1,UploadValue) ;
                                proc.setString(2, FileUploadDataBeanObj.getAccount_type());
                                proc.setString(3, FileUploadDataBeanObj.getIntt_category());
                                proc.setString(4, FileUploadDataBeanObj.getSegment_code());
                                proc.setString(5, FileUploadDataBeanObj.getLimit());
                                proc.setString(6, FileUploadDataBeanObj.getRate());
                                proc.setString(7, FileUploadDataBeanObj.getRate_type());
                                proc.setString(8, FileUploadDataBeanObj.getExpiry_date());
                                proc.setString(9, FileUploadDataBeanObj.getApproval_amt());
                                proc.setString(10, FileUploadDataBeanObj.getCust_number());
                                proc.setString(11, FileUploadDataBeanObj.getMember_id());
                                proc.setString(12, FileUploadDataBeanObj.getPacs_main_acct());
                                proc.setString(13, FileUploadDataBeanObj.getPacs_sub_acct());
                                proc.setString(14, FileUploadDataBeanObj.getSecurity_indicator());
                                proc.setString(15, FileUploadDataBeanObj.getActivity_code());
                                proc.setString(16, FileUploadDataBeanObj.getScheme_code());
                                proc.setString(17, FileUploadDataBeanObj.getCustomer_type());
                                proc.setString(18, FileUploadDataBeanObj.getSector_indicator());
                                proc.setString(19, FileUploadDataBeanObj.getExpiry_rate());
                                proc.setString(20, FileUploadDataBeanObj.getExpiry_rate_type());
                                proc.setString(21,pacsId);


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
                        //Data Entry Ends

                    } else if (UploadValue.equalsIgnoreCase("SB")) {

                        for (int i = 1; i < sheet.getRows(); i++) {
                            FileUploadDataBeanObj = new FileUploadDataBean();
                            for (int j = 0; j < sheet.getColumns(); j++) {
                                Cell cell = sheet.getCell(j, i);
                                switch (j) {
                                    case 0:
                                        FileUploadDataBeanObj.setStudentRecordType(cell.getContents());
                                        break;
                                    case 1:
                                        FileUploadDataBeanObj.setStudentNumber(cell.getContents());
                                        break;
                                    case 2:
                                        FileUploadDataBeanObj.setFirstName(cell.getContents());
                                        break;
                                    case 3:
                                        FileUploadDataBeanObj.setMiddleName(cell.getContents());
                                        break;
                                    case 4:
                                        FileUploadDataBeanObj.setLastName(cell.getContents());
                                        break;
                                    case 5:
                                        FileUploadDataBeanObj.setAddress1(cell.getContents());
                                        break;
                                    case 6:
                                        FileUploadDataBeanObj.setAddress2(cell.getContents());
                                        break;
                                    case 7:
                                        FileUploadDataBeanObj.setAddress3(cell.getContents());
                                        break;
                                    case 8:
                                        FileUploadDataBeanObj.setCityCode(cell.getContents());
                                        break;
                                    case 9:
                                        FileUploadDataBeanObj.setStateCode(cell.getContents());
                                        break;
                                    case 10:
                                        FileUploadDataBeanObj.setPostBoxNumber(cell.getContents());
                                        break;
                                    case 11:
                                        FileUploadDataBeanObj.setPhoneNumber(cell.getContents());
                                        break;
                                    case 12:
                                        FileUploadDataBeanObj.setIdType(cell.getContents());
                                        break;
                                    case 13:
                                        FileUploadDataBeanObj.setIdNumber(cell.getContents());
                                        break;
                                    case 14:
                                        FileUploadDataBeanObj.setBirthDate(cell.getContents());
                                        break;
                                    case 15:
                                        FileUploadDataBeanObj.setGender(cell.getContents());
                                        break;
                                    case 16:
                                        FileUploadDataBeanObj.setMotherName(cell.getContents());
                                        break;
                                    case 17:
                                        FileUploadDataBeanObj.setResidentialStatus(cell.getContents());
                                        break;
                                    case 18:
                                        FileUploadDataBeanObj.setNationalityCode(cell.getContents());
                                        break;
                                    case 19:
                                        FileUploadDataBeanObj.setCustomerType(cell.getContents());
                                        break;
                                    case 20:
                                        FileUploadDataBeanObj.setTitle(cell.getContents());
                                        break;
                                }
                            }
                            FileUploadArrayList.add(FileUploadDataBeanObj);
                        }

                        //Now Fetch The Arraylist Data to save in databse


                        for (int i = 0; i < FileUploadArrayList.size(); i++) {

                            FileUploadDataBeanObj = FileUploadArrayList.get(i);
                            System.out.println(FileUploadDataBeanObj.getStudentRecordType());
                            System.out.println(FileUploadDataBeanObj.getStudentNumber());
                            System.out.println(FileUploadDataBeanObj.getFirstName());
                            System.out.println(FileUploadDataBeanObj.getMiddleName());
                            System.out.println(FileUploadDataBeanObj.getLastName());
                            System.out.println(FileUploadDataBeanObj.getAddress1());
                            System.out.println(FileUploadDataBeanObj.getAddress2());
                            System.out.println(FileUploadDataBeanObj.getAddress3());
                            System.out.println(FileUploadDataBeanObj.getCityCode());
                            System.out.println(FileUploadDataBeanObj.getStateCode());
                            System.out.println(FileUploadDataBeanObj.getPostBoxNumber());
                            System.out.println(FileUploadDataBeanObj.getPhoneNumber());
                            System.out.println(FileUploadDataBeanObj.getIdType());
                            System.out.println(FileUploadDataBeanObj.getIdNumber());
                            System.out.println(FileUploadDataBeanObj.getBirthDate());
                            System.out.println(FileUploadDataBeanObj.getGender());
                            System.out.println(FileUploadDataBeanObj.getMotherName());
                            System.out.println(FileUploadDataBeanObj.getResidentialStatus());
                            System.out.println(FileUploadDataBeanObj.getNationalityCode());
                            System.out.println(FileUploadDataBeanObj.getCustomerType());
                            System.out.println(FileUploadDataBeanObj.getTitle());

                        try {
                            con = DbHandler.getDBConnection();
                            try {
                                proc = con.prepareCall("{ call PACS_AccountFiletodb(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }");
                            } catch (SQLException ex) {
                                Logger.getLogger(UploadServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }

                        proc.setString(1,UploadValue) ;
                        proc.setString(2,FileUploadDataBeanObj.getStudentRecordType());
                        proc.setString(3,FileUploadDataBeanObj.getStudentNumber());
                        proc.setString(4,FileUploadDataBeanObj.getFirstName());
                        proc.setString(5,FileUploadDataBeanObj.getMiddleName());
                        proc.setString(6,FileUploadDataBeanObj.getLastName());
                        proc.setString(7,FileUploadDataBeanObj.getAddress1());
                        proc.setString(8,FileUploadDataBeanObj.getAddress2());
                        proc.setString(9,FileUploadDataBeanObj.getAddress3());
                        proc.setString(10,FileUploadDataBeanObj.getCityCode());
                        proc.setString(11,FileUploadDataBeanObj.getStateCode());
                        proc.setString(12,FileUploadDataBeanObj.getPostBoxNumber());
                        proc.setString(13,FileUploadDataBeanObj.getPhoneNumber());
                        proc.setString(14,FileUploadDataBeanObj.getIdType());
                        proc.setString(15,FileUploadDataBeanObj.getIdNumber());
                        proc.setString(16,FileUploadDataBeanObj.getBirthDate());
                        proc.setString(17,FileUploadDataBeanObj.getGender());
                        proc.setString(18,FileUploadDataBeanObj.getMotherName());
                        proc.setString(19,FileUploadDataBeanObj.getResidentialStatus());
                        proc.setString(20,FileUploadDataBeanObj.getNationalityCode());
                        proc.setString(21,FileUploadDataBeanObj.getCustomerType());
                        proc.setString(22,FileUploadDataBeanObj.getTitle());
                        proc.setString(23,pacsId);

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

            message = "File Uploaded Successfully";

        } catch (Exception ex) {
            ex.printStackTrace();
            message = "Unable to read Excel/Excel is Tampered";

        } finally {
            request.setAttribute("message", message);
            request.getRequestDispatcher("/pacsFileUpload.jsp").forward(request, response);
        }


    }

    @Override
    public void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, java.io.IOException {

        throw new ServletException("GET method used with " + getClass().getName() + ": POST method required.");
    }
}
