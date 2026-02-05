# 잡은 물고기 중 가장 큰 물고기의 길이 구하기 - 해설

## 난이도
Level 1

## 핵심 개념
- MAX 집계 함수
- CONCAT으로 문자열 결합
- NULL 자동 무시 특성

## 접근 방식
1. MAX(LENGTH)로 최대값 조회
2. CONCAT으로 'cm' 문자열 추가
3. 별칭 지정 (AS MAX_LENGTH)

## 왜 NULL 처리가 필요 없는가?
- MAX() 함수는 자동으로 NULL 무시
- 가장 큰 값만 반환하므로 NULL 영향 없음

## CONCAT 함수
- CONCAT(MAX(LENGTH), 'cm')
- 숫자와 문자열을 결합
- 결과: "50cm" 형태

## 시간복잡도
O(n) - 전체 스캔 후 최대값 반환
