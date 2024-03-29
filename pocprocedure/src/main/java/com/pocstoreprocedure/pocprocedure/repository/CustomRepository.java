package com.pocstoreprocedure.pocprocedure.repository;
import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.pocstoreprocedure.pocprocedure.model.PackageC;

@Repository
public interface CustomRepository extends JpaRepository<PackageC,Integer>{
    
    @Procedure("create_workshop_data")
    void createWorkshopData(@Param("p_workshop_id") int workshopId, 
    @Param("p_country_code") int countryCode, 
    @Param("p_currency_parameter") BigDecimal currencyParameter);

    
}
