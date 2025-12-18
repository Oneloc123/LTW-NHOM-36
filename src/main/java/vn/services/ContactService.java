package vn.services;

import vn.dao.ContactDao;
import vn.model.Contact;

public class ContactService {

    private ContactDao contactDao = new ContactDao();

    public boolean saveContact(String name, String email, String subject, String message) {
            return true;
        //        return contactDao.insertContact(name,email,subject,message);
    }
}
