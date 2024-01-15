package com.pfa.servicedemandes.controller;

import com.pfa.servicedemandes.model.Demande;
import com.pfa.servicedemandes.repository.AdminRepository;
import com.pfa.servicedemandes.service.DemandeService;
import com.pfa.servicedemandes.service.FirebaseAuthService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admins")
@RequiredArgsConstructor
public class AdminController {
    private final AdminRepository adminRepository;
    private final FirebaseAuthService firebaseAuthService;
    private final DemandeService demandeService;
    @GetMapping
    public ResponseEntity<Boolean> isAdmin(HttpServletRequest request) {
        String userId = firebaseAuthService.getUidFromRequest(request);
        return ResponseEntity.ok(adminRepository.findByUserId(userId).isPresent());
    }
    @GetMapping("/all")
    public ResponseEntity<List<Demande>> getAllDemandesForAllUsers() {
        List<Demande> demandes = demandeService.getAllDemandesForAllUsers();
        return ResponseEntity.ok(demandes);
    }
    @PutMapping("/{id}")
    public ResponseEntity<Demande> updateDemande(@PathVariable int id, @RequestBody Demande newDemande) {
        Demande oldDemande=demandeService.findById(id);
        oldDemande.setEtat(newDemande.getEtat());
        Demande updatedDemande = demandeService.updateDemande(oldDemande);
        //TODO : notify user
        // call notification service
        return ResponseEntity.ok(updatedDemande);
    }
}
