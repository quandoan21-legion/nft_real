package com.demo.nft.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
public class Nft {

    private Long id;
    private String code;
    private String name;
    private String description;
    private String thumbnailUrl;

    private BigDecimal price;
    private String currency;

    private Long creatorId;
    private Long ownerId;
    private Long categoryId;

    private Status status = Status.ON_SALE;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Long createdBy;
    private Long updatedBy;

    public enum Status {
        ON_SALE,
        SOLD,
        NOT_FOR_SALE
    }
}
