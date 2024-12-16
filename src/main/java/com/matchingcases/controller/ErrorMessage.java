package com.matchingcases.controller;


public enum ErrorMessage {
    ERROR_CASE_ID_MISSING("請輸入案件編號"),
    ERROR_CASE_ID_FORMAT("案件編號格式錯誤，請輸入有效的數字"),
    ERROR_CASE_ID_RANGE("案件編號超出範圍，請輸入 1 至 " + Integer.MAX_VALUE + " 之間的數字"),
    ERROR_CASE_NOT_FOUND("找不到該案件，請檢查案件編號是否正確"),
    ERROR_SYSTEM_BUSY("系統忙碌中，請稍後再試"),
    ERROR_ILLEGAL_REQUEST("非法請求，請勿重複提交表單");

    private final String message;

    ErrorMessage(String message) {
        this.message = message;
    }

    public String getMessage() {
        return message;
    }
}

