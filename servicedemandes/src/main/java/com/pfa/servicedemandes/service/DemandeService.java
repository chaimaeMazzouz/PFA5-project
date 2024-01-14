package com.pfa.servicedemandes.service;

import com.pfa.servicedemandes.model.Demande;
import com.pfa.servicedemandes.repository.DemandeRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DemandeService {

    private final DemandeRepository demandeRepository;

    public List<Demande> getAllDemandes(String userId) {
        return demandeRepository.findAllByUserId(userId);
    }
    public List<Demande> getAllDemandesForAllUsers() {
        return demandeRepository.findAll();
    }

    public Demande createDemande(Demande demande) {
        return demandeRepository.save(demande);
    }

    @Transactional
    public Demande updateDemande(Demande demande) {
        Demande existingDemande = demandeRepository.findById(demande.getId())
                .orElseThrow(() -> new IllegalArgumentException("Demande not found with id: " + demande.getId()));

        existingDemande.setSujet(demande.getSujet());
        existingDemande.setDescription(demande.getDescription());
        existingDemande.setDateCreation(demande.getDateCreation());
        existingDemande.setEtat(demande.getEtat());
        existingDemande.setUserId(demande.getUserId());

        return existingDemande;
    }

    public void deleteDemande(int id, String userId) {
        Demande demande = demandeRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Demande not found with id: " + id));

        if (!demande.getUserId().equals(userId)) {
            throw new IllegalStateException("Unauthorized to delete this demande");
        }

        demandeRepository.deleteById(id);
    }
}