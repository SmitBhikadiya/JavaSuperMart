
package POJOs;

public class PojoAdminUser {
    private int adid;
    private String adname;
    private String ademail;
    private String adcontact;
    private String adtype;
    private String adpassword;
    private String adaddress;

    public PojoAdminUser() {
    }

    public PojoAdminUser(String adname, String ademail, String adcontact, String adtype, String adpassword, String adaddress) {
        this.adname = adname;
        this.ademail = ademail;
        this.adcontact = adcontact;
        this.adtype = adtype;
        this.adpassword = adpassword;
        this.adaddress = adaddress;
    }
    
    public PojoAdminUser(int adid,String adname, String ademail, String adcontact, String adpassword, String adaddress) {
        this.adid = adid;
        this.adname = adname;
        this.ademail = ademail;
        this.adcontact = adcontact;
        this.adpassword = adpassword;
        this.adaddress = adaddress;
    }

    public int getAdid() {
        return adid;
    }

    public void setAdid(int adid) {
        this.adid = adid;
    }

    public String getAdname() {
        return adname;
    }

    public void setAdname(String adname) {
        this.adname = adname;
    }

    public String getAdemail() {
        return ademail;
    }

    public void setAdemail(String ademail) {
        this.ademail = ademail;
    }

    public String getAdcontact() {
        return adcontact;
    }

    public void setAdcontact(String adcontact) {
        this.adcontact = adcontact;
    }

    public String getAdtype() {
        return adtype;
    }

    public void setAdtype(String adtype) {
        this.adtype = adtype;
    }

    public String getAdpassword() {
        return adpassword;
    }

    public void setAdpassword(String adpassword) {
        this.adpassword = adpassword;
    }

    public String getAdaddress() {
        return adaddress;
    }

    public void setAdaddress(String adaddress) {
        this.adaddress = adaddress;
    }
    
    
    
}
