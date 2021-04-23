/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJOs;

public class PojoStore {
    private int strid;
    private int skid;
    private String imgpath;
    private String strname;
    private String strcontact;
    private String straddress;
    private String stropentime;
    private String strclosetime;
    private int strhavingserviser;
    private String strupdatedtime;

    public PojoStore() {
    }

    public PojoStore(int skid, String imgpath, String strname, String strcontact, String straddress, String stropentime, String strclosetime, int strhavingserviser) {
        this.skid = skid;
        this.imgpath = imgpath;
        this.strname = strname;
        this.strcontact = strcontact;
        this.straddress = straddress;
        this.stropentime = stropentime;
        this.strclosetime = strclosetime;
        this.strhavingserviser = strhavingserviser;
    }
    
    

    public PojoStore(String imgpath, String strname, String strcontact, String straddress, String stropentime, String strclosetime, int strhavingserviser) {
        this.imgpath = imgpath;
        this.strname = strname;
        this.strcontact = strcontact;
        this.straddress = straddress;
        this.stropentime = stropentime;
        this.strclosetime = strclosetime;
        this.strhavingserviser = strhavingserviser;
    }

    public PojoStore(int strid, int skid, String imgpath, String strname, String strcontact, String straddress, String stropentime, String strclosetime, int strhavingserviser) {
        this.strid = strid;
        this.skid = skid;
        this.imgpath = imgpath;
        this.strname = strname;
        this.strcontact = strcontact;
        this.straddress = straddress;
        this.stropentime = stropentime;
        this.strclosetime = strclosetime;
        this.strhavingserviser = strhavingserviser;
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

    public String getImgpath() {
        return imgpath;
    }

    public void setImgpath(String imgpath) {
        this.imgpath = imgpath;
    }

    public String getStrname() {
        return strname;
    }

    public void setStrname(String strname) {
        this.strname = strname;
    }

    public String getStrcontact() {
        return strcontact;
    }

    public void setStrcontact(String strcontact) {
        this.strcontact = strcontact;
    }

    public String getStraddress() {
        return straddress;
    }

    public void setStraddress(String straddress) {
        this.straddress = straddress;
    }

    public String getStropentime() {
        return stropentime;
    }

    public void setStropentime(String stropentime) {
        this.stropentime = stropentime;
    }

    public String getStrclosetime() {
        return strclosetime;
    }

    public void setStrclosetime(String strclosetime) {
        this.strclosetime = strclosetime;
    }

    public int getStrhavingserviser() {
        return strhavingserviser;
    }

    public void setStrhavingserviser(int strhavingserviser) {
        this.strhavingserviser = strhavingserviser;
    }

    public String getStrupdatedtime() {
        return strupdatedtime;
    }

    public void setStrupdatedtime(String strupdatedtime) {
        this.strupdatedtime = strupdatedtime;
    }
    
}
