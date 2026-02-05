# 잡은 물고기의 평균 길이 구하기 - 해설

## 난이도
Level 1

## 핵심 개념
- COALESCE로 NULL 값 대체
- AVG 집계 함수
- ROUND로 소수점 처리

## 접근 방식
1. NULL인 LENGTH는 10으로 대체
2. 전체 평균 계산
3. 소수점 둘째자리까지 반올림

## 왜 COALESCE를 AVG 안에 넣는가?
- AVG는 기본적으로 NULL 제외
- COALESCE 없이 AVG(LENGTH) → NULL 행 무시됨
- COALESCE(LENGTH, 10) → NULL을 10으로 변환 후 평균

## ROUND 함수
- ROUND(값, 2): 소수점 둘째자리까지 반올림
- 문제 요구사항 충족

## 시간복잡도
O(n) - 전체 행 스캔 후 집계
