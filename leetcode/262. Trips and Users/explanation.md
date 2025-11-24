# Explanation: LeetCode 262. Trips and Users

## 1. 문제 핵심 요약
2013-10-01 ~ 2013-10-03 동안의 trip 데이터를 기반으로  
각 날짜별 **취소율(Cancellation Rate)** 을 계산하는 문제이다.

중요 조건:
- client와 driver 모두 banned = 'no' 여야 valid trip.
- status LIKE 'cancelled%' → 모든 취소 상태 포함.
- 소수점 둘째자리까지 반올림 처리.

---

## 2. 접근 방식

### (1) banned 체크
Users 테이블에서 driver/client 닉 구분 없이 모두 banned='no' 조건을 JOIN 에 직접 명시해야 한다.

```sql
JOIN Users u_client ON t.client_id = u_client.users_id AND u_client.banned = 'no'
JOIN Users u_driver ON t.driver_id = u_driver.users_id AND u_driver.banned = 'no'
```

### (2) 취소 여부 계산

status 컬럼은 다음과 같이 구성될 수 있다:
	•	cancelled_by_driver
	•	cancelled_by_client

따라서 LIKE ‘cancelled%’ 로 처리하는 것이 가장 정확하고 안전하다.

```sql
Cancellation Rate = (취소된 Trip 수) / (전체 Trip 수)
```
## 3. 성능 관점

핵심 인덱스
	•	Users(users_id, banned)
	•	Trips(request_at, client_id, driver_id)

JOIN 필터링을 ON 절에서 수행해 불필요한 row를 초기에 제거하므로 효율적이다.