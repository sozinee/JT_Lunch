package egovframework.jtLunch.admin.dashboard.DAO;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.admin.dashboard.DTO.OwnerManagementDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

@Repository("ownerManagementDAO")
public class OwnerManagementDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<OwnerManagementDTO> selectOwner() throws Exception{
		return sqlSession.selectList("OwnerManagement.selectOwner");
	}
	
	public OwnerManagementDTO checkID(String id) throws Exception{
		return sqlSession.selectOne("OwnerManagement.checkID", id);
	}
	
	public void ownerJoin(OwnerManagementDTO ownerManagementDTO) throws Exception{
		sqlSession.insert("OwnerManagement.ownerJoin", ownerManagementDTO);
	}
	
	public List<RestaurantDTO> selectRestaurant() throws Exception{
		return sqlSession.selectList("OwnerManagement.selectRestaurant");
	}
}
