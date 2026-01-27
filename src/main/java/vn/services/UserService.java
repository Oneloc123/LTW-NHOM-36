package vn.services;

import vn.dao.UserDao;
import vn.model.Password;
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
    public boolean updateAvatar(int userId,String imgURL){
        return userDao.updateAvatar(userId,imgURL);
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
        return Password.checkPassword(password, user.getPassword());
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
    public boolean registerUser(User user)
    {
        return userDao.insertUser(user);
    }
    public void updatePassword(int id, String newPass)
    {
        userDao.updatePassword(id, newPass);
    }
    public User getUserByEmail(String email)
    {
        return userDao.getUserByUserName(email);
    }

    public List<User> searchByName(String keyword) {
        return userDao.getUserByKeyword(keyword);
    }

    public List<User> filterUsers(String keyword, String role, String status) {
        return  userDao.filterUsers(keyword,role,status);
    }

    public void deleteUserById(int id) {
        userDao.deleteUserById(id);
    }

    public List<User> filterUsers(String keyword, String role) {
        return userDao.filterUsers(keyword,role);
    }

    public List<User> filterUsers(String keyword) {
        return userDao.filterUsers(keyword);
    }
}
