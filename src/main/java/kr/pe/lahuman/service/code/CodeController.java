package kr.pe.lahuman.service.code;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.Utils;

import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

@Controller
public class CodeController {

	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "/admin/codeMaster.do", method = RequestMethod.GET)
	public String codeMasterView(){
		return "admin/code/codeMasterView";
	}
	
	@RequestMapping(value = "/admin/codeMaster/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getMasterList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		return codeService.getCodeMasterList(paramMap);
	}

	@RequestMapping(value = "/admin/codeMaster/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processCodeMaster(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = codeService.processCodeMaster(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/admin/code.do", method = RequestMethod.GET)
	public String codeView(){
		return "admin/code/codeView";
	}
	
	@RequestMapping(value = "/admin/code/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getCodeList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		return codeService.getCodeList(paramMap);
	}
	
	@RequestMapping(value = "/admin/code/allList.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getCodeAllList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("code_master", request.getParameter("CODE_MASTER"));
		return codeService.getCodeList(param);
	}

	@RequestMapping(value = "/{type}/code/codeList.json", method = RequestMethod.POST)
	public @ResponseBody  List<DataMap<String, Object>> getComboCodeList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("code_master", request.getParameter("CODE_MASTER"));
		return codeService.getComboCodeList(param);
	}
	
	@RequestMapping(value = "/admin/code/comboCodeMaster.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getcomboCodeMaster(HttpServletRequest request){
		return codeService.getComboCodeMaster(null);
	}

	@RequestMapping(value = "/admin/code/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processCode(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = codeService.processCode(paramList);
		
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
