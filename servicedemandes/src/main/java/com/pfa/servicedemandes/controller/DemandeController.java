package com.pfa.servicedemandes.controller;

import com.pfa.servicedemandes.model.Demande;
import com.pfa.servicedemandes.repository.DemandeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("api/demandes")
public class DemandeController {
    @Autowired
    private DemandeRepository demandeRepository;

    @GetMapping("find/{id}")
    public Demande findById(@PathVariable(required = true) String id) {
        return demandeRepository.findById(Integer.parseInt(id));
    }

    @GetMapping("findAll")
    public List<Demande> findAll() {
        return demandeRepository.findAll();
    }

    @PostMapping("save")
    public void save(@RequestBody Demande Demande) {
        demandeRepository.save(Demande);
    }

    @PutMapping("put")
    public void patch(@RequestBody Demande Demande) {
        demandeRepository.save(Demande);
    }

    @DeleteMapping("delete/{id}")
    public void delete(@PathVariable(required = true) String id) {
        Demande demande = demandeRepository.findById(Integer.parseInt(id));
        demandeRepository.delete(demande);
    }

    @DeleteMapping("deleteAll")
    public void deleteAll() {
        demandeRepository.deleteAll();
    }

    @GetMapping("count")
    public long count() {
        return demandeRepository.count();
    }
}
