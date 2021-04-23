
package POJOs;

public class PojoOrdersStatus {
    private int ordid;
    private int ordstatus;
    private String ordarrivalat;
    private String accepttime;
    private String deliverytime;
    private String acceptstatus;
    private String acceptedname;
    private String acceptedcontact;
    private String pin;

    public PojoOrdersStatus() {
    }

    public PojoOrdersStatus(int ordid, int ordstatus, String pin) {
        this.ordid = ordid;
        this.ordstatus = ordstatus;
        this.pin = pin;
    }

    public PojoOrdersStatus(int ordstatus, String ordarrivalat, String deliverytime, String acceptstatus, String acceptedname, String acceptedcontact) {
        this.ordstatus = ordstatus;
        this.ordarrivalat = ordarrivalat;
        this.deliverytime = deliverytime;
        this.acceptstatus = acceptstatus;
        this.acceptedname = acceptedname;
        this.acceptedcontact = acceptedcontact;
    }

    public PojoOrdersStatus(int ordid, int ordstatus, String ordarrivalat, String deliverytime, String acceptstatus, String acceptedname, String acceptedcontact) {
        this.ordid = ordid;
        this.ordstatus = ordstatus;
        this.ordarrivalat = ordarrivalat;
        this.deliverytime = deliverytime;
        this.acceptstatus = acceptstatus;
        this.acceptedname = acceptedname;
        this.acceptedcontact = acceptedcontact;
    }

    public PojoOrdersStatus(int ordid, int ordstatus, String ordarrivalat, String deliverytime, String acceptstatus, String acceptedname, String acceptedcontact, String pin) {
        this.ordid = ordid;
        this.ordstatus = ordstatus;
        this.ordarrivalat = ordarrivalat;
        this.deliverytime = deliverytime;
        this.acceptstatus = acceptstatus;
        this.acceptedname = acceptedname;
        this.acceptedcontact = acceptedcontact;
        this.pin = pin;
    }

    public PojoOrdersStatus(int ordid, int ordstatus, String ordarrivalat, String accepttime, String deliverytime, String acceptstatus, String acceptedname, String acceptedcontact, String pin) {
        this.ordid = ordid;
        this.ordstatus = ordstatus;
        this.ordarrivalat = ordarrivalat;
        this.accepttime = accepttime;
        this.deliverytime = deliverytime;
        this.acceptstatus = acceptstatus;
        this.acceptedname = acceptedname;
        this.acceptedcontact = acceptedcontact;
        this.pin = pin;
    }

    public String getAccepttime() {
        return accepttime;
    }

    public void setAccepttime(String accepttime) {
        this.accepttime = accepttime;
    }
    
    
    
    

    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
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

    public String getDeliverytime() {
        return deliverytime;
    }

    public void setDeliverytime(String deliverytime) {
        this.deliverytime = deliverytime;
    }

    public String getAcceptstatus() {
        return acceptstatus;
    }

    public void setAcceptstatus(String acceptstatus) {
        this.acceptstatus = acceptstatus;
    }

    public String getAcceptedname() {
        return acceptedname;
    }

    public void setAcceptedname(String acceptedname) {
        this.acceptedname = acceptedname;
    }

    public String getAcceptedcontact() {
        return acceptedcontact;
    }

    public void setAcceptedcontact(String acceptedcontact) {
        this.acceptedcontact = acceptedcontact;
    }

    public String getPin() {
        return pin;
    }

    public void setPin(String pin) {
        this.pin = pin;
    }
}
