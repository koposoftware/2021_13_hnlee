-- DML (INSERT, UPDATE, DELETE)
-- [환율] 삽입
DELETE FROM exchange_rate;
INSERT INTO exchange_rate(
    no, nation_kr, currency_en
    , cash_buy_rate, cash_buy_spread, cash_sell_rate, cash_sell_spread
    , transfer_send_rate, transfer_receive_rate
    ,tc_buy_rate,foreign_check_sell_rate
    , buy_basic_rate, transfer_commission, usd_change_rate
)
VALUES(
    exchange_rate_seq.nextval,
    '폴란드', 'PLN', '328.83', '8.00', '280.13', '8.00', '307.82', '301.14', '0.00', '0.00', '304.48', '2.22500', '0.2630'
);

-- [카드] 카드 개설
DELETE FROM card;
INSERT INTO CARD(
    card_no
    , cvc
    , name_en
    , member_id
    , password
)
VALUES(
    '4562112245947852'
    ,'32ㅇㄴㄹ3'
    , 'HAENEE LEE'
    ,'hanny'
    , '123124ㅇㄹㄴㄹ1'
);

-- 잔액 초기화 프로시저 실행
exec CARD_BALANCER_RESET_PROC('4123-3528-5210-2497');


-- [회원] 회원가입
insert into member(
    id, password, name, email, phone, authority, type
)values(
    'hanny', '$2a$10$SVDtTyTAO.D9zm7Ds9GUXuUR1pE0OD56RJDY2ZqAwrTnawS9D9TFm', '이해니', 'nee1202@naver.com' ,'010-2121-7514', 'ROLE_USER', '홈페이지 회원가입' -- 비밀번호 : 1111
);

insert into member(
    id, password, name, email, phone, authority, type
)values(
    'ally', '$2a$10$SVDtTyTAO.D9zm7Ds9GUXuUR1pE0OD56RJDY2ZqAwrTnawS9D9TFm', '셀러', 'ally@test.com' ,'010-8875-7524', 'ROLE_PARTNER', '홈페이지 회원가입' -- 비밀번호 : 1111
);

commit;

-- [카드] 카드 정보 입력
insert into card(
    card_no, cvc, family_name, given_name, member_id
) values(
    '1235' 
    , '123'
    , 'LEE'
    , 'HAENEE'
    , 'hanny'
);


-- [카드] 신청내역 입력
insert into card_register(
    no, zip, addr1, addr2, card_no, APPLICANT_ID
) values(
    CARD_REGISTER_SEQ.nextval
    , 412220
    , '경기도'
    , '고양시'
    , '1235'
    , 'hanny'
);


-- [카드] 잔액 최초 입력 (더미 데이터용)
insert into card_balance(
    no, card_no, currency_code, balance
) values(
    card_balance_seq.nextval
    , '1235' 
    , 'USD'
    , 500
);

-- [충전] 충전 내역 입력
INSERT INTO charge_history(
    no, account_no,account_bank,
    currency_en, kr_amount,card_no,exchange_rate,fe_amount
) values(
    charge_history_seq.nextval
    , '9090909-999999'
    , '카카오'
    , 'USD'
    , 4000
    , '123'
    , 100.9
    , 50000
);

-- [충전] 환불 내역 입력
INSERT INTO refund_history(
    no, account_no,account_bank,
	currency_en, kr_amount,card_no,exchange_rate,fe_amount
) values(
    refund_history_seq.nextval
    , '9090909-999999'
    , '카카오'
    , 'USD'
    , 4000
    , '123'
    , 100.9
    , 50000
);



-- [쇼핑] 상품 등록
INSERT INTO product(
    no, url, img, brand, name, price, currency, admin_id, seller_id, shop_code
) VALUES(product_seq.nextval,'https://www.mytheresa.com/ko-kr/catalog/product/view/id/1877766/s/jw-anderson-intarsia-sweater-1877766/?catref=category','https://img.mytheresa.com/1088/1088/66/jpeg/catalog/product/7f/P00573027.jpg','JW ANDERSON','인타르시아 스웨터',505,'EUR','admin1','mytheresa', '001');



-- [쇼핑] 판매자 등록
INSERT INTO partner(id, team, shop_code)
VALUES('mytheresa', '온라인운영팀', '001');

INSERT INTO partner(id,team, shop_code)
VALUES('amazon', '제휴판매팀', '002');


-- [쇼핑] 제휴 쇼핑몰 등록
INSERT INTO partner_shop(code, site, name, currency, nation_kr)
    VALUES('001','https://www.mytheresa.com/','mytheresa','EUR','독일');

INSERT INTO partner_shop(code, site, name, currency, nation_kr)
    VALUES('002','https://www.amazon.com/','AMAZON','USD','미국');

-- [쇼핑] 찜목록 추가
INSERT INTO favourite_list(no, member_id, product_no)
    VALUES(favourite_list_seq.nextval, 'hanny', 62);


-- [쇼핑] 알람 등록
INSERT INTO alarm_list(
    no, member_id, product_no, alarm_price, alarm_rate, alarm_currency
) VALUES(alarm_list_seq.nextval, 'hanny', 62, 1500000, 1346 , 'EUR');

-- [관리자] 회원 등록
INSERT INTO admin(
    id, password, name, email, phone, type, dept, empno
)values(
    'admin', '$2a$10$SVDtTyTAO.D9zm7Ds9GUXuUR1pE0OD56RJDY2ZqAwrTnawS9D9TFm', 
    '관리자', 'iamsunny7514@gmail.com' ,'010-8867-7514', '최초관리자 생성'
    , 'IT부서', 0001 -- 비밀번호 : 1111
);

