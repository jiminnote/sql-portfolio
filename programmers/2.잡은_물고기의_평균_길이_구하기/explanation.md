# Explanation: 잡은 물고기의 평균 길이 구하기

## 1. 접근 아이디어

`FISH_INFO` 테이블에서 물고기의 평균 길이를 계산할 때 중요한 규칙은 다음과 같다:

- **LENGTH 값이 NULL이면 → 10cm로 간주한다.**
- LENGTH 값이 있는 경우 → 실제 값을 그대로 사용한다.
- 이후 모든 물고기의 길이를 반영해 평균을 계산하고, 결과는 소수점 둘째 자리까지 반올림한다.

SQL에서는 `COALESCE(LENGTH, 10)` 을 사용하면 NULL을 10으로 대체할 수 있으므로  
문제 규칙과 정확히 일치하는 가장 명확하고 단순한 접근 방식이다.

---

## 2. 쿼리 구조 분석

### (1) NULL 처리
```
COALESCE(LENGTH, 10)
```
- NULL → 10  
- NOT NULL → LENGTH 값 그대로  
- 문제의 핵심 규칙을 직접 반영

---

### (2) 평균 계산
```
AVG(COALESCE(LENGTH, 10))
```
- NULL 값이 제거되지 않도록 반드시 `COALESCE` 를 AVG 내부에서 수행해야 한다.
- 그렇지 않으면 NULL 값이 자동으로 제외되기 때문에 문제 조건이 깨진다.

---

### (3) 반올림 처리
```
ROUND(…, 2)
```
- 결과를 소수점 둘째 자리까지 반올림  
- 문제의 출력 요구사항을 충족

---

## 3. 최종 SQL

```
SELECT ROUND(AVG(COALESCE(LENGTH, 10)), 2) AS AVERAGE_LENGTH
FROM FISH_INFO;
```

---

## 4. 성능 관점

- COALESCE는 매우 가벼운 연산이며 인덱스를 크게 방해하지 않는다.
- AVG는 전체 스캔이 필요하므로 큰 테이블에서는 비용이 발생할 수 있다.
- NULL이 많은 경우 다음과 같은 부분 인덱스로 일부 성능을 높일 수 있다:

```
CREATE INDEX idx_fish_length_notnull
ON FISH_INFO (LENGTH)
WHERE LENGTH IS NOT NULL;
```


---

