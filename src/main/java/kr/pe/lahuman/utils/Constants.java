package kr.pe.lahuman.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class Constants {

	static Properties props = new Properties();

	static{
		InputStream is = Constants.class.getResourceAsStream("/common.properties");
		try {
			props.load(is);
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				is.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String getValue(String key){
		return props.getProperty(key);
	}
	
	public final static String STATUS="STATUS";
	public final static String SUCCESS="SUCCESS";
	public final static String ERROR="ERROR";
	public final static String MESSAGE="MESSAGE";
	
	
}
