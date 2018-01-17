package kr.pe.lahuman.service.statistics;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.lahuman.utils.DataMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import scala.annotation.meta.param;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class StatisticsController {

	@Autowired
	private StatisticsServiceImpl staticsService;
	

	@RequestMapping(value = "/{type}/statistics/event.do", method = RequestMethod.GET)
	public String event(@PathVariable("type")String type){
		return type + "/statistics/event";
	}
	@RequestMapping(value = "/{type}/statistics/service.do", method = RequestMethod.GET)
	public String service(@PathVariable("type")String type){
		return type +"/statistics/service";
	}
	
	@RequestMapping(value = "/{type}/statistics/tagCloud.do", method = RequestMethod.GET)
	public String tagCloud(@PathVariable("type")String type){
		return type +"/statistics/tagCloud";
	}
	
	@RequestMapping(value = "/{type}/statistics/ganttChart.do", method = RequestMethod.GET)
	public String ganttChart(HttpServletRequest request, @PathVariable("type")String type){
		if(request.getParameter("START_DT") != null && request.getParameter("END_DT") != null){
			DataMap<String, Object> param = new DataMap<String, Object>();
			param.put("start_dt", request.getParameter("START_DT"));
			param.put("end_dt", request.getParameter("END_DT"));
			
			request.setAttribute("chartData", staticsService.ganttChart(param));
		}
		return type +"/statistics/ganttChart";
	}
	
	@RequestMapping(value = "/{type}/statistics/ganttChart2.do", method = RequestMethod.GET)
	public String ganttChart2(HttpServletRequest request, @PathVariable("type")String type){
		return type +"/statistics/ganttChart2";
	}
	
	@RequestMapping(value = "/{type}/exclue/statistics/ganttChart2.do", method = RequestMethod.GET)
	public String ganttChart2Pop(HttpServletRequest request, @PathVariable("type")String type){
		return type +"/statistics/ganttChart2Pop";
	}
	

	
	@RequestMapping(value = "/{type}/statistics/ganttChart2.json", method = RequestMethod.POST, 
			produces = "application/json; charset=utf-8")
	public @ResponseBody List<HashMap<String, Object>> ganttChart2(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		response.setContentType("text/plain; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		
			List<HashMap<String, Object>> ganttData = new ArrayList<HashMap<String,Object>>();
			
			List<DataMap<String, Object>> dataList = staticsService.ganttChart2(paramMap);
			
			String procUser = "";
			for(DataMap<String, Object> data : dataList){
				if(procUser.equals(data.getString("proc_user"))){
					HashMap<String, Object> dt = ganttData.get((ganttData.size()-1));
					
					setSeries(data, dt);
					
				}else{
					procUser = data.getString("proc_user");
					
					HashMap<String, Object> dt = new HashMap<String, Object>();
					dt.put("id", data.getString("req_code"));
					dt.put("name", data.getString("proc_user"));
					dt.put("series", new ArrayList<HashMap<String, Object>>());
					
					setSeries(data, dt);
					
					ganttData.add(dt);
				}
			}
			
			return ganttData;
	}
	private void setSeries(DataMap<String, Object> data,
			HashMap<String, Object> dt) {
		HashMap<String, Object> series = new HashMap<String, Object>();
		series.put("name", data.getString("title"));
		series.put("start", data.getString("receipt_dt"));
		series.put("end", data.getString("complete_dt"));
		series.put("color", "#"+data.getString("proc_type"));
		
		((List)dt.get("series")).add(series);
	}
	
	@RequestMapping(value = "/{type}/statistics/tagCloudResult.json", method = RequestMethod.POST, 
			produces = "application/json; charset=utf-8")
	public @ResponseBody List<DataMap<String, Object>> tagCloudResult(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		response.setContentType("text/plain; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		if("".equals(paramMap.getString("SERVICE_ID"))){
			return staticsService.tagCloudService(paramMap);
		}else{
			return staticsService.tagCloudCategory(paramMap);
		}
		
	}
	
	@RequestMapping(value = "/{type}/statistics/exclue/eventResult.do", method = RequestMethod.POST, 
			produces = "application/json; charset=utf-8")
	public @ResponseBody String eventResult(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		List<DataMap<String, Object>> dataList = staticsService.event(paramMap);
		StringBuilder result = makeCSVFormat(paramMap, dataList);
		response.setContentType("text/plain; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		return result.toString();
	}
	@RequestMapping(value = "/{type}/statistics/exclue/serviceResult.do", method = RequestMethod.POST, 
			produces = "application/json; charset=utf-8")
	@ResponseBody
	public List<DataMap<String, Object>> serviceResult(HttpServletRequest request, HttpServletResponse response) throws IOException, ParseException{
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		response.setContentType("text/plain; charset=utf-8");
		response.setCharacterEncoding("UTF-8");
		return staticsService.service(paramMap);
	}
	private StringBuilder makeCSVFormat(DataMap<String, Object> paramMap,
			List<DataMap<String, Object>> dataList) throws ParseException {
		StringBuilder result = new StringBuilder();
		boolean isFirst = true;
		String from = paramMap.getString("START_DT");
		String to = paramMap.getString("END_DT");
		SimpleDateFormat transFormat = new SimpleDateFormat(getFormat(paramMap.getString("type")));
		Calendar fromCal = new GregorianCalendar();
		fromCal.setTime(transFormat.parse(from));
		Calendar toCal = new GregorianCalendar();
		toCal.setTime(transFormat.parse(to));
		
		int f=0;
		DataMap<String, Object> data = null;
		if(dataList.size() > 0)
			data = dataList.get(f++);
		if(isFirst){
			setData(result, "DT", "요청", "변경", "장애", "단순요청");
			result.append("\r\n");
			isFirst = false;
		}
		
		while((fromCal.getTime().compareTo(toCal.getTime())) < 1){
			String dt = transFormat.format(fromCal.getTime());
			if(data.getString("DT").equals(dt)){
				setData(result, data.getString("DT"), data.getString("EV01"), data.getString("EV02"), data.getString("EV03"), data.getString("CALL_CNT"));
				if(f<dataList.size())
					data = dataList.get(f++);
			}else{
				setData(result, dt, "0", "0", "0", "0");	
			}
			result.append("\r\n");
			nextDate(fromCal, paramMap.getString("type"));
		}
		return result;
	}
	
	private final String seperatKey = ",";
	private void setData(StringBuilder result, String dt, String ev01, String ev02, String ev03, String callCnt){
		result.append(dt);
		result.append(seperatKey);
		result.append(ev01);
		result.append(seperatKey);
		result.append(ev02);
		result.append(seperatKey);
		result.append(ev03);
		result.append(seperatKey);
		result.append(callCnt);
	}
	private String getFormat(String type) {
		if("YMD".equals(type)){
			return "yyyyMMdd";
		}else if("YM".equals(type)){
			return "yyyyMM";
		}else if("Y".equals(type)){
			return "yyyy";
		}

		return null;
	}
	private void nextDate(Calendar fromCal, String type) {
		if("YMD".equals(type)){
			fromCal.add(Calendar.DATE, 1);
		}else if("YM".equals(type)){
			fromCal.add(Calendar.MONTH, 1);
		}else if("Y".equals(type)){
			fromCal.add(Calendar.YEAR, 1);
		}
	}
	
}
