package kr.kro.globalpay.currency.vo;

import lombok.Data;

@Data
public class CallbackVO {

	/*
	 "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMDAwMDAwMTA2Iiwic2NvcGUiOlsibG9naW4iLCJpbnF1aXJ5IiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOiIxNTc2OTgxNDkzIiwianRpIjoiN2M5NTVjYzAtM2I4ZS00ZTJkLTg0YWYtZTcyNWI5YzFlNTAwIn0.DONr1R0Ae2fe4qN56VZkEGB364vo951rUToHkDTxvJ8",
	  "token_type": "Bearer",
	  "expires_in": "7776000",
	  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMDAwMDAwMTA2Iiwic2NvcGUiOlsibG9naW4iLCJpbnF1aXJ5IiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOiIxNTc3ODQ1NDkzIiwianRpIjoiMDcyYzhmMDYtMmNkMi00MTE2LTk2ZWMtN2EwNmEyYzE0OWQ2In0._jJcs7roGVkyQ9u3N5XKbz7Ff8n8nzgzGYfKy9hR6rQ",
	  "scope": "login inquiry transfer",
	  "user_seq_no": "1000000106"
	  */
	private String access_token;
	private String token_type;
	private String expires_in;
	private String refresh_token;
	private String scope;
	private String user_seq_no;
	
}
