# Explanation: 한 해(2021년)에 잡은 물고기 수 구하기

## 1. 접근 아이디어

이 문제는 `FISH_INFO` 테이블에서 **2021년에 잡힌 물고기 개수를 계산**하는 단순 집계 문제이다.  
핵심은 `TIME` 컬럼의 **자료형(Date / Datetime / String)** 에 따라 연도 필터링 방식이 달라진다는 점이다.

### 핵심 규칙
- 날짜 타입(Date/Datetime) → **범위 조건(Best Practice) 사용**
- 문자열 타입(YYYYMMDD, YYYY-MM-DD) → `'2021%'` 패턴 매칭 사용

---

## 2. 왜 DATE 타입에서는 범위 조건을 써야 하는가?

다음 조건은 직관적이지만 성능 문제가 있다:

```
WHERE TO_CHAR(TIME, 'YYYY') = '2021'
```

문제점:
- 인덱스 사용 불가 → 전체 테이블 스캔 발생  
- 데이터가 수십만/수백만 건이면 심각한 성능 저하

따라서 **DATE 컬럼을 변환하지 않고 그대로 비교하는 범위 조건**이 최적이다.

```
WHERE TIME >= DATE '2021-01-01'
  AND TIME <  DATE '2022-01-01'
```

이 방식의 장점:
- 인덱스 적용 가능  
- 불필요한 함수 연산 없음  
- 연도 단위 필터링에서 가장 안정적  

---

## 3. 문자열 타입일 경우의 처리

만약 TIME이 문자열(예: `'2021-05-03'`, `'20210503'`)이라면,

```
WHERE TIME LIKE '2021%'
```

이 방식이 정확하고 단순하며 성능도 나쁘지 않다.

---

## 4. 최종 SQL (문자열 기준 풀이)

```
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE TIME LIKE '2021%';
```

---

## 5. DATE 타입 기준 Best Practice SQL

```
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE TIME >= DATE '2021-01-01'
  AND TIME <  DATE '2022-01-01';
```

---

## 6. 성능 관점

- DATE 타입에서 범위 필터링은 인덱스를 활용하므로 가장 빠른 방식
- 문자열 LIKE 조건은 TIME이 정규화된 문자열일 때 안전
- 날짜 조작 함수(TO_CHAR/DATE_FORMAT 등)는 인덱스를 무력화하므로 비추

필요 시 인덱스 추가 가능:

```
CREATE INDEX idx_fish_time ON FISH_INFO (TIME);
```

---

