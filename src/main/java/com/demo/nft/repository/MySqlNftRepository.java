package com.demo.nft.repository;

import com.demo.nft.entity.Nft;
import com.demo.nft.helper.MySqlHelper;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.demo.nft.helper.MySqlHelper.getConnection;

public class MySqlNftRepository implements NftRepository {
    private static MySqlHelper mySqlHelper = new MySqlHelper();

    @Override
    public Nft save(Nft nft) {
        return null;
    }

    @Override
    public Nft update(int id, Nft nft) {
        return null;
    }

    @Override
    public boolean deleteById(int id) {
        return false;
    }

    @Override
    public Nft findById(int id) {
        return null;
    }

    @Override
    public Nft findByUsername(String username) {
        return null;
    }

    @Override
    public List<Nft> findAll() {
        List<Nft> list = new ArrayList<>();
        String sql = "SELECT id, code, name, description, thumbnail_url, price, currency, creator_id, owner_id, category_id, status, created_at, updated_at FROM nfts";

        try {
            Connection conn = MySqlHelper.getConnection();
            if (conn == null) {
                throw new SQLException("Không thể kết nối đến database.");
            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Nft nft = new Nft();
                nft.setCode(rs.getString("code"));
                nft.setName(rs.getString("name"));
                nft.setDescription(rs.getString("description"));
                nft.setThumbnailUrl(rs.getString("thumbnail_url"));
                nft.setPrice(rs.getFloat("price"));
                nft.setCurrency(rs.getString("currency"));
                nft.setCreatorId(rs.getLong("creator_id"));
                nft.setOwnerId(rs.getLong("owner_id"));
                nft.setCategoryId(rs.getLong("category_id"));
//                nft.setStatus(rs.get("status"));
                list.add(nft);
            }


            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}
