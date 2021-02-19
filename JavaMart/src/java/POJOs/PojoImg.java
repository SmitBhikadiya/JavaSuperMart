/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package POJOs;

public class PojoImg {
    private int imgid;
    private String imgname;
    private int imgsize;
    private String imgtype;
    private String imgupdatedat;

    public PojoImg(){}
    
    public PojoImg(String imgname, int imgsize, String imgtype) {
        this.imgname = imgname;
        this.imgsize = imgsize;
        this.imgtype = imgtype;
    }

    public int getImgid() {
        return imgid;
    }

    public void setImgid(int imgid) {
        this.imgid = imgid;
    }

    public String getImgname() {
        return imgname;
    }

    public void setImgname(String imgname) {
        this.imgname = imgname;
    }

    public int getImgsize() {
        return imgsize;
    }

    public void setImgsize(int imgsize) {
        this.imgsize = imgsize;
    }

    public String getImgtype() {
        return imgtype;
    }

    public void setImgtype(String imgtype) {
        this.imgtype = imgtype;
    }

    public String getImgupdatedat() {
        return imgupdatedat;
    }

    public void setImgupdatedat(String imgupdatedat) {
        this.imgupdatedat = imgupdatedat;
    }
    
    
    
}
