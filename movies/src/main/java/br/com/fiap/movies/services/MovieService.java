package br.com.fiap.movies.services;

import br.com.fiap.movies.models.Movie;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class MovieService {

    private final List<Movie> repository = new ArrayList<>();

    public List<Movie> getMovies(){
        return repository;
    }

    public Movie addMovie(Movie movie){
        repository.add(movie);
        return movie;
    }

}
