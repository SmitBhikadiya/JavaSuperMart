
package POJOs;

public class PojoOrderRequest {
    private int ordid;
    private int cstmid;
    private String paymethod;
    private int ordtotalbill;
    private int ordstatus;
    private String ordarrivalat;
    private String cstmname;
    private String cstmemail;
    private String cstmcontact;
    private String cstmaddress;
    private int ordcharge;

    public PojoOrderRequest() {
    }
    
    

    public PojoOrderRequest(int ordid, int cstmid, String paymethod, int ordtotalbill, int ordstatus, String ordarrivalat, String cstmname, String cstmemail, String cstmcontact, String cstmaddress) {
        this.ordid = ordid;
        this.cstmid = cstmid;
        this.paymethod = paymethod;
        this.ordtotalbill = ordtotalbill;
        this.ordstatus = ordstatus;
        this.ordarrivalat = ordarrivalat;
        this.cstmname = cstmname;
        this.cstmemail = cstmemail;
        this.cstmcontact = cstmcontact;
        this.cstmaddress = cstmaddress;
    }

    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }

    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
    }

    public String getPaymethod() {
        return paymethod;
    }

    public void setPaymethod(String paymethod) {
        this.paymethod = paymethod;
    }

    public int getOrdtotalbill() {
        return ordtotalbill;
    }

    public void setOrdtotalbill(int ordtotalbill) {
        this.ordtotalbill = ordtotalbill;
    }

    public int getOrdstatus() {
        return ordstatus;
    }

    public void setOrdstatus(int ordstatus) {
        this.ordstatus = ordstatus;
    }

    public String getOrdarrivalat() {
        return ordarrivalat;
    }

    public void setOrdarrivalat(String ordarrivalat) {
        this.ordarrivalat = ordarrivalat;
    }

    public String getCstmname() {
        return cstmname;
    }

    public void setCstmname(String cstmname) {
        this.cstmname = cstmname;
    }

    public String getCstmemail() {
        return cstmemail;
    }

    public void setCstmemail(String cstmemail) {
        this.cstmemail = cstmemail;
    }

    public String getCstmcontact() {
        return cstmcontact;
    }

    public void setCstmcontact(String cstmcontact) {
        this.cstmcontact = cstmcontact;
    }

    public String getCstmaddress() {
        return cstmaddress;
    }

    public void setCstmaddress(String cstmaddress) {
        this.cstmaddress = cstmaddress;
    }

    public int getOrdcharge() {
        return ordcharge;
    }

    public void setOrdcharge(int ordcharge) {
        this.ordcharge = ordcharge;
    }
    
    
}
