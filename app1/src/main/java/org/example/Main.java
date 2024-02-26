package org.example;

import io.javalin.Javalin;

public class Main {
    public static void main(String[] args) {
        Javalin app = Javalin.create().start(7000);
        app.get("/", ctx -> {
            ctx.html("<h1>Sitio aplicacion 1</h1>");
        });
    }
}