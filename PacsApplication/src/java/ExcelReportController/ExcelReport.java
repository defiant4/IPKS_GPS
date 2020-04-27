/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ExcelReportController;

/**
 *
 * @author Tcs Helpdesk10
 */
import LoginDb.DbHandler;
import java.io.*;
import java.math.BigDecimal;
import jxl.WorkbookSettings;
import java.util.*;
import jxl.Workbook;
import jxl.write.DateFormat;
import jxl.write.Number;
import java.sql.*;
import java.util.zip.*;
import jxl.write.*;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import jxl.CellView;
import jxl.format.Colour;
import jxl.format.Border;
import jxl.format.CellFormat;

class ExcelReport {

    WorkbookSettings ws = null;
    WritableSheet s = null;

    //String query=null;
    public ExcelReport() {
        this.ws = new WorkbookSettings();
        ws.setLocale(new Locale("en", "EN"));
    }

    public WorkbookSettings getWorkBookSetting() {
        return ws;
    }

    public void writeDataSheet(WritableSheet s, ArrayList heading, String query) {

        Statement stmt = null;
        Connection conn = null;
        ResultSet results = null;

        DecimalFormat Currency = new DecimalFormat("0.00");
        try {

            conn = DbHandler.getDBConnection();
            stmt = conn.createStatement();

            // This is for testing purpose to check the query
            //System.out.println(query);
            results = stmt.executeQuery(query);

            int rowPos = 0;
            int colPos;
            WritableFont wf;
            WritableCellFormat cf;

            // This is for Heading 
            wf = new WritableFont(WritableFont.ARIAL, 12, WritableFont.BOLD);
            cf = new WritableCellFormat(wf);
            cf.setWrap(false);
            cf.setBackground(jxl.format.Colour.LIGHT_GREEN);
            cf.setBorder(Border.ALL, jxl.format.BorderLineStyle.THIN);
            CellView cv = new CellView();
            cv.setAutosize(true);

            colPos = -1;
            Iterator itrHeading = heading.iterator();
            while (itrHeading.hasNext()) {
                colPos++;
                Heading oHeading = (Heading) itrHeading.next();
                String sHeading = oHeading.getName();
                
                s.addCell(new Label(colPos, rowPos, sHeading, cf));
                s.setColumnView(colPos, cv);
                
                
            }

            // This is for Results
            //Reset Fonts for results section
            wf = new WritableFont(WritableFont.ARIAL, 11, WritableFont.NO_BOLD);

            //Looping For results  
            while (results.next()) {
                rowPos++;
                colPos = -1;
                Iterator itrHeading1 = heading.iterator();
                while (itrHeading1.hasNext()) {
                    colPos++;
                    Heading oHeading1 = (Heading) itrHeading1.next();
                    String sHeading1 = oHeading1.getName();
                    int sType = oHeading1.getType();
                    if (sType == 1) {
                        cf = new WritableCellFormat(wf);
                        cf.setWrap(false);
                        cf.setBorder(Border.ALL, jxl.format.BorderLineStyle.THIN);
                        cv.setAutosize(true);

                        s.addCell(new Label(colPos, rowPos, results.getString(sHeading1), cf));

                        s.setColumnView(colPos, cv);

                    } else if (sType == 2) {
                        cf = new WritableCellFormat(wf, NumberFormats.FLOAT);
                        cf.setWrap(false);
                        cf.setBorder(Border.ALL, jxl.format.BorderLineStyle.THIN);
                        cv.setAutosize(true);
                        s.addCell(new Number(colPos, rowPos, results.getBigDecimal(sHeading1).floatValue(), cf));

                        s.setColumnView(colPos, cv);

                    }
                }
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {

                if (stmt != null) {
                    stmt.close();
                }
                if (results != null) {
                    results.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
