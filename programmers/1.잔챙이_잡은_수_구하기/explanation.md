# 잔챙이 잡은 수 구하기 - 해설

## 난이도
Level 1

## 핵심 개념
- NULL 처리 (IS NULL)
- COUNT 집계 함수
- COALESCE 함수 활용

## 접근 방식
1. LENGTH가 NULL인 행 = 10cm 이하 잔챙이
2. NULL 조건으로 필터링
3. COUNT(*)로 개수 집계

## 왜 LENGTH IS NULL인가?
- 문제 정의: 10cm 이하 물고기는 LENGTH에 NULL 저장
- 따라서 WHERE LENGTH <= 10이 아닌 WHERE LENGTH IS NULL 사용
- 또는 COALESCE(LENGTH, 10) <= 10 사용 가능

## COALESCE vs IS NULL
- IS NULL: 단순 NULL 체크 (더 직관적)
- COALESCE: NULL을 특정 값으로 대체 (더 유연함)

## 시간복잡도
O(n) - 테이블 전체 스캔
