# Explanation: 잔챙이 잡은 수 구하기

## 1. 접근 아이디어

이 문제의 핵심은 “길이가 10cm 이하인 물고기”를 어떻게 판별할 것인가이다.  
`FISH_INFO` 테이블에서 **LENGTH가 NULL이면 10cm 이하**로 간주하도록 정의되어 있다.

즉, 조건 해석은 다음과 같다.

- LENGTH > 10 → 실제 길이 저장됨  
- LENGTH ≤ 10 → DB에서 NULL 로 저장됨  
- 따라서, **10cm 이하 물고기 = LENGTH IS NULL**

길이가 저장되어 있지 않다는 것은 실제 길이가 10cm 이하인 잔챙이라는 의미이므로, 단순히 `LENGTH IS NULL` 조건을 만족하는 행의 개수를 세면 된다.

---

## 2. 쿼리 구조 설명

### (1) FROM
```
FROM FISH_INFO
```
문제에서 요구하는 모든 데이터는 `FISH_INFO` 테이블에 있음.

---

### (2) WHERE
```
WHERE LENGTH IS NULL
```

핵심 조건.  
길이가 10cm 이하인 물고기만 필터링하는 조건이며 문제 정의 그대로 반영.

---

### (3) SELECT
```
SELECT COUNT(*) AS FISH_COUNT
```

조건에 맞는 모든 행의 수를 카운트하여 결과 컬럼명을 `FISH_COUNT` 로 지정.

---

## 3. 최종 SQL

```
SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE LENGTH IS NULL;
```

---

## 4. 성능 관점

- `LENGTH` 컬럼의 NULL 여부만 체크하므로 인덱스 도움은 제한적  
- 매우 큰 테이블이라면 Partial Index 고려 가능:

```
CREATE INDEX idx_fish_length_null 
ON FISH_INFO (LENGTH) 
WHERE LENGTH IS NULL;
```


