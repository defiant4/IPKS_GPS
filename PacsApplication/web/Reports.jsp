<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="net.sf.jasperreports.engine.export.JRTextExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRTextExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRCsvExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRCsvExporter"%>
<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRHtmlExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRPdfExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Report</title>
        <link rel="shortcut icon" href="img/favicon.ico" type="image/x-icon" />
    </head>
    <body>

        <%
            out.clear();
            out.clearBuffer();
            long startTime = System.currentTimeMillis();
            if ("C".equalsIgnoreCase(request.getParameter("DOWNLOAD"))) {
                JRCsvExporter csvExporter = new JRCsvExporter();
                csvExporter.setParameter(JRCsvExporterParameter.JASPER_PRINT, request.getAttribute("reportBody"));
                csvExporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
                response.setContentType("application/octet-stream");
                String fileName = (String) request.getAttribute("fileName");
                response.setHeader("Content-Disposition", fileName);
                csvExporter.exportReport();
                response.flushBuffer();
                response.reset();

            } else if ("T".equalsIgnoreCase(request.getParameter("DOWNLOAD"))) {
                char PAGE_BREAK = 12;
                JRTextExporter textExporter = new JRTextExporter();
                textExporter.setParameter(JRTextExporterParameter.JASPER_PRINT, request.getAttribute("reportBody"));
                textExporter.setParameter(JRTextExporterParameter.OUTPUT_WRITER, out);
                textExporter.setParameter(JRTextExporterParameter.PAGE_HEIGHT, new Integer(53));
                textExporter.setParameter(JRTextExporterParameter.PAGE_WIDTH, new Integer(130));
                textExporter.setParameter(JRTextExporterParameter.BETWEEN_PAGES_TEXT, String.valueOf(PAGE_BREAK));
                response.setContentType("text/html");
                String fileName = (String) request.getAttribute("fileName");
                response.setHeader("Content-Disposition", fileName);
                textExporter.exportReport();
                response.flushBuffer();
                response.reset();
                
            } else if ("P".equalsIgnoreCase(request.getParameter("DOWNLOAD"))) {
                JRPdfExporter pdfExporter = new JRPdfExporter();
                pdfExporter.setParameter(JRPdfExporterParameter.JASPER_PRINT, request.getAttribute("reportBody"));
                pdfExporter.setParameter(JRPdfExporterParameter.OUTPUT_STREAM, response.getOutputStream());
                response.setContentType("application/pdf");
                String fileName = (String) request.getAttribute("fileName");
                response.setHeader("Content-Disposition", fileName);
                pdfExporter.exportReport();
                response.flushBuffer();
                response.reset();

            }//Added By SUBHAM For Excel Format on 26/09/2014
            else if ("E".equalsIgnoreCase(request.getParameter("DOWNLOAD"))) {
                // coding For Excel:
                JRXlsExporter exporterXLS = new JRXlsExporter();
                exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, request.getAttribute("reportBody"));
                exporterXLS.setParameter(JRXlsExporterParameter.OUTPUT_STREAM, response.getOutputStream());
                exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
                exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
                exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
                exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
                // SET THE MIME TYPE.
                response.setContentType("application/vnd.ms-excel");
                // set content dispostion to attachment in with file name.
                // case the open/save dialog needs to appear.
                String fileName = (String) request.getAttribute("fileName");
                response.setHeader("Content-Disposition", fileName);
                exporterXLS.exportReport();
                response.flushBuffer();
                response.reset();
            } //Added By SUBHAM For Excel Format
            else {
                JRHtmlExporter exporter = new JRHtmlExporter();
                exporter.setParameter(JRExporterParameter.JASPER_PRINT, request.getAttribute("reportBody"));
                exporter.setParameter(JRExporterParameter.OUTPUT_WRITER, out);
                exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
                exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD, Boolean.TRUE);
                exporter.exportReport();
                response.flushBuffer();
                response.reset();
            }


        %>

    </body>
</html>