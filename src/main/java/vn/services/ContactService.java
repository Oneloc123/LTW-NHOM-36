package vn.services;

import vn.dao.ContactDao;

public class ContactService {

    private final ContactDao contactDao = new ContactDao();

    public boolean saveContact(String name, String email, String message) {
        // GỌI ĐÚNG TÊN HÀM TRONG DAO
        return contactDao.insertContact(name, email, message);
    }
}
