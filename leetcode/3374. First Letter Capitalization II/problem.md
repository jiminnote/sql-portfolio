# 3374. First Letter Capitalization II

## 문제 요약
`user_content` 테이블의 문자열을 다음 규칙에 따라 변환하는 SQL 문제이다.

### 변환 규칙
1. **각 단어의 첫 글자는 대문자**, 나머지는 **소문자**로 변환한다.
2. **하이픈(-)** 으로 연결된 경우, **하이픈으로 구분된 각 부분의 첫 글자는 대문자**로 한다.  
   예: `top-rated` → `Top-Rated`
3. **공백 및 특수문자의 위치는 그대로 유지**하고, 수정하는 것은 문자열 내 **영문 대소문자만**이다.

### 출력 요구 사항
- 원본 내용(`original_text`)과 변환된 내용(`converted_text`)을 모두 반환한다.
- content_id 기준으로 출력한다.

---

## 입력 테이블 구조

### user_content
| Column       | Type     |
|--------------|----------|
| content_id   | int      |
| content_text | varchar  |

---

## 조건 정리
- 단어는 공백 혹은 허용된 특수문자로 분리된 **연속된 알파벳** 시퀀스.
- 변환 대상은 오직 알파벳 문자.
- 하이픈(`-`)으로 구성된 복합 단어는 부분별 규칙 적용.
- 공백 및 특수문자는 **모양 그대로 유지**한다.

---

## 출력 예시

| content_id | original_text                   | converted_text                  |
|------------|---------------------------------|---------------------------------|
| 1          | hello world of SQL              | Hello World Of Sql              |
| 2          | the QUICK-brown fox             | The Quick-Brown Fox             |
| 3          | modern-day DATA science         | Modern-Day Data Science         |
| 4          | web-based FRONT-end development | Web-Based Front-End Development |

---

