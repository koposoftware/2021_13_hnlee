import requests
from selenium import webdriver
from selenium.webdriver.support.select import Select
from selenium.webdriver.common.keys import Keys
import time
from bs4 import BeautifulSoup
import cx_Oracle
import os
from datetime import datetime

# 오늘 날짜 구하기
today = datetime.today().strftime("%Y-%m-%d")

# 셀레니움 연결설정
options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")
path = "C:\DEV-util\chromedriver_win32\chromedriver.exe"
driver = webdriver.Chrome(path, options=options)
driver.implicitly_wait(10)

# 하나은행 환율 사이트 접속
driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_07i.do")

search_date = 20201019

time.sleep(2)

while(search_date < 20211031):
    # 검색할 날짜 입력
    a = "//*[@id='tmpInqStrDt_d']"
    elem = driver.find_element_by_xpath(a)
    elem.clear()
    search_date = search_date + 1
    print(search_date)
    elem.send_keys(search_date) 
    
    time.sleep(2)


    # 조회할 통화 선택
    select = Select(driver.find_element_by_id("curCd"))

    nation_list = {"USD","JPY","EUR","CNY","HKD","THB","TWD","PHP","SGD","AUD","VND","GBP","CAD","MYR","RUB"
    ,"ZAR","NOK","NZD","DKK","MXN","MNT","BHD","BDT"
    ,"BRL","BND","SAR","LKR","SEK","CHF","AED","DZD"
    ,"OMR","JOD","ILS","EGP","INR","IDR","CZK","CLP","KZT"
    ,"QAR","KES","COP","KWD","TZS","TRY","PKR","PLN","HUF"}

    num = 1
    for i in nation_list:

        print(num)
        num = num + 1
        select.select_by_value(i)

        time.sleep(2)

        # 조회 버튼 클릭
        b = "//*[@id='HANA_CONTENTS_DIV']/div[2]/a"
        btn = driver.find_element_by_xpath(b)
        btn.send_keys(Keys.ENTER)

        time.sleep(2)


        # BeautifulSoup으로 html 데이터 파싱
        html = driver.page_source
        soup = BeautifulSoup(html, 'lxml')

        date = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(2)').text # 조회 날짜
        print(date) 

        currency = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(4)').text # 조회 통화
        print(currency)

        time.sleep(2)

        rows = soup.select('#searchContentDiv > div.printdiv > table > tbody > tr')
        oneNations = []
        rows.reverse() 

        for j in rows:
            cols = j.select('td')

            round = cols[0].text
            timing = str(search_date) + " " + cols[1].text
            send = cols[4].text
            send = send.replace(",", "")
            receive = cols[5].text
            receive = receive.replace(",", "")
            basic = cols[8].text
            basic = basic.replace(",", "")
            dollor = cols[11].text
            dollor = dollor.replace(",", "")

            oneNations_oneRow = []
            oneNations_oneRow.append(i) # 화폐코드
            oneNations_oneRow.append(timing)
            oneNations_oneRow.append(send)
            oneNations_oneRow.append(receive)
            oneNations_oneRow.append(basic)
            oneNations_oneRow.append(dollor)

            oneNations.append(oneNations_oneRow)
                

        # print(oneNations)

        # 오라클 연결 및 데이터 삽입
        conn = cx_Oracle.connect('hanny', '1234', 'hana-global-wallet.cybcchck26su.ap-northeast-2.rds.amazonaws.com:1521/ORCL', encoding='UTF-8', nencoding='UTF-8')

        cursor = conn.cursor() # 커서 생성
        print("커서생성")
        sql = "INSERT INTO exchange_rate2(no, currency_en, reg_date, transfer_send_rate, transfer_receive_rate, buy_basic_rate, usd_change_rate) VALUES(exchange_rate_seq2.nextval, :1, TO_DATE(:2 ,'YYYY-MM-DD HH24:MI:SS'), :3, :4, :5, :6)"

        cursor.bindarraysize = len(oneNations)
        cursor.executemany(sql, oneNations)

        conn.commit()
        print("커밋완료!")
        cursor.close()
        conn.close()

        print("-----------------------")
