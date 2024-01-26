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
@Table(name = "SCREEN_ROLES")
@Getter
@Setter
public class ScreenRole {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="screen_rol_id")
    private Integer screenRolId;

    @Column(name="screen_id")
    private Integer screenId;

    @Column(name="rol_id")
    private Integer rolId;

    @Column(name="can_read")
    private Integer rolCanRead;

    @Column(name="can_write")
    private Integer rolCanWrite;

    @Column(name="can_edit")
    private Integer rolCanEdit;

    @Column(name="can_delete")
    private Integer rolCanDelete;

    @Column(name="workshop_id")
    private Integer workshopId;
    
}
