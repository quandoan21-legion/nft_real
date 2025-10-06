package com.demo.nft.entity;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class User {
    private int id;
    private String username;
    private String fullname;
    private String email;
    private String passwordHash;
    private String primaryWalletAddress;
}
