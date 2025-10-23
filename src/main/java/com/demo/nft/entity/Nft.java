package com.demo.nft.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class Nft {

    public static final int STATUS_NOT_FOR_SALE = 0;
    public static final int STATUS_ON_SALE = 1;

    private Long id;
    private String code;
    private String name;
    private String description;
    private String thumbnailUrl;

    private Float price;
    private String currency;

    private Long creatorId;
    private Long ownerId;
    private Long categoryId;

    private int status = STATUS_ON_SALE;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long createdBy;
    private Long updatedBy;
}
