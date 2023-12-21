package com.pfa.servicedemandes.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Utilisateur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String nom;
    private String prenom;
    @Column(unique = true)
    private String email;
    private String tel;
    @Column(unique = true)
    private String password;
    @ManyToOne
    private Role role;
}
