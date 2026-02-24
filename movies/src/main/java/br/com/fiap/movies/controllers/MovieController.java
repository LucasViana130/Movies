package br.com.fiap.movies.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MovieController {

    @RequestMapping(path = "/")
    public String healthCheck(){
        return "Server UP";
    }

}
