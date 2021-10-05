package kr.kro.globalpay.util;

import java.util.HashMap;
import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

//https://1-7171771.tistory.com/84
/**
 * @class ExampleSend
 * @brief This sample code demonstrate how to send sms through CoolSMS Rest API
 *        PHP 출처 : https://developer.coolsms.co.kr/JAVA_SDK_EXAMPLE_Message
 */
public class SmsUtil {
	private static final String api_key = "NCS8YKZ6UOZBO5QK";
	private static final String api_secret = "3LH7F4ODGADNWLVP30ANIZCRZ1DB9ZMS";

	public static void sendSms(String receiver, String text) {
		Message coolsms = new Message(api_key, api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", receiver); // 수신전화번호
		params.put("from", "01021217514"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", text);
		params.put("app_version", "test app 1.2"); // application name and version
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
		
	}
	
	
//	public static void main(String[] args) {
//
//		Message coolsms = new Message(api_key, api_secret);
//
//		// 4 params(to, from, type, text) are mandatory. must be filled
//		HashMap<String, String> params = new HashMap<String, String>();
//		params.put("to", "01021217514"); // 수신전화번호
//		params.put("from", "01021217514"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
//		params.put("type", "SMS");
//		params.put("text", "이해니 SMS 테스트");
//		params.put("app_version", "test app 1.2"); // application name and version
//
//		try {
//			JSONObject obj = (JSONObject) coolsms.send(params);
//			System.out.println(obj.toString());
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage());
//			System.out.println(e.getCode());
//		}
//	}
}