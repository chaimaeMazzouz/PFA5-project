package com.pfa.servicedemandes.controller;

import com.pfa.servicedemandes.model.Demande;
import com.pfa.servicedemandes.repository.AdminRepository;
import com.pfa.servicedemandes.service.FirebaseAuthService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/admins")
@RequiredArgsConstructor
public class AdminController {
    private final AdminRepository adminRepository;
    private final FirebaseAuthService firebaseAuthService;
    @GetMapping
    public ResponseEntity<Boolean> isAdmin(HttpServletRequest request) {
        String userId = firebaseAuthService.getUidFromRequest(request);
        return ResponseEntity.ok(adminRepository.findByUserId(userId).isPresent());
    }
}
