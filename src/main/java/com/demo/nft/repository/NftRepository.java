package com.demo.nft.repository;
import com.demo.nft.entity.Nft;

import java.util.List;

public interface NftRepository {
    Nft save(Nft nft);
    Nft update(int id, Nft nft);
    boolean deleteById(int id);
    Nft findById(int id);
    Nft findByUsername(String username);
    List<Nft> findAll();

}
