package com.pocstoreprocedure.pocprocedure.service;


import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
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

    public void insertRegistersSP(int workshopId, int countryCode, BigDecimal currencyParameter) {

        try {
            cR.createWorkshopData(workshopId, countryCode, currencyParameter);
            
        } catch (Exception e) {
            System.out.println("ERROR EN EL SERVICE CORRIENDO INSERT REGISTER:");
            System.out.println(e);
        }
    }


    //_________________________________________________________________________________
    //Sin usar Repository (Cuando no esta ligado a una entidad)
    @PersistenceContext
    private EntityManager entityManager;

    public void insertRegistersSP2(int workshopId, int countryCode, BigDecimal currencyParameter) {
        StoredProcedureQuery query = this.entityManager
            .createStoredProcedureQuery("create_workshop_data")
            .registerStoredProcedureParameter(1, Integer.class, ParameterMode.IN)
            .setParameter(1, workshopId);

            query.registerStoredProcedureParameter(2, Integer.class, ParameterMode.IN)
            .setParameter(2, countryCode);

            query.registerStoredProcedureParameter(3, BigDecimal.class, ParameterMode.IN)
            .setParameter(3, currencyParameter);
        
            query.execute();
    }

}
