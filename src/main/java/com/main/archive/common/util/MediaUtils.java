package com.main.archive.common.util;

import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;

public class MediaUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(MediaUtils.class);
	
	// static으로 선언되었으므로 프로그램이 실행될 때
	// private static Map<String, MediaType> mediaMap;과
	// static{}(스태틱 블록)은 바로 메모리에 로딩된다.
	private static Map<String, MediaType> mediaMap;
	
	//=====================================================
	// statick block
	// 클래스를 로딩할 때 제일 먼저 실행되는 코드
	//=====================================================
	static {
		mediaMap = new HashMap<String, MediaType>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);
		mediaMap.put("GIF", MediaType.IMAGE_GIF);
		mediaMap.put("PNG", MediaType.IMAGE_PNG);
		
	}
	
	//=====================================================
	// 이미지 파일인지 아닌지 구분하는 메서드
	// 이미지 파일을 업로드하면 썸네일 파일을 만들고, 나머지 파일들은 그냥 업로드한다.(에디터써서 안쓸듯?)
	// getMediaType(String type)을 호출하여
	// 위의 static{}에 있으면 이미지 파일, 아니면 일반 파일이다.
	//=====================================================
	public static MediaType getMediaType(String type) {
		
		// toUpperCase() => 대문자로 변경
		return mediaMap.get(type.toUpperCase());
	}
	//==========================================================
	// 경로를 계산하여 만드는 메서드
	// DecimalFormat("00") : 10보다 작은 경우 자리수를 맞추기 위해서 사용하는 메서드
	// File.separator : File 구분자
	// Windows	: "C:\data\ upload"
	// Linux	: "/home/dooley/upload" 
	//==========================================================
	public static String calculatePath(String uploadPath) {
		
		// 년 월 일 정보를 얻기 위해서 캘린더의 인스턴스를 가져온다.
		Calendar cal = Calendar.getInstance();
		
		// 년도를 구해서 변수에 저장한다.
		String yearPath = File.separator + cal.get(Calendar.YEAR);
		
		// 월을 구해서 변수에 저장한다.
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH) + 1);
		
		// 일을 구해서 변수에 저장한다.
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		// 년원일에 맞게 디렉토리를 생성한다.
		makeDir(uploadPath, yearPath, monthPath, datePath);
		logger.info("calculatePath 입력받은 uploadPath: " + uploadPath);
		logger.info("Data 경로: " + datePath);
		
		// 경로를 리턴한다.
		
		return uploadPath + datePath;
		
	}	// End - public static String calculatePath(String uploadPath)
	
	//==========================================================
	// 디렉토리를 만드는 메서드
	// 가변 사이즈의 매개 변수 마침표 3개(...)
	// String ... 에 uploadPath
	// paths[0]에 yearPath
	// paths[1]에 monthPath
	// paths[2]에 datePath 가 들어오게 된다.
	//==========================================================
	private static void makeDir(String uploadPath, String ...paths) {
		
		// 디렉토리가 이미 존재한다면 만들지 않고 들어간다.
		// paths[paths.length-1] = datePath
		if(new File(paths[paths.length-1]).exists()) {
			return;
		}
		// paths에 있는 모든 정보(년, 월, 일 경로)만큼 반복을 한다.
		// paths에 있는 정보 전체 다 사용
		// paths 하나에 있는 정보를 path 안에 넣고 다음으로...
		for(String path : paths) {
			File dirPath = new File(uploadPath + path);
			if(!dirPath.exists()) {
				dirPath.mkdir();
			}
		}
		
	}	// End - private static void makeDir(String uploadPath, String ...strings paths)

}	// End - public class MediaUtils