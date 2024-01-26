package com.pocstoreprocedure.pocprocedure.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.pocstoreprocedure.pocprocedure.model.PackageC;

@Repository
public interface CustomRepository extends JpaRepository<PackageC,Integer>{
    
    @Procedure("insert_dummy_data")
    void insertRegisters(@Param("workshop_id") int workshopId);

    @Procedure("insert_dummy_data")
    void insertRegistersNoParam();
    
}
