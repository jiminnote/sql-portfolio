# 262. Trips and Users - 해설

## 난이도
Hard

## 핵심 개념
- 다중 JOIN (같은 테이블을 여러 번 JOIN)
- 조건부 집계 (CASE WHEN + SUM/COUNT)
- 날짜 범위 필터링
- ROUND 함수로 소수점 처리

## 접근 방식
1. Trips 테이블에서 client, driver 각각 Users 테이블과 JOIN
2. banned = 'no' 조건으로 유효한 trip만 필터링
3. 날짜별로 GROUP BY 후 취소율 계산
4. 소수점 둘째자리까지 반올림

## 왜 JOIN 조건에 banned 체크를 넣는가?
- WHERE 절보다 JOIN ON 절에서 필터링하면 초기에 불필요한 row 제거
- 성능 최적화에 유리

## 취소율 계산 공식
- cancelled_by_driver, cancelled_by_client 모두 포함
- LIKE 'cancelled%'로 간결하게 처리

## 시간복잡도
O(n) - 단일 스캔 후 집계
