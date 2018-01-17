package kr.pe.lahuman.service.hello;

import java.util.List;

public interface HelloService {

	String getData(AuthorsVO vo) throws Exception;

	String insert2Error(AuthorsVO vo) throws Exception;

	String insert(AuthorsVO vo) throws Exception;

	void deleteAllData() throws Exception;

	List<AuthorsVO> getList() throws Exception;

}
