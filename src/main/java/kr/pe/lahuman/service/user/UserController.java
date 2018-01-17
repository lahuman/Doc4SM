package kr.pe.lahuman.service.user;

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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
@Controller
public class UserController {

	@Autowired
	private UserServiceImpl userService;
	
	@RequestMapping(value = "/admin/user.do", method = RequestMethod.GET)
	public String codeMasterView(){
		return "admin/user/list";
	}
	
	@RequestMapping(value = "/admin/user/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		return userService.getList(paramMap);
	}
	
	@RequestMapping(value = "/admin/user/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = userService.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/admin/user/rolelist.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getRoleList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("USER_ID", request.getParameter("USER_ID"));
		return userService.roleList(param);
	}
	
	@RequestMapping(value = "/admin/user/processRole.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processRole(HttpServletRequest request){
		List<DataMap<String, Object>> paramList = new ArrayList<DataMap<String, Object>>();
		
		String[] roleIds = request.getParameterValues("ROLE_ID");
		String userId = request.getParameter("USER_ID");
		if(roleIds == null){
			DataMap<String, Object> data = new DataMap<String, Object>();
			data.put("user_id", userId);
			paramList.add(data);
		}else{
			for(String roleId : roleIds){
				DataMap<String, Object> data = new DataMap<String, Object>();
				data.put("user_id", userId);
				data.put("role_id", roleId);
				paramList.add(data);
			}
				
		}
		
		String message = userService.processRole(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	
	@RequestMapping(value = "/{type}/user/userList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getUserList(HttpServletRequest request){
		return userService.getUserList(null);
	}
}
