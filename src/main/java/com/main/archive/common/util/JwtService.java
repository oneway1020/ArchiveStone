package com.main.archive.common.util;

import java.security.Key;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

@Service
public class JwtService {
	private String secretKey = "secretKey-userInfo-authorization-jwt-manage-token"; // 서명에 사용할 secretKey
	private Key key = Keys.hmacShaKeyFor(secretKey.getBytes());
	
	
    /*
    JWT 생성
    @param m_idx
    @return String
     */
	
	// 로그인 토큰생성 (claim으로 토큰안에 정보 계속 추가가능)
    public String createJwt(int m_idx){
        Date now = new Date();
        return Jwts.builder()
                .setHeaderParam("type","jwt")
                .claim("m_idx", m_idx)
                //.claim("m_level", m_level)
                //.claim("m_id", m_id)
                //.claim("m_name", m_name) 이런식으로 계속 추가 가능
                .setIssuedAt(now)
                .setExpiration(new Date(System.currentTimeMillis()+1*(1000*60*60*24*365))) //발급날짜 계산
                .signWith(key, SignatureAlgorithm.HS256) //signature 부분
                .compact();
        
//         다른 방식으로 토큰 생성
//         Claims claims = Jwts.claims()
//         		.setSubject("토큰이름")
//         		.setIssuedAt(new Date()) // 토큰 생성일 위에방식처럼 now도 씀
//         		.setExpiration(new Date(cal.getTimeInMillis()));		// 만료일 설정
//         claims.put("key", "value");	// 담고 싶은 값 입력
//         
//         String jwt = Jwts.builder().setHeaderParam("typ", "JWT")
//        		 .setClaims(claims)
//        		 .signWith(key, SignatureAlgorithm.HS256)	// 암호화
//        		 .compact();
//         
//         return jwt;
         
    }

    /*
    Header에서 X-ACCESS-TOKEN 으로 JWT 추출
    @return String
     */
    public String getJwt(){
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
        return request.getHeader("X-ACCESS-TOKEN");
    }

    /*
    JWT에서 m_idx 추출
    @return int
    @throws BaseException
     */
    public int getUserIdx() throws Exception{
        //1. JWT 추출
        String accessToken = getJwt();
        if(accessToken == null || accessToken.length() == 0){
            throw new Exception("EMPTY_JWT");
        }

        // 2. JWT parsing
        Jws<Claims> claims;
        try{
            claims = Jwts.parserBuilder()
                    .setSigningKey(key).build()
                    .parseClaimsJws(accessToken);
        } catch (Exception ignored) {
            throw new Exception("INVALID_JWT");
        }

        // 3. m_idx 추출
        return claims.getBody().get("m_idx",Integer.class);
    }
    
    // 토큰의 유효성 + 만료일자 확인
    public boolean validateToken(String jwtToken) {
        try {
            Jws<Claims> claims = Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(jwtToken);
            return !claims.getBody().getExpiration().before(new Date());	// 토큰 유효기간(만료일) 추출해와서 확인
        } catch (Exception e) {
            return false;
        }
    }

}