package com.pocstoreprocedure.pocprocedure.controller;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pocstoreprocedure.pocprocedure.service.CustomService;

@RestController
@RequestMapping("/api")
public class AppController {

    @Autowired
    CustomService customService;

    @PostMapping("/insertData")
    public ResponseEntity<String> insertSP(@RequestParam int workshopId, 
    @RequestParam int countryCode, 
    @RequestParam BigDecimal currencyParameter) {
        customService.insertRegistersSP(workshopId, countryCode, currencyParameter);
       
        return ResponseEntity.ok("SP llamado exitosamente"); 
    }

    //______________________________________________________________

    // @PostMapping("/insertSPNoParamOnlyService")
    // public ResponseEntity<String> insertSPNoParamOnlyService() {
    //     customService.insertRegistersSP2();
    //     return ResponseEntity.ok("SP llamado exitosamente");
    // }




    
    
    @GetMapping("/test")
    public ResponseEntity<String> testEndpoint() {
        return ResponseEntity.ok("El endpoint de prueba funciona correctamente");
    }
    
}
