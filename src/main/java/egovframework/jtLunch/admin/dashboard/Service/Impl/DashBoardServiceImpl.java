package egovframework.jtLunch.admin.dashboard.Service.Impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.admin.dashboard.DAO.DashBoardDAO;
import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.DashBoardService;

@Service("dashBoardService")
public class DashBoardServiceImpl implements DashBoardService{
	
	@Resource(name="dashBoardDAO")
	private DashBoardDAO dashBoardDAO;
	
	@Override
	public DashBoardDTO getChartData(Map<String, Object> restaurant_id) throws Exception{
		return dashBoardDAO.getChartData(restaurant_id);
	}
	@Override
	public DashBoardDTO getChartMonth(Map<String, Object> restaurant_id) throws Exception{
		return dashBoardDAO.getChartMonth(restaurant_id);
	}
	@Override
	public int getmonthAte(Map<String, Object> restaurant_id) throws Exception{
		return dashBoardDAO.getmonthAte(restaurant_id);
	}
	@Override
	public List<DashBoardDTO> searchUser() throws Exception{
		return dashBoardDAO.searchUser();
	}
	@Override
	public int deleteUser(String user_id) throws Exception{
		return dashBoardDAO.deleteUser(user_id);
	}
	@Override
	public List<DashBoardDTO> printAteUser(DashBoardDTO dto) throws Exception{
		return dashBoardDAO.printAteUser(dto);
	}
	@Override
	public int userInsert(DashBoardDTO dto) throws Exception{
		return dashBoardDAO.userInsert(dto);
	}
	@Override
	public List<RestaurantDTO> restaurantList() throws Exception {
		return dashBoardDAO.restaurantList();
	}
	@Override
	public int selectAteUser(String restaurant_id) throws Exception {
		return dashBoardDAO.selectAteUser(restaurant_id);
	}
	@Override
	public List<DashBoardDTO> usermanage(Map<String, Object> searchList) throws Exception{
		return dashBoardDAO.usermanage(searchList);
	}
	
	
	
	/////////////////////////////////////////////////////////
	
	public List<Map<String, Object>> getDepartment() throws Exception {
		return dashBoardDAO.getDepartment();
	}
	public List<Map<String, Object>> getTeam(String parameter) throws Exception {
		return dashBoardDAO.getTeam(parameter);
	}
}

