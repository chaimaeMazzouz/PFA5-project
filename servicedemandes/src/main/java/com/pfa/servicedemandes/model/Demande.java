package com.pfa.servicedemandes.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@AllArgsConstructor
@Data
@NoArgsConstructor
public class Demande {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String sujet;
    private String description;
    private Date dateCreation;
    @Enumerated(EnumType.STRING)
    private Etat etat;
    private String userId;
}
