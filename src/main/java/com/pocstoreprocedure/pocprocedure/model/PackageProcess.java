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
@Table(name = "PACKAGE_PROCESS")
@Getter
@Setter
public class PackageProcess {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="package_process_id")
    private Integer packageProcessId;

   @Column(name="packageId")
    private Integer packageId;

    @Column(name="process_id")
    private Integer processId;

    @Column(name="process_sequence")
    private Integer processSequence;

    
}
