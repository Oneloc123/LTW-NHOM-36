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
                                        "phoneNumber = :phoneNumber " +
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
    public void insertUser(User user) {
        get().useHandle(h ->
                h.createUpdate(
                                "INSERT INTO users " +
                                        "(username, password, email, fullName, address, phoneNumber, role, isActive, createAt, imgURL) " +
                                        "VALUES (:username, :password, :email, :fullName, :address, :phoneNumber, :role, :active, :createAt, :imgURL)"
                        )
                        .bindBean(user)
                        .execute()
        );
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


}
