package egovframework.jtLunch.main.qrcode.DAO;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.jtLunch.main.qrcode.DTO.QrCodeDTO;

@Repository("qrcodeDAO")
public class QrCodeDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
/*	//예약자 식수 확인 업데이트
	public int updateRes(String id) {
		return sqlSession.update("user.qrupdate", id);
	}
	//QR인식 예약자를 식수자 테이블에 추가
	public int insertRes(String id) {
		return sqlSession.insert("user.ateinsert", id);
	}
	//미예약자 테이블에 추가
	public int insertnoRes(String id) {
		return sqlSession.insert("user.noreserve", id);
	}
	//QR인식 미예약자를 식수자 테이블에 추가
	public int insertnoResate(String id) {
		return sqlSession.insert("user.noreserve_update", id);
	}
	//예약자 테이블에 추가
	public ReservationDTO selectRes(String id) {
		return sqlSession.selectOne("user.rescheck", id);
	}
*/
	//식수자 확인
	public QrCodeDTO selectCheck(String id) {
		return sqlSession.selectOne("user.qrcheck", id);
	}
	//QR코드 인식 한 사람 식수자 테이블에 추가
	public int ateuserInsert(Map<String, Object> reqMap) {
		return sqlSession.insert("user.ateuserInsert", reqMap);
	}

}
