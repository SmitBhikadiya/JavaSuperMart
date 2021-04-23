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
public class PojoRegistration {
    private int userId;
    private String userName;
    private String userType;
    private String userEmail;
    private String userMobile;
    private String userPassword;
    private String userAddress;
    private String userRegistrationTime;

    public PojoRegistration(String userName, String userType, String userEmail, String userMobile, String userPassword, String userAddress) {
        this.userName = userName;
        this.userType = userType;
        this.userEmail = userEmail;
        this.userMobile = userMobile;
        this.userPassword = userPassword;
        this.userAddress = userAddress;
    }

    public PojoRegistration() {
        
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserMobile() {
        return userMobile;
    }

    public void setUserMobile(String userMobile) {
        this.userMobile = userMobile;
    }

    public String getUserPassword() {
        return userPassword;
    }

    public void setUserPassword(String userPassword) {
        this.userPassword = userPassword;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserRegistrationTime() {
        return userRegistrationTime;
    }

    public void setUserRegistrationTime(String userRegistrationTime) {
        this.userRegistrationTime = userRegistrationTime;
    }
    
    
}
