package vn.services;

import vn.dao.UserDao;
import vn.model.User;

import java.util.ArrayList;
import java.util.List;

public class UserService {
    UserDao userDao = new UserDao();

    public User getUserByUserName(String userName)
    {
        User u = userDao.getUserByUserName(userName);
        if(u!=null)
            return u;
        else
            return null;
    }
    // OK
    public List<User> getAllUsers()
    {
        return userDao.getList();
    }


    public boolean checkUserNameAndPassword(String username, String password)
    {
        User user = userDao.getUserByUserName(username);
        if(user == null)return false;
        if(user.getPassword().equals(password)) return true;
        return false;   
    }
    public boolean checkPassword(String username, String password)
    {
        return userDao.checkLogin(username, password);
    }
    public User getUserById(int id)
    {
        return userDao.getUserById(id);
    }
    public void updateUser(User user)
    {
        userDao.updateProfile(user);
    }
    public List<User> getListUser()
    {
        return userDao.getList();
    }
    public void registerUser(User user)
    {
        userDao.insertUser(user);
    }
    public void updatePassword(int id, String newPass)
    {
        userDao.updatePassword(id, newPass);
    }
}
