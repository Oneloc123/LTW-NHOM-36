package vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import vn.model.Contact;

public class ContactDao {

    private static final String INSERT_SQL =
            "INSERT INTO contacts(name, email, message) VALUES (?, ?, ?)";

    public void insert(Contact contact) {
        try (Connection conn = DBProperties.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_SQL)) {

            ps.setString(1, contact.getName());
            ps.setString(2, contact.getEmail());
            ps.setString(3, contact.getMessage());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
