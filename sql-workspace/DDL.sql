-- DDL(CREATE, ALTER, DROP, RENAME, TRUNCATE)

-- [환율] 국가 코드
DROP TABLE nation_code;
CREATE TABLE nation_code
(
    currency_en    VARCHAR2(20) NOT NULL,
    currency_kr    VARCHAR2(50) NOT NULL,
    nation_kr    VARCHAR2(100) NOT NULL,
    nation_en    VARCHAR2(100) NOT NULL,
    nation_en_initial    VARCHAR2(20),
    currency_code VARCHAR2(100),
    CONSTRAINT nation_code_pk PRIMARY key(currency_en)
);

select * from nation_code;

-- [회원] 테이블
DROP TABLE MEMBER;
CREATE TABLE member
(
    id              VARCHAR2(100) NOT NULL,
    password        VARCHAR2(500) NOT NULL,
    name            VARCHAR2(100) NOT NULL,
    email           VARCHAR2(200) NOT NULL UNIQUE,
    phone           VARCHAR2(50) NOT NULL UNIQUE,
    type            VARCHAR2(50) NOT NULL,
    authority       VARCHAR2(100) DEFAULT 'ROLE_USER',
    reg_date        DATE DEFAULT SYSDATE,
    CONSTRAINT member_id_pk PRIMARY key(id)   
);

-- [환율] 환율 테이블 (bak_기존)
DROP TABLE exchange_rate;
CREATE TABLE exchange_rate
(
    no    NUMBER(38) NOT NULL,
    nation_kr    VARCHAR2(30) NOT NULL,
    currency_en    VARCHAR2(30) NOT NULL,
    reg_date    DATE DEFAULT SYSDATE,
    cash_buy_rate    NUMBER(10,2) NOT NULL,
    cash_buy_spread    NUMBER(10,2) NOT NULL,
    cash_sell_rate    NUMBER(10,2) NOT NULL,
    cash_sell_spread    NUMBER(10,2) NOT NULL,
    transfer_send_rate    NUMBER(10,2) NOT NULL,
    transfer_receive_rate    NUMBER(10,2) NOT NULL,
    buy_basic_rate    NUMBER(10,2) NOT NULL,
    transfer_commission    NUMBER(10,2) NOT NULL,
    usd_change_rate    NUMBER(10,2) NOT NULL,
    tc_buy_rate    NUMBER(10,2) NOT NULL,
    foreign_check_sell_rate    NUMBER(10,2) NOT NULL,
    CONSTRAINT exchange_rate_pk PRIMARY key(no) 
);


-- [환율] 시퀀스
DROP SEQUENCE exchange_rate_seq;
CREATE SEQUENCE exchange_rate_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
    
/*--------------------------------------환율 2차 크롤링------------------------------------------*/
DROP TABLE exchange_rate2;
CREATE TABLE exchange_rate2
(
    no    NUMBER(38) NOT NULL,
    --nation_kr    VARCHAR2(30) NOT NULL,
    currency_en    VARCHAR2(30) NOT NULL,
    reg_date    DATE DEFAULT SYSDATE NOT NULL,
    transfer_send_rate    NUMBER(10,2) NOT NULL,
    transfer_receive_rate    NUMBER(10,2) NOT NULL,
    buy_basic_rate    NUMBER(10,2) NOT NULL,
    usd_change_rate    NUMBER(10,2) NOT NULL
);
    
DROP SEQUENCE exchange_rate_seq2;
CREATE SEQUENCE exchange_rate_seq2 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
    
    
INSERT INTO exchange_rate2(
    no
    ,currency_en
    ,reg_date
    ,transfer_send_rate
    ,transfer_receive_rate
    ,buy_basic_rate
    ,usd_change_rate
)VALUES(
    exchange_rate_seq2.nextval
    ,'USD'
    --,(SELECT TO_DATE('2020090108:23:08','YYYY-MM-DD HH24:MI:SS') FROM DUAL)
    ,TO_DATE('2020090108:23:08','YYYY-MM-DD HH24:MI:SS')
    ,0
    ,0
    ,0
    ,0
);

select * from exchange_rate2 order by no desc;

select to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') from exchange_rate2;

--YYYYMMDDHH24MISS
SELECT TO_DATE('20200901130202', 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

SELECT TO_CHAR(TO_DATE('2020090113:02:02', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

/*---------------------------------------------------------------------------------------------------------------*/

-- [카드] 카드 정보 테이블
DROP TABLE card;
CREATE TABLE card
(
    card_no    VARCHAR2(30) NOT NULL,  
    cvc    VARCHAR2(500) NOT NULL, -- 암호화
    expire_date    DATE DEFAULT SYSDATE + (INTERVAL '5' YEAR),
    family_name    VARCHAR2(255) NOT NULL,
    given_name    VARCHAR2(255) NOT NULL,
    member_id    VARCHAR2(255) NOT NULL,
    password    VARCHAR2(500), -- 암호화
    opening_date    DATE DEFAULT sysdate,
    CONSTRAINT card_no_pk PRIMARY KEY ( card_no )
);



-- [카드] 카드 신청내역 테이블
DROP TABLE card_register;
CREATE TABLE card_register
(
    no    NUMBER(38) NOT NULL,
    reg_date    DATE DEFAULT sysdate,
    zip VARCHAR2(15) NOT NULL,
    addr1    VARCHAR2(500) NOT NULL,
    addr2    VARCHAR2(500) NOT NULL,
    status    VARCHAR2(255) DEFAULT 'processing',
    card_no    VARCHAR2(30) NOT NULL,
    applicant_id    VARCHAR2(100) NOT NULL,
    tracking_no    VARCHAR2(500),
    shipment_company    VARCHAR2(255),
    shipping_date    DATE,
    CONSTRAINT card_register_pk PRIMARY key(no)
);



-- [카드] 신청내역 시퀀스
DROP SEQUENCE card_register_seq;
CREATE SEQUENCE card_register_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

-- [카드] 잔액 테이블
DROP TABLE card_balance;
CREATE TABLE card_balance
(
    no    NUMBER(38) NOT NULL,
    card_no    VARCHAR2(30) NOT NULL,
    currency_en    VARCHAR2(30) NOT NULL,
    balance    NUMBER(38) DEFAULT 0 NOT NULL,
    CONSTRAINT card_balance_pk PRIMARY key(no)
);



-- [카드] 잔액 시퀀스
DROP SEQUENCE card_balance_seq;
CREATE SEQUENCE card_balance_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
    
    
-- [외화] 충전내역
DROP TABLE charge_history;
CREATE TABLE charge_history
(
    NO NUMBER(38,0) NOT NULL, 
	ACCOUNT_NUM VARCHAR2(255 BYTE) NOT NULL, 
	ACCOUNT_BANK VARCHAR2(100 BYTE) NOT NULL, 
	REG_DATE DATE DEFAULT sysdate NOT NULL, 
	CURRENCY_EN VARCHAR2(10 BYTE), 
	KR_AMOUNT NUMBER(38,2) NOT NULL, 
	CARD_NO VARCHAR2(30 BYTE) NOT NULL, 
	EXCHANGE_RATE NUMBER(38,2), 
	FE_AMOUNT NUMBER(38,2) NOT NULL, 
	EXCHANGE_CODE NUMBER(38,2) NOT NULL, 
	AFTER_BALANCE NUMBER(38,2) NOT NULL, 
	COMMISSION_KR NUMBER(38,2) NOT NULL, 
	WITHOUT_COMMISSION NUMBER(38,2) NOT NULL, 
    CONSTRAINT charge_history_pk PRIMARY key(no)
);

-- [카드] 카드 충전내역 시퀀스
DROP SEQUENCE charge_history_seq;
CREATE SEQUENCE charge_history_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
    
-- [외화] 환불내역
DROP TABLE refund_history;
CREATE TABLE refund_history
(
    NO NUMBER(38,0) NOT NULL, 
	ACCOUNT_NUM VARCHAR2(255 BYTE) NOT NULL, 
	ACCOUNT_BANK VARCHAR2(100 BYTE) NOT NULL, 
	REG_DATE DATE DEFAULT sysdate NOT NULL, 
	CURRENCY_EN VARCHAR2(10 BYTE), 
	KR_AMOUNT NUMBER(38,2) NOT NULL, 
	CARD_NO VARCHAR2(30 BYTE) NOT NULL, 
	EXCHANGE_RATE NUMBER(38,2), 
	FE_AMOUNT NUMBER(38,2) NOT NULL, 
	EXCHANGE_CODE NUMBER(38,2) NOT NULL, 
	AFTER_BALANCE NUMBER(38,2) NOT NULL, 
	COMMISSION_KR NUMBER(38,2) NOT NULL, 
	WITHOUT_COMMISSION NUMBER(38,2) NOT NULL, 
    CONSTRAINT refund_history_pk PRIMARY key(no)
);

-- [카드] 카드 환불내역 시퀀스
DROP SEQUENCE refund_history_seq;
CREATE SEQUENCE refund_history_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;



-- [카드] 카드 잔액 초기화 프로시저
DROP PROCEDURE CARD_BALANCER_RESET_PROC;
CREATE OR REPLACE PROCEDURE CARD_BALANCER_RESET_PROC
(
    V_CARD_NO card.card_no%TYPE 
)
IS
BEGIN
   -- CARD_BALANCE 초기화
   FOR NATION_REC  IN ( SELECT * FROM NATION_CODE )                    
   LOOP
       insert into card_balance(
            no, card_no, currency_en
        ) values(
            card_balance_seq.nextval
            , V_CARD_NO
            , nation_rec.currency_en
        );
   END LOOP;
END;
/


-- [쇼핑] 상품 테이블
DROP TABLE product;
CREATE TABLE product
(
    no    NUMBER(38) NOT NULL,
    url    VARCHAR2(500) NOT NULL,
    img    VARCHAR2(500),
    brand    VARCHAR2(255),
    name    VARCHAR2(255) NOT NULL,
    price    NUMBER(38) NOT NULL,
    currency    VARCHAR2(20) NOT NULL,
    reg_date    DATE DEFAULT sysdate NOT NULL,
    admin_id    VARCHAR2(100),
    seller_id    VARCHAR2(255) NOT NULL,
    shop_code    VARCHAR2(10) NOT NULL,
    CONSTRAINT product_no_pk PRIMARY key(no)
);

-- [쇼핑] 상품 테이블 시퀀스
DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;
    
    

-- [쇼핑] 상품 판매자
DROP TABLE seller;
CREATE TABLE seller
(
    id    VARCHAR2(255) NOT NULL,
    password    VARCHAR2(500) NOT NULL,
    tel    VARCHAR2(100) NOT NULL,
    email    VARCHAR2(100) NOT NULL,
    name    VARCHAR2(100) NOT NULL,
    team    VARCHAR2(100) NOT NULL,
    code    NUMBER(38) NOT NULL,
    reg_date    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT seller_id_pk PRIMARY key(id)
);

-- [쇼핑] 제휴 쇼핑몰
DROP TABLE partner_shop;
CREATE TABLE partner_shop
(
    code    VARCHAR2(10) NOT NULL,
    site    VARCHAR2(255) NOT NULL,
    name    VARCHAR2(100) NOT NULL,
    reg_date    DATE DEFAULT SYSDATE NOT NULL,
    currency    VARCHAR2(10) NOT NULL,
    nation_kr    VARCHAR2(10) NOT NULL,
    CONSTRAINT partner_shop_pk PRIMARY key(code)
);

-- [쇼핑] 제휴 쇼핑몰 코드 시퀀스
DROP SEQUENCE partner_shop_seq;
CREATE SEQUENCE partner_shop_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;


-- [쇼핑] 찜하기 목록
DROP TABLE favourite_list;
CREATE TABLE favourite_list
(
    no    NUMBER(38) NOT NULL,
    reg_date    DATE DEFAULT sysdate NOT NULL,
    member_id    VARCHAR2(100) NOT NULL,
    product_no    NUMBER(38) NOT NULL,
    CONSTRAINT favourite_list_pk PRIMARY key(no)
);

-- [쇼핑] 찜목록 시퀀스
DROP SEQUENCE favourite_list_seq;
CREATE SEQUENCE favourite_list_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;


-- [쇼핑] 알림 신청 목록
DROP TABLE alarm_list;
CREATE TABLE alarm_list
(
    no    NUMBER(38) NOT NULL,
    reg_date    DATE DEFAULT sysdate NOT NULL,
    member_id    VARCHAR2(100) NOT NULL,
    product_no    NUMBER(38) NOT NULL,
    alarm_price    NUMBER(38,2) NOT NULL,
    alarm_rate    NUMBER(38,2) NOT NULL,
    alarm_currency    VARCHAR2(10) NOT NULL,
    CONSTRAINT alarm_list_pk PRIMARY key(no)
);

-- [쇼핑] 알림 신청 시퀀스
DROP SEQUENCE alarm_list_seq;
CREATE SEQUENCE alarm_list_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;

-- [쇼핑] 제휴사별 할인 목록
DROP TABLE discount;
CREATE TABLE discount
(
    no    NUMBER(38) NOT NULL,
    start_date    DATE NOT NULL,
    end_date    DATE NOT NULL,
    shop_code    VARCHAR2(10) NOT NULL,
    discount    NUMBER(38) NOT NULL,
    type    VARCHAR2(10) NOT NULL,
    CONSTRAINT discount_pk PRIMARY key(no)
);
-- [쇼핑] 제휴사별 할인 목록 시퀀스
DROP SEQUENCE discount_list_seq;
CREATE SEQUENCE discount_list_seq 
    INCREMENT BY 1
    START WITH 1
    NOCACHE;


-- [쇼핑] 결제 내역
DROP TABLE pay_history;
CREATE TABLE pay_history
(
    no    NUMBER(38) NOT NULL,
    reg_date    DATE NOT NULL,
    currency_en    VARCHAR2(20) NOT NULL,
    fe_amount    NUMBER(38,2) NOT NULL,
    card_no    VARCHAR2(30) NOT NULL,
    discount_amount    NUMBER(38,2) DEFAULT 0 NOT NULL,
    product_no    NUMBER(38) NOT NULL,
    after_balance    NUMBER(38,2) NOT NULL,
    CONSTRAINT discount_pk PRIMARY key(no)
);


-- [관리자] 관리자 회원테이블
DROP TABLE admin;
CREATE TABLE admin
(
    id    VARCHAR2(100) NOT NULL,
    password    VARCHAR2(500) NOT NULL,
    name    VARCHAR2(100) NOT NULL,
    email    VARCHAR2(100) NOT NULL,
    phone    VARCHAR2(13) NOT NULL,
    type    VARCHAR2(100) NOT NULL,
    reg_date    DATE DEFAULT SYSDATE NOT NULL,
    authority    VARCHAR2(100) DEFAULT 'ROLE_ADMIN' NOT NULL,
    dept    VARCHAR2(100) NOT NULL,
    empno    NUMBER(4) NOT NULL,
    CONSTRAINT admin_id_pk PRIMARY key(id)
);

