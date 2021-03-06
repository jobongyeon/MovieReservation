package kr.co.cinema;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.cinema.dto.BranchDayCount;
import kr.co.cinema.dto.Payment;
import kr.co.cinema.dto.Screen;
import kr.co.cinema.dto.ScreenSchedule;
import kr.co.cinema.dto.Seat;

@Service
public class HomeService {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeService.class);
	
	@Autowired
	private HomeDao homeDao;
	
	//******코드(PK) 생성 시작******
	
	static private String resultCode = "";							// 반환할 코드 초기화
	
	// 코드 생성하는 메서드(비회원,마일리지,한줄평/평점,좌석(다:다))
	public String madeCode(String kind){
		logger.debug("		makeCode(String) 진입");
		
		// DB에서 Code 가져오기
		Map<String, String> map = new HashMap<String, String>();	// Mapper에 parameter값으로 들어갈 맵 생성
		map.put("kind", kind);										// 맵에 "kind"라는 이름으로 들어온 입력값을 put
		String getCode = homeDao.selectOneCode(map);				// db에서 마지막으로 입력된 코드 값 가져오기

		// 현재 날짜 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");		// yyMMdd 형식으로  포맷지정
		Date currentDate = new Date();								// 현재 날짜
		String dDay=sdf.format(currentDate);						// 현재 날자를 yyMMdd로 바꿈
		logger.debug("		makeCode() 현재 날짜 : "+dDay);
		
		String getFirst="";
		String getDate ="";
		String getNum="";
		
		// DB에서 가져온 값이 null일때
		if(getCode==null){
			resultCode = differenceDayCodeMake(dDay,kind);		// 코드 생성
		}else{
			getFirst= getCode.substring(0,2);					// 코드에서 고유번호 추출
			getDate = getCode.substring(2, 8);					// 코드에서 날짜 추출
			getNum= getCode.substring(8);						// 코드에서 숫자 추출	
			
			// 날짜가 같으면
			if(getDate.equals(dDay)){									// 코드에서 추출한 날짜와 현재 날짜 비교 후 같으면
				logger.debug("		makeCode() 날짜 값이 같음");
				int intNum = Integer.parseInt(getNum);					// 코드에서 추출한 숫자를 int형으로 변환
				resultCode =getFirst + getDate 
						+ Integer.toString(intNum+1);					// 숫자 1 증가
			}else{	// 날짜가 다르면
				differenceDayCodeMake(dDay,kind);
			}
		}
		
		
		logger.debug("		makeCode() db에서 가져온 값 : "+getCode+
				",고유번호 : "+getFirst+", 날짜 : "+getDate+", 누적 번호 : "+getNum);
		
		return resultCode;
	}
	
	
		public String differenceDayCodeMake(String dDay,String kind){

			logger.debug("		makeCode() 날짜 값이 다름");
			switch(kind){											// 입력값에 따른 스위치 문
				case "nonMember" :									// 입력값이 nonMember이면
					logger.debug("		makeCode() nonMember");
					resultCode = "13"+dDay+"10001";					// 고유번호 +현재날짜+숫자 초기화
					break;
				case "mileage" :
					logger.debug("		makeCode() mileage");
					resultCode = "14"+dDay+"10001";
					break;
				case "reply" :
					logger.debug("		makeCode() reply");
					resultCode = "31"+dDay+"100001";
					break;
				case "replyRecommend" :
					logger.debug("		makeCode() replyRecommend");
					resultCode = "32"+dDay+"100001";
					break;
				case "seats" :
					logger.debug("		makeCode() seats");
					resultCode = "45"+dDay+"1000001";
					break;
				default : break;
				}
		logger.debug("		makeCode() 반환할 코드 값 : "+resultCode);
		return resultCode;
	}
	
	
	// Object형식으로 받아서 코드 생성하기
		public String madeCode(Object object){
			logger.debug("		makeCode(Object) 진입");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");							// yyMMdd 형식으로  포맷지정
			Date currentDate = new Date();													// 현재 날짜
			String dDay=sdf.format(currentDate);											// 현재 날자를 yyMMdd로 바꿈
			logger.debug("		makeCode() 현재 날짜 : "+dDay);
			
			// 상영관 코드 생성
			if(object instanceof Screen){													// object를 Screen 타입인지 비교
				logger.debug("		makeCode(Object) Screen");
				Screen screen = (Screen) object;											// object를 Screen으로 형변환
				
				Map<String, String> map = new HashMap<String, String>();					// Mapper에 parameter값으로 들어갈 맵 생성
				String getBrcCode=Integer.toString(screen.getBrcCode());					// 입력값에서 brcCode 가져오기 ex)41101
				
				map.put("ScreenBrcCode",getBrcCode);
				
				String getScreenCode = homeDao.selectObjectCode(map);						// brcCode에 해당하는 최신의 screen_code 가져오기  ex)42101101
				if(getScreenCode==null){
					resultCode = "42"+getBrcCode.substring(2,5)+"101";	
				}else{
					String brcNum= getScreenCode.substring(2,5);								// brcCode에서 지점 번호만 추출
					String screenNum = getScreenCode.substring(5);								// screenCode에서 누적 번호 추출
					int resultNum = Integer.parseInt(screenNum)+1;								// 추출한 번호에 +1로 다음번호 생성
					
					System.out.println("brcNum : "+brcNum);
					logger.debug("		makeCode() db에서 가져온 값 : "+getScreenCode+
							",지점 번호 : "+brcNum+", 누적 번호 : "+screenNum);
					
					resultCode = "42"+brcNum+resultNum;		
				}
													// 반환 코드 생성
				logger.debug("		makeCode() 반환될 코드 값 : "+resultCode);
			}
			
			// 지점별 예매/매출 코드 생성
			else if(object instanceof BranchDayCount){
				logger.debug("		makeCode(Object) BranchDayCount");
				BranchDayCount branchDayCount = (BranchDayCount) object;
				
				String getBrcCode=Integer.toString(branchDayCount.getBrcCode());			// 입력값에서 brcCode 가져오기 ex)41101
				
				Map<String, String> map = new HashMap<String, String>();					// Mapper에 parameter값으로 들어갈 맵 생성
				map.put("BDCBrcCode",getBrcCode);
				String getBranchDayCountCode = homeDao.selectObjectCode(map);				// brcCode에 해당하는 최신의 brcCnt_code 가져오기  ex)35101101
				
				// DB에서 가져온 코드가 null일때
				if(getBranchDayCountCode==null){
					resultCode="35"+getBrcCode.substring(2,5)+"101";
				}else{
					String brcNum= getBranchDayCountCode.substring(2,5);						// brcCode에서 지점 번호만 추출
					String branchDayCountNum = getBranchDayCountCode.substring(5);				// getBranchDayCountCode에서 누적 번호 추출
					int resultNum = Integer.parseInt(branchDayCountNum)+1;						// 추출한 번호에 +1로 다음번호 생성
					
					System.out.println("brcNum : "+brcNum);
					logger.debug("		makeCode() db에서 가져온 값 : "+getBranchDayCountCode+
							",지점 번호 : "+brcNum+", 누적 번호 : "+branchDayCountNum);
					
					resultCode = "35"+brcNum+resultNum;			
				}
												// 반환 코드 생성
				logger.debug("		makeCode() 반환될 코드 값 : "+resultCode);
				
			}
			// 상영 일정 코드 생성
			else if(object instanceof ScreenSchedule){
				logger.debug("		makeCode(Object) ScreenSchedule");
				ScreenSchedule screenSchedule = (ScreenSchedule) object;					// object를 ScreenSchedule 타입으로 변경

				String getScreenCode  = screenSchedule.getScrCode();						// 입력값에서 scrCode 가져오기 ex)42101101
				
				Map<String, String> map = new HashMap<String, String>();					// Mapper에 parameter값으로 들어갈 맵 생성
				map.put("srcCode",getScreenCode);
				String getScreenScheduleCode = homeDao.selectObjectCode(map);				// scrCode에 해당하는 최신의 scs_code 가져오기 
				
				if(getScreenScheduleCode==null){											// 기존 코드 없을 경우 새로운 코드 생성
					String scrNum = screenSchedule.getScrCode().substring(2);
					resultCode = "43"+dDay+scrNum+"101";
				}else{
				
					String getFirst = getScreenScheduleCode.substring(0,2);
					String getDate= getScreenScheduleCode.substring(2,8);						// scs_code에서 날짜 추출
					String getScreenNum = getScreenScheduleCode.substring(8,14);				// screen 번호 추출
					String getNum = getScreenScheduleCode.substring(14,17);						// scs_code에서 누적번호 추출
					if(dDay.equals(getDate)){
						logger.debug("		makeCode() 날짜 값이 같음");
						int intNum = Integer.parseInt(getNum);									// 코드에서 추출한 숫자를 int형으로 변환
						resultCode =getFirst + getDate + getScreenNum
								+ Integer.toString(intNum+1);									// 숫자 1 증가
					}else{
						logger.debug("		makeCode() 날짜 값이 다름");
						resultCode = getFirst+dDay+getScreenNum+"101";
					}
				}
			}

			// 좌석 코드 생성
			else if(object instanceof Seat){
				logger.debug("		makeCode(Object) Seat");
				Seat seat = (Seat) object;
				
				Map<String, String> map = new HashMap<String, String>();		// Mapper에 parameter값으로 들어갈 맵 생성
				String getScsCode = seat.getScsCode();
				map.put("SeatScsCode", getScsCode);
				String getSeatCode = homeDao.selectObjectCode(map);
				if(getSeatCode==null){											// 기존 코드 없을 경우 새로운 코드 생성
					String scsNum = seat.getScsCode().substring(8);
					resultCode = "44"+dDay+scsNum+"1001";
				}else{
					
					String getFirst = getSeatCode.substring(0,2);
					String getDate = getSeatCode.substring(2,8);
					String getScsNum = getSeatCode.substring(8,17);
					String getNum = getSeatCode.substring(17);
					
					if(dDay.equals(getDate)){
						logger.debug("		makeCode() 날짜 값이 같음");
						int intNum = Integer.parseInt(getNum);
						resultCode = getFirst+getDate+getScsNum+Integer.toString(intNum+1);
					}
					else{
						logger.debug("		makeCode() 날짜 값이 다름");
						resultCode = getFirst+dDay+getScsNum+"1001";
					}
				}
			}
			
			//결제 코드 생성
			else if(object instanceof Payment){
				logger.debug("		makeCode(Object) Payment");
				Payment payment = (Payment) object;
				String getScsCode = payment.getScsCode();
				
				Map<String, String> map = new HashMap<String, String>();		// Mapper에 parameter값으로 들어갈 맵 생성
				map.put("PaymentScsCode", getScsCode);
				String getPmtCode = homeDao.selectObjectCode(map);
				
				if(getPmtCode == null){											// 기존 코드 없을 경우 새로운 코드 생성
					String scsNum = payment.getScsCode().substring(8);
					resultCode = "51"+dDay+scsNum+"1001";
				}else{
					
					String getFirst = getPmtCode.substring(0, 2);
					String getDate = getPmtCode.substring(2,8);
					String getScsNum = getPmtCode.substring(8,17);
					String getNum = getPmtCode.substring(17);
					
					if(dDay.equals(getDate)){
						logger.debug("		makeCode() 날짜 값이 같음");
						int intNum = Integer.parseInt(getNum);
						resultCode = getFirst+getDate+getScsNum+Integer.toString(intNum+1);
					}
					else{
						logger.debug("		makeCode() 날짜 값이 다름");
						resultCode = getFirst+dDay+getScsNum+"1001";
					}
				}
			}
			
		logger.debug("		makeCode() resultCode : "+resultCode);
		return resultCode;
		}
		

}
