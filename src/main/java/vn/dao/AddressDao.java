package vn.dao;

import vn.model.Address;

import java.util.List;

public class AddressDao extends BaseDao{

    public Address getAddressByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, full_address " +
                                        "FROM user_addresses " +
                                        "WHERE user_id = :userId " +
                                        "LIMIT 1"
                        )
                        .bind("userId", userId)
                        .mapToBean(Address.class)
                        .findOne()
                        .orElse(null)
        );
    }
    public List<Address> getAddressesByUserId(int userId) {
        return get().withHandle(h ->
                h.createQuery(
                                "SELECT id, user_id, full_address " +
                                        "FROM user_addresses " +
                                        "WHERE user_id = :userId"
                        )
                        .bind("userId", userId)
                        .mapToBean(Address.class)
                        .list()
        );
    }



    public static void main(String[] args) {
        AddressDao addressDao = new AddressDao();
        System.out.println(addressDao.getAddressByUserId(1).getFullAddress());
        for(Address address:addressDao.getAddressesByUserId(1)){
            System.out.println(address.getFullAddress());
        }
    }
}
