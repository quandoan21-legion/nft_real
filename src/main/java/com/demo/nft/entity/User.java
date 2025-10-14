package com.demo.nft.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class User {
    private Long id;
    private String username;
    private String passwordHash;
    private String fullName;
    private String email;
    private Role role = Role.VIEWER;
    private Status status = Status.ACTIVE;
    private String primaryWalletAddress;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    private Long createdBy;
    private Long updatedBy;

    public enum Role {
        ADMIN, ARTIST, VIEWER
    }

    public enum Status {
        ACTIVE, INACTIVE
    }
}
