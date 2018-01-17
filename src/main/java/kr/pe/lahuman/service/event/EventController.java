package kr.pe.lahuman.service.event;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.pe.lahuman.service.call.CallServiceImpl;
import kr.pe.lahuman.service.user.UserServiceImpl;
import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.Utils;

import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

@Controller
public class EventController {

	@Autowired
	private EventServiceImpl eventService;
	@Autowired
	private CallServiceImpl callService;
	@Autowired
	private UserServiceImpl userService;
	
	
	@RequestMapping(value = "/{type}/event/addEventForm.do")
	public String addEvent(HttpServletRequest request, @PathVariable("type")String type, Principal principal){
			DataMap<String, Object> userInfo =  userService.getName(principal.getName());
			request.setAttribute("user_id", userInfo.getString("user_id"));
			request.setAttribute("name", userInfo.getString("NAME"));
			request.setAttribute("tel", userInfo.getString("TEL"));
		return type+"/event/form";
	}
	
	@RequestMapping(value = "/{type}/event/pop/callForm.do", method = RequestMethod.POST)
	public String callForm(@PathVariable("type")String type){
		return type+"/event/callForm";
	}
	@RequestMapping(value = "/{type}/event/pop/eventForm.do", method = RequestMethod.POST)
	public String eventForm(@PathVariable("type")String type){
		return type+"/event/eventForm";
	}
	
	
	@RequestMapping(value = "/{type}/event/addEvent.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> process(HttpServletRequest request){
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		
		
		String message = "";
		int resultCnt = 0;
		if("event".equals(paramMap.getString("TYPE"))){
			resultCnt = eventService.marge(paramMap);
		}else{
			//call 용으로 데이터 변경
			paramMap.put("CONTENTS", paramMap.getString("REQ_TITLE"));
			paramMap.put("START_DT", paramMap.getString("REQ_DT"));
			resultCnt = callService.marge(paramMap);
		}
		
		if(resultCnt < 1){
			message = paramMap.getString("REQ_TITLE");
		}
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	
	
	@RequestMapping(value = "/{type}/event/event.do", method = RequestMethod.GET)
	public String event(@PathVariable("type")String type){
		return type+"/event/list";
	}
	
	@RequestMapping(value = "/{type}/event/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		
		paramMap.put("sort", request.getParameter("sort"));
		paramMap.put("order", request.getParameter("order"));
		return eventService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/event/pop/processEvent.do")
	public String processEvent(@PathVariable("type")String type, Principal principal, HttpServletRequest request){
		DataMap<String, Object> userInfo =  userService.getName(principal.getName());
		
		request.setAttribute("user_id", userInfo.getString("user_id"));
		return type+"/event/processForm";
	}

	///{type}/event/read.json
	@RequestMapping(value = "/{type}/event/read.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getRead(HttpServletRequest request){
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		return eventService.getRead(paramMap);
	}
	@RequestMapping(value = "/{type}/event/pop/EV00Form.do", method = RequestMethod.POST)
	public String processForm(@PathVariable("type")String type){
		return type+"/event/EV00Form";
	}
	@RequestMapping(value = "/{type}/event/pop/EV01Form.do", method = RequestMethod.POST)
	public String serviceForm(@PathVariable("type")String type){
		return type+"/event/EV01Form";
	}
	@RequestMapping(value = "/{type}/event/pop/EV02Form.do", method = RequestMethod.POST)
	public String changeForm(@PathVariable("type")String type){
		return type+"/event/EV02Form";
	}
	@RequestMapping(value = "/{type}/event/pop/EV03Form.do", method = RequestMethod.POST)
	public String obstacleForm(@PathVariable("type")String type){
		return type+"/event/EV03Form";
	}
	
	
	
	@RequestMapping(value = "/{type}/event/pop/doFileUpload.do", method = RequestMethod.GET)
	public String doFileUpload(@PathVariable("type")String type){
		return type+"/event/fileuploadForm";
	}
	
	@RequestMapping(value = "/{type}/event/pop/doFileUploadResult.do", method = RequestMethod.GET)
	public String doFileUploadResult(@PathVariable("type")String type){
		return "fileuploadResult";
	}
	
	
	private String FILE_SEPARATOR = "/";
	@RequestMapping(value = "/{type}/event/pop/doFileUpload.do",headers = "content-type=multipart/*", method = RequestMethod.POST)
	public String doFileUpload(@PathVariable("type")String type, @RequestParam("file") MultipartFile file,
			@RequestParam("REQ_CODE") String reqCode,@RequestParam("TYPE") String fileType, HttpServletResponse response) throws IOException {
		DataMap<String, Object> paramMap = new DataMap<String, Object>();
		paramMap.put("REQ_CODE", reqCode);
		
//		response.getOutputStream().write("<!DOCTYPE html><html><head>".getBytes());
//		response.getOutputStream().write("<script type=\"text/javascript\">".getBytes());
		// file upload
		String fileName = null;
		if (!file.isEmpty()) {
			try {
				File folder = new File(Constants.getValue("file.upload.path")
						+ Calendar.getInstance().get(Calendar.YEAR)
						+ File.separator);
				if (!folder.exists() || !folder.isDirectory()) {
					folder.mkdirs();
				}
				fileName = ("undefined".equals(reqCode)?"":reqCode)+"_"+file.getOriginalFilename();
				byte[] bytes = file.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(
						new FileOutputStream(new File(folder.getAbsolutePath()
								+ File.separator + fileName)));
				buffStream.write(bytes);
				buffStream.close();
				paramMap.put(fileType,
						Calendar.getInstance().get(Calendar.YEAR)
								+ FILE_SEPARATOR + fileName);

			} catch (Exception e) {
//				response.getOutputStream().write("alert('ERROR!!'); history.back();</script>".getBytes());
//				response.getOutputStream().flush();
//		    	response.getOutputStream().close();
//		    	response.flushBuffer();
		    	return "redirect:/"+type+"/event/pop/doFileUploadResult.do?result=ERROR";
			}
		} else {
//			response.getOutputStream().write("alert('FILE NOT FOUND!'); history.back();</script>".getBytes());
//			response.getOutputStream().flush();
//	    	response.getOutputStream().close();
//	    	response.flushBuffer();
			return "redirect:/"+type+"/event/pop/doFileUploadResult.do?result="+URLEncoder.encode("FILE NOT FOUND!","UTF-8");
		}
		
		eventService.changeAttachFile(paramMap);
		
//		response.getOutputStream().write(("alert('FILE UPLOAD SECUSS.'); opener.setFileName('"+URLEncoder.encode(paramMap.getString(fileType),"UTF-8")+"'); window.close();</script>").getBytes());
//		response.getOutputStream().write("</head></html>".getBytes());
//		response.getOutputStream().flush();
//    	response.getOutputStream().close();
//    	response.flushBuffer();
		
		return "redirect:/"+type+"/event/pop/doFileUploadResult.do?result="+URLEncoder.encode("FILE UPLOAD SECUSS.","UTF-8")+"&fileName="+URLEncoder.encode(paramMap.getString(fileType),"UTF-8");
	}
	@RequestMapping(value = "/{type}/event/processEvent.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processEvent(HttpServletRequest request){
		Gson gson = new Gson();
		DataMap<String, Object> paramMap = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		//file_name 관련 처리
		if("- 삭제 -".equals(paramMap.getString("FILE_NAME"))){
			paramMap.put("FILE_NAME", "-");
		}else{
			paramMap.put("FILE_NAME", "");
		}
		
		if("- 삭제 -".equals(paramMap.getString("REQ_FILE"))){
			paramMap.put("REQ_FILE", "-");
		}
		
		
		try{
			eventService.processEvent(paramMap);
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}catch(Exception e){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+e.getMessage()+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}
		return responseMessage;
	}
	
	
	@RequestMapping(value = "/{type}/event/attattachFile.do",method = RequestMethod.GET)
    public void doDownload(@RequestParam("REQ_CODE") String REQ_CODE,
    		@RequestParam("TYPE") String fileType, 
    		HttpServletRequest request,
            HttpServletResponse response) throws Exception {
    	DataMap<String, Object> paramMap = new DataMap<String, Object>();
    	paramMap.put("REQ_CODE", REQ_CODE);
    	DataMap<String, Object> resultMap = (DataMap<String, Object>) eventService.getRead(paramMap);
    	
    	if("".equals(resultMap.getString(fileType)) || "-".equals(resultMap.getString(fileType))){
    		return;
    	}
    	
    	File file = new File(Constants.getValue("file.upload.path") + eventService.getRead(paramMap).get(fileType));
    	
        ServletContext context = request.getServletContext();
        // get MIME type of the file
        String mimeType = context.getMimeType(file.getAbsolutePath());
        if (mimeType == null) {
            // set to binary type if MIME mapping not found
            mimeType = "application/octet-stream";
        }
 
       final int DEFAULT_BUFFER_SIZE = 4096;
	   BufferedOutputStream bufferedOutputStream = null;
	   BufferedInputStream bufferedInputStream = null;

		try {
			bufferedInputStream = new BufferedInputStream(new FileInputStream(
					file), DEFAULT_BUFFER_SIZE);
			response.reset();
//			response.setContentType("application/force-download");
			response.setContentLength((int) file.length());
			// set content attributes for the response
	        response.setContentType(mimeType);
	 
	        // set headers for the response
	        String headerKey = "Content-Disposition";
	        String headerValue = String.format("attachment; filename=\"%s\"",
	        		URLEncoder.encode(file.getName(),"UTF-8"));
	        response.setHeader(headerKey, headerValue);
	        
			
			bufferedOutputStream = new BufferedOutputStream(response
					.getOutputStream(), DEFAULT_BUFFER_SIZE);
			byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
			int length;
			while ((length = bufferedInputStream.read(buffer)) > 0) {
				bufferedOutputStream.write(buffer, 0, length);
			}
			// Finalize task.
			bufferedOutputStream.flush();
		} finally {
			// Gently close streams.
			bufferedOutputStream.close();
			bufferedInputStream.close();
		}

    }	
	
	@RequestMapping(value = "/{type}/event/changeStatus.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> changeStatus(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = eventService.changeStatus(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/{type}/singleUpload.do")
	public String singleUpload() {
		return "singleUpload";
	}

	@RequestMapping(value = "/{type}/multipleUpload.do")
	public String multiUpload() {
		return "multipleUpload";
	}

	@RequestMapping(value = "/{type}/singleSave.do", method = RequestMethod.POST)
	public @ResponseBody
	String singleSave(@RequestParam("file") MultipartFile file,
			@RequestParam("desc") String desc) {
		String fileName = null;
		if (!file.isEmpty()) {
			try {
				fileName = file.getOriginalFilename();
				byte[] bytes = file.getBytes();
				BufferedOutputStream buffStream = new BufferedOutputStream(
						new FileOutputStream(new File(Constants.getValue("file.upload.path") + fileName)));
				buffStream.write(bytes);
				buffStream.close();
				return "You have successfully uploaded " + fileName;
			} catch (Exception e) {
				return "You failed to upload " + fileName + ": "
						+ e.getMessage();
			}
		} else {
			return "Unable to upload. File is empty.";
		}
	}

	@RequestMapping(value = "/{type}/multipleSave.do", method = RequestMethod.POST)
	public @ResponseBody
	String multipleSave(@RequestParam("file") MultipartFile[] files) {
		String fileName = null;
		String msg = "";
		if (files != null && files.length > 0) {
			for (int i = 0; i < files.length; i++) {
				try {
					fileName = files[i].getOriginalFilename();
					byte[] bytes = files[i].getBytes();
					BufferedOutputStream buffStream = new BufferedOutputStream(
							new FileOutputStream(new File(Constants.getValue("file.upload.path") + fileName)));
					buffStream.write(bytes);
					buffStream.close();
					msg += "You have successfully uploaded " + fileName
							+ "<br/>";
				} catch (Exception e) {
					return "You failed to upload " + fileName + ": "
							+ e.getMessage() + "<br/>";
				}
			}
			return msg;
		} else {
			return "Unable to upload. File is empty.";
		}
	}
	
	
	@RequestMapping(value = "/{type}/event/pop/commentList.do", method = RequestMethod.GET)
	public String commentList(HttpServletRequest request, @PathVariable("type")String type, Principal principal){
		DataMap<String, Object> userInfo =  userService.getName(principal.getName());
		request.setAttribute("user_id", userInfo.getString("user_id"));	
		return type+"/event/commentList";
	}
	
	@RequestMapping(value = "/{type}/event/commentChange.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> commentChange(HttpServletRequest request){
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		
		String message = eventService.commentChange(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	}
	
	@RequestMapping(value = "/{type}/event/commentList.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getCommentList(HttpServletRequest request){
		DataMap<String, Object> param = new DataMap<String, Object>();
		param.put("REQ_CODE", request.getParameter("REQ_CODE"));
		return eventService.getCommentList(param);
	}
	
}
