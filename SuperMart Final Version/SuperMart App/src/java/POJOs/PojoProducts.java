
package POJOs;

public class PojoProducts {
    private int prdid;
    private int strid;
    private String imgpath;
    private String prdname;
    private int prdprize;
    private String prdunit;
    private int prddiscount;
    private int prdtotalqty;
    private String prdcategory;
    private String prddescription;
    private int prdpurchasedbycstm;
    private String prdupdatedtime;
    
    /* for populer category */
    private int count;
    private int catid;
    

    public PojoProducts(){}

    public PojoProducts(int prdid, int strid, String imgpath, String prdname, int prdprize, String prdunit, int prddiscount, int prdtotalqty, String prdcategory, String prddescription) {
        this.prdid = prdid;
        this.strid = strid;
        this.imgpath = imgpath;
        this.prdname = prdname;
        this.prdprize = prdprize;
        this.prdunit = prdunit;
        this.prddiscount = prddiscount;
        this.prdtotalqty = prdtotalqty;
        this.prdcategory = prdcategory;
        this.prddescription = prddescription;
    }

    
    public PojoProducts(int strid, String imgpath, String prdname, int prdprize, String prdunit, int prddiscount, int prdtotalqty, String prdcategory, String prddescription) {
        this.strid = strid;
        this.imgpath = imgpath;
        this.prdname = prdname;
        this.prdprize = prdprize;
        this.prdunit = prdunit;
        this.prddiscount = prddiscount;
        this.prdtotalqty = prdtotalqty;
        this.prdcategory = prdcategory;
        this.prddescription = prddescription;
    }

    public int getPrdpurchasedbycstm() {
        return prdpurchasedbycstm;
    }

    public void setPrdpurchasedbycstm(int prdpurchasedbycstm) {
        this.prdpurchasedbycstm = prdpurchasedbycstm;
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
    
   

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
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

    public int getPrdtotalqty() {
        return prdtotalqty;
    }

    public void setPrdtotalqty(int prdtotalqty) {
        this.prdtotalqty = prdtotalqty;
    }

    public String getPrdupdatedtime() {
        return prdupdatedtime;
    }

    public void setPrdupdatedtime(String prdupdatedtime) {
        this.prdupdatedtime = prdupdatedtime;
    }
    
    /* for populer category */

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public int getCatid() {
        return catid;
    }

    public void setCatid(int catid) {
        this.catid = catid;
    }
    
    
    
}
