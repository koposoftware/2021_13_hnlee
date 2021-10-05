/* -------------------------- DDL : ALTER ------------------------------*/

-- [1] 컬럼 추가하기
ALTER TABLE pay_history ADD after_balance NUMBER(38,2);
UPDATE pay_history SET after_balance = 0;
ALTER TABLE pay_history MODIFY after_balance NOT NULL;


ALTER TABLE product ADD onsale CHAR(1) DEFAULT 'N'; -- 판매 개시 여부 default 'N'
select * from product order by reg_date desc;

ALTER TABLE charge_history ADD exchange_code NUMBER(38);
UPDATE CHARGE_HISTORY SET EXCHANGE_CODE = 2;
ALTER TABLE charge_history MODIFY exchange_code NOT NULL;

ALTER TABLE charge_history ADD after_balance NUMBER(38);
UPDATE CHARGE_HISTORY SET after_balance = 2;
ALTER TABLE charge_history MODIFY after_balance NOT NULL;


ALTER TABLE refund_history ADD commission_amount NUMBER(38,2);
UPDATE refund_history SET commission_amount = KR_AMOUNT * 0.03;
ALTER TABLE refund_history MODIFY commission_amount NOT NULL;

ALTER TABLE refund_history ADD exchange_code NUMBER(38);
UPDATE refund_history SET EXCHANGE_CODE = 2;
ALTER TABLE refund_history MODIFY exchange_code NOT NULL;



-- [2] 컬럼명 변경
alter table charge_history rename column account_no to account_num;
alter table refund_history rename column account_no to account_num;
alter table partner rename column code to shop_code;
alter table partner_shop rename column currency to currency_en;


-- [3] 테이블명 변경
rename seller to partner;

-- [4] 컬럼 삭제
alter table partner drop column password;
alter table partner drop column tel;
alter table partner drop column email;
alter table partner drop column name;
alter table partner drop column reg_date;


-- [컬럼] 데이터 타입 변경 (데이터 없는 경우)
alter table partner_shop modify code number(38);



-- [컬럼] 데이터 타입 변경 (데이터 있는 경우)
-- 새 컬럼을 생성 (기존 데이터를 옮겨담을 컬럼)
ALTER TABLE product ADD code_price number(38,2);

-- 새 컬럼에 기존 데이터를 입력 (SET)
UPDATE product SET code_price = price;

-- 기존 컬럼 삭제
ALTER TABLE product DROP COLUMN price;

-- 새 컬럼의 이름을 기존 컬럼 이름으로 RENAME
ALTER TABLE product RENAME COLUMN code_price TO price;

commit;


-- 특정 날짜에 입력된 값 일괄 삭제
select to_char(reg_date, 'yyyy-mm-dd HH:mi:ss') from exchange_rate e, nation_code n where e.currency_en = n.currency_en order by reg_date desc;
delete from exchange_rate where to_char(reg_date, 'yyyy-mm-dd') = '2021-09-30';

select to_char(reg_date, 'yyyy-mm-dd HH:mi:ss') from product order by reg_Date desc;
delete from product where to_char(reg_date, 'yyyy-mm-dd HH:mi:ss') = '2021-09-30 02:42:27';

commit;