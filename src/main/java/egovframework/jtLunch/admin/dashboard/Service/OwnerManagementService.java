package egovframework.jtLunch.admin.dashboard.Service;

import java.util.List;

import egovframework.jtLunch.admin.dashboard.DTO.OwnerManagementDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;

public interface OwnerManagementService {
	
	public List<OwnerManagementDTO> selectOwner() throws Exception;
	
	public OwnerManagementDTO checkID(String id) throws Exception;
	
	public void ownerJoin(OwnerManagementDTO ownerManagementDTO) throws Exception;
	
	public List<RestaurantDTO> selectRestaurant() throws Exception;
}
