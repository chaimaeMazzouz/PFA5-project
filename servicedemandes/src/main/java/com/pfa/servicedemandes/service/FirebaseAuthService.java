package com.pfa.servicedemandes.service;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Service;

@Service
public class FirebaseAuthService {

    public String getUidFromRequest(HttpServletRequest request) {
        String idToken = extractToken(request);
        if (idToken != null) {
            return getUidFromToken(idToken);
        }
        return null; // Or handle this scenario appropriately
    }
    public String getEmailFromRequest(HttpServletRequest request) {
        String email = getEmailFromToken(extractToken(request));
        if (email != null) {
            return email;
        }
        return null; // Or handle this scenario appropriately
    }

    public String getUidFromToken(String idToken) {
        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
            return decodedToken.getUid();
        } catch (FirebaseAuthException e) {
            e.printStackTrace();
            return null; // Handle exception appropriately
        }
    }
    public String getEmailFromToken(String idToken) {
        try {
            FirebaseToken decodedToken = FirebaseAuth.getInstance().verifyIdToken(idToken);
            return decodedToken.getEmail();
        } catch (FirebaseAuthException e) {
            e.printStackTrace();
            return null; // Handle exception appropriately
        }
    }

    private String extractToken(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            return authHeader.substring(7);
        }
        return null;
    }
}
