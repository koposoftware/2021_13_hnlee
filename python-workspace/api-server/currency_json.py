import requests
from selenium import webdriver
import time
from bs4 import BeautifulSoup
import cx_Oracle
import os
from datetime import datetime
import json
from collections import OrderedDict
from flask import Flask, request


def getExRates(search_date):

    # 오늘 날짜 구하기
    # today = datetime.today().strftime("%Y%m%d")

    # 셀레니움 연결설정
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument("user-agent=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36")
    path = "C:\DEV-util\chromedriver_win32\chromedriver.exe"
    driver = webdriver.Chrome(path, options=options)
    driver.implicitly_wait(10)

    # 하나은행 환율 사이트 접속
    driver.get("https://www.kebhana.com/cms/rate/index.do?contentUrl=/cms/rate/wpfxd651_01i.do#//HanaBank")

    a = "//*[@id='tmpInqStrDt']"
    elem = driver.find_element_by_xpath(a)
    elem.clear()
    elem.send_keys(search_date)
    # elem.send_keys(today) # 검색할 날짜 입력
    # elem.send_keys(20190603) # 검색할 날짜 입력

    b = "//*[@id='HANA_CONTENTS_DIV']/div[2]/a"
    btn = driver.find_element_by_xpath(b)
    btn.click() # 조회 버튼 클릭


    # BeautifulSoup으로 html 데이터 파싱
    html = driver.page_source
    soup = BeautifulSoup(html, 'lxml')

    nations = soup.select('td.tc > a > u')
    prices = soup.find_all('td', {'class' : 'txtAr'})

    round = soup.select_one('#searchContentDiv > div.printdiv > p > span.fl > strong:nth-child(4)').get_text()

    twoList = []
    exchange_rates = OrderedDict()

    for i in range(len(nations)):
        nation = nations[i].get_text()
        nation = nation.replace("\n", "")
        nation = nation.replace("\t", "")

        temp = nation.split()
        krName = temp[0]
        enName = temp[1]
        
        oneList = []
        oneList.append(krName)
        oneList.append(enName)  

        print(enName)


        for j in range(0, 11): # 0부터 10까지
            price = prices[11 * i + j].get_text()
            price = price.replace(",", "")

            # 현찰 살때 환율
            cashBuyRate = prices[11 * i + 0].get_text()
            cashBuyRate = cashBuyRate.replace(",", "")

            # 현찰 살때 spread
            cashBuySpread = prices[11 * i + 1].get_text()
            cashBuySpread = cashBuySpread.replace(",", "")

            # 현찰 팔때 환율
            cashSellRate = prices[11 * i + 2].get_text()
            cashSellRate = cashSellRate.replace(",", "")

            # 현찰 팔때 spread
            cashSellSpread = prices[11 * i + 3].get_text()
            cashSellSpread = cashSellSpread.replace(",", "")

            # 송금 보낼때 
            transferSendRate = prices[11 * i + 4].get_text()
            transferSendRate = transferSendRate.replace(",", "")

            # 송금 받을때
            transferReceiveRate = prices[11 * i + 5].get_text()
            transferReceiveRate = transferReceiveRate.replace(",", "")

            # t/c 사실때
            tcBuyRate = prices[11 * i + 6].get_text()
            tcBuyRate = tcBuyRate.replace(",", "")

            # 외화수표 파실때
            foreignCheckSellRate = prices[11 * i + 7].get_text()
            foreignCheckSellRate = foreignCheckSellRate.replace(",", "")

            # 매매기준율
            buyBasicRate = prices[11 * i + 8].get_text()
            buyBasicRate = buyBasicRate.replace(",", "")

            # 환가료율
            transferCommission = prices[11 * i + 9].get_text()
            transferCommission = transferCommission.replace(",", "")

            # 미화 환산율
            usdChangeRate = prices[11 * i + 10].get_text()
            usdChangeRate = usdChangeRate.replace(",", "")

            oneList.append(price)
        
        twoList.append(oneList)

        exchange_rates[enName] = {
            'nationKr' : krName
            , 'currencyEn' : enName
            , 'cashBuyRate' : cashBuyRate 
            , 'cashBuySpread' : cashBuySpread
            , 'cashSellRate' : cashSellRate
            , 'cashSellSpread' : cashSellSpread
            , 'transferSendRate' : transferSendRate
            , 'transferReceiveRate' : transferReceiveRate
            , 'tcBuyRate' : tcBuyRate
            , 'foreignCheckSellRate' : foreignCheckSellRate
            , 'buyBasicRate' : buyBasicRate
            , 'transferCommission' : transferCommission
            , 'usdChangeRate' : usdChangeRate
        }


    # print(json.dumps(exchange_rates, ensure_ascii=False, indent="\t"))
    return json.dumps(exchange_rates, ensure_ascii=False, indent="\t")


app = Flask(__name__)

@app.route('/')
def index():
    parameter_dict = request.args.to_dict()

    if len(parameter_dict) == 0:
        today = datetime.today().strftime("%Y%m%d")
        return getExRates(today)

    parameters = ''
    for key in parameter_dict.keys() : 
        parameters = request.args.get('date')
        return getExRates(parameters)


if __name__ == "__main__":
    app.run(host= '0.0.0.0', port= 5000, debug= True)
