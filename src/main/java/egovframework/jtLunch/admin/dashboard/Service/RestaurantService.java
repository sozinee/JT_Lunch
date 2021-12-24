package egovframework.jtLunch.admin.dashboard.Service;

import java.util.List;

import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

public interface RestaurantService {
	
	public List<RestaurantDTO> RestaurantPrint() throws Exception;
	
	public RestaurantDTO RestaurantSelect(String restaurant_id) throws Exception;
	
	public int RestaurantInsert(RestaurantDTO dto) throws Exception;
	
	public int RestaurantUpdate(RestaurantDTO dto) throws Exception;
	
	public int RestaurantDelete(String restaurant_id) throws Exception;
	
	public int RestaurantCount() throws Exception;
}
