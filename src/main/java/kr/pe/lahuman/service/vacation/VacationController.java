package kr.pe.lahuman.service.vacation;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.Utils;

import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class VacationController {

	@Autowired
	private VacationServiceImpl vacationService;
	
	
	@RequestMapping(value = "/{type}/vacation.do", method = RequestMethod.GET)
	public String view(@PathVariable("type")String type){
		return type+"/vacation/list";
	}


	@RequestMapping(value = "/{type}/vacation/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return vacationService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/vacation/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processContract(HttpServletRequest request){
		
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		String message = vacationService.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	} 
	
	
	
	@RequestMapping(value = "/{type}/holiday.do", method = RequestMethod.GET)
	public String holidayView(@PathVariable("type")String type){
		return type+"/holiday/list";
	}


	@RequestMapping(value = "/{type}/holiday/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getHolidayList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return vacationService.getHolidayList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/holiday/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> holidayProcessContract(HttpServletRequest request){
		
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		String message = vacationService.holidayProcess(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	} 
}
