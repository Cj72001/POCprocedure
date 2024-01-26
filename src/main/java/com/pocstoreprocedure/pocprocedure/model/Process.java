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
@Table(name = "PROCESS")
@Getter
@Setter
public class Process {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="process_id")
    private Integer processId;

    @Column(name="process_name")
    private String processName;

    @Column(name="process_estimated_time")
    private Integer processEstimatedTime;

    @Column(name="process_price")
    private Double processPrice;
    
    @Column(name="workshop_id")
    private Integer packageWorkshopId;

    @Column(name="process_active")
    private Integer processIsActive;

    @Column(name="created_at")
    private String processCreateDate;

    @Column(name="update_at")
    private String processUpdateDate;



    
}
