-- [환율] 국가 코드 조회
select * from nation_code;

-- [환율] 환율 갯수
select count(*) from exchange_rate e, nation_code n where e.currency_en = n.currency_en order by reg_date desc; --393

SELECT * FROM OPENBANK_ACCOUNT;


-- [환율] 전체 조회
select * from exchange_rate e, nation_code n where e.currency_en = n.currency_en order by reg_date desc;

-- [환율] 실시간 전체 환율 조회
select * from exchange_rate e, nation_code n 
where e.currency_en = n.currency_en
and e.reg_date = (select max(reg_date) from exchange_rate);


-- [환율] 선택 외화의 현재 환율 조회
select * from exchange_rate e, nation_code n 
where e.currency_en = n.currency_en
and e.currency_en = 'EUR' 
and e.reg_date = (select max(reg_date) from exchange_rate);


-- [환율] 선택 국가 환율 조회 (ROWNUM 포함)
select * from exchange_rate e, nation_code n 
where e.currency_en = n.currency_en 
and e.currency_en = 'USD' 
order by e.reg_date;

-- [회원] ID 체크
select count(*) from member where id = 'hanny';

select id, password, name, authority from member
			where id = 'admin1';

-- [회원] 전체 회원 조회
select * from member;

-- [회원] 비밀번호 가져오기
select password from member where id = 'gildong';

-- [카드] 유효기간 만료일 계산
select SYSDATE + (INTERVAL '5' YEAR)  from dual;

-- [카드] 카드 번호 중복체크
select count(*) from card where card_no = '1235';

-- [카드/오픈뱅킹] ID로 소유한 카드번호와 계좌 조회
SELECT O.* FROM openbank_account O, CARD C
WHERE C.MEMBER_ID = 'kelly'
AND O.CARD_NO = C.CARD_NO;


-- [충전] 충전 내역 조회
SELECT * FROM charge_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
		order by reg_date desc;

-- [환불] 환불 내역 조회
SELECT * FROM refund_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
		order by reg_date desc;
                
        
-- [결제] 결제 내역 조회
SELECT * FROM pay_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
		order by reg_date desc;




-- [이용내역] 전체 이용내역

-- [충전] 충전 내역 조회
select * from
(SELECT 
'충전' as type 
, h.kr_amount as etcAmount
, h.currency_en as currency_en
, h.fe_amount as fe_amount
, n.currency_code as currency_code
, h.reg_date as reg_date
, h.after_balance as after_balance
, n.nation_en_initial as nation_en_initial
, n.nation_en as nationEn
FROM charge_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
union
-- [환불] 환불 내역 조회
SELECT 
'환불' as type 
, h.kr_amount as etcAmount
, h.currency_en as currency_en
, h.fe_amount as fe_amount
, n.currency_code as currency_code
, h.reg_date as reg_date
, h.after_balance as after_balance
, n.nation_en_initial as nation_en_initial
, n.nation_en as nationEn
FROM refund_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
union                
-- [결제] 결제 내역 조회
SELECT  
'결제' as type 
, h.discount_amount as etcAmount
, h.currency_en as currency_en
, h.fe_amount as fe_amount
, n.currency_code as currency_code
, h.reg_date as reg_date
, h.after_balance as after_balance
, n.nation_en_initial as nation_en_initial
, n.nation_en as nation_en
FROM pay_history h, CARD C, nation_code n
		WHERE C.MEMBER_ID = 'hanny'
		and c.card_no = h.card_no
		and h.currency_en = n.currency_en
)
order by reg_date desc;






-- [카드] 잔액 조회
select 
    b.currency_en as currency_en
    , b.balance as balance
    , c.card_no as card_no
    , n.currency_kr as currency_kr
    , n.nation_kr as nation_kr
    , n.nation_en as nation_en
    , n.currency_code as currency_code
from card_balance b, card c, nation_code n
where c.member_id = 'kelly'
and balance != 0
and b.card_no = c.card_no
and b.currency_en = n.currency_en
order by balance desc;

-- [카드] 보유중인 외화의 현재 환율
select * from exchange_rate 
where reg_date = (select max(reg_date) from exchange_rate) 
and currency_en in (select b.currency_en
    from card_balance b, card c
    where c.member_id = 'hanny'
    and balance != 0
    and b.card_no = c.card_no);

-- [카드] 나의 카드 잔액과 현재 환율 구하기
select * from 
(select 
    b.currency_en as currency_en
    , b.balance as balance
    , c.card_no as card_no
    , n.nation_en_initial as nation_en_initial
    , n.currency_kr as currency_kr
    , n.nation_kr as nation_kr
    , n.nation_en as nation_en
    , n.currency_code as currency_code
    from card_balance b, card c, nation_code n
    where c.member_id = 'hanny'
    and balance != 0
    and b.card_no = c.card_no
    and b.currency_en = n.currency_en
    order by balance desc
) x, (
select * from exchange_rate 
    where reg_date = (select max(reg_date) from exchange_rate) 
    and currency_en in 
        (select b.currency_en
        from card_balance b, card c
        where c.member_id = 'hanny'
        and balance != 0
        and b.card_no = c.card_no)
) k
where x.currency_en = k.currency_en;

    
-- [카드] 특정 카드의 특정 외화 잔액 조회
select balance 
from card_balance 
where card_no = '1235' and currency_code = 'USD';

-- ID로 잔액 조회
SELECT b.* FROM CARD D, card_balance b where d.card_no = b.card_no and d.member_id = 'hanny' and currency_en = 'USD';
select * from product order by no desc;

select * from charge_history;

-- [쇼핑] 쇼핑몰로 상품 검색
select P.*, S.NAME AS shop_name, s.reg_date as shop_reg_date
FROM PRODUCT P, partner_shop S
WHERE p.shop_code = s.code
AND shop_code in (001, 002);

-- [쇼핑] 전체 상품 검색
select P.*, s.shop_name, s.reg_date as shop_reg_date
FROM PRODUCT P, partner_shop S
WHERE p.shop_code = s.code
and p.onsale = 'Y' order by p.reg_date desc;

select P.*, s.shop_name, s.reg_date as shop_reg_date, s.discount as discount, s.type as type
		FROM PRODUCT P, (select * from discount d, partner_shop S where s.code = d.shop_code (+) and sysdate between d.start_date and d.end_date) S
		WHERE p.shop_code = s.code
		order by p.reg_date asc;


-- [쇼핑] 상품 하나 상세 검색
select P.*, s.shop_name, s.reg_date as shop_reg_date
FROM PRODUCT P, partner_shop S
WHERE p.no = '1' and p.shop_code = s.code
and p.onsale = 'Y';

select P.*, s.shop_name, s.reg_date as shop_reg_date, s.discount as discount, s.type as type
		FROM PRODUCT P, (select * from discount d, partner_shop S where s.code = d.shop_code (+)) S
		WHERE p.no = 112 and p.shop_code = s.code
		order by p.reg_date desc;


-- [쇼핑] 특정 회원의 찜목록 존재 여부 확인
select * from favourite_list where member_id = 'hanny' and product_no= '62';

-- [쇼핑] 특정 회원의 찜목록 리스트 and 이미 담겨있는 상품인지 확인
select * from favourite_list where member_id = 'hanny';
select count(*) from favourite_list where member_id = 'hanny' and product_no=60;

-- [쇼핑] 찜 목록 조회하기
select * from favourite_list f, product p, partner_shop s
where f.product_no = p.no 
and p.shop_code = s.code
and f.member_id = 'hanny';



-- [쇼핑] 알람 신청 목록 조회하기
select * from alarm_list a, product p, partner_shop s
where a.product_no = p.no 
and p.shop_code = s.code
and a.member_id = 'hanny';

-- 실시간 환율까지 출력
select * from alarm_list a, product p, partner_shop s, exchange_rate e, nation_code n 
where e.currency_en = n.currency_en
and a.product_no = p.no 
and p.shop_code = s.code
and a.alarm_currency = e.currency_en
and e.reg_date = ((select max(reg_date) from exchange_rate))
and a.member_id = 'hanny';




select * from card_balance where card_no = '1235' and currency_en = (select currency from product where product.no = 62);

select b.balance, p.price
from card_balance b, product p
where b.currency_en = p.currency
and p.no = 112
and b.card_no = '1235';

-- [결제] 결제 잔액 조회
select (b.balance - p.price)
from card_balance b, product p
where b.currency_en = p.currency
and p.no = 112
and b.card_no = '1235';

-- [결제] 결제 내역 조회
select * from pay_history h, product p where h.product_no = p.no order by h.reg_date desc;

select h.*, p.*, s.site, s.shop_name 
from pay_history h, product p, partner_shop s , card c
where h.card_no = c.card_no and h.product_no = p.no and p.shop_code = s.code and c.member_id = 'hanny'
order by h.reg_date desc;

-- [알림 문자메시지]
select * 
from alarm_list a, member m 
where a.member_id = m.id and a.alarm_rate >= '1328' and a.alarm_currency='EUR';

select * from openbank_auth;

-- [결제 내역] 월별 검색
select p.*, c.*, m.id as id, m.name as member_name, t.name, t.price, s.shop_name as shopName, n.*
from pay_history p, card c, member m, product t, partner_shop s, nation_code n
where p.reg_date between to_date('200001', 'yyyy-mm') and to_date('205012', 'yyyy-mm') 
and p.card_no = c.card_no
and c.member_id = m.id
and p.product_no = t.no
and t.shop_code = s.code
and p.currency_en = n.currency_en
order by p.reg_date desc;

select sum(fe_amount) * 0.025
from pay_history p, card c, member m, product t, partner_shop s, nation_code n
where p.reg_date between to_date('200001', 'yyyy-mm') and to_date('205012', 'yyyy-mm') 
and p.card_no = c.card_no
and c.member_id = m.id
and p.product_no = t.no
and t.shop_code = s.code
and p.currency_en = n.currency_en
order by p.reg_date desc;