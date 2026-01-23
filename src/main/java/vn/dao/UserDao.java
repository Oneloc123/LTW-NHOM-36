package vn.dao;

import org.jdbi.v3.core.statement.PreparedBatch;
import vn.model.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDao extends BaseDao {
    // OK
    public List<User> getList() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users"
                        )
                        .mapToBean(User.class)
                        .list()
        );
    }
    // OK
    public User getUserById(int id) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users WHERE id = :id"
                        )
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    //OK
    public void insert(List<User> users) {
        get().useHandle(h -> {
            PreparedBatch batch = h.prepareBatch(
                    "INSERT INTO users " +
                            "(username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL) " +
                            "VALUES (:username, :password, :email, :fullName, :address, :phoneNumber, :role, :active, :createAt, :imgURL)"
            );

            for (User u : users) {
                batch.bindBean(u).add();
            }
            batch.execute();
        });
    }

    // OK
    public void updateProfile(User user) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE users SET " +
                                        "email = :email, " +
                                        "fullName = :fullName, " +
                                        "address = :address, " +
                                        "phoneNumber = :phoneNumber, " +
                                        "password = :password " +
                                        "WHERE id = :id"
                        )
                        .bindBean(user)
                        .execute()
        );
    }

    // OK
    public void updatePassword(int id, String password) {
        get().useHandle(h ->
                h.createUpdate(
                                "UPDATE users SET password = :password WHERE id = :id"
                        )
                        .bind("id", id)
                        .bind("password", password)
                        .execute()
        );
    }

    // OK
    public boolean checkLogin(String username, String password) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM users " +
                                        "WHERE username = :username " +
                                        "AND password = :password " +
                                        "AND isActive = 1"
                        )
                        .bind("username", username)
                        .bind("password", password)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }

    // OK
    public boolean insertUser(User user) {
        try {
            get().useHandle(h ->
                    h.createUpdate(
                                    "INSERT INTO users " +
                                            "(username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL) " +
                                            "VALUES (:username, :password, :email, :fullName, :address, :phoneNumber, :role, :active, :createAt, :imgURL)"
                            )
                            .bindBean(user)
                            .execute()
            );
            return true; // Thành công
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Thất bại
        }
    }

    //OK
    public User getUserByUserName(String username) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users WHERE username = :username"
                        )
                        .bind("username", username)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public User getUserByMail(String email) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users WHERE email = :email"
                        )
                        .bind("email", email)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }

    // 🔹 Tìm kiếm theo username
    public List<User> getUserByKeyword(String keyword) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users WHERE username LIKE :keyword"
                        )
                        .bind("keyword", "%" + keyword + "%")
                        .mapToBean(User.class)
                        .list()
        );
    }

    public List<User> filterUsers(String keyword, String role, String status) {

        return get().withHandle(h -> {

            String sql =
                    "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                            "FROM users WHERE 1=1 ";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += "AND (username LIKE :keyword " +
                        "OR fullName LIKE :keyword " +
                        "OR email LIKE :keyword) ";
            }

            if (role != null && !role.isEmpty()) {
                sql += "AND role = :role ";
            }

            if (status != null && !status.isEmpty()) {
                sql += "AND isActive = :status ";
            }

            var query = h.createQuery(sql);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.bind("keyword", "%" + keyword.trim() + "%");
            }

            if (role != null && !role.isEmpty()) {
                query.bind("role", role);
            }

            if (status != null && !status.isEmpty()) {
                query.bind("status", Integer.parseInt(status));
            }

            return query.mapToBean(User.class).list();
        });
    }


    public void deleteUserById(int id) {
        get().useHandle(h ->
                h.createUpdate("DELETE FROM users WHERE id = :id")
                        .bind("id", id)
                        .execute()
        );
    }

    public List<User> filterUsers(String keyword, String role) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users " +
                                        "WHERE (:keyword IS NULL OR username LIKE :keyword) " +
                                        "AND (:role IS NULL OR role = :role) "
                        )
                        .bind("keyword",
                                (keyword == null || keyword.trim().isEmpty())
                                        ? null
                                        : "%" + keyword + "%")
                        .bind("role",
                                (role == null || role.trim().isEmpty())
                                        ? null
                                        : role)
                        .mapToBean(User.class)
                        .list()
        );
    }

    public List<User> filterUsers(String keyword) {

        return get().withHandle(h -> {

            String sql =
                    "SELECT id, username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL " +
                            "FROM users ";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += "WHERE fullName LIKE :keyword";
            }

            var query = h.createQuery(sql);

            if (keyword != null && !keyword.trim().isEmpty()) {
                query.bind("keyword", "%" + keyword + "%");
            }

            return query.mapToBean(User.class).list();
        });
    }



}
