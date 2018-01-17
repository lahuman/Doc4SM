package kr.pe.lahuman.service.hello;

import java.util.List;

public interface HelloDao {

//	@Insert("INSERT INTO authors (name, email) VALUES( #{name}, #{email})")
	int insert(AuthorsVO vo) throws Exception;

//	@Delete("DELETE FROM authors")
	void deleteAllData() throws Exception;
	
//	@Select("SELECT id, name, email FROM authors")
	List<AuthorsVO> getList() throws Exception;
}
