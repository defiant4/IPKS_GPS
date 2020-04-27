/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DataEntryBean;

/**
 *
 * @author 590685
 */
public class memberEnrollmentBean {

    //for create
    private String custName;
    private String memberId;
    private String folioNumber;
    private String guardianName;
    private String dateOfBirth;
    private String addr;
    private String district;
    
//for amend
    private String custNameAmend;
    private String memberIdAmend;
    private String folioNumberAmend;
    private String guardianNameAmend;
    private String dateOfBirthAmend;
    private String addrAmend;
    private String districtAmend;

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getAddrAmend() {
        return addrAmend;
    }

    public void setAddrAmend(String addrAmend) {
        this.addrAmend = addrAmend;
    }

    public String getCustName() {
        return custName;
    }

    

    public void setCustName(String custName) {
        this.custName = custName;
    }

   

    public String getCustNameAmend() {
        return custNameAmend;
    }

    public void setCustNameAmend(String custNameAmend) {
        this.custNameAmend = custNameAmend;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getDateOfBirthAmend() {
        return dateOfBirthAmend;
    }

    public void setDateOfBirthAmend(String dateOfBirthAmend) {
        this.dateOfBirthAmend = dateOfBirthAmend;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getDistrictAmend() {
        return districtAmend;
    }

    public void setDistrictAmend(String districtAmend) {
        this.districtAmend = districtAmend;
    }

    public String getFolioNumber() {
        return folioNumber;
    }

    public void setFolioNumber(String folioNumber) {
        this.folioNumber = folioNumber;
    }

    public String getFolioNumberAmend() {
        return folioNumberAmend;
    }

    public void setFolioNumberAmend(String folioNumberAmend) {
        this.folioNumberAmend = folioNumberAmend;
    }

    public String getGuardianName() {
        return guardianName;
    }

    public void setGuardianName(String guardianName) {
        this.guardianName = guardianName;
    }

    public String getGuardianNameAmend() {
        return guardianNameAmend;
    }

    public void setGuardianNameAmend(String guardianNameAmend) {
        this.guardianNameAmend = guardianNameAmend;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getMemberIdAmend() {
        return memberIdAmend;
    }

    public void setMemberIdAmend(String memberIdAmend) {
        this.memberIdAmend = memberIdAmend;
    }
}
