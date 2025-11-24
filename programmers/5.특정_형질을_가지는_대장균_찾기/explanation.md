# Explanation: 조건에 부합하는 중고거래 댓글 조회하기

## 1. 접근 아이디어

이 문제의 핵심은 다음 두 가지이다:

1. **2022년 10월에 작성된 게시글만 필터링**
2. 해당 게시글에 연결된 댓글을 JOIN하여 조회

또한, 실무에서는 날짜 필터링 방식이 성능에 큰 차이를 만들기 때문에  
`TO_CHAR` 변환 대신 **범위 조건을 이용한 날짜 비교**가 필수적이다.

---

## 2. 쿼리 구조 분석

### (1) FROM / JOIN  
```
FROM USED_GOODS_BOARD B
JOIN USED_GOODS_REPLY R
    ON B.BOARD_ID = R.BOARD_ID
```
- 게시글(B)과 댓글(R)을 BOARD_ID 기준으로 INNER JOIN  
- 게시글에 댓글이 존재하는 행만 조회됨

---

### (2) WHERE – 날짜 필터링 (성능 핵심)  
```
WHERE B.CREATED_DATE >= DATE '2022-10-01'
  AND B.CREATED_DATE <  DATE '2022-11-01'
```

왜 이렇게 처리하는가?

- `TO_CHAR(B.CREATED_DATE, 'YYYY-MM') = '2022-10'`  
  → 인덱스 사용 불가, 전체 스캔 발생  
- 범위 조건은 **인덱스가 그대로 적용**되므로 실무 SQL에서 가장 권장되는 방식

---

### (3) SELECT – 날짜 포맷 변환  
```
TO_CHAR(R.CREATED_DATE, 'YYYY-MM-DD') AS CREATED_DATE
```
- 날짜 컬럼을 문자열 형식으로 변환  
- 출력 요구사항(YYYY-MM-DD)에 맞게 가공

---

### (4) ORDER BY  
```
ORDER BY R.CREATED_DATE ASC, B.TITLE ASC
```
정렬 기준 2단계:

1. 댓글 작성일 오름차순  
2. 제목 오름차순  

---



## 3. 성능 관점

- 날짜 변환(`TO_CHAR`)을 WHERE 조건에 사용하면 **인덱스가 무효화**됨  
- 범위 조건은 인덱스 사용률을 높여 성능을 크게 개선함  
- JOIN 대상 테이블이 커질수록 날짜 조건 최적화의 효과가 더 커짐  
- 필요하다면 `USED_GOODS_BOARD.CREATED_DATE` 에 인덱스를 생성하면 효과적임:

```
CREATE INDEX idx_board_created_date
ON USED_GOODS_BOARD (CREATED_DATE);
```

---

## 5. 요약

- 날짜 비교는 반드시 **범위 조건**으로 수행  
- 댓글 작성일_FORMAT은 SELECT에서만 변환  
- JOIN + 날짜 필터링 + 정렬 조합의 전형적인 실무형 SQL 문제
