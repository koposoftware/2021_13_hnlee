import json
from collections import OrderedDict
import requests
from bs4 import BeautifulSoup
from datetime import datetime
import os
from flask import Flask, jsonify, request

headers = {'User-Agent' : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36'}

def getPageString(url):
    data = requests.get(url, headers= headers)
    return data.content

url = 'https://www.mytheresa.com/ko-kr/new-arrivals/what-s-new-this-week-1.html?fta_korea=1'


data = getPageString(url)
bsObj = BeautifulSoup(data, 'html.parser')

ul = bsObj.find("ul", {"class" : "products-grid products-grid--max-3-col"})

lis = ul.findAll("li", {"class" : "item"})


item_lists = OrderedDict()
cnt = 0

for item in lis:
    # 상품 링크
    url = item.find("a", {"class" : "product-image"}).get('href')

    # 상품 사진
    img = item.find("img", {"class" : "lazyload"}).get('data-src')

    # 상품 브랜드
    brand = item.find("span", {"class" : "ph1"}).getText()

    # 상품 이름
    name = item.find("h2", {"class" : "product-name"}).find("a").getText()

    # 상품 가격 정보
    priceInfo = item.find("span", {"class" : "price"}).getText()

    temp = priceInfo.split()
    currency = temp[0]
    price = temp[1]

    cnt = cnt + 1
    item_lists[cnt] = {
        'url' : url,
        'img' : img,
        'brand' : brand,
        'name' : name,
        'price' : price,
        'currency' : currency
    }

print(json.dumps(item_lists, ensure_ascii=False, indent="\t"))

