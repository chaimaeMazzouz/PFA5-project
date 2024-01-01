package com.pfa.servicedemandes.controller;

import com.pfa.servicedemandes.model.Demande;
import com.pfa.servicedemandes.service.DemandeService;
import com.pfa.servicedemandes.service.FirebaseAuthService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/demandes")
@RequiredArgsConstructor
public class DemandeController {

    private final DemandeService demandeService;
    private final FirebaseAuthService firebaseAuthService;
    @GetMapping
    public ResponseEntity<List<Demande>> getAllDemandes(HttpServletRequest request) {
        String userId = firebaseAuthService.getUidFromRequest(request);
        List<Demande> demandes = demandeService.getAllDemandes(userId);
        return ResponseEntity.ok(demandes);
    }

    @PostMapping
    public ResponseEntity<Demande> createDemande(@RequestBody Demande demande, HttpServletRequest request) {
        String userId = firebaseAuthService.getUidFromRequest(request);
        demande.setUserId(userId);
        Demande createdDemande = demandeService.createDemande(demande);
        return ResponseEntity.ok(createdDemande);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Demande> updateDemande(@PathVariable int id, @RequestBody Demande demande) {
        demande.setId(id);
        Demande updatedDemande = demandeService.updateDemande(demande);
        return ResponseEntity.ok(updatedDemande);
    }


    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDemande(@PathVariable int id, HttpServletRequest request) {
        String userId = firebaseAuthService.getUidFromRequest(request);
        demandeService.deleteDemande(id, userId);
        return ResponseEntity.ok().build();
    }
}