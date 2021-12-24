package egovframework.jtLunch.admin.dashboard.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.RestaurantService;

@Controller
public class RestaurantController {
	
	String[] bank = {"카카오뱅크", "농협", "신한", "IBK기업", "하나", "우리", "국민", "SC제일", "대구", "부산", "광주", "새마을금고", 
			 "경남", "전북", "제주", "산업", "우체국", "신협", "수협", "씨티", "케이뱅크", "토스뱅크", "도이치", "BOA", 
			 "BNP", "중국공상", "HSBC ", "JP모간", "산림조합", "저축은행"};
	
	@Autowired
	private RestaurantService restaurantService;
	//식당 관리 페이지
	@RequestMapping(value = "/admin/restaurant", method = RequestMethod.GET)
	public String restaurant(Model model) throws Exception {
		
		List<RestaurantDTO> dto = restaurantService.RestaurantPrint();
		model.addAttribute("restaurant", dto);
		
		return "admin/restaurant/restaurant";
	}
	
	//식당 등록 페이지
	@RequestMapping(value = "/admin/restaurantinsert", method = RequestMethod.GET)
	public String restaurantinsert(Model model) throws Exception {
		
		model.addAttribute("bank", bank);
		
		return "admin/restaurant/restaurantInsert";
	}
	
	//식당 등록 
	@RequestMapping(value = "/admin/restaurantInsert", method = RequestMethod.POST)
	public String restaurantInsert(RestaurantDTO dto, Model model) throws Exception {
		
		
		restaurantService.RestaurantInsert(dto);
		
		return "redirect:/admin/restaurant";
	}
	
	//식당 상세보기
	@RequestMapping(value = "/admin/restaurantdetails", method = RequestMethod.GET)
	public String restaurantdetails(@RequestParam("restaurant_id") String restaurant_id, Model model) throws Exception {
		
		model.addAttribute("restaurant", restaurantService.RestaurantSelect(restaurant_id));
		
		return "admin/restaurant/restaurantDetails";
	}
	
	//식당 수정 페이지
	@RequestMapping(value = "/admin/restaurantupdate", method = RequestMethod.GET)
	public String restaurantupdate(@RequestParam("restaurant_id") String restaurant_id, Model model) throws Exception {
		
		model.addAttribute("bank", bank);
		model.addAttribute("restaurant", restaurantService.RestaurantSelect(restaurant_id));
		
		return "admin/restaurant/restaurantUpdate";
	}
	
	//식당 수정
	@RequestMapping(value = "/admin/restaurantUpdate", method = RequestMethod.POST)
	public String restaurantUpdate(RestaurantDTO dto, Model model) throws Exception {
		
		restaurantService.RestaurantUpdate(dto);
		
		return "redirect:/admin/restaurant";
	}
	
	//식당 삭제
	@RequestMapping(value = "/admin/restaurantDelete", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	@ResponseBody
	public String restaurantDelete(@RequestParam("restaurant_id") String restaurant_id, Model model) throws Exception {
		
		String resultMsg = "";
		
		try {
			restaurantService.RestaurantDelete(restaurant_id);
			resultMsg = "삭제완료";
		} catch(Exception e){
			resultMsg = "삭제실패";
		}
			
		return resultMsg;	
	}
		

}
