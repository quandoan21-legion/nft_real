package com.demo.nft.repository;

import com.demo.nft.entity.User;

import java.util.Optional;

public interface UserRepository {
    Optional<User> findByUsername(String username);

    Optional<User> findByEmail(String email);

    Optional<User> findById(Long id);

    User save(User user);
}
