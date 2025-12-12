package vn.dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

import java.sql.SQLException;

public class BaseDao {
    private static Jdbi jdbi;

    protected Jdbi get(){
        if(jdbi==null){
            makeConect();
        }
        return jdbi;
    }

    private static void makeConect() {
        MysqlDataSource src = new MysqlDataSource();
        String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" + DBProperties.dbname()+ "?" + DBProperties.option();
        src.setURL(url);
        src.setUser(DBProperties.username());
        src.setPassword(DBProperties.password());

        try {
            // - Nén dữ liệu: Dữ liệu được gửi từ MySQL lên web được nén lại
            src.setUseCompression(true);
            // - Tự động kết nối lại nếu có lỗi
            src.setAutoReconnect(true);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        jdbi = Jdbi.create(src);
    }

    public void main(String[] args) {
        BaseDao baseDao = new BaseDao();
        baseDao.get();
    }
}