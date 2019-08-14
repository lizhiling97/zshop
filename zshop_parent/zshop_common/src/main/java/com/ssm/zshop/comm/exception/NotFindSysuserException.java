package com.ssm.zshop.comm.exception;

public class NotFindSysuserException extends Exception {

    public NotFindSysuserException() {
        super();
    }

    public NotFindSysuserException(String message) {
        super(message);
    }

    public NotFindSysuserException(String message, Throwable cause) {
        super(message, cause);
    }

    public NotFindSysuserException(Throwable cause) {
        super(cause);
    }
}
