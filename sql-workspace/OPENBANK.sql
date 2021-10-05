DROP TABLE openbank_auth;
CREATE TABLE openbank_auth
(
    id    VARCHAR2(100) NOT NULL,
    access_token    VARCHAR2(500) NOT NULL,
    refresh_token    VARCHAR2(500) NOT NULL,
    user_seq_no    VARCHAR2(100) NOT NULL,
    expires_in    NUMBER(38) NOT NULL,
    token_type    VARCHAR2(100) NOT NULL,
    scope    VARCHAR2(100) NOT NULL,
    reg_date    DATE DEFAULT sysdate NOT NULL,
    CONSTRAINT openbank_auth_pk PRIMARY key(user_seq_no) 
);
select * from openbank_auth where id ='hanny';
commit;

DROP TABLE openbank_acnt;
CREATE TABLE openbank_acnt
(
    fintech_use_num    VARCHAR2(500) NOT NULL,
    account_alias    VARCHAR2(500),
    bank_code_std    VARCHAR2(500),
    bank_code_sub    VARCHAR2(500),
    bank_name    VARCHAR2(500),
    account_num    VARCHAR2(500),
    account_num_masked    VARCHAR2(500),
    account_holder_name    VARCHAR2(500),
    account_holder_type    VARCHAR2(500),
    acount_type    VARCHAR2(500),
    inquiry_agree_yn    VARCHAR2(500),
    inquiry_agree_dtime    VARCHAR2(500),
    id    VARCHAR2(100),
    CONSTRAINT openbank_acnt_pk PRIMARY key(fintech_use_num)
);

DROP TABLE openbank_balance;
CREATE TABLE openbank_balance
(
    api_tran_id    VARCHAR2(500) NOT NULL,
    api_tran_dtm    VARCHAR2(500),
    rsp_code    VARCHAR2(500),
    rsp_message    VARCHAR2(500),
    bank_tran_id    VARCHAR2(500),
    bank_tran_date    VARCHAR2(500),
    bank_code_tran    VARCHAR2(500),
    bank_rsp_code    VARCHAR2(500),
    bank_rsp_message    VARCHAR2(500),
    bank_name    VARCHAR2(500),
    savings_bank_name    VARCHAR2(500),
    fintech_use_num    VARCHAR2(500) NOT NULL,
    balance_amt    NUMBER(38),
    available_amt    NUMBER(38),
    account_type    VARCHAR2(500),
    product_name    VARCHAR2(500),
    account_issue_date    VARCHAR2(500),
    maturity_date    VARCHAR2(500),
    last_tran_date    VARCHAR2(500),
    CONSTRAINT openbank_balance_pk PRIMARY key(api_tran_id)
);

delete from openbank_auth;
commit;
select * from openbank_auth;
select * from openbank_acnt;
select * from openbank_balance;
select count(*) from openbank_auth where id = 'newcardtest' and access_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiIxMTAwOTk3ODkzIiwic2NvcGUiOlsiaW5xdWlyeSIsImxvZ2luIiwidHJhbnNmZXIiXSwiaXNzIjoiaHR0cHM6Ly93d3cub3BlbmJhbmtpbmcub3Iua3IiLCJleHAiOjE2NDEwMDY4ODksImp0aSI6IjVmNmQxMjgzLWNiYmEtNDY2Yi1iZDY5LWEyNzAyMTQ0YTkxOSJ9.JFo5NTxvSLAEqUGSGveElyX96WATmireFxU0DqEEPt4';


<update id="mergeACNT" parameterType="java.util.List">
    BEGIN
    <foreach collection="list" item="item" separator=" ">
    MERGE INTO openbank_acnt    
        --비교대상 [TABLE/VIEW], DUAL은 위와 동일 할때 사용(쿼리 대상 [TABLE/VIEW]) 
        USING fintech_use_num ON
        (
            -- 조건에 사용한 COLUMN은 UPDATE 불가
            fintech_use_num = #{item.fintechUseNum}	
        ) 
        -- 조건 불일치 시 INSERT
        WHEN NOT MATCHED THEN    
            INSERT INTO openbank_acnt( 
                id
                fintech_use_num,
                account_alias,
                bank_code_std,
                bank_code_sub,
                bank_name,
                account_num,
                account_num_masked,
                account_holder_name,
                account_holder_type,
                acount_type,
                inquiry_agree_yn,
                inquiry_agree_dtime
            ) VALUES(
                #{item.id}
                , #{item.fintechUseNum}
                , #{item.accountAlias}
                , #{item.bankCodeStd}
                , #{item.bankCodeSub}
                , #{item.bankName}
                , #{item.accountNum}
                , #{item.accountNumMasked}
                , #{item.item.accountHolderName}
                , #{item.accountHolderType}
                , #{item.acountType}
                , #{item.inquiryAgreeYn}
                , #{item.inquiryAgreeDtime}
            )
    </foreach>
    END;
</update>
















-- openbank 계좌 테이블
DROP TABLE openbank_account;
create table openbank_account(
    no    NUMBER(38) NOT NULL,
    account_num    varchar2(500) NOT NULL,
    password    varchar2(500) NOT NULL,
    fin_number    varchar2(255) NOT NULL,
    balance    NUMBER(38) NOT NULL,
    alias    varchar2(50) NOT NULL,
    opening_date    DATE NOT NULL,
    account_type    varchar2(255) NOT NULL,
    account_bank    varchar2(255) NOT NULL,
    card_no    VARCHAR2(30) NOT NULL,
    CONSTRAINT openbank_account_no_pk PRIMARY key(no) 
);

-- openbank 계좌 테이블 시퀀스 
DROP SEQUENCE openbank_account_seq;
CREATE SEQUENCE openbank_account_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

-- openbank_account 더미 데이터 삽입
INSERT INTO openbank_account(
    no
	, account_num
	, password
	, fin_number
	, balance
    , alias
    , opening_date
    , account_type
    , account_bank
    , card_no
)
VALUES(
    openbank_account_seq.nextval
	, '88888-88888'
	,'1993'
	,'q123456789'
	, 10000
    , '해니계좌'
    , sysdate - 57
    ,'입출금 계좌'
    ,'하나은행'
    , '1235'
);


INSERT INTO openbank_account(
    no
	, account_num
	, password
	, fin_number
	, balance
    , alias
    , opening_date
    , account_type
    , account_bank
    , card_no
)
VALUES(
    openbank_account_seq.nextval
	, '12121-12-1211212'
	,'1993'
	,'q123456789'
	, 50000000
    , '급여 들어오는 계좌'
    , sysdate - 148
    ,'적금 통장'
    ,'카카오'
    , '1235'
);

INSERT INTO openbank_account(
    no
	, account_num
	, password
	, fin_number
	, balance
    , alias
    , opening_date
    , account_type
    , account_bank
    , card_no
)
VALUES(
    openbank_account_seq.nextval
	, '9090909-999999'
	,'1993'
	,'q9876'
	, 5000
    , '급여 들어오는 계좌'
    , sysdate - 148
    ,'적금 통장'
    ,'카카오'
    , '4158-7805-8236-1368'
);

-- 4123-3528-5210-2497
INSERT INTO openbank_account(
    no
	, account_num
	, password
	, fin_number
	, balance
    , alias
    , opening_date
    , account_type
    , account_bank
    , card_no
)
VALUES(
    openbank_account_seq.nextval
	, '66555-6555555'
	,'1993'
	,'q9876'
	, 5000
    , '자유 입출금 계좌'
    , sysdate - 148
    ,'적금 통장'
    ,'카카오'
    , '4123-3528-5210-2497'
);

commit;

-- 오픈뱅킹 계좌 조회
select * from openbank_account where account_num = '66555-6555555';
