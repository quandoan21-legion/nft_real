package com.demo.nft.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.EnvUtil;

public class MySqlHelper {
    private static final String DB_URL = EnvUtil.getOrDefault(
        "DB_URL",
        "jdbc:mysql://localhost:3306/nft_market?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
    );
    private static final String DB_USERNAME = EnvUtil.getOrDefault("DB_USERNAME", "nft_app");
    private static final String DB_PASSWORD = EnvUtil.getOrDefault("DB_PASSWORD", "nft_app_password");
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
