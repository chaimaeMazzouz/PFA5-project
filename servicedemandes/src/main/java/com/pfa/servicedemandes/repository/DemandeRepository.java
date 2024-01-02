package com.pfa.servicedemandes.repository;

import com.pfa.servicedemandes.model.Demande;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DemandeRepository extends JpaRepository<Demande, Integer> {
    List<Demande> findAllByUserId(String userId);
}
