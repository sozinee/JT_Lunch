package egovframework.jtLunch.admin.dashboard.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

@Repository("restaurantDAO")
public class RestaurantDAO {

	@Autowired
	private SqlSession sqlSession;
	//식당관리 페이지
	public List<RestaurantDTO> RestaurantPrint() throws Exception{
		return sqlSession.selectList("restaurant.RestaurantPrint");
	}
	//식당관리 상세보기
	public RestaurantDTO RestaurantSelect(String restaurant_id) throws Exception{
		return sqlSession.selectOne("restaurant.RestaurantSelect", 	restaurant_id);
	}
	//식당 등록
	public int RestaurantInsert(RestaurantDTO dto) throws Exception{
		return sqlSession.insert("restaurant.RestaurantInsert", dto);
	}
	//식당 수정
	public int RestaurantUpdate(RestaurantDTO dto) throws Exception{
		return sqlSession.update("restaurant.RestaurantUpdate", dto);
	}
	//식당 삭제
	public int RestaurantDelete(String 	restaurant_id) throws Exception{
		return sqlSession.delete("restaurant.RestaurantDelete", restaurant_id);
	}
	public int RestaurantCount() {
		return sqlSession.selectOne("restaurant.RestaurantCount");
	}
}
