import geohash2
import requests
import pymongo
import sys

# 함수로 만들기    
def oneroom(addr):
    
    # 1. 동이름으로 위도 경도 구하기
    url = "https://apis.zigbang.com/search?q={}".format(addr)
    response = requests.get(url)
    lat, lng = response.json()["items"][0]["lat"], response.json()["items"][0]["lng"]
    
    # 2. 위도 경도로 geohash 알아내기
    geohash = geohash2.encode(lat, lng, precision=5) 
    
    # 3. geohash로 매물 리스트 가져오기
    url = "https://apis.zigbang.com/v2/items?\
deposit_gteq=0&domain=zigbang&geohash={}&rent_gteq=0&sales_type_in=전세|월세&service_type_eq=원룸".format(geohash)
    response = requests.get(url)
    items = response.json()["items"]
    ids = [item["item_id"] for item in items]
    
    # 4. id로 매물 정보 가져오기
    url = "https://apis.zigbang.com/v2/items/list"
    params = {
        "domain": "zigbang",
        "withCoalition": "false",
        "item_ids": ids[:900],
    }

    response = requests.post(url, params)
    items = response.json()["items"]
    return [item for item in items if addr in item["address"]]


if len(sys.argv) < 3:
    print("insert addr and collection_name!!!")

datas = oneroom(sys.argv[1].replace("_", " "))
print(datas)

server = pymongo.MongoClient('mongodb://ssac:ssacpw@13.124.137.37:27017/')

db = server.zigbang
collection = db[sys.argv[2]]
collection.insert_many(datas)


