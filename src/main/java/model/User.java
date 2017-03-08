package model;

import java.util.ArrayList;

public class User {

    /**
     * Attributes
     * ------------
     */

    private String name;
    private String pass;
    private String avatar;
    private String about;
    private int role;


    /**
     * Constructors
     * ------------
     */

    public User(String name, String pass, String avatar, String about, int role) {
        this.name = name;
        this.pass = pass;
        this.avatar = avatar;
        this.about = about;
        this.role = role;
    }


    /**
     * Getters
     * ------------
     */

    public String getName() {
        return name;
    }

    public String getAvatar() {
        return avatar;
    }

    public String getAbout() {
        return about;
    }

    public int getRole() {
        return role;
    }

    /**
     * Setters
     * ------------
     */

    public void setName(String name) {
        this.name = name;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public void setAbout(String about) {
        this.about = about;
    }

    public void setRole(int role) {
        this.role = role;
    }
}
