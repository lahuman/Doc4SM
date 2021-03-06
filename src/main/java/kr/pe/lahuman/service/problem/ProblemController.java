package kr.pe.lahuman.service.problem;

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
public class ProblemController {

	@Autowired
	private ProblemServiceImpl problemService ;
	
	@RequestMapping(value = "/{type}/problem/list.do", method = RequestMethod.GET)
	public String view(@PathVariable("type")String type){
		return type+"/problem/list";
	}
	
	@RequestMapping(value = "/{type}/problem/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return problemService.getList(paramMap);
	}
	

	@RequestMapping(value = "/{type}/problem/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = problemService.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}	
	
	@RequestMapping(value = "/{type}/pop/problemRelation.do", method = RequestMethod.GET)
	public String popup(@PathVariable("type")String type){
		return type+"/problem/pop";
	}
	
	@RequestMapping(value = "/{type}/problem/reationList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getCompanuList(HttpServletRequest request){
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("problem_id", request.getParameter("PROBLEM_ID"));
		return problemService.problemRelationList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/problem/reationProcess.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> reationProcess(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = problemService.mergeRelation(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}	
	
	@RequestMapping(value = "/{type}/problem/eventList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> eventList(HttpServletRequest request){
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("year", request.getParameter("YEAR"));
		return problemService.eventList(paramMap);
	}
}
