package vn.model;

public class Contact {
    private String name;
    private String email;
    private String message;

    public Contact(String name, String email, String message) {
        this.name = name;
        this.email = email;
        this.message = message;
    }

    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getMessage() { return message; }
}
