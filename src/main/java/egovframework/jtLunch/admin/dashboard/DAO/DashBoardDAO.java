package egovframework.jtLunch.admin.dashboard.DAO;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

@Repository("dashBoardDAO")
public class DashBoardDAO {
	
	@Autowired
	private SqlSession sqlSession;
	//일별 식수 현황 그래프
	public DashBoardDTO getChartData(Map<String, Object> restaurant_id) throws Exception{
		return sqlSession.selectOne("dashBoard.getChartData", restaurant_id);
	}
	//월별 식수 현황 그래프
	public DashBoardDTO getChartMonth(Map<String, Object> restaurant_id) throws Exception{
		return sqlSession.selectOne("dashBoard.getChartMonth", restaurant_id);
	}
	//월별 식수자 수 
	public int getmonthAte(Map<String, Object> restaurant_id) throws Exception{
		return sqlSession.selectOne("dashBoard.getmonthAte", restaurant_id);
	}
	//사용자 정보 출력
	public List<DashBoardDTO> searchUser() throws Exception{
		return sqlSession.selectList("dashBoard.searchUser");
	}
	//사용자 정보 삭제
	public int deleteUser(String user_id) throws Exception{
		return sqlSession.delete("dashBoard.deleteUser", user_id);
	}
	//식수자 리스트 출력
	public List<DashBoardDTO> printAteUser(DashBoardDTO dto) throws Exception{
		return sqlSession.selectList("dashBoard.printAteUser", dto);
	}
	//사용자 정보 등록
	public int userInsert(DashBoardDTO dto) throws Exception{
		return sqlSession.insert("dashBoard.userInsert", dto);
	}
	//식당 리스트 selectbox로 출력
	public List<RestaurantDTO> restaurantList() throws Exception{
		return sqlSession.selectList("dashBoard.restaurantList");
	}
	//선택한 식당 식수 인원 확인
	public int selectAteUser(String restaurant_id) throws Exception{
		return sqlSession.selectOne("dashBoard.selectAteUser", restaurant_id);
	}
	//사용자 관리 - 사용자 리스트 출력
	public List<DashBoardDTO> usermanage(Map<String, Object> searchList) throws Exception{
		return sqlSession.selectList("usermanagement.usermanage", searchList);
	}
	
	
	///////////////////////////////////////////////////////
	public List<Map<String, Object>> getDepartment() throws Exception {
		return sqlSession.selectList("usermanagement.getDepartment");
	}
	public List<Map<String, Object>> getTeam(String parameter) throws Exception {
		return sqlSession.selectList("usermanagement.getTeam", parameter);
	}
}
