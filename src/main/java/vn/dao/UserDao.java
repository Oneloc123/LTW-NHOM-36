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

    static void main(String[] args) {
        UserDao dao=new UserDao();
        List<User> users = dao.getListUser();
        dao.insert(users);
    }
}
