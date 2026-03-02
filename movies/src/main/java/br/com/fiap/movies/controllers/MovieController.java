package br.com.fiap.movies.controllers;

import org.slf4j.ILoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MovieController {

    private final Logger log = LoggerFactory.getLogger(getClass());

    @GetMapping("/")
    public String healthCheck(){
        return "Server UP";
    }

    @GetMapping("/movies")
    public Movie getMovies(){
        log.info("Listando todos os filmes");
        return null;//mocky
    }

}
