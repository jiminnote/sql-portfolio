# 3374. First Letter Capitalization II - 해설

## 난이도
Hard

## 핵심 개념
- 재귀 CTE (Recursive Common Table Expression)
- LAG() 윈도우 함수
- 문자열 분해 및 재조합
- REGEXP를 활용한 패턴 매칭

## 접근 방식
1. 재귀 CTE로 문자열을 한 글자씩 분해
2. LAG()로 이전 문자 참조
3. 이전 문자에 따라 대소문자 변환 규칙 적용
4. GROUP_CONCAT으로 다시 문자열 조합

## 왜 재귀 CTE인가?
- MySQL은 문자열 파싱 함수가 제한적
- SUBSTRING으로 한 글자씩 추출하며 ROW 생성
- pos 변수로 위치 추적

## 변환 규칙 (CASE WHEN)
- prev_c IS NULL → 첫 글자는 대문자
- prev_c = ' ' → 공백 뒤는 대문자
- prev_c = '-' → 하이픈 뒤는 대문자
- prev_c가 대문자이고 현재도 대문자 → 소문자로 변환

## 핵심 패턴
- LAG(c) OVER (PARTITION BY id ORDER BY pos) AS prev_c
- 같은 문자열(id) 내에서 이전 문자 참조
- 문맥 기반 조건 판단의 핵심

## 시간복잡도
O(n × m) - n: 행 수, m: 평균 문자열 길이
