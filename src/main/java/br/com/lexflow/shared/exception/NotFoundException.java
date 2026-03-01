package br.com.lexflow.shared.exception;

import org.springframework.http.HttpStatus;

public class NotFoundException extends BusinessException {

    public NotFoundException(String resource, Object id) {
        super(resource + " não encontrado: " + id,
              HttpStatus.NOT_FOUND,
              "NOT_FOUND");
    }

    public NotFoundException(String message) {
        super(message, HttpStatus.NOT_FOUND, "NOT_FOUND");
    }
}
