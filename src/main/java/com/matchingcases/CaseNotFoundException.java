package com.matchingcases;

/**
 * 自訂異常類別：案件未找到異常
 * 
 * 當在服務層中查找某個案件但該案件不存在時，拋出此異常
 */
public class CaseNotFoundException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	// 构造器: 傳入錯誤訊息
	public CaseNotFoundException(String message) {
		super(message);
	}

	// 可選的：傳入錯誤訊息和異常對象
	public CaseNotFoundException(String message, Throwable cause) {
		super(message, cause);
	}
}
