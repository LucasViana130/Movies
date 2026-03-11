package br.com.fiap.movies.models;

import lombok.*;

import java.time.LocalDate;
import java.util.Objects;

@Data
@AllArgsConstructor
public class Movie {
    private Long id;
    private String title;
    private String synopsis;
    private Integer rating;
    private LocalDate releaseDate;

}
