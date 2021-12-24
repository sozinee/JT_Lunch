package egovframework.jtLunch.admin.dashboard.Service;

import java.util.List;
import java.util.Map;

import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

public interface DashBoardService {

	public DashBoardDTO getChartData(Map<String, Object> restaurant_id) throws Exception; 
	
	public DashBoardDTO getChartMonth(Map<String, Object> restaurant_id) throws Exception; 
	
	public int getmonthAte(Map<String, Object> restaurant_id) throws Exception;
	
	public List<DashBoardDTO> searchUser() throws Exception;
	
	public int deleteUser(String user_id) throws Exception;
	
	public List<DashBoardDTO> printAteUser(DashBoardDTO dto) throws Exception;
	
	public int userInsert(DashBoardDTO dto) throws Exception;
	
	public List<RestaurantDTO> restaurantList() throws Exception;
	
	public int selectAteUser(String restaurant_id) throws Exception;
	
	public List<DashBoardDTO> usermanage(Map<String, Object> searchList) throws Exception;
	
	
	
	////////////////////////////////////////////////////////
	public List<Map<String,Object>> getDepartment() throws Exception;
	
	public List<Map<String,Object>> getTeam(String parameter) throws Exception;
	
}
