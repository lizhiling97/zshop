package com.ssm.zshop.comm.exception;

public class CustomerNotException extends Exception {

    public CustomerNotException() {
        super();
    }

    public CustomerNotException(String message) {
        super(message);
    }

    public CustomerNotException(String message, Throwable cause) {
        super(message, cause);
    }

    public CustomerNotException(Throwable cause) {
        super(cause);
    }
}
