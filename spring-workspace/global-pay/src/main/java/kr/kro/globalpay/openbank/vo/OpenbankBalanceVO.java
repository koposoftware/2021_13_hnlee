package kr.kro.globalpay.openbank.vo;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
@Alias("openbankBalanceVO")
public class OpenbankBalanceVO {
	private String id;
	
	@JsonProperty(value = "api_tran_id")
	private String apiTranId;
	
	@JsonProperty(value = "api_tran_dtm")
	private String apiTranDtm;
	
	@JsonProperty(value = "rsp_code")
	private String rspCode;
	
	@JsonProperty(value = "rsp_message")
	private String rspMessage;
	
	@JsonProperty(value = "bank_tran_id")
	private String bankTranId;
	
	@JsonProperty(value = "bank_tran_date")
	private String bankTranDate;
	
	@JsonProperty(value = "bank_code_tran")
	private String bankCodeTran;
	
	@JsonProperty(value = "bank_rsp_code")
	private String bankRspCode;
	
	@JsonProperty(value = "bank_rsp_message")
	private String bankRspMessage;
	
	@JsonProperty(value = "bank_name")
	private String bankName;
	
	@JsonProperty(value = "savings_bank_name")
	private String savingsBankName;
	
	@JsonProperty(value = "fintech_use_num")
	private String fintechUseNum;
	
	@JsonProperty(value = "balance_amt")
	private String balanceAmt;
	
	@JsonProperty(value = "available_amt")
	private String availableAmt;
	
	@JsonProperty(value = "account_type")
	private String accountType;
	
	@JsonProperty(value = "product_name")
	private String productName;
	
	@JsonProperty(value = "account_issue_date")
	private String accountIssueDate;
	
	@JsonProperty(value = "maturity_date")
	private String maturityDate;
	
	@JsonProperty(value = "last_tran_date")
	private String lastTranDate;
	
	// 추가 
	private OpenbankAcntVO openbankAcntVO;
}
