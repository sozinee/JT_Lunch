package egovframework.jtLunch.main.qrcode.Service;

import java.util.Map;

import egovframework.jtLunch.main.qrcode.DTO.QrCodeDTO;

public interface QrCodeService {
/*
	public int updateRes(String id);
	
	public int insertRes(String id);

	public int insertnoRes(String id);
	
	public int insertnoResate(String id);
	
	public ReservationDTO selectRes(String id);
*/	
	public QrCodeDTO selectCheck(String id);

	public int ateuserInsert(Map<String, Object> reqMap);

}
