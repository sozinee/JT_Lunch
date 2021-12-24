package egovframework.jtLunch.admin.cmmn.DAO;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.owner.DTO.SearchResultDTO;

@Repository("AdminCmmnDAO")
public class AdminCmmnDAO {
	@Inject
	SqlSession sqlSession;

	public int CountAteTerm(DashBoardDTO dashBoardDTO) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CheckAteUser.CountAteTerm",dashBoardDTO);
	}
	public int CountAteTermTable(String ate_Date){
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CheckAteUser.CountAteTermTable",ate_Date);
	}
	
	public int CountAteTermTable2(SearchResultDTO searchResultDTO){
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CheckAteUser.CountAteTermTable2",searchResultDTO);
	}
}
