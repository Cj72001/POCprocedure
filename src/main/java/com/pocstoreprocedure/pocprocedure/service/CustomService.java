package com.pocstoreprocedure.pocprocedure.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pocstoreprocedure.pocprocedure.repository.CustomRepository;

import jakarta.persistence.EntityManager;
import jakarta.persistence.ParameterMode;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.StoredProcedureQuery;
import jakarta.transaction.Transactional;

@Service
public class CustomService {

    //SP desde repository:
    @Autowired
    private CustomRepository cR;

    @Transactional
    public void insertRegistersSP(int workshopId) {

        try {
            cR.insertRegisters(workshopId);
            
        } catch (Exception e) {
            System.out.println("ERROR EN EL SERVICE CORRIENDO INSERT REGISTER:");
            System.out.println(e);
        }
    }

    @Transactional
    public void insertRegistersSPNoParam() {

        try {
            cR.insertRegistersNoParam();
        } catch (Exception e) {
            System.out.println("ERROR EN EL SERVICE CORRIENDO INSERT REGISTER:");
            System.out.println(e);
        }
        
    }

    //_________________________________________________________________________________
    //Sin usar Repository (Cuando no esta ligado a una entidad)
    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public void callProcedure(int workshopId) {
        StoredProcedureQuery query = this.entityManager
            .createStoredProcedureQuery("insert_dummy_data")
            .registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN)
            .setParameter(1, workshopId);
        
        query.execute();
    }

    @Transactional
    public void callProcedureNoParam() {
        StoredProcedureQuery query = this.entityManager.createStoredProcedureQuery("insert_dummy_data");
        
        query.execute();
    }
}
