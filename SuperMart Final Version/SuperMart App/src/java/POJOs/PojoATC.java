
package POJOs;

public class PojoATC {
    private int cstmid;
    private int ordid;
    private int prdid;
    private int ordlistid;
    private int ordcharge;
    private int prdqty;
    private int prdtotalamount;
    private String imgpath;
    private String prdname;
    private int prdprize;
    private String prdunit;
    private int prddiscount;
    private int stock;
    private String prdcategory;
    private String prddescription;

    public PojoATC() {
    }

    public PojoATC(int cstmid, int ordid, int prdid, int ordlistid, int prdqty, int prdtotalamount, String imgpath, String prdname, int prdprize, String prdunit, int prddiscount, int stock, String prdcategory, String prddescription) {
        this.cstmid = cstmid;
        this.ordid = ordid;
        this.prdid = prdid;
        this.ordlistid = ordlistid;
        this.prdqty = prdqty;
        this.prdtotalamount = prdtotalamount;
        this.imgpath = imgpath;
        this.prdname = prdname;
        this.prdprize = prdprize;
        this.prdunit = prdunit;
        this.prddiscount = prddiscount;
        this.stock = stock;
        this.prdcategory = prdcategory;
        this.prddescription = prddescription;
    }

    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
    }

    public int getOrdid() {
        return ordid;
    }

    public void setOrdid(int ordid) {
        this.ordid = ordid;
    }

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
    }

    public int getOrdlistid() {
        return ordlistid;
    }

    public void setOrdlistid(int ordlistid) {
        this.ordlistid = ordlistid;
    }

    public int getPrdqty() {
        return prdqty;
    }

    public void setPrdqty(int prdqty) {
        this.prdqty = prdqty;
    }

    public int getPrdtotalamount() {
        return prdtotalamount;
    }

    public void setPrdtotalamount(int prdtotalamount) {
        this.prdtotalamount = prdtotalamount;
    }

    public String getImgpath() {
        return imgpath;
    }

    public void setImgpath(String imgpath) {
        this.imgpath = imgpath;
    }

    public String getPrdname() {
        return prdname;
    }

    public void setPrdname(String prdname) {
        this.prdname = prdname;
    }

    public int getPrdprize() {
        return prdprize;
    }

    public void setPrdprize(int prdprize) {
        this.prdprize = prdprize;
    }

    public String getPrdunit() {
        return prdunit;
    }

    public void setPrdunit(String prdunit) {
        this.prdunit = prdunit;
    }

    public int getPrddiscount() {
        return prddiscount;
    }

    public void setPrddiscount(int prddiscount) {
        this.prddiscount = prddiscount;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getPrdcategory() {
        return prdcategory;
    }

    public void setPrdcategory(String prdcategory) {
        this.prdcategory = prdcategory;
    }

    public String getPrddescription() {
        return prddescription;
    }

    public void setPrddescription(String prddescription) {
        this.prddescription = prddescription;
    }

    public int getOrdcharge() {
        return ordcharge;
    }

    public void setOrdcharge(int ordcharge) {
        this.ordcharge = ordcharge;
    }
    
    
}
