package vn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import org.jdbi.v3.core.statement.PreparedBatch;
import vn.model.Contact;

public class ContactDao extends BaseDao {

    private static final String INSERT_SQL =
            "INSERT INTO contacts(name, email, message) VALUES (?, ?, ?)";

    public boolean insertContact(String name, String email, String subject, String message) {
        return get().withHandle(h -> {
            PreparedBatch batch = h.prepareBatch(
                    "INSERT INTO contacts " +
                            "(name, email, subject, message) " +
                            "VALUES (:name, :email, :subject, :message)"
            );

            batch
                    .bind("name", name)
                    .bind("email", email)
                    .bind("subject", subject)
                    .bind("message", message)
                    .add();

            int[] result = batch.execute();
            return result.length > 0;
        });
    }



}
