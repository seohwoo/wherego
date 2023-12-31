package team02.db.land;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class API_used extends Using_API_KEY {
	String api_key;
	BufferedReader bf;
	String result;
	URL url;
	int pageNum;
	int numOfRows;

	private API_used() {

	}

	private static API_used instance = new API_used();

	public static API_used getInstance() {
		return instance;
	}

	public String getCurrentTime() {

		LocalDate currentDate = LocalDate.now();
		// 원하는 형식으로 날짜를 포맷
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String currentTime = currentDate.format(formatter);

		return currentTime;
	}

	public String findSubLocation(String areacode) {
		ArrayList<HashMap<String, String>> location = new ArrayList<HashMap<String, String>>();
		api_key = getEncoding_API_KEY();
		String totalCount = "";
		try {
			url = new URL(
					"https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=50&pageNo=1&MobileOS=ETC&MobileApp=team02&areaCode="
							+ areacode + "&_type=json&serviceKey=" + api_key);

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			totalCount = String.valueOf(body.get("totalCount"));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}// findSubLocation()

	public ArrayList<HashMap<String, String>> findLocation(String areaCode) {
		ArrayList<HashMap<String, String>> location = new ArrayList<HashMap<String, String>>();
		api_key = getEncoding_API_KEY();

		try {
			if (areaCode.equals("")) {
				url = new URL(
						"https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=50&pageNo=1&MobileOS=ETC&MobileApp=team02&_type=json&serviceKey="
								+ api_key);
			} else {
				url = new URL(
						"https://apis.data.go.kr/B551011/KorService1/areaCode1?numOfRows=50&pageNo=1&MobileOS=ETC&MobileApp=team02&areaCode="
								+ areaCode + "&_type=json&serviceKey=" + api_key);
			}
			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			int totalCount = ((Long) body.get("totalCount")).intValue();
			JSONArray item = (JSONArray) items.get("item");
			for (int i = 0; i < totalCount; i++) {
				JSONObject arrItem = (JSONObject) item.get(i);
				HashMap<String, String> area = new HashMap<String, String>();
				area.put("name", arrItem.get("name").toString());
				area.put("code", arrItem.get("code").toString());
				location.add(area);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return location;
	}// findLocation()

	public HashMap<String, String> findTotalCount_NumOfRows(String areaCode, String sigunguCode) {
		HashMap<String, String> values = new HashMap<String, String>();
		api_key = getEncoding_API_KEY();

		try {

			url = new URL("https://apis.data.go.kr/B551011/KorService1/areaBasedSyncList1?serviceKey=" + api_key
					+ "&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=team02&_type=json&showflag=1&listYN=Y&arrange=O&contentTypeId=12&areaCode="
					+ areaCode + "&sigunguCode=" + sigunguCode);
			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject trueResponse = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) trueResponse.get("body");
			values.put("totalCount", (body.get("totalCount").toString()));
			values.put("numOfRows", (body.get("numOfRows").toString()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return values;
	}// findTotalCount_NumberOfRows()

	public ArrayList<HashMap<String, String>> findFestival(String areaCode, String sigunguCode, int pageNum) {
		ArrayList<HashMap<String, String>> festival = new ArrayList<HashMap<String, String>>();
		api_key = getEncoding_API_KEY();
		HashMap<String, String> values = new HashMap<String, String>();
		values = findTotalCount_NumOfRows(areaCode, sigunguCode);
		numOfRows = Integer.parseInt(values.get("numOfRows"));

		try {
			this.pageNum = pageNum;
			url = new URL("https://apis.data.go.kr/B551011/KorService1/areaBasedSyncList1?serviceKey=" + api_key
					+ "&numOfRows=" + numOfRows + "&pageNo=" + pageNum
					+ "&MobileOS=ETC&MobileApp=team02&_type=json&showflag=1&listYN=Y&arrange=O&contentTypeId=12&areaCode="
					+ areaCode + "&sigunguCode=" + sigunguCode);
			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject trueResponse = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) trueResponse.get("body");
			JSONObject items = (JSONObject) body.get("items");
			JSONArray item = (JSONArray) items.get("item");
			numOfRows = Integer.parseInt(values.get("numOfRows"));
			for (int i = 0; i < numOfRows; i++) {
				HashMap<String, String> fesMap = new HashMap<String, String>();
				JSONObject Array_item = (JSONObject) item.get(i);
				fesMap.put("contentid", String.valueOf(Array_item.get("contentid")));
				fesMap.put("areacode", String.valueOf(Array_item.get("areacode")));
				fesMap.put("sigungucode", String.valueOf(Array_item.get("sigungucode")));
				fesMap.put("title", String.valueOf(Array_item.get("title")));
				fesMap.put("addr1", String.valueOf(Array_item.get("addr1")));
				fesMap.put("firstimage", String.valueOf(Array_item.get("firstimage")));
				fesMap.put("cat1", String.valueOf(Array_item.get("cat1")));
				fesMap.put("cat2", String.valueOf(Array_item.get("cat2")));
				fesMap.put("cat3", String.valueOf(Array_item.get("cat3")));
				festival.add(fesMap);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return festival;
	}// findFestival()

	public HashMap<String, String> findRandInfo(String contentid) {
		HashMap<String, String> randInfo = new HashMap<String, String>();
		api_key = getEncoding_API_KEY();

		try {
			url = new URL(
					"https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=team02&_type=json&contentId="
							+ contentid
							+ "&contentTypeId=12&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=N&overviewYN=Y&numOfRows=10&pageNo=1&serviceKey="
							+ api_key);

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			JSONArray item = (JSONArray) items.get("item");
			JSONObject arrItem = (JSONObject) item.get(0);
			randInfo.put("homepage", arrItem.get("homepage").toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return randInfo;
	}// findRandInfo()

	public HashMap<String, String> findDetailRandInfo(String contentid) {
		HashMap<String, String> DetailrandInfo = new HashMap<String, String>();
		api_key = getEncoding_API_KEY();

		try {
			url = new URL(
					"https://apis.data.go.kr/B551011/KorService1/detailIntro1?MobileOS=ETC&MobileApp=team02&_type=json&contentId="
							+ contentid + "&contentTypeId=12&numOfRows=10&pageNo=1&serviceKey=" + api_key);

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			JSONArray item = (JSONArray) items.get("item");
			JSONObject arrItem = (JSONObject) item.get(0);
			DetailrandInfo.put("infocenter", arrItem.get("infocenter").toString());
			DetailrandInfo.put("restdate", arrItem.get("restdate").toString());
			DetailrandInfo.put("expguide", arrItem.get("expguide").toString());
			DetailrandInfo.put("usetime", arrItem.get("usetime").toString());
			DetailrandInfo.put("parking", arrItem.get("parking").toString());
			DetailrandInfo.put("chkbabycarriage", arrItem.get("chkbabycarriage").toString());
			DetailrandInfo.put("chkpet", arrItem.get("chkpet").toString());

		} catch (Exception e) {
			e.printStackTrace();
		}
		return DetailrandInfo;
	}// findDetailRandInfo()

	public HashMap<String, String> findCategory(String cat1, String cat2, String cat3) {
		HashMap<String, String> category = new HashMap<String, String>();
		api_key = getEncoding_API_KEY();

		try {
			url = new URL(
					"https://apis.data.go.kr/B551011/KorService1/categoryCode1?numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=team02&contentTypeId=12&cat1="
							+ cat1 + "&cat2=" + cat2 + "&cat3=" + cat3 + "&_type=json&serviceKey=" + api_key);

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			JSONArray item = (JSONArray) items.get("item");
			JSONObject arrItem = (JSONObject) item.get(0);
			if (arrItem.get("name") == null) {
				category.put("name", null);
			} else {
				category.put("name", String.valueOf(arrItem.get("name")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return category;
	}// findCategory()

	public HashMap<String, String> findXY(String contentid) {
		HashMap<String, String> xyMap = new HashMap<String, String>();
		api_key = getEncoding_API_KEY();

		try {
			url = new URL(
					"https://apis.data.go.kr/B551011/KorService1/detailCommon1?MobileOS=ETC&MobileApp=wherego&_type=json&contentId="
							+ contentid
							+ "&contentTypeId=12&defaultYN=Y&firstImageYN=Y&areacodeYN=Y&catcodeYN=Y&addrinfoYN=Y&mapinfoYN=Y&overviewYN=Y&numOfRows=10&pageNo=1&serviceKey="
							+ api_key);

			bf = new BufferedReader(new InputStreamReader(url.openStream(), "UTF-8"));
			result = bf.readLine();
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
			JSONObject response = (JSONObject) jsonObject.get("response");
			JSONObject body = (JSONObject) response.get("body");
			JSONObject items = (JSONObject) body.get("items");
			JSONArray item = (JSONArray) items.get("item");
			JSONObject arrItem = (JSONObject) item.get(0);
			xyMap.put("mapx", (arrItem.get("mapx").toString()));
			xyMap.put("mapy", (arrItem.get("mapy").toString()));
			xyMap.put("areacode", (arrItem.get("areacode").toString()));
			xyMap.put("sigungucode", (arrItem.get("sigungucode").toString()));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return xyMap;
	}// findXY()

}