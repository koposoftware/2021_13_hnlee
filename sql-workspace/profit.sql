-- [수익률 구하기]

-- 1) 현재 구매한 OMR 평균가격 : 3332.42
SELECT trunc(SUM(KR_AMOUNT)/SUM(FE_AMOUNT), 2)
FROM(
    select * from refund_history 
    where currency_en = 'OMR'
    union 
    select * from charge_history
    where currency_en = 'OMR'
);

select * from charge_history;
select * from refund_history;


select SUM(G.KR_AMOUNT) from card c, charge_history g
where c.card_no = g.card_no and c.member_id = 'hanny' and g.currency_en = 'USD';

select SUM(R.KR_AMOUNT) from card c, REFUND_history R
where c.card_no = R.card_no and c.member_id = 'hanny' and R.currency_en = 'USD';

SELECT * FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD';

/* 한국돈이 (-)면 충전, 한국돈이 (+)면 환불 */





-- 2) 현재 1 OMR당 원화 팔때 가격 : 2868.91
SELECT cash_sell_rate FROM(
SELECT * FROM exchange_rate WHERE CURRENCY_EN='OMR' ORDER BY REG_DATE DESC) 
WHERE ROWNUM = 1;

-- 2-2) 현재 1 OMR당 원화 살때 가격 : 3323.66
SELECT cash_buy_rate FROM(
SELECT * FROM exchange_rate WHERE CURRENCY_EN='OMR' ORDER BY REG_DATE DESC) 
WHERE ROWNUM = 1;

-- 3) 현재 OMR 보유 금액 : 190 
SELECT BALANCE FROM card_balance WHERE currency_en = 'OMR';


/*
[개별 수익률]
보유 주수 : 2주

내 평균 가격 : 13600원 (총가격 / 총손익 * 100 = -12.86%)
현재 팔때 가격 : 11850원
-----------------------------------------------------------------
1주당 손익 : (현재 가격) - (내 평균 가격) = (11850 - 13600) = -1750원



총 가격 : 13600 * 2 = 27200 (총가격 / 총손익 * 100 = -12.86%)
팔때 가격 : 11850 * 2 = 23700 
----------------------
총 손익 : ((현재 가격) - (내 평균 가격)) * (주수) = (11850 - 13600) * 2 = -3500원


손익률 : -12.86%
*/



/*
[총 수익률]
A 2000  (-400) 
B 3000  (+500)
C 1000  (-800)
D 6000  (-1000)
--------------
총 구매가격 : 총 12000원 들여서 외화를 샀어! 
총 손익 : 총 -1700원 손해
총 손익률 : -1700 / 12000 * 100 = -14.16%
*/





SELECT * FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD';
update charge_history set commission_kr = commission_kr * -1;
update charge_history set without_commission = without_commission * -1;
commit;

/*-----------------------------------------수익률 재정산-----------------------------------------*/

-- 1단계 : 카드 잔액 구하기 (ID) ==> 생각해보니 잔액을 구하면 결제금액까지 빠져서 완전한 평균을 낼 수 없음!! 2단계에서 잔액 구해야함
SELECT * FROM CARD D, card_balance b where d.card_no = b.card_no and d.member_id = 'hanny' and b.currency_en = 'USD'; -- 특정 외화만 구할때
SELECT b.* FROM CARD D, card_balance b where d.card_no = b.card_no and d.member_id = 'hanny'; -- 특정 회원의 전체 잔액 구할때

-- 2단계 : 해당 외화를 구매하기 위해 지불한 총 원화 금액 
SELECT SUM(KR_AMOUNT) as KR_AMOUNT, SUM(WITHOUT_COMMISSION) as WITHOUT_COMMISSION, SUM(COMMISSION_KR) as COMMISSION_KR, SUM(FE_AMOUNT) FE_AMOUNT
FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) 
WHERE CARD_NO = '1235' and currency_en = 'USD';

SELECT SUM(KR_AMOUNT) FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD'; -- 수수료 포함
SELECT SUM(WITHOUT_COMMISSION) FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD';-- 수수료 제외
SELECT SUM(COMMISSION_KR) FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD'; -- 수수료
SELECT SUM(FE_AMOUNT) FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) WHERE CARD_NO = '1235' and currency_en = 'USD'; -- 수수료

SELECT -118.53 + -10575 FROM DUAL; -- -10693.53

-- 3단계 : 10693.53(원화지불금액) / 9(잔액) = 평균 금액 구하기
select  round(10693.53 / 9, 2) from dual; -- 1188.17


select round(KR_AMOUNT / FE_AMOUNT, 2) as avgPrice, KR_AMOUNT, WITHOUT_COMMISSION, COMMISSION_KR, FE_AMOUNT from (
    SELECT 
        SUM(KR_AMOUNT) as KR_AMOUNT
        , SUM(WITHOUT_COMMISSION) as WITHOUT_COMMISSION
        , SUM(COMMISSION_KR) as COMMISSION_KR
        , SUM(FE_AMOUNT) FE_AMOUNT
    FROM (SELECT * FROM refund_history UNION SELECT * FROM CHARGE_HISTORY) 
    WHERE CARD_NO = '1235' and currency_en = 'USD'
);
-- -1188.17	-10693.53	-10575	-118.53	9

-- 4단계 : 환율 구하기 = 현재 환율이랑 비교하기
select e.transfer_send_rate from exchange_rate e, nation_code n 
where e.currency_en = n.currency_en
and e.reg_date = (select max(reg_date) from exchange_rate) and e.currency_en = 'USD'; -- 현재 송금 보낼때 환율 = 1197.3




