package vn.dao;

public class ContactDao extends BaseDao {

    public boolean insertContact(String name, String email, String message) {
        try {
            return get().withHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO contacts (name, email, message) " +
                                            "VALUES (:name, :email, :message)"
                            )
                            .bind("name", name)
                            .bind("email", email)
                            .bind("message", message)
                            .execute() > 0
            );
        } catch (Exception e) {
            e.printStackTrace(); // log ra console Tomcat
            return false;
        }
    }
}
