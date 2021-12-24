package egovframework.jtLunch.admin.dashboard.Controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import egovframework.jtLunch.admin.dashboard.DTO.RestaurantDTO;
import egovframework.jtLunch.admin.dashboard.Service.RestaurantService;

@Controller
public class QRmakeController {
	
	@Autowired
	private RestaurantService restaurantService;
	@Autowired
	ServletContext servletContext;
	
	@RequestMapping(value="/admin/qrcodemake", method=RequestMethod.POST, produces = "application/text; charset=utf8") 
	@ResponseBody
	public ModelAndView makeqr(@RequestParam("tel") String tel, @RequestParam("name") String name, HttpServletRequest request, HttpSession session, RestaurantDTO dto, Model model) throws WriterException, IOException {
		
			ModelAndView mv = new ModelAndView("jsonView");
			try {
				String filename = "C:\\JT_QRImage\\" + name + "_" + tel + ".jpg";
				String imgFile = "/filepath/" + name + "_" + tel + ".jpg";
				String num_check = Integer.toString(restaurantService.RestaurantCount());
				
			    // QRCode 색상값
			    int qrcodeColor = 0x00000000; 
			    // QRCode 배경색상값  
			    int backgroundColor = 0xFFFFFFFF; 
			         
			    //QRCode 생성
			    QRCodeWriter qrCodeWriter = new QRCodeWriter();  
			    BitMatrix bitMatrix = qrCodeWriter.encode("jointreeLunch_" + num_check + "_" + tel, BarcodeFormat.QR_CODE, 200, 200);    // 200,200은 width, height
			  
			    MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrcodeColor,backgroundColor); 
			    BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix,matrixToImageConfig); 

			    //파일 경로, 파일 이름 , 파일 확장자에 맡는 파일 생성
			    File temp =  new File(filename);
			    if(!temp.exists()) { 
			    	temp.mkdirs(); 
				}  

			    // ImageIO를 사용하여 파일쓰기 
			    ImageIO.write(bufferedImage, "jpg", temp); 
			    
			    mv.addObject("resultMsg","생성완료");
			    mv.addObject("filename",imgFile);
	
				
			} catch(Exception e){
				mv.addObject("resultMsg","생성실패");
			}
				
			return mv;	
		}
}