package kr.pe.lahuman.service.svn;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import kr.pe.lahuman.utils.Constants;
import kr.pe.lahuman.utils.DataMap;
import kr.pe.lahuman.utils.Utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.spockframework.gentyref.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.tmatesoft.svn.core.SVNException;
import org.tmatesoft.svn.core.SVNLogEntry;
import org.tmatesoft.svn.core.SVNLogEntryPath;
import org.tmatesoft.svn.core.SVNURL;
import org.tmatesoft.svn.core.auth.ISVNAuthenticationManager;
import org.tmatesoft.svn.core.internal.io.dav.DAVRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.fs.FSRepositoryFactory;
import org.tmatesoft.svn.core.internal.io.svn.SVNRepositoryFactoryImpl;
import org.tmatesoft.svn.core.io.SVNRepository;
import org.tmatesoft.svn.core.io.SVNRepositoryFactory;
import org.tmatesoft.svn.core.wc.SVNWCUtil;

import com.google.gson.Gson;

@Controller
public class VersionManagerController {

	@Autowired
	private VersionServiceImpl versionService;
	private Logger log = LoggerFactory.getLogger(VersionManagerController.class);
	
	@RequestMapping(value = "/{type}/version/list.do", method = RequestMethod.GET)
	public String list(@PathVariable("type")String type){
		return type + "/version/list";
	}
	@RequestMapping(value = "/{type}/version/pop/showDetail.do", method = RequestMethod.GET)
	public String showDetail(@PathVariable("type")String type){
		return type + "/version/showDetail";
	}
	
	@RequestMapping(value = "/{type}/version/list.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);

		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		SVNRepository repository = null;
		
		//svn 연동 
		String url = Constants.getValue("svn.url");
        String name = Constants.getValue("svn.name");
        String password = Constants.getValue("svn.password");
        long startRevision = 0;
        long endRevision = -1;//HEAD (the latest) revision
        
        try {
			repository = loginSVN(repository, url,
					name, password);
        } catch (SVNException svne) {
            /*
             * Perhaps a malformed URL is the cause of this exception.
             */
            log.info("error while creating an SVNRepository for the location '"
                            + url + "': " + svne.getMessage());
            paramMap.put("COMMENT", "error while creating an SVNRepository for the location '"
                    + url + "': " + svne.getMessage());
            List<DataMap<String, Object>> resultList = new ArrayList<DataMap<String, Object>>();
            resultList.add(paramMap);
            resultMap.put("rows", resultList);
            repository.closeSession();
            return resultMap;
        }

        /*
         * Gets the latest revision number of the repository
         */
        try {
            endRevision = repository.getLatestRevision();
            if("".equals(paramMap.getString("PATH"))){
            	
	            //setTotal
	            resultMap.put("total", endRevision);
	            
	            endRevision = endRevision - paramMap.getInt("offset");
	            if(endRevision < 0){
	            	endRevision = Math.abs(endRevision);
	            	startRevision = 0;
	            }else{
	            	startRevision = endRevision-(paramMap.getInt("rows")-1);
	            	if(startRevision < 0)
	            		startRevision = 0;
	            }
            
            }
            
            
        } catch (SVNException svne) {
        	log.info("error while fetching the latest repository revision: " + svne.getMessage());
			paramMap.put("COMMENT", "error while fetching the latest repository revision: " + svne.getMessage());
			List<DataMap<String, Object>> resultList = new ArrayList<DataMap<String, Object>>();
			resultList.add(paramMap);
			resultMap.put("rows", resultList);
			repository.closeSession();
			return resultMap;
        }
        
        Collection logEntries = null;
        try {
            /*
             * Collects SVNLogEntry objects for all revisions in the range
             * defined by its start and end points [startRevision, endRevision].
             * For each revision commit information is represented by
             * SVNLogEntry.
             * 
             * the 1st parameter (targetPaths - an array of path strings) is set
             * when restricting the [startRevision, endRevision] range to only
             * those revisions when the paths in targetPaths were changed.
             * 
             * the 2nd parameter if non-null - is a user's Collection that will
             * be filled up with found SVNLogEntry objects; it's just another
             * way to reach the scope.
             * 
             * startRevision, endRevision - to define a range of revisions you are
             * interested in; by default in this program - startRevision=0, endRevision=
             * the latest (HEAD) revision of the repository.
             * 
             * the 5th parameter - a boolean flag changedPath - if true then for
             * each revision a corresponding SVNLogEntry will contain a map of
             * all paths which were changed in that revision.
             * 
             * the 6th parameter - a boolean flag strictNode - if false and a
             * changed path is a copy (branch) of an existing one in the repository
             * then the history for its origin will be traversed; it means the 
             * history of changes of the target URL (and all that there's in that 
             * URL) will include the history of the origin path(s).
             * Otherwise if strictNode is true then the origin path history won't be
             * included.
             * 
             * The return value is a Collection filled up with SVNLogEntry Objects.
             */
            logEntries = repository.log(new String[] {paramMap.getString("PATH")}, null,
            		startRevision, endRevision, true, true);

        } catch (SVNException svne) {
        	log.info("error while collecting log information for '"
                    + url + "': " + svne.getMessage());
        	paramMap.put("COMMENT", "error while collecting log information for '"
                    + url + "': " + svne.getMessage());
        	 List<DataMap<String, Object>> resultList = new ArrayList<DataMap<String, Object>>();
             resultList.add(paramMap);
             resultMap.put("rows", resultList);
             repository.closeSession();
        	return resultMap;
        }
        
        

        List<DataMap<String, Object>> rows = new ArrayList<DataMap<String, Object>>();
        SimpleDateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");	
        
        for (Iterator entries = logEntries.iterator(); entries.hasNext();) {
        	DataMap<String, Object> data = new DataMap<String, Object>();
            /*
             * gets a next SVNLogEntry
             */
            SVNLogEntry logEntry = (SVNLogEntry) entries.next();
            /*
             * gets the revision number
             */
            data.put("REVISON", logEntry.getRevision()+"");
            /*
             * gets the author of the changes made in that revision
             */
            data.put("AUTHOR", logEntry.getAuthor());
            /*
             * gets the time moment when the changes were committed
             */
            
            data.put("DATE", df.format(logEntry.getDate()));
            /*
             * gets the commit log message
             */
            data.put("COMMENT", logEntry.getMessage());

            rows.add(data);
        }
        
        Collections.sort(rows, new Comparator<DataMap<String, Object>>() {

			@Override
			public int compare(DataMap<String, Object> arg0,
					DataMap<String, Object> arg1) {
				return arg0.getInt("REVISON")>arg1.getInt("REVISON")?-1:arg0.getInt("REVISON")<arg1.getInt("REVISON")?1:0;
			}
        	
		});
        resultMap.put("rows", rows);
        repository.closeSession();
		return resultMap;
	}
	private SVNRepository loginSVN(SVNRepository repository,
			String url, String name, String password) throws SVNException {
		setupLibrary();
        
    
        /*
         * Creates an instance of SVNRepository to work with the repository.
         * All user's requests to the repository are relative to the
         * repository location used to create this SVNRepository.
         * SVNURL is a wrapper for URL strings that refer to repository locations.
         */
        repository = SVNRepositoryFactory.create(SVNURL.parseURIEncoded(url));
    
        
        /*
         * User's authentication information (name/password) is provided via  an 
         * ISVNAuthenticationManager  instance.  SVNWCUtil  creates  a   default 
         * authentication manager given user's name and password.
         * 
         * Default authentication manager first attempts to use provided user name 
         * and password and then falls back to the credentials stored in the 
         * default Subversion credentials storage that is located in Subversion 
         * configuration area. If you'd like to use provided user name and password 
         * only you may use BasicAuthenticationManager class instead of default 
         * authentication manager:
         * 
         *  authManager = new BasicAuthenticationsManager(userName, userPassword);
         *  
         * You may also skip this point - anonymous access will be used. 
         */
        ISVNAuthenticationManager authManager = SVNWCUtil.createDefaultAuthenticationManager(name, password);
        repository.setAuthenticationManager(authManager);
		return repository;
	}
	
	
	
	@RequestMapping(value = "/{type}/version/showDetail.json", method = RequestMethod.POST)
	public @ResponseBody List<DataMap<String, Object>> getDetailList(HttpServletRequest request){
		DataMap<String, Object> keyword = new DataMap<String, Object>();
		keyword.put("REVISON", request.getParameter("REVISON"));
		
		List<DataMap<String, Object>> rows = getSVNFileInfo(keyword);
		return rows;
	}
	
	public List<DataMap<String, Object>> getSVNFileInfo(
			DataMap<String, Object> keyword) {
		SVNRepository repository = null;
		//svn 연동 
		String url = Constants.getValue("svn.url");
        String name = Constants.getValue("svn.name");
        String password = Constants.getValue("svn.password");
        long startRevision = 0;
        long endRevision = -1;//HEAD (the latest) revision
        
        try {
			repository = loginSVN(repository, url,
					name, password);
        } catch (SVNException svne) {
            /*
             * Perhaps a malformed URL is the cause of this exception.
             */
            log.info("error while creating an SVNRepository for the location '"
                            + url + "': " + svne.getMessage());
            keyword.put("PATH", "error while creating an SVNRepository for the location '"
                    + url + "': " + svne.getMessage());
            List<DataMap<String, Object>> resultList = new ArrayList<DataMap<String, Object>>();
            resultList.add(keyword);
            repository.closeSession();
            return resultList;
        }
        

        //SET REVISON
        endRevision = keyword.getInt("REVISON");
        startRevision = keyword.getInt("REVISON");

        
        Collection logEntries = null;
        try {
            /*
             * Collects SVNLogEntry objects for all revisions in the range
             * defined by its start and end points [startRevision, endRevision].
             * For each revision commit information is represented by
             * SVNLogEntry.
             * 
             * the 1st parameter (targetPaths - an array of path strings) is set
             * when restricting the [startRevision, endRevision] range to only
             * those revisions when the paths in targetPaths were changed.
             * 
             * the 2nd parameter if non-null - is a user's Collection that will
             * be filled up with found SVNLogEntry objects; it's just another
             * way to reach the scope.
             * 
             * startRevision, endRevision - to define a range of revisions you are
             * interested in; by default in this program - startRevision=0, endRevision=
             * the latest (HEAD) revision of the repository.
             * 
             * the 5th parameter - a boolean flag changedPath - if true then for
             * each revision a corresponding SVNLogEntry will contain a map of
             * all paths which were changed in that revision.
             * 
             * the 6th parameter - a boolean flag strictNode - if false and a
             * changed path is a copy (branch) of an existing one in the repository
             * then the history for its origin will be traversed; it means the 
             * history of changes of the target URL (and all that there's in that 
             * URL) will include the history of the origin path(s).
             * Otherwise if strictNode is true then the origin path history won't be
             * included.
             * 
             * The return value is a Collection filled up with SVNLogEntry Objects.
             */
            logEntries = repository.log(new String[] {""}, null,
            		startRevision, endRevision, true, true);

        } catch (SVNException svne) {
        	log.info("error while collecting log information for '"
                    + url + "': " + svne.getMessage());
        	 keyword.put("PATH", "error while collecting log information for '"
                     + url + "': " + svne.getMessage());
             List<DataMap<String, Object>> resultList = new ArrayList<DataMap<String, Object>>();
             resultList.add(keyword);
             repository.closeSession();
             return resultList;
        }
        
        

        List<DataMap<String, Object>> rows = new ArrayList<DataMap<String, Object>>();
        
        for (Iterator entries = logEntries.iterator(); entries.hasNext();) {
        	
            /*
             * gets a next SVNLogEntry
             */
            SVNLogEntry logEntry = (SVNLogEntry) entries.next();

            /*
             * displaying all paths that were changed in that revision; cahnged
             * path information is represented by SVNLogEntryPath.
             */
            if (logEntry.getChangedPaths().size() > 0) {
                /*
                 * keys are changed paths
                 */
                Set changedPathsSet = logEntry.getChangedPaths().keySet();

                for (Iterator changedPaths = changedPathsSet.iterator(); changedPaths
                        .hasNext();) {
                	DataMap<String, Object> data = new DataMap<String, Object>();
                    /*
                     * obtains a next SVNLogEntryPath
                     */
                    SVNLogEntryPath entryPath = (SVNLogEntryPath) logEntry
                            .getChangedPaths().get(changedPaths.next());
                    /*
                     * SVNLogEntryPath.getPath returns the changed path itself;
                     * 
                     * SVNLogEntryPath.getType returns a charecter describing
                     * how the path was changed ('A' - added, 'D' - deleted or
                     * 'M' - modified);
                     * 
                     * If the path was copied from another one (branched) then
                     * SVNLogEntryPath.getCopyPath &
                     * SVNLogEntryPath.getCopyRevision tells where it was copied
                     * from and what revision the origin path was at.
                     */
                    data.put("TYPE", entryPath.getType()+"");
                    data.put("PATH", entryPath.getPath());
                    data.put("DETAIL", ((entryPath.getCopyPath() != null) ? " (from "
                            + entryPath.getCopyPath() + " revision "
                            + entryPath.getCopyRevision() + ")" : ""));
                    
//                    System.out.println(" "
//                            + entryPath.getType()
//                            + "	"
//                            + entryPath.getPath()
//                            + ((entryPath.getCopyPath() != null) ? " (from "
//                                    + entryPath.getCopyPath() + " revision "
//                                    + entryPath.getCopyRevision() + ")" : ""));
                    rows.add(data);
                }
            }
        }
        repository.closeSession();
		return rows;
	}
	
	/*
     * Initializes the library to work with a repository via 
     * different protocols.
     */
    private void setupLibrary() {
        /*
         * For using over http:// and https://
         */
        DAVRepositoryFactory.setup();
        /*
         * For using over svn:// and svn+xxx://
         */
        SVNRepositoryFactoryImpl.setup();
        
        /*
         * For using over file:///
         */
        FSRepositoryFactory.setup();
    }
    
    
    @RequestMapping(value = "/{type}/version/manage.do", method = RequestMethod.GET)
	public String view(@PathVariable("type")String type){
		return type+"/version/manage";
	}


	@RequestMapping(value = "/{type}/version/manage.json", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getManageList(HttpServletRequest request){
		DataMap<String, Object> paramMap = Utils.makePagingMap(request);
		Gson gson = new Gson();
		DataMap<String, Object> keyworkd = gson.fromJson(request.getParameter("param"), new TypeToken<DataMap<String, Object>>(){}.getType());
		if(keyworkd != null)
			paramMap.putAll(keyworkd);
		return versionService.getList(paramMap);
	}
	
	@RequestMapping(value = "/{type}/version/process.do", method = RequestMethod.POST)
	public @ResponseBody DataMap<String, Object> processContract(HttpServletRequest request){
		
		Gson gson = new Gson();
		List<DataMap<String, Object>> paramList = gson.fromJson(request.getParameter("param"), new TypeToken<ArrayList<DataMap<String, Object>>>(){}.getType());
		String message = versionService.process(paramList);
		
		DataMap<String, Object> responseMessage = new DataMap<String, Object>();
		if(!"".equals(message )){
			responseMessage.put(Constants.STATUS, Constants.ERROR);
			responseMessage.put(Constants.MESSAGE, "["+message+"] 처리에 실패 하였습니다. 데이터를 확인 하여 주세요.");
		}else{
			responseMessage.put(Constants.STATUS, Constants.SUCCESS);
		}
		return responseMessage;
	} 

	//5분만다 한번씩 실행 되며, 월요일부터 금요일만 실행된다(주말 제외)
	@Scheduled(cron="0 */5 9-19 * * MON-FRI")
    public void updateVersionInfo()
    {
		
		if("N".equals(Constants.getValue("svn.use"))){
			return;
		}
		
		SVNRepository repository = null;
		
		//svn 연동 
		String url = Constants.getValue("svn.url");
        String name = Constants.getValue("svn.name");
        String password = Constants.getValue("svn.password");
        long startRevision = 0;
        long endRevision = -1;//HEAD (the latest) revision
        
        try {
			repository = loginSVN(repository, url,
					name, password);
        } catch (SVNException svne) {
            /*
             * Perhaps a malformed URL is the cause of this exception.
             */
            log.info("error while creating an SVNRepository for the location '"
                            + url + "': " + svne.getMessage());
            repository.closeSession();
            return;
        }
        
        startRevision = versionService.getLastSVNVersion(null);
        /*
         * Gets the latest revision number of the repository
         */
        try {
            endRevision = repository.getLatestRevision();
            if(endRevision < startRevision){
            	log.info("Already Updated Version Information!");
            	repository.closeSession();
            	return;
            }
        } catch (SVNException svne) {
        	log.info("error while fetching the latest repository revision: " + svne.getMessage());
        	repository.closeSession();
			return ;
        }
        
        Collection logEntries = null;
        try {
            /*
             * Collects SVNLogEntry objects for all revisions in the range
             * defined by its start and end points [startRevision, endRevision].
             * For each revision commit information is represented by
             * SVNLogEntry.
             * 
             * the 1st parameter (targetPaths - an array of path strings) is set
             * when restricting the [startRevision, endRevision] range to only
             * those revisions when the paths in targetPaths were changed.
             * 
             * the 2nd parameter if non-null - is a user's Collection that will
             * be filled up with found SVNLogEntry objects; it's just another
             * way to reach the scope.
             * 
             * startRevision, endRevision - to define a range of revisions you are
             * interested in; by default in this program - startRevision=0, endRevision=
             * the latest (HEAD) revision of the repository.
             * 
             * the 5th parameter - a boolean flag changedPath - if true then for
             * each revision a corresponding SVNLogEntry will contain a map of
             * all paths which were changed in that revision.
             * 
             * the 6th parameter - a boolean flag strictNode - if false and a
             * changed path is a copy (branch) of an existing one in the repository
             * then the history for its origin will be traversed; it means the 
             * history of changes of the target URL (and all that there's in that 
             * URL) will include the history of the origin path(s).
             * Otherwise if strictNode is true then the origin path history won't be
             * included.
             * 
             * The return value is a Collection filled up with SVNLogEntry Objects.
             */
            logEntries = repository.log(new String[] {""}, null,
            		startRevision, endRevision, true, true);

        } catch (SVNException svne) {
        	log.info("error while collecting log information for '"
                    + url + "': " + svne.getMessage());
        	repository.closeSession();
        	return;
        }
		
        for (Iterator entries = logEntries.iterator(); entries.hasNext();) {
        	DataMap<String, Object> data = new DataMap<String, Object>();
            /*
             * gets a next SVNLogEntry
             */
            SVNLogEntry logEntry = (SVNLogEntry) entries.next();
            /*
             * gets the revision number
             */
            data.put("SVN_VERSION", logEntry.getRevision()+"");
            /*
             * gets the author of the changes made in that revision
             */
            data.put("AUTHOR", logEntry.getAuthor());
            /*
             * gets the commit log message
             */
            String comment[] = logEntry.getMessage().split("\\r?\\n");
            
            if(comment.length > 2){
            	if("@".equals(comment[0].substring(0, 1)) || "#".equals(comment[0].substring(0, 1))){
            		//첫번째 라인에 약속된 값이 있을 경우
            		 data.put("KIND_CD", "#".equals(comment[0].substring(0, 1))?"I":"O");
            		 data.put("ID", comment[0].substring(1));
            		//두번째 버젼 정보를 확인
            		if("V".equals(comment[1].substring(0, 1).toUpperCase())){
            			data.put("VERSION", comment[1]);	
            		}
            		versionService.marge(data);
            	}
            }
        }
		repository.closeSession();
    }
}
