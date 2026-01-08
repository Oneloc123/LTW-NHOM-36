//package vn.dao;
//
//import com.mysql.cj.jdbc.MysqlDataSource;
//import org.jdbi.v3.core.Jdbi;
//
//import java.sql.SQLException;
//
//public abstract class BaseDao {
//    private static Jdbi jdbi;
//
//    protected Jdbi get(){
//        if(jdbi==null){
//            makeConnect();
//        }
//        return jdbi;
//    }
//
//    private void makeConnect() {
//        MysqlDataSource src = new MysqlDataSource();
//        String url = "jdbc:mysql://" + DBProperties.host() + ":" + DBProperties.port() + "/" + DBProperties.dbname()+ "?" + DBProperties.option();
//        src.setURL(url);
//        src.setUser(DBProperties.username());
//        src.setPassword(DBProperties.password());
//
//        try {
//            // - Nén dữ liệu: Dữ liệu được gửi từ MySQL lên web được nén lại
//            src.setUseCompression(true);
//            // - Tự động kết nối lại nếu có lỗi
//            src.setAutoReconnect(true);
//        } catch (SQLException e) {
//            throw new RuntimeException(e);
//        }
//
//        jdbi = Jdbi.create(src);
//    }
//
//}
package vn.dao;

import com.mysql.cj.jdbc.MysqlDataSource;
import org.jdbi.v3.core.Jdbi;

public abstract class BaseDao {

    private static Jdbi jdbi;

    protected synchronized Jdbi get() {
        if (jdbi == null) {

            MysqlDataSource src = new MysqlDataSource();

            String url = "jdbc:mysql://"
                    + DBProperties.host()
                    + ":" + DBProperties.port()
                    + "/" + DBProperties.dbname()
                    + "?" + DBProperties.option();

            src.setURL(url);
            src.setUser(DBProperties.username());
            src.setPassword(DBProperties.password());

            jdbi = Jdbi.create(src);
        }
        return jdbi;
    }
}
