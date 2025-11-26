# Explanation: LeetCode 3374. First Letter Capitalization II

## 1. 문제 핵심 요약
문자열을 다음 규칙에 따라 **영문 대소문자만 변경**하는 문제이다:

- 각 단어의 **첫 글자는 대문자**, 나머지는 **소문자**
- **하이픈(-)으로 연결된 단어도 부분별 첫 글자만 대문자**
- **공백 및 특수문자는 원래 상태 그대로 유지**

문자열을 단순 분리 후 처리하는 것이 아니라, **문자 단위 분석**과 **문맥(이전 문자) 기반 조건 처리**가 핵심이다.

---

## 2. 접근 전략

### (1) 문자열을 **문자 단위로 분해**
MySQL은 기본적으로 TEXT 파싱 기능이 부족하므로,  
재귀 CTE(Recursive CTE)를 사용해 **문자 하나씩 ROW로 분리**한다.

### (2) 각 문자에 대해 **이전 문자(prev_c)** 를 분석
`LAG()` 윈도우 함수를 사용해,  
현재 문자의 규칙을 결정할 때 **이전 문자가 무엇인지 비교**한다.

### (3) 규칙에 따라 대소문자 변환
CASE 조건으로 변환 규칙을 정의:
- `prev_c`가 공백이면 → 다음 문자는 대문자
- `prev_c`가 '-'이고 현재 문자가 소문자이면 → 대문자
- 이전과 현재가 모두 대문자이면 → 현재 문자만 소문자

### (4) 변환된 문자들을 다시 합치기
`GROUP_CONCAT`으로 문자들을 **위치 순서대로 재조합**하여 하나의 문자열을 만든다.

---

## 3. CTE 구성 설명

### 1) `char_table`: 재귀적으로 문자열을 문자 단위로 분리

```sql
WITH RECURSIVE char_table AS (
  SELECT content_id AS id, content_text AS text, 1 AS pos,
         SUBSTRING(content_text, 1, 1) AS c
  FROM user_content
  
  UNION ALL
  
  SELECT id, text, pos + 1,
         SUBSTRING(text, pos + 1, 1)
  FROM char_table
  WHERE pos + 1 <= LENGTH(text)
)
```
	•	문자열을 pos 위치에 따라 한 글자씩 추출
	•	MySQL에서 문자열 셀을 ROW 형태로 만드는 핵심 단계

### 2) labeled: 이전 문자(prev_c) 부여
```sql
, labeled AS (
  SELECT id, pos, text, c,
         LAG(c) OVER (PARTITION BY id ORDER BY pos) AS prev_c
  FROM char_table
)
```
	•	LAG() 함수로 이전 문자를 가져와 조건 판단 준비
    
### 3) converted: 규칙에 따라 문자 변환
```sql
, converted AS (
  SELECT id, pos, text,
      CASE
          WHEN prev_c IS NULL THEN UPPER(c)
          WHEN prev_c = ' ' THEN UPPER(c)
          WHEN prev_c = '-' AND c REGEXP '[a-z]' THEN UPPER(c)
          WHEN prev_c REGEXP '[A-Z]' AND c REGEXP '[A-Z]' THEN LOWER(c)
          ELSE c
      END AS out_char
  FROM labeled
)
```

