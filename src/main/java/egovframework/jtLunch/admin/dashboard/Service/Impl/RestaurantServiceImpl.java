package egovframework.jtLunch.admin.dashboard.Service.Impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.admin.dashboard.DAO.RestaurantDAO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.RestaurantService;

@Service("restaurantService")
public class RestaurantServiceImpl implements RestaurantService{
	
	@Resource(name="restaurantDAO")
	private RestaurantDAO restaurantDAO;
	
	@Override
	public List<RestaurantDTO> RestaurantPrint() throws Exception{
		return restaurantDAO.RestaurantPrint();
	}
	@Override
	public RestaurantDTO RestaurantSelect(String restaurant_id) throws Exception{
		return restaurantDAO.RestaurantSelect(restaurant_id);
	}
	@Override
	public int RestaurantInsert(RestaurantDTO dto) throws Exception{
		return restaurantDAO.RestaurantInsert(dto);
	}
	@Override
	public int RestaurantUpdate(RestaurantDTO dto) throws Exception{
		return restaurantDAO.RestaurantUpdate(dto);
	}
	@Override
	public int RestaurantDelete(String restaurant_id) throws Exception{
		return restaurantDAO.RestaurantDelete(restaurant_id);
	}
	@Override
	public int RestaurantCount() throws Exception{
		return restaurantDAO.RestaurantCount();
	}
	
}
