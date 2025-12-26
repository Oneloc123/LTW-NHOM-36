package vn.dao;

import org.jdbi.v3.core.statement.PreparedBatch;

public class ContactDao extends BaseDao {

    public boolean insertContact(String name, String email, String message) {
        return get().withHandle(h -> {

            PreparedBatch batch = h.prepareBatch(
                    "INSERT INTO contacts (name, email, message) " +
                            "VALUES (:name, :email, :message)"
            );

            batch
                    .bind("name", name)
                    .bind("email", email)
                    .bind("message", message)
                    .add();

            int[] result = batch.execute();
            return result.length > 0;
        });
    }
}
