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
@Table(name = "PACKAGES")
@Getter
@Setter
public class PackageC {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="package_id")
    private Integer packageId;

    @Column(name="package_name")
    private String packageName;

    @Column(name="package_price")
    private Double packagePrice;

    @Column(name="service_type_id")
    private Integer packageServiceTypeId;
    
    @Column(name="workshop_id")
    private Integer packageWorkshopId;

    @Column(name="package_active")
    private Integer packageIsActive;

    @Column(name="created_at")
    private String packageCreateDate;

    @Column(name="update_at")
    private String packageUpdateDate;



    
}
