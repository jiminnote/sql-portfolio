# 언어별 개발자 분류하기 (SQL 코딩테스트)
https://school.programmers.co.kr/learn/courses/30/lessons/276036#
## 문제 개요

`SKILLCODES` 테이블과 `DEVELOPERS` 테이블을 이용해  
각 개발자의 보유 기술을 비트마스크로 판별하고,  
조건에 맞춰 **등급(GRADE)을 부여하여 조회**하는 문제입니다.

---

## 테이블 구조

### SKILLCODES

각 프로그래밍 언어(스킬)에 대해 이름, 분류, 비트 코드 정보를 저장합니다.  
`CODE` 는 2의 제곱수로 구성되며, 여러 스킬을 하나의 정수로 조합할 수 있습니다.

| NAME | TYPE | UNIQUE | NULLABLE |
|------|------|---------|-----------|
| NAME | VARCHAR(N) | Y | N |
| CATEGORY | VARCHAR(N) | N | N |
| CODE | INTEGER | Y | N |

---

### DEVELOPERS

각 개발자의 인적 정보와 스킬 정보를 저장합니다.

| NAME | TYPE | UNIQUE | NULLABLE |
|------|------|---------|-----------|
| ID | VARCHAR(N) | Y | N |
| FIRST_NAME | VARCHAR(N) | N | Y |
| LAST_NAME | VARCHAR(N) | N | Y |
| EMAIL | VARCHAR(N) | Y | N |
| SKILL_CODE | INTEGER | N | N |

- `SKILL_CODE` 는 스킬 비트값의 누적 합 (Bit Mask)