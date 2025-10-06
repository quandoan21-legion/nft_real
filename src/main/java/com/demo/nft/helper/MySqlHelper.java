package com.demo.nft.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.EnvUtil;

public class MySqlHelper {
    private static final String DB_URL = EnvUtil.get("DB_URL");
    private static final String DB_USERNAME = EnvUtil.get("DB_USERNAME");
    private static final String DB_PASSWORD = EnvUtil.get("DB_PASSWORD");
    private static Connection connection;

    public static Connection getConnection() {
        if(connection == null){
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection =
                        DriverManager.getConnection(
                                DB_URL,
                                DB_USERNAME,
                                DB_PASSWORD);
                System.out.println("Mở kết nối thành công đến mysql.");
            } catch (SQLException | ClassNotFoundException e) {
                System.err.println(e.getMessage());
                System.err.println("Không thể kết nối database.");
            }
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            connection.close();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            System.err.println("Không thể đóng kết nối đến database.");
        }
    }
}

