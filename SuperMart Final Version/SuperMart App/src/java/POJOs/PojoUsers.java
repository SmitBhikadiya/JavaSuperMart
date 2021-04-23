/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJOs;

public class PojoUsers {
    private int cstmid;
    private String cstmname;
    private String cstmemail;
    private String cstmcontact;
    private String cstmaddress;
    private String cstmpassword;
    private String cstmupdatedtime;

    public PojoUsers() {
    }
    
    public PojoUsers(String cstmname, String cstmemail, String cstmcontact, String cstmaddress, String cstmpassword) {
        this.cstmname = cstmname;
        this.cstmemail = cstmemail;
        this.cstmcontact = cstmcontact;
        this.cstmaddress = cstmaddress;
        this.cstmpassword = cstmpassword;
    }

    public PojoUsers(int cstmid, String cstmname, String cstmemail, String cstmcontact, String cstmaddress, String cstmpassword) {
        this.cstmid = cstmid;
        this.cstmname = cstmname;
        this.cstmemail = cstmemail;
        this.cstmcontact = cstmcontact;
        this.cstmaddress = cstmaddress;
        this.cstmpassword = cstmpassword;
    }

    
    
    public int getCstmid() {
        return cstmid;
    }

    public void setCstmid(int cstmid) {
        this.cstmid = cstmid;
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

    public String getCstmpassword() {
        return cstmpassword;
    }

    public void setCstmpassword(String cstmpassword) {
        this.cstmpassword = cstmpassword;
    }

    public String getCstmupdatedtime() {
        return cstmupdatedtime;
    }

    public void setCstmupdatedtime(String cstmupdatedtime) {
        this.cstmupdatedtime = cstmupdatedtime;
    }
    
    
}
