package com.demo.nft.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.EnvUtil;

public class MySqlHelper {
    private static final String DB_URL = EnvUtil.get("DB_URL");
    private static final String DB_USERNAME = EnvUtil.get("DB_USERNAME");
    private static final String DB_PASSWORD = EnvUtil.get("DB_PASSWORD");
    private static volatile Connection connection;

    public MySqlHelper() {}

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            synchronized (MySqlHelper.class) {
                if (connection == null || connection.isClosed()) {
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(
                                DB_URL,
                                DB_USERNAME,
                                DB_PASSWORD
                        );
                        System.out.println("Mở kết nối thành công đến MySQL.");
                    } catch (ClassNotFoundException e) {
                        throw new SQLException("Không tìm thấy MySQL Driver: " + e.getMessage(), e);
                    } catch (SQLException e) {
                        System.err.println("Lỗi kết nối database: " + e.getMessage());
                        throw e;
                    }
                }
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                    System.out.println("Đóng kết nối thành công.");
                }
            } catch (SQLException e) {
                System.err.println("Lỗi khi đóng kết nối: " + e.getMessage());
            } finally {
                connection = null;
            }
        }
    }
}