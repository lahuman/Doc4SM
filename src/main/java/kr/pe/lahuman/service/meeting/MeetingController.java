package kr.pe.lahuman.service.meeting;

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
public class MeetingController {

	@Autowired
	private MeetingServiceImpl meetingService;
	
	@RequestMapping(value = "/{type}/meet/list.do", method = RequestMethod.GET)
	public String list(@PathVariable("type")String type){
		return type+"/meeting/list";
	}

	@RequestMapping(value = "/{type}/meet/pop/form.do", method = RequestMethod.GET)
	public String form(@PathVariable("type")String type){
		return type+"/meeting/form";
	}
	
	@RequestMapping(value = "/{type}/meet/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		
		paramMap.put("sort", request.getParameter("sort"));
		paramMap.put("order", request.getParameter("order"));
		
		return meetingService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/meet/view.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getView(HttpServletRequest request){
//		Gson gson = new Gson();
//		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("id", request.getParameter("ID"));
		return meetingService.getRead(paramMap);
	}
	
	
	@RequestMapping(value = "/{type}/meet/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = meetingService.process(paramList);
		
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
