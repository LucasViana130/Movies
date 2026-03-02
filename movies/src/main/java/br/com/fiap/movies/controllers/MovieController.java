package br.com.fiap.movies.controllers;

import br.com.fiap.movies.models.Movie;
import br.com.fiap.movies.services.MovieService;
import org.slf4j.ILoggerFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
public class MovieController {

    private final Logger log = LoggerFactory.getLogger(getClass());

    @Autowired
    private MovieService service;

    @GetMapping("/")
    public String healthCheck(){
        return "Server UP";
    }

    @GetMapping("/movies")
    public List<Movie> getMovies(){
        log.info("Listando todos os filmes");
        return service.getMovies();
    }

    @PostMapping("/movies")
    @ResponseStatus(code = HttpStatus.CREATED)
    public Movie addMovie(@RequestBody Movie movie){
        log.info("Cadastrando novo filme...");
        return service.addMovie(movie);
    }

}
