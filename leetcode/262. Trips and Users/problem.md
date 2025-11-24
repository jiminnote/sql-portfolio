# 262. Trips and Users

## 문제 요약
2013-10-01 ~ 2013-10-03 기간 동안  
**정상적인 사용자(client, driver 모두 banned = 'no')가 포함된 Trip** 에 대해  
각 날짜별 **취소율(Cancellation Rate)** 을 계산하는 문제이다.

취소 상태(status):
- 'cancelled_by_driver'
- 'cancelled_by_client'
따라서 status LIKE 'cancelled%' 로 처리할 수 있다.

출력 형식:
- Day: 날짜(request_at)
- Cancellation Rate: (취소된 건수 / 전체 건수)  → 소수점 둘째 자리까지 반올림

---

## 입력 테이블 구조

### Trips
| Column      | Type    |
|-------------|---------|
| id          | int     |
| client_id   | int     |
| driver_id   | int     |
| city_id     | int     |
| status      | varchar |
| request_at  | varchar |

### Users
| Column    | Type    |
|-----------|---------|
| users_id  | int     |
| banned    | varchar ('yes'/'no') |
| role      | varchar ('client'/'driver') |

제약조건:
- client_id → Users.users_id
- driver_id → Users.users_id

---

## 요구사항
- driver와 client 모두 banned = 'no' 인 경우만 valid trip.
- status LIKE 'cancelled%' 인 경우만 "취소"로 카운트.
- 날짜별로 취소율 계산.
- 출력 순서는 날짜 오름차순.

---

## 출력 예시 형식

| Day        | Cancellation Rate |
|------------|--------------------|
| 2013-10-01 | 0.33               |
| 2013-10-02 | 0.00               |
| 2013-10-03 | 0.50               |