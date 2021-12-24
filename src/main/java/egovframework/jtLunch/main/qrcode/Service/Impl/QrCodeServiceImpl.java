package egovframework.jtLunch.main.qrcode.Service.Impl;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import egovframework.jtLunch.main.qrcode.DAO.QrCodeDAO;
import egovframework.jtLunch.main.qrcode.DTO.QrCodeDTO;
import egovframework.jtLunch.main.qrcode.Service.QrCodeService;
@Service("qrcodeService")
public class QrCodeServiceImpl implements QrCodeService{
	
	@Inject
	private QrCodeDAO qrcodeDAO;
/*	
	@Override
	public int updateRes(String id) {
		return qrcodeDAO.updateRes(id);
	}
	@Override
	public int insertRes(String id) {
		return qrcodeDAO.insertRes(id);
	}
	@Override
	public int insertnoRes(String id) {
		return qrcodeDAO.insertnoRes(id);
	}	
	@Override
	public int insertnoResate(String id) {
		return qrcodeDAO.insertnoResate(id);
	}	
	@Override
	public ReservationDTO selectRes(String id) {
		return qrcodeDAO.selectRes(id);
	}
*/	
	@Override
	public QrCodeDTO selectCheck(String id) {
		return qrcodeDAO.selectCheck(id);
	}
	@Override
	public int ateuserInsert(Map<String, Object > reqMap) {
		return qrcodeDAO.ateuserInsert(reqMap);
	}	
}
