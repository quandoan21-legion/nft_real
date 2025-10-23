package com.demo.nft.repository;

import com.demo.nft.entity.User;
import com.demo.nft.helper.MySqlHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Optional;

public class MySqlUserRepository implements UserRepository {

    @Override
    public Optional<User> findByUsername(String username) {
        return findBy("SELECT * FROM users WHERE username = ? LIMIT 1", username);
    }

    @Override
    public Optional<User> findByEmail(String email) {
        return findBy("SELECT * FROM users WHERE email = ? LIMIT 1", email);
    }

    @Override
    public Optional<User> findById(Long id) {
        if (id == null) {
            return Optional.empty();
        }
        String sql = "SELECT * FROM users WHERE id = ? LIMIT 1";
        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setLong(1, id);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return Optional.of(mapRowToUser(rs));
                    }
                }
            }
            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể truy vấn người dùng: " + e.getMessage(), e);
        }
    }

    private Optional<User> findBy(String sql, String value) {
        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, value);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return Optional.of(mapRowToUser(rs));
                    }
                }
            }
            return Optional.empty();
        } catch (SQLException e) {
            throw new RuntimeException("Không thể truy vấn người dùng: " + e.getMessage(), e);
        }
    }

    @Override
    public User save(User user) {
        String sql = """
            INSERT INTO users (username, password_hash, full_name, email, role, status, primary_wallet_address, created_at, updated_at, created_by, updated_by)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }

            try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                LocalDateTime now = LocalDateTime.now();
                Timestamp currentTimestamp = Timestamp.valueOf(now);

                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPasswordHash());

                if (user.getFullName() != null && !user.getFullName().isBlank()) {
                    ps.setString(3, user.getFullName());
                } else {
                    ps.setNull(3, java.sql.Types.VARCHAR);
                }

                if (user.getEmail() != null && !user.getEmail().isBlank()) {
                    ps.setString(4, user.getEmail());
                } else {
                    ps.setNull(4, java.sql.Types.VARCHAR);
                }

                ps.setString(5, user.getRole().name());
                ps.setString(6, user.getStatus().name());

                if (user.getPrimaryWalletAddress() != null && !user.getPrimaryWalletAddress().isBlank()) {
                    ps.setString(7, user.getPrimaryWalletAddress());
                } else {
                    ps.setNull(7, java.sql.Types.VARCHAR);
                }

                ps.setTimestamp(8, currentTimestamp);
                ps.setTimestamp(9, currentTimestamp);

                if (user.getCreatedBy() != null) {
                    ps.setLong(10, user.getCreatedBy());
                } else {
                    ps.setNull(10, java.sql.Types.BIGINT);
                }

                if (user.getUpdatedBy() != null) {
                    ps.setLong(11, user.getUpdatedBy());
                } else {
                    ps.setNull(11, java.sql.Types.BIGINT);
                }

                int affectedRows = ps.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Lưu người dùng thất bại, không có bản ghi nào được tạo.");
                }

                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        user.setId(rs.getLong(1));
                    }
                }

                user.setCreatedAt(now);
                user.setUpdatedAt(now);
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Không thể lưu người dùng: " + e.getMessage(), e);
        }
    }

    private User mapRowToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getLong("id"));
        user.setUsername(rs.getString("username"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFullName(rs.getString("full_name"));
        user.setEmail(rs.getString("email"));

        String role = rs.getString("role");
        if (role != null) {
            user.setRole(User.Role.valueOf(role));
        }

        String status = rs.getString("status");
        if (status != null) {
            user.setStatus(User.Status.valueOf(status));
        }

        user.setPrimaryWalletAddress(rs.getString("primary_wallet_address"));

        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            user.setCreatedAt(createdAt.toLocalDateTime());
        }

        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            user.setUpdatedAt(updatedAt.toLocalDateTime());
        }

        long createdBy = rs.getLong("created_by");
        if (!rs.wasNull()) {
            user.setCreatedBy(createdBy);
        }

        long updatedBy = rs.getLong("updated_by");
        if (!rs.wasNull()) {
            user.setUpdatedBy(updatedBy);
        }

        return user;
    }
}
