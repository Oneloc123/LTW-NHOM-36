package vn.services;

import vn.dao.ContactDao;
import vn.model.Contact;

public class ContactService {

    private ContactDao contactDao = new ContactDao();

    public void saveContact(Contact contact) {
        contactDao.insert(contact);
    }
}
