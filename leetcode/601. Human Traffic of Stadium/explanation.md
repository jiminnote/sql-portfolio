# Explanation: LeetCode 601. Human Traffic of Stadium

## 1. 문제 핵심 요약
Stadium 방문자 수 중 **people >= 100** 인 날만 고려하고,  
그 날들이 **id 기준으로 3일 이상 연속**일 때  
해당 연속 구간의 모든 기록을 출력하는 문제이다.

이 문제의 핵심은 “연속된 날짜(id)” 구간을 식별하는 것이다.

---

## 2. 접근 전략

### (1) 우선 people >= 100인 행만 필터한다.

### (2) "연속 구간" 탐지 기법
Window Function 기반 연속 그룹화의 대표 패턴:
```sql
id - ROW_NUMBER() OVER (ORDER BY id)
```
예시:  
id 값이 5,6,7,10,11,12 라면

| id | row_number | id - rn | 결과 |
|----|------------|---------|------|
| 5  | 1          | 4       | 그룹 A |
| 6  | 2          | 4       | 그룹 A |
| 7  | 3          | 4       | 그룹 A |
|10  | 4          | 6       | 그룹 B |
|11  | 5          | 6       | 그룹 B |
|12  | 6          | 6       | 그룹 B |

같은 결과값(id - rn)이면 **연속 구간**임을 의미.

---

## 3. CTE 구성 설명

```sql
WITH cte AS (
    SELECT
        s.*,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium s
    WHERE people >= 100
)
```
	- 연속 id마다 같은 grp 값 생성
	- people 조건을 미리 필터링하여 성능 최적화

---

## 4. 3개 이상 연속된 구간 필터링
```sql
WHERE grp IN (
    SELECT grp
    FROM cte
    GROUP BY grp
    HAVING COUNT(*) >= 3
)
```
이 부분이 “연속된 3일 이상” 구간만 추출하는 핵심.

---

## 5. 성능 관점 메모
-	people >= 100 필터를 먼저 적용해 데이터량 감소
- Window Function 계산 비용 감소
- 인덱스: Stadium(id), Stadium(people) 있으면 유리
