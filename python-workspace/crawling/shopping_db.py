import requests
from bs4 import BeautifulSoup
from datetime import datetime
import cx_Oracle

headers = {'User-Agent' : 'Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.82 Safari/537.36'} # 크롤링 차단 막기 위한 헤더 셋팅

def getPageString(url):
    data = requests.get(url, headers= headers)
    return data.content

url = 'https://www.mytheresa.com/ko-kr/new-arrivals/what-s-new-this-week-1.html?fta_korea=1'

data = getPageString(url)
bsObj = BeautifulSoup(data, 'html.parser')

ul = bsObj.find("ul", {"class" : "products-grid products-grid--max-3-col"})
lis = ul.findAll("li", {"class" : "item"})

items = []

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

    i = []
    i.append(url)
    i.append(img)
    i.append(brand)
    i.append(name)
    i.append(price.replace(",", "")) # 숫자로 들어가기 때문에 , 없애줘야 함

    items.append(i)

print(items)

# 오라클 연결 및 데이터 삽입
conn = cx_Oracle.connect('hanny', '1234', 'hana-global-wallet.cybcchck26su.ap-northeast-2.rds.amazonaws.com:1521/ORCL', encoding='UTF-8', nencoding='UTF-8')

cursor = conn.cursor() # 커서 생성

sql = "INSERT INTO product(no, url, img, brand, name, price, currency, admin_id, seller_id, shop_code) VALUES(product_seq.nextval, :1, :2,:3,:4,:5,'EUR', 'admin1','mytheresa', '001')"

cursor.bindarraysize = len(items)
cursor.executemany(sql, items)

conn.commit()
print("커밋완료!")
cursor.close()
conn.close()
