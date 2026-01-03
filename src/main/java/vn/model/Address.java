package vn.model;

public class Address {
    private int id;
    private int userID;
    private String fullAddress;

    public Address(int id, int userID, String fullAddress) {
        this.id = id;
        this.userID = userID;
        this.fullAddress = fullAddress;
    }
    public Address() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullAddress() {
        return fullAddress;
    }

    public void setFullAddress(String fullAddress) {
        this.fullAddress = fullAddress;
    }
}
