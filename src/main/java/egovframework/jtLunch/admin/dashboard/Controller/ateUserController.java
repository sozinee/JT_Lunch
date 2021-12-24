package egovframework.jtLunch.admin.dashboard.Controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.jtLunch.admin.cmmn.Service.AdminCmmnService;
import egovframework.jtLunch.admin.dashboard.DTO.DashBoardDTO;
import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.DashBoardService;
import egovframework.jtLunch.admin.owner.DTO.DateData;
import egovframework.jtLunch.admin.owner.DTO.SearchResultDTO;
import net.sf.json.JSONArray;

@Controller
public class ateUserController {
	
	@Autowired
	private AdminCmmnService adminCmmnService;
	@Autowired
	private DashBoardService dashBoardService;
	
	//기간별 식수 조회
	@RequestMapping(value = "/admin/ateuserSearch", method = RequestMethod.GET)
	public String ateuserSearch(Model model) throws Exception {
		
		List<RestaurantDTO> restaurant = dashBoardService.restaurantList();
		
		model.addAttribute("restaurant", JSONArray.fromObject(restaurant));
		
		return "admin/printAteuser/ateuserSearch";
	}
	
	@RequestMapping(value = "/admin/totalCountSearch", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView totalCountSearch(HttpServletRequest re, Model model) {	
		
		DecimalFormat decFormat = new DecimalFormat("###,###");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		ModelAndView mv = new ModelAndView("jsonView");
		
		try {
			String startDate = re.getParameter("startDt");
			String endDate = re.getParameter("endDt");
			String restaurant = re.getParameter("restaurant");
			
			DashBoardDTO userdto2 = new DashBoardDTO();
			
			userdto2.setDb_startDate(startDate);
			userdto2.setDb_endDate(endDate);
			userdto2.setRestaurant_id(restaurant);
			
			List<DashBoardDTO> userdto = dashBoardService.printAteUser(userdto2);
			Date sd = format.parse(startDate);
			Date ed = format.parse(endDate);
			ArrayList<String> dates = new ArrayList<String>();
			SearchResultDTO[] ateuserlist = new SearchResultDTO[100];
			List<SearchResultDTO> dto = new ArrayList<SearchResultDTO>();
			Date currentDate = sd;
			
			while (currentDate.compareTo(ed) <= 0) {
				dates.add(format.format(currentDate));
				Calendar c = Calendar.getInstance();
				c.setTime(currentDate);
				c.add(Calendar.DAY_OF_MONTH, 1);
				currentDate = c.getTime();
			}
		
			for(int i=0; i<dates.size(); i++) {
				SearchResultDTO srdto=new SearchResultDTO();
				int ateResult = 0;
				ateResult=adminCmmnService.CountAteTermTable(dates.get(i));
				srdto.setEatDate(dates.get(i));
				srdto.setAteUserCount(ateResult);
				dto.add(i,srdto);
			}
			
			for(int i=0; i<dto.size(); i++) {
				ateuserlist[i] = dto.get(i);
			}
		
			DateData dd = new DateData();
			
			dd.setStartDate(startDate);
			dd.setEndDate(endDate);
			
			int ateUser = 0;
			
			ateUser = adminCmmnService.CountAteTerm(userdto2);
			String money = decFormat.format(ateUser*7000);
			
			mv.addObject("ateUser",ateUser);
			mv.addObject("money",money);
			mv.addObject("result",ateuserlist);
			mv.addObject("searchUser",userdto);
			mv.addObject("msg","검색완료!");
			
		} catch(Exception e){
			mv.addObject("msg","시스템오류 검색실패!");
		}
		
		return mv;
	}
	
	//기간별 정산
	@RequestMapping(value = "/admin/caculate", method = RequestMethod.GET)
	public String calculate(Model model) throws Exception {
		
		List<RestaurantDTO> restaurant = dashBoardService.restaurantList();
		
		model.addAttribute("restaurant", JSONArray.fromObject(restaurant));
		
		return "admin/printAteuser/calculate";
	}
}
