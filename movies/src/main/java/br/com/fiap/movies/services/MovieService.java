package br.com.fiap.movies.services;

import br.com.fiap.movies.models.Movie;
import br.com.fiap.movies.repositories.MovieRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;

@Service
public class MovieService {

    @Autowired
    private MovieRepository repository;

    public List<Movie> getMovies(){
        return repository.findAll();
    }

    public Movie addMovie(Movie movie){
        return repository.save(movie);
    }

    public Optional<Movie> getMovieById(Long id) {
       return repository.findById(id);
    }

    public void deleteMovie(Long id) {
        var optionalMovie = getMovieById(id);
        if(optionalMovie.isEmpty()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Filme não encontrado");
        }

       repository.deleteById(id);
    }

    public Movie updateMovie(Long id, Movie newMovie) {
        var optionalMovie = getMovieById(id);
        if(optionalMovie.isEmpty()){
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Filme não encontrado");
        }
        //BeanUtils.copyProperties(newMovie, movie, "id");
        newMovie.setId(id);
        return repository.save(newMovie);
    }
}
