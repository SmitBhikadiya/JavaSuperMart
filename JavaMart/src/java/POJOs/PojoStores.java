/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJOs;

/**
 *
 * @author Smit Bhikadiya
 */
public class PojoStores {
    private int strid; // primary
    private int skid; // foreign
    private int imgid; // foreign
    private String strname;
    private String stradd;
    private String strcontact;
    private String strtype;
    private String ishaving;
    private String openat;
    private String closeat;
    private String strUpdated;
    
     public PojoStores(String strname, String stradd, String strcontact, String strtype, String ishaving, String openat, String closeat) {
        this.strname = strname;
        this.stradd = stradd;
        this.strcontact = strcontact;
        this.strtype = strtype;
        this.ishaving = ishaving;
        this.openat = openat;
        this.closeat = closeat;
    }

    public int getStrid() {
        return strid;
    }

    public void setStrid(int strid) {
        this.strid = strid;
    }

    public int getSkid() {
        return skid;
    }

    public void setSkid(int skid) {
        this.skid = skid;
    }

    public int getImgid() {
        return imgid;
    }

    public void setImgid(int imgid) {
        this.imgid = imgid;
    }

    public String getStrname() {
        return strname;
    }

    public void setStrname(String strname) {
        this.strname = strname;
    }

    public String getStradd() {
        return stradd;
    }

    public void setStradd(String stradd) {
        this.stradd = stradd;
    }

    public String getStrcontact() {
        return strcontact;
    }

    public void setStrcontact(String strcontact) {
        this.strcontact = strcontact;
    }

    public String getStrtype() {
        return strtype;
    }

    public void setStrtype(String strtype) {
        this.strtype = strtype;
    }

    public String getIshaving() {
        return ishaving;
    }

    public void setIshaving(String ishaving) {
        this.ishaving = ishaving;
    }

    public String getOpenat() {
        return openat;
    }

    public void setOpenat(String openat) {
        this.openat = openat;
    }

    public String getCloseat() {
        return closeat;
    }

    public void setCloseat(String closeat) {
        this.closeat = closeat;
    }

    public String getStrUpdated() {
        return strUpdated;
    }

    public void setStrUpdated(String strUpdated) {
        this.strUpdated = strUpdated;
    }
}
