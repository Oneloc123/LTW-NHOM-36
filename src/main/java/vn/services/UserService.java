package vn.services;

import vn.dao.UserDao;
import vn.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    UserDao userDao = new UserDao();

    public User getUserByUserName(String userName)
    {
        List<User> users = userDao.getListUser();
        for(User u:users){
            if(u.getUsername().equals(userName)){
                return u;
            }
        }
        return null;
    }
    public List<User> getAllUsers()
    {
        return userDao.getListUser();
    }
    public boolean checkUserNameAndPassword(String username, String password)
    {
        User user = getUserByUserName(username);
        if(user == null)return false;
        if(user.getPassword().equals(password)) return true;
        return false;
    }
}
