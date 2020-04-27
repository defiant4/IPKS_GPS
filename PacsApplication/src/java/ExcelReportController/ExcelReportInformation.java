/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ExcelReportController;

import DataEntryBean.ExcelReportBean;
import java.util.ArrayList;

/**
 *
 * @author Tcs Helpdesk10
 */
public class ExcelReportInformation {

    private String reportName;
    private String reportQuery;
    private ArrayList reportHeader;

    public int TYPE_STRING = 1;
    public int TYPE_BIG_DECIMAL = 2;

    public ExcelReportInformation(String sReportName) {

        this.reportName = sReportName;
    }

// Here provide the required query for the Report
    public String getReportQuery() {

        StringBuffer queryBuffer = new StringBuffer();
        if (reportName.equalsIgnoreCase("BULK_TRANSACTION_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, d.dccb_name as DCCB_NAME, d.sb_acc_no as SAVINGS_ACCOUNT_NO,d.cif_no as CIF_NO,d.prod_code as PRODUCT_CODE,d.intt_cat as INTEREST_CATEGORY, \n");
          //  queryBuffer.append("  (p.first_name||nvl2(p.middle_name,' '||p.middle_name,'')||nvl2(p.last_name,' '||p.last_name,'')) as CUSTOMER_NAME,\n");
            queryBuffer.append("  to_char(d.txn_post_date, 'DD-MON-YYYY') as TRANSACTION_POSTING_DATE,\n");
            queryBuffer.append("   d.jrnl_no as JOURNAL_NO,\n");
            queryBuffer.append("  (case d.txn_ind\n"
                    + "         when 'DR' then\n"
                    + "          'KCC-Disbursement'\n"
                    + "         when 'CR' then\n"
                    + "          'KCC-Repayment'\n"
                    + "       end) as TRANSACTION_TYPE,\n");
            queryBuffer.append("  d.txn_amt as TRANSACTION_AMOUNT,d.comments as COMMENTS \n");
            queryBuffer.append("    from bulk_txn_post d \n");

            //queryBuffer.append("    where p.linked_sb_accno=d.sb_acc_no \n");
            //queryBuffer.append("  and a.customer_no=p.cif_no \n");
           // queryBuffer.append("   and a.link_accno=d.sb_acc_no \n");
            queryBuffer.append("  where d.post_flag='Y' \n");

            reportQuery = queryBuffer.toString();

        } else if (reportName.equalsIgnoreCase("EOD_INTT_COMPUTATION_REPORT")) {

            queryBuffer.append("  select rownum  as SL_NO ,e.activity as ACTIVITY,a.pacs_id as PACS_ID, e.account_no as ACCOUNT_NO,e.errordesc as REMARKS,e.sys_date as TRANSACTION_DATE  \n");
            queryBuffer.append("    from eod_log e, dep_account a \n");
            queryBuffer.append("    where a.key_1=e.account_no \n");

            reportQuery = queryBuffer.toString();

        } else if (reportName.equalsIgnoreCase("BULK_KYC_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, t.bank_name as BANK_NAME,t.cbs_br_code as CBS_BR_CODE, t.cif_no as CIF_NO,  \n");
            queryBuffer.append("    t.customer_type as CUSTOMER_TYPE,t.linked_sb_accno as LINKED_SB_ACCNO,t.title as TITLE, \n");
            queryBuffer.append("    t.first_name as FIRST_NAME,t.middle_name as MIDDLE_NAME,t.last_name as LAST_NAME, t.guardian_name as GUARDIAN_NAME, \n");
            queryBuffer.append("    t.address_1 as ADDRESS_1,t.address_2 as ADDRESS_2,t.address_3 as ADDRESS_3, \n");
            queryBuffer.append("    t.district as DISTRICT,t.city as CITY,t.state as STATE,t.birth_date as BIRTH_DATE, \n");
            queryBuffer.append("    t.gender as GENDER,t.mobile_no as MOBILE_NO,t.id_type as ID_TYPE, \n");
            queryBuffer.append("    t.id_no as ID_NO,t.id_issue_date as ID_ISSUE_DATE,t.id_issued_at as ID_ISSUED_AT,t.post_date as POST_DATE,t.comments as COMMENTS \n");
            queryBuffer.append("    from bulk_kyc t \n");

            reportQuery = queryBuffer.toString();

        }

        return reportQuery;
    }

    public String getReportQuery(ExcelReportBean Bean, String pacsId) {

        StringBuffer queryBuffer = new StringBuffer();
        String accountNo = "";
        String product = "";
        String fromDate = "";
        String toDate = "";
        String fromAmount = "";
        String toAmount = "";
        String linkedSbAccount = "";

        accountNo = (Bean.getAccountNo() == null) ? "" : Bean.getAccountNo();
        product = (Bean.getProductName() == null) ? "" : Bean.getProductName();
        fromDate = (Bean.getFromDate() == null) ? "" : Bean.getFromDate();
        toDate = (Bean.getToDate() == null) ? "" : Bean.getToDate();
        fromAmount = (Bean.getFromAmount() == null) ? "" : Bean.getFromAmount();
        toAmount = (Bean.getToAmount() == null) ? "" : Bean.getToAmount();
        linkedSbAccount = (Bean.getLinkedSbAccount() == null) ? "" : Bean.getLinkedSbAccount();

        if (reportName.equalsIgnoreCase("ACCOUNT_ENQUIRY_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, KEY_1 as ACCOUNT_NO, to_char(ACCT_OPEN_DT,'DD-MON-YYYY') as ACCT_OPEN_DT,a.link_accno as LINKED_CBS_ACCOUNT_NO, AVAIL_BAL,  \n");
            queryBuffer.append("    a.CUSTOMER_NO as CUSTOMER_NO,a.SANCTION_AMT as SANCTION_AMT ,a.PRIN_OUTST as PRIN_OUTST ,a.INTT_OUTST as INTT_OUTST,a.PENAL_INTT_PAID as PENAL_INTT_PAID, \n");
            queryBuffer.append("    (t.first_name||nvl2(t.middle_name,' '||t.middle_name,'')||nvl2(t.last_name,' '||t.last_name,'')) as CUST_NAME, \n");
            queryBuffer.append("    p.prod_name as PRODUCT_NAME,to_char(a.limit_exp_date,'DD-MON-YYYY') as LIMIT_EXPIRY_DATE,a.PRIN_PAID as PRINCIPAL_PAID,a.INTT_PAID as INTEREST_PAID,a.PENAL_INTT_OUTST as PENAL_INTT_OUTSTANDING \n");
            queryBuffer.append("     from dep_product p,dep_account a, kyc_details t  \n");
            queryBuffer.append("    where a.dep_prod_id=p.id and t.cif_no =a.customer_no and a.pacs_id='" + pacsId + "' \n");

            if (!accountNo.equalsIgnoreCase("")) {
                queryBuffer.append("    and  a.key_1='" + Bean.getAccountNo() + "' \n");
            }

            if ((!fromDate.equalsIgnoreCase("")) && (!toDate.equalsIgnoreCase(""))) {

                queryBuffer.append("    and  a.ACCT_OPEN_DT between to_date ('" + Bean.getFromDate() + "','dd/mm/yyyy') \n");
                queryBuffer.append("   and to_date ('" + Bean.getToDate() + "','dd/mm/yyyy') \n");
            }

            if (!product.equalsIgnoreCase("")) {
                queryBuffer.append("    and dep_prod_id='" + Bean.getProductName() + "' \n");
            }

            if ((!fromAmount.equalsIgnoreCase("")) && (!toAmount.equalsIgnoreCase(""))) {
                queryBuffer.append("    and a.AVAIL_BAL between='" + Bean.getFromAmount() + "' \n");
                queryBuffer.append("    and '" + Bean.getToAmount() + "' \n");
            }

            if (!linkedSbAccount.equalsIgnoreCase("")) {
                queryBuffer.append("    and link_accno='" + Bean.getLinkedSbAccount() + "' \n");
            }

            reportQuery = queryBuffer.toString();

        } else if (reportName.equalsIgnoreCase("TRANSACTION_ENQUIRY_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, a.key_1 as ACCOUNT_NO,a.link_accno as LINKED_CBS_ACCOUNT_NO,d.cbs_ref_no as CBS_REF_NO,to_char(d.tran_date,'DD-MON-YYYY') AS TRAN_DATE, \n");
            queryBuffer.append("    (case d.tran_ind\n"
                    + "                             when 'DR' then 'KCC-Disbursement'\n"
                    + "                             when 'CR' then 'KCC-Repayment'\n"
                    + "                        end)  as TXN_TYPE,d.txn_amt as TXN_AMT,to_char(a.LIMIT_EXP_DATE,'dd-MON-yyyy') as LIMIT_EXPIRY_DATE,p.PROD_NAME as PRODUCT_NAME,d.END_BAL as END_BALANCE \n");

            queryBuffer.append(" from dep_txn d,dep_account a, dep_product p \n");
            queryBuffer.append(" where d.acct_no=a.key_1\n"
                    + "                        and a.dep_prod_id=p.id and a.pacs_id='" + pacsId + "' \n");

            if (!accountNo.equalsIgnoreCase("")) {
                queryBuffer.append("    and  a.key_1='" + Bean.getAccountNo() + "' \n");
            }

            if ((!fromDate.equalsIgnoreCase("")) && (!toDate.equalsIgnoreCase(""))) {

                queryBuffer.append("    and  d.tran_date between  to_date ('" + Bean.getFromDate() + "','dd/mm/yyyy') \n");
                queryBuffer.append("   and to_date ('" + Bean.getToDate() + "','dd/mm/yyyy') \n");
            }

            if (!product.equalsIgnoreCase("")) {
                queryBuffer.append("    and a.dep_prod_id='" + Bean.getProductName() + "' \n");
            }

            if ((!fromAmount.equalsIgnoreCase("")) && (!toAmount.equalsIgnoreCase(""))) {
                queryBuffer.append("    and d.txn_amt between='" + Bean.getFromAmount() + "' \n");
                queryBuffer.append("    and '" + Bean.getToAmount() + "' \n");
            }

            if (!linkedSbAccount.equalsIgnoreCase("")) {
                queryBuffer.append("    and link_accno='" + Bean.getLinkedSbAccount() + "' \n");
            }
           
            reportQuery = queryBuffer.toString();

        } else if (reportName.equalsIgnoreCase("GL_ACCOUNT_ENQUIRY_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, KEY_1 as GL_ACCOUNT_NO, LEDGER_NAME as LEDGER_NAME, to_char(acct_open_date,'DD-MON-YYYY') as GL_ACCT_OPEN_DT, cum_curr_val as CURRENT_BALANCE,  \n");
            queryBuffer.append("    decode(a.status,'A','ACTIVE','INACTIVE') as STATUS, gl_code as GL_CODE, \n");
            queryBuffer.append("    gl_name as GL_NAME from GL_product p,GL_account a where a.GL_prod_id=p.id and a.pacs_id='" + pacsId + "' \n");

            if (!accountNo.equalsIgnoreCase("")) {
                queryBuffer.append("    and  a.key_1='" + Bean.getAccountNo() + "' \n");
            }

            if ((!fromDate.equalsIgnoreCase("")) && (!toDate.equalsIgnoreCase(""))) {

                queryBuffer.append("    and  a.ACCT_OPEN_DT between to_date ('" + Bean.getFromDate() + "','dd/mm/yyyy') \n");
                queryBuffer.append("   and to_date ('" + Bean.getToDate() + "','dd/mm/yyyy') \n");
            }

            if (!product.equalsIgnoreCase("")) {
                queryBuffer.append("    and a.gl_prod_id='" + Bean.getProductName() + "' \n");
            }

            if ((!fromAmount.equalsIgnoreCase("")) && (!toAmount.equalsIgnoreCase(""))) {
                queryBuffer.append("    and a.cum_curr_val between='" + Bean.getFromAmount() + "' \n");
                queryBuffer.append("    and '" + Bean.getToAmount() + "' \n");
            }
            reportQuery = queryBuffer.toString();

        } else if (reportName.equalsIgnoreCase("GL_TRANSACTION_ENQUIRY_REPORT")) {

            queryBuffer.append("  select rownum as SL_NO, a.key_1 as GL_ACCOUNT_NO,g.cbs_ref_no as CBS_REF_NO,to_char(g.tran_date,'DD-MON-YYYY') as TRAN_DATE,g.jrnl_no as JRNL_NO,  \n");
            queryBuffer.append("    (case g.tran_ind \n"
                    + "                             when 'DR' then 'GL-DEBIT'\n"
                    + "                             when 'CR' then 'GL-CREDIT'\n"
                    + "                        end) as TXN_TYPE,g.txn_amt as TXN_AMT \n");

            queryBuffer.append(" from gl_txn g,gl_account a, gl_product p \n");
            queryBuffer.append(" where g.acct_no=a.key_1 \n"
                    + "                        and a.gl_prod_id=p.id and a.pacs_id='" + pacsId + "' \n");

            if (!accountNo.equalsIgnoreCase("")) {
                queryBuffer.append("    and  a.key_1='" + Bean.getAccountNo() + "' \n");
            }

            if ((!fromDate.equalsIgnoreCase("")) && (!toDate.equalsIgnoreCase(""))) {

                queryBuffer.append("    and  g.tran_date between  to_date ('" + Bean.getFromDate() + "','dd/mm/yyyy') \n");
                queryBuffer.append("   and to_date ('" + Bean.getToDate() + "','dd/mm/yyyy') \n");
            }

            if (!product.equalsIgnoreCase("")) {
                queryBuffer.append("    and a.gl_prod_id='" + Bean.getProductName() + "' \n");
            }

            if ((!fromAmount.equalsIgnoreCase("")) && (!toAmount.equalsIgnoreCase(""))) {
                queryBuffer.append("    and  g.txn_amt between='" + Bean.getFromAmount() + "' \n");
                queryBuffer.append("    and '" + Bean.getToAmount() + "' \n");
            }

            reportQuery = queryBuffer.toString();

        }

        return reportQuery;
    }

    // Here provide the Headers & Type of Headers of the Report
    public ArrayList getReportHeader() {
        reportHeader = new ArrayList();
        if (reportName.equalsIgnoreCase("BULK_TRANSACTION_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("DCCB_NAME", TYPE_STRING));
            reportHeader.add(new Heading("SAVINGS_ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("CIF_NO", TYPE_STRING));
            reportHeader.add(new Heading("PRODUCT_CODE", TYPE_STRING));
            reportHeader.add(new Heading("INTEREST_CATEGORY", TYPE_STRING));
            reportHeader.add(new Heading("TRANSACTION_POSTING_DATE", TYPE_STRING));
            reportHeader.add(new Heading("JOURNAL_NO", TYPE_STRING));
            reportHeader.add(new Heading("TRANSACTION_TYPE", TYPE_STRING));
            reportHeader.add(new Heading("TRANSACTION_AMOUNT", TYPE_STRING));
            reportHeader.add(new Heading("COMMENTS", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("EOD_INTT_COMPUTATION_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("ACTIVITY", TYPE_STRING));
            reportHeader.add(new Heading("PACS_ID", TYPE_STRING));
            reportHeader.add(new Heading("ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("REMARKS", TYPE_STRING));
            reportHeader.add(new Heading("TRANSACTION_DATE", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("BULK_KYC_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("BANK_NAME", TYPE_STRING));
            reportHeader.add(new Heading("CBS_BR_CODE", TYPE_STRING));
            reportHeader.add(new Heading("CIF_NO", TYPE_STRING));
            reportHeader.add(new Heading("CUSTOMER_TYPE", TYPE_STRING));
            reportHeader.add(new Heading("LINKED_SB_ACCNO", TYPE_STRING));
            reportHeader.add(new Heading("TITLE", TYPE_STRING));
            reportHeader.add(new Heading("FIRST_NAME", TYPE_STRING));
            reportHeader.add(new Heading("MIDDLE_NAME", TYPE_STRING));
            reportHeader.add(new Heading("LAST_NAME", TYPE_STRING));
            reportHeader.add(new Heading("GUARDIAN_NAME", TYPE_STRING));
            reportHeader.add(new Heading("ADDRESS_1", TYPE_STRING));
            reportHeader.add(new Heading("ADDRESS_2", TYPE_STRING));
            reportHeader.add(new Heading("ADDRESS_3", TYPE_STRING));
            reportHeader.add(new Heading("DISTRICT", TYPE_STRING));
            reportHeader.add(new Heading("CITY", TYPE_STRING));
            reportHeader.add(new Heading("STATE", TYPE_STRING));
            reportHeader.add(new Heading("BIRTH_DATE", TYPE_STRING));
            reportHeader.add(new Heading("GENDER", TYPE_STRING));
            reportHeader.add(new Heading("MOBILE_NO", TYPE_STRING));
            reportHeader.add(new Heading("ID_TYPE", TYPE_STRING));
            reportHeader.add(new Heading("ID_NO", TYPE_STRING));
            reportHeader.add(new Heading("ID_ISSUE_DATE", TYPE_STRING));
            reportHeader.add(new Heading("ID_ISSUED_AT", TYPE_STRING));
            reportHeader.add(new Heading("POST_DATE", TYPE_STRING));
            reportHeader.add(new Heading("COMMENTS", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("ACCOUNT_ENQUIRY_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("ACCT_OPEN_DT", TYPE_STRING));
            reportHeader.add(new Heading("LINKED_CBS_ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("AVAIL_BAL", TYPE_STRING));
            reportHeader.add(new Heading("CUSTOMER_NO", TYPE_STRING));
            reportHeader.add(new Heading("SANCTION_AMT", TYPE_STRING));
            reportHeader.add(new Heading("PRIN_OUTST", TYPE_STRING));
            reportHeader.add(new Heading("INTT_OUTST", TYPE_STRING));
            reportHeader.add(new Heading("PENAL_INTT_PAID", TYPE_STRING));
            reportHeader.add(new Heading("CUST_NAME", TYPE_STRING));
            reportHeader.add(new Heading("PRODUCT_NAME", TYPE_STRING));
            reportHeader.add(new Heading("LIMIT_EXPIRY_DATE", TYPE_STRING));
            reportHeader.add(new Heading("PRINCIPAL_PAID", TYPE_STRING));
            reportHeader.add(new Heading("INTEREST_PAID", TYPE_STRING));
            reportHeader.add(new Heading("PENAL_INTT_OUTSTANDING", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("TRANSACTION_ENQUIRY_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("LINKED_CBS_ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("CBS_REF_NO", TYPE_STRING));
            reportHeader.add(new Heading("TRAN_DATE", TYPE_STRING));
            reportHeader.add(new Heading("TXN_TYPE", TYPE_STRING));
            reportHeader.add(new Heading("TXN_AMT", TYPE_STRING));
            reportHeader.add(new Heading("LIMIT_EXPIRY_DATE", TYPE_STRING));
            reportHeader.add(new Heading("PRODUCT_NAME", TYPE_STRING));
            reportHeader.add(new Heading("END_BALANCE", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("GL_ACCOUNT_ENQUIRY_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("GL_ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("LEDGER_NAME", TYPE_STRING));
            reportHeader.add(new Heading("GL_ACCT_OPEN_DT", TYPE_STRING));
            reportHeader.add(new Heading("CURRENT_BALANCE", TYPE_STRING));
            reportHeader.add(new Heading("STATUS", TYPE_STRING));
            reportHeader.add(new Heading("GL_CODE", TYPE_STRING));
            reportHeader.add(new Heading("GL_NAME", TYPE_STRING));

        } else if (reportName.equalsIgnoreCase("GL_TRANSACTION_ENQUIRY_REPORT")) {
            reportHeader.add(new Heading("SL_NO", TYPE_STRING));
            reportHeader.add(new Heading("GL_ACCOUNT_NO", TYPE_STRING));
            reportHeader.add(new Heading("CBS_REF_NO", TYPE_STRING));
            reportHeader.add(new Heading("TRAN_DATE", TYPE_STRING));
            reportHeader.add(new Heading("JRNL_NO", TYPE_STRING));
            reportHeader.add(new Heading("TXN_TYPE", TYPE_STRING));
            reportHeader.add(new Heading("TXN_AMT", TYPE_STRING));

        }

        return reportHeader;
    }
}
