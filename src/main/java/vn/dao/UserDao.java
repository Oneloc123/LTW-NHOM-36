package vn.dao;

import org.jdbi.v3.core.statement.PreparedBatch;
import vn.model.User;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDao extends BaseDao {
    static Map<Integer,User> data=new HashMap<Integer,User>();
    static {
        data.put(1,new User(1,"username1","1","email1.com",
                "user1","001","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(2,new User(2,"username2","1","email2.com",
                "user2","002","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(3,new User(3,"username3","1","email3.com",
                "user3","003","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(4,new User(4,"username4","1","email1.com",
                "user1","001","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(5,new User(5,"username5","1","email1.com",
                "user1","001","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(6,new User(6,"username6","1","email1.com",
                "user1","001","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));
        data.put(7,new User(7,"username7","1","email1.com",
                "user1","001","client",
                true,"1/1/2020","src/main/webapp/assets/img/User/imgUser1.png"));

    }
    public List<User> getListUser() {
        return new ArrayList<>(data.values());
    }
    public List<User> getList() {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users"
                        )
                        .mapToBean(User.class)
                        .list()
        );
    }
    public User getUserById(int id) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, username, password, email, fullName, phoneNumber, role, isActive, createAt, imgURL " +
                                        "FROM users WHERE id = :id"
                        )
                        .bind("id", id)
                        .mapToBean(User.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public User getUser(int id) {
        return data.get(id);
    }
    public void insert(List<User> users){
        get().useHandle(h -> {
            PreparedBatch batch = h.prepareBatch(
                    "INSERT INTO users " +
                            "(id, username, password, email, fullName, phoneNumber, role, isActive, createAt, imgURL) " +
                            "VALUES (:id, :username, :password, :email, :fullName, :phoneNumber, :role, :active, :createAt, :imgURL)"
            );

            users.forEach( u -> {
                batch.bindBean(u).add();
            });
            batch.execute();
        });
    }
    public void updateProfile(User user) {
        get().useHandle(h -> {
            h.createUpdate(
                            "UPDATE users SET " +
                                    "email = :email, " +
                                    "fullName = :fullName, " +
                                    "phoneNumber = :phoneNumber, " +
                                    "imgURL = :imgURL " +
                                    "WHERE id = :id"
                    )
                    .bindBean(user)
                    .execute();
        });
    }
    public void updatePassword(int id, String password) {
        get().useHandle(h -> {
            h.createUpdate(
                            "UPDATE users SET password = :password WHERE id = :id"
                    )
                    .bind("id", id)
                    .bind("password", password)
                    .execute();
        });
    }
    public boolean checkLogin(String username, String password) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT COUNT(*) FROM users " +
                                        "WHERE username = :username AND password = :password"
                        )
                        .bind("username", username)
                        .bind("password", password)
                        .mapTo(Integer.class)
                        .one() > 0
        );
    }
    public void insertUser(User user) {
        get().useHandle(h -> {
            h.createUpdate(
                            "INSERT INTO users " +
                                    "(username, password, email, fullName, phoneNumber, role, isActive, createAt, imgURL) " +
                                    "VALUES (:username, :password, :email, :fullName, :phoneNumber, :role, :active, :createAt, :imgURL)"
                    )
                    .bindBean(user)
                    .execute();
        });
    }
    static void main(String[] args) {
        UserDao dao=new UserDao();
        List<User> users = dao.getListUser();
        dao.insert(users);
    }
}
