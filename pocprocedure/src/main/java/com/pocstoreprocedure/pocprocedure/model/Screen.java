package com.pocstoreprocedure.pocprocedure.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "SCREENS")
@Getter
@Setter
public class Screen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="screen_id")
    private Integer screenId;

    @Column(name="screen_name")
    private String screenName;

    @Column(name="screen_code")
    private Integer screenCode;
    
}
