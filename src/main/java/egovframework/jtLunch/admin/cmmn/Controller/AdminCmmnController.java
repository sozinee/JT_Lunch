package egovframework.jtLunch.admin.cmmn.Controller;

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
import egovframework.jtLunch.admin.owner.DTO.SearchResultDTO;

@Controller
//기간별 정산
public class AdminCmmnController {
	@Autowired
	private AdminCmmnService adminCmmnService;
	
	@RequestMapping(value = "/cmmn/totalCalculate", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView totalCalculate(HttpServletRequest re, Model model) throws Exception {	
		
		DecimalFormat decFormat = new DecimalFormat("###,###");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		ModelAndView mv = new ModelAndView("jsonView");
		String startDate = re.getParameter("startDt");
		String endDate = re.getParameter("endDt");
		String restaurant_id = re.getParameter("restaurant"); 
		
		DashBoardDTO dashBoardDTO = new DashBoardDTO();
		
		dashBoardDTO.setDb_startDate(startDate);
		dashBoardDTO.setDb_endDate(endDate);
		dashBoardDTO.setRestaurant_id(restaurant_id);
		
		Date sd = format.parse(startDate);
		Date ed = format.parse(endDate);
		
		List<SearchResultDTO> dates = new ArrayList<SearchResultDTO>();
		SearchResultDTO[] ateuserlist=new SearchResultDTO[100];
		List<SearchResultDTO> dto= new ArrayList<SearchResultDTO>();
		
		Date currentDate = sd;
		
		while (currentDate.compareTo(ed) <= 0) {
			SearchResultDTO ateuserlistdto = new SearchResultDTO();
			ateuserlistdto.setRestaurant_id(restaurant_id);
			ateuserlistdto.setEatDate(format.format(currentDate));
			dates.add(ateuserlistdto);
			
			System.out.println(dates+"asdasdasd");
			Calendar c = Calendar.getInstance();
			c.setTime(currentDate);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDate = c.getTime();
		}
		
		for(int i=0;i<dates.size();i++) {
			SearchResultDTO ateuserlistdto = new SearchResultDTO();
			
			ateuserlistdto.setRestaurant_id(dates.get(i).getRestaurant_id());
			ateuserlistdto.setEatDate(dates.get(i).getEatDate());
			
			int ateResult = 0;
			ateResult = adminCmmnService.CountAteTermTable2(ateuserlistdto);
			
			ateuserlistdto.setAteUserCount(ateResult);
			
			String tmoney = decFormat.format(ateResult*7000);
			ateuserlistdto.setTotalMoney(tmoney);
			
			dto.add(i,ateuserlistdto);
		}
		
		for(int i=0;i<dto.size();i++) {
			ateuserlist[i]=dto.get(i);
		}
		
		int ateUser = adminCmmnService.CountAteTerm(dashBoardDTO);
		String money = decFormat.format(ateUser*7000);
		mv.addObject("ateUser",ateUser);
		mv.addObject("money",money);
		mv.addObject("msg","검색완료!");
		mv.addObject("result",ateuserlist);
		
		return mv;
	}
}
