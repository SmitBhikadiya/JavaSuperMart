
package POJOs;

import java.util.logging.Logger;

public class PojoOrderHistoryList {
    private int ordhistorylistid;
    private int ordhistoryid;
    private int prdid;
    private String prdname;
    private int prdprize;
    private int prdqty;
    private int prdtotal;
    private String prdimgpath;

    public PojoOrderHistoryList() {
    }

    public PojoOrderHistoryList(int ordhistoryid, int prdid,String prdname, int prdprize, int prdqty, int prdtotal, String prdimgpath) {
        this.ordhistoryid = ordhistoryid;
        this.prdid = prdid;
        this.prdname = prdname;
        this.prdprize = prdprize;
        this.prdqty = prdqty;
        this.prdtotal = prdtotal;
        this.prdimgpath = prdimgpath;
    }

    public int getOrdhistorylistid() {
        return ordhistorylistid;
    }

    public void setOrdhistorylistid(int ordhistorylistid) {
        this.ordhistorylistid = ordhistorylistid;
    }

    public int getOrdhistoryid() {
        return ordhistoryid;
    }

    public void setOrdhistoryid(int ordhistoryid) {
        this.ordhistoryid = ordhistoryid;
    }

    public int getPrdid() {
        return prdid;
    }

    public void setPrdid(int prdid) {
        this.prdid = prdid;
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

    public int getPrdqty() {
        return prdqty;
    }

    public void setPrdqty(int prdqty) {
        this.prdqty = prdqty;
    }

    public int getPrdtotal() {
        return prdtotal;
    }

    public void setPrdtotal(int prdtotal) {
        this.prdtotal = prdtotal;
    }

    public String getPrdimgpath() {
        return prdimgpath;
    }

    public void setPrdimgpath(String prdimgpath) {
        this.prdimgpath = prdimgpath;
    }
    
    
}
