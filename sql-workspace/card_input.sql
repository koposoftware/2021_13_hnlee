/*[카드] 외화 충전하기 */


/*
    내부에서 조회해서 out 출력할 변수?
    - 환율 : 환율 no, 환율 고시 시점, 송금보낼때 환율, 매매기준율 => rateNo, rateRegDate, transferSendRate, buyBasicRate
    
rateNo
rateRegDate
transferSendRate
buyBasicRate
*/


-- [환율] 실시간 현재 환율 확인 : 충전할때는 전신환매도율 = 송금보낼때 환율
select no as rate_no, reg_date as rate_reg_date, transfer_send_rate, buy_basic_rate from(
    select * from exchange_rate2 where currency_en = 'USD' order by reg_date desc
) where rownum = 1;


/*  
    필요한 매개변수 :
        - 오픈뱅킹 : 은행명, 은행계좌           => accountBank, accountNum
        - 카드 : 카드번호                     => cardNo
        - 충전 : 충전 외화코드, 충전 외화 금액   => currencyEn, fe_amount
        
    
accountBank
accountNum
cardNo
currencyEn
fe_amount
*/


-- [환전] 오픈뱅킹 계좌에서 출금 (잔액 변경)
update openbank_account set balance = balance - 100 -- kr_amount
where account_bank = '카카오'
and account_num = '12121-12-1211212';




-- [환전] 카드 잔액 변경
update card_balance set balance = balance + 50 -- fe_amount
where card_no = '1235'  
and currency_en = 'USD';


/*
    내부에서 조회해서 out 출력할 변수
        - 카드 : 잔액 (변경 후) after_balance
*/
-- [카드] 잔액 조회
select balance from card_balance where card_no = '1235' and currency_en = 'USD';

-- [환전] 충전 거래 내역에 기록 : 거래 후 잔액이 안 넣어져 있음
INSERT INTO charge_history(
    no
    , account_num        -- accountNum
    , account_bank      -- accountBank
    , currency_en
    , kr_amount         -- transferSendRate * fe_amount
    , card_no           -- cardNo
    , exchange_rate
    , exchange_code     -- rate_no
    , fe_amount         -- fe_amount
    , after_balance     -- after_balance
) values(
    charge_history_seq.nextval
    , '9090909-999999'
    , '카카오'
    , 4000
    , '123'
    , 50000
    , 300
    , 200
);




-- [오픈뱅킹] 잔액 변경
select * from openbank_account where card_no = '4123-3528-5210-2497';
select * from openbank_account where card_no = '1235';


-- [충전] 충전 내역 조회
select * from charge_history where card_no = '4123-3528-5210-2497';
select * from charge_history where card_no = '1235' order by reg_date desc;
select * from refund_history where card_no = '4123-3528-5210-2497';
select * from refund_history where card_no = '1235' order by reg_date desc;

-- [카드] 카드 잔액 변경 내역
select * from card_balance where card_no = '4123-3528-5210-2497';
select * from card_balance where card_no = '1235' and balance != 0;




-- 충전내역 초기화
delete from charge_history;
update card_balance set balance = 0;
update openbank_account set balance = 2000000;

delete from charge_history where card_no = '1235';
update card_balance set balance = 0  where card_no = '1235';


-- 환불내역 초기화
delete from refund_history;
commit;


select * from exchange_rate where no = 549;


commit;

/*
CREATE OR REPLACE PROCEDURE CHARGE_PROC
(
    V_account_bank IN OPENBANK_ACCOUNT.ACCOUNT_BANK%TYPE
    , V_account_num IN OPENBANK_ACCOUNT.ACCOUNT_NUM%TYPE
    , V_card_no IN openbank_account.card_no%TYPE
    , V_exchange_code IN charge_history.exchange_code%TYPE
    , V_fe_amount IN charge_history.fe_amount%TYPE
    , V_kr_amount IN charge_history.kr_amount%TYPE
)
IS
    V_
BEGIN

END CHARGE_PROC;
*/

SELECT * FROM charge_history h, CARD C, nation_code n
WHERE C.MEMBER_ID = 'hanny'
and c.card_no = h.card_no
and h.currency_en = n.currency_en
order by reg_date desc;

desc charge_history;