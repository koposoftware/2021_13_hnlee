import requests
from selenium import webdriver
import time
from bs4 import BeautifulSoup
import cx_Oracle
import os
from datetime import datetime
import schedule
import sys

# 오라클에 insert할 함수
def insert_function():

    # 이전 배열 저장
    before_list = []

    # 오늘 날짜 구하기
    today = datetime.today().strftime("%Y%m%d")

    # 셀레니움 연결설정
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")
    path = "C:\DEV-util\chromedriver_win32\chromedriver.exe"
    driver = webdriver.Chrome(path, options=options)


    # 하나은행 환율 사이트 접속
    driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_01i.do#//HanaBank")

    time.sleep(2)

    a = "//*[@id='tmpInqStrDt']"
    elem = driver.find_element_by_xpath(a)
    elem.clear()
    elem.send_keys(today) # 검색할 날짜 입력
    # elem.send_keys(20190603) # 검색할 날짜 입력


    time.sleep(2)

    b = "//*[@id='HANA_CONTENTS_DIV']/div[2]/a"
    btn = driver.find_element_by_xpath(b)
    btn.click() # 조회 버튼 클릭

    time.sleep(2)


    # BeautifulSoup으로 html 데이터 파싱
    html = driver.page_source
    soup = BeautifulSoup(html, 'lxml')

    nations = soup.select('td.tc > a > u')
    prices = soup.find_all('td', {'class' : 'txtAr'})

    round = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(4)').get_text()

    twoList = []

    for i in range(len(nations)):
        # print(nations[i].get_text())
        nation = nations[i].get_text()
        nation = nation.replace("\n", "")
        nation = nation.replace("\t", "")

        temp = nation.split()
        krName = temp[0]
        enName = temp[1]
        
        oneList = []
        oneList.append(krName)
        oneList.append(enName)

        for j in range(0, 11):
            price = prices[11 * i + j].get_text()
            price = price.replace(",", "")
            oneList.append(price)
        
        twoList.append(oneList)

    # 이전 리스트와 현재 파싱한 리스트 같은지 확인
    if(before_list == twoList):
        print("이전과 같습니다.")
    else:
        print("이전과 다릅니다.")
        before_list = twoList


        # 오라클 연결 및 데이터 삽입
        conn = cx_Oracle.connect('hanny', '1234', 'hana-global-wallet.cybcchck26su.ap-northeast-2.rds.amazonaws.com:1521/ORCL', encoding='UTF-8', nencoding='UTF-8')

        cursor = conn.cursor() # 커서 생성

        roundSql = "select count(*) from exchange_rate where round = :1"
        cursor.execute(roundSql, round)
        print(cursor.fetchone())

        sql = "INSERT INTO exchange_rate(no, nation_kr, nation_en, cash_buy_rate, cash_buy_spread, cash_sell_rate, cash_sell_spread, transfer_send_rate, transfer_receive_rate,tc_buy_rate,foreign_check_sell_rate, buy_basic_rate, transfer_commission, usd_change_rate) VALUES(exchange_rate_seq.nextval, :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13)"

        cursor.bindarraysize = len(twoList)
        cursor.executemany(sql, twoList)

        conn.commit()
        print("커밋완료!")
        cursor.close()
        conn.close()

def exit():
    print('함수가 종료됩니다.')
    sys.exit()


schedule.every(10).minutes.do(insert_function)
schedule.every().saturday.do(exit)


