package com.example.demo;

import org.springframework.http.HttpStatus;

public class ResponseWrapper<T> {
    private HttpStatus isSuccess;
    private T data;

    public ResponseWrapper(HttpStatus isSuccess, T data) {
        this.isSuccess = isSuccess;
        this.data = data;
    }

    public HttpStatus isSuccess() {
        return isSuccess;
    }

    public void setSuccess(HttpStatus success) {
        isSuccess = success;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
