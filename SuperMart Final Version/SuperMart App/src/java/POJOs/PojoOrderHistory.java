
package POJOs;

public class PojoOrderHistory {
    private int ordhistoryid;
    private int ordid;
    private int cstmid;
    private int strid;
    private int ordcharge;
    private String deliveredby;
    private String acceptedtype;
    private String deliveredcontact;
    private String orderedtime;
    private String deliveredtime;
    private String billingname;
    private String billingaddress;

    public PojoOrderHistory() {
    }

    public PojoOrderHistory(int ordid, int cstmid, int strid, int ordcharge, String deliveredby, String acceptedtype, String deliveredcontact, String orderedtime, String deliveredtime, String billingname, String billingaddress) {
        this.ordid = ordid;
        this.cstmid = cstmid;
        this.strid = strid;
        this.ordcharge = ordcharge;
        this.deliveredby = deliveredby;
        this.acceptedtype = acceptedtype;
        this.deliveredcontact = deliveredcontact;
        this.orderedtime = orderedtime;
        this.deliveredtime = deliveredtime;
        this.billingname = billingname;
        this.billingaddress = billingaddress;
    }

    public String getAcceptedtype() {
        return acceptedtype;
    }

    public void setAcceptedtype(String acceptedtype) {
        this.acceptedtype = acceptedtype;
    }

    public String getBillingname() {
        return billingname;
    }

    public void setBillingname(String billingname) {
        this.billingname = billingname;
    }

    
    public String getBillingaddress() {
        return billingaddress;
    }

    public void setBillingaddress(String billingaddress) {
        this.billingaddress = billingaddress;
    }

    
    public int getOrdhistoryid() {
        return ordhistoryid;
    }

    public void setOrdhistoryid(int ordhistoryid) {
        this.ordhistoryid = ordhistoryid;
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

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }

    public int getOrdcharge() {
        return ordcharge;
    }

    public void setOrdcharge(int ordcharge) {
        this.ordcharge = ordcharge;
    }

    public String getDeliveredby() {
        return deliveredby;
    }

    public void setDeliveredby(String deliveredby) {
        this.deliveredby = deliveredby;
    }

    public String getDeliveredcontact() {
        return deliveredcontact;
    }

    public void setDeliveredcontact(String deliveredcontact) {
        this.deliveredcontact = deliveredcontact;
    }

    public String getOrderedtime() {
        return orderedtime;
    }

    public void setOrderedtime(String orderedtime) {
        this.orderedtime = orderedtime;
    }

    public String getDeliveredtime() {
        return deliveredtime;
    }

    public void setDeliveredtime(String deliveredtime) {
        this.deliveredtime = deliveredtime;
    }
    
    
}
