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
public class Heading {

    private String sName;
    private int sType;

    public Heading(String Name, int Type) {
        this.sName = Name;
        this.sType = Type;
    }

    public String getName() {
        return sName;
    }

    public int getType() {
        return sType;
    }

}
