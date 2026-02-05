# 3451. Find Invalid IP Addresses - 해설

## 난이도
Hard

## 핵심 개념
- SUBSTRING_INDEX로 문자열 분리
- CAST를 통한 타입 변환
- 복합 OR 조건으로 유효성 검사
- LENGTH와 REPLACE를 활용한 구분자 개수 확인

## 접근 방식
1. 옥텟 개수가 4개인지 확인 (. 개수 = 3)
2. 각 옥텟을 정수로 변환 후 0~255 범위 검사
3. Leading Zero 검사 (01, 001 등은 invalid)
4. 조건 만족하는 IP를 그룹화하여 카운트

## 옥텟 개수 검사
- LENGTH(ip) - LENGTH(REPLACE(ip, '.', '')) <> 3
- 점(.)을 제거한 길이 차이 = 점의 개수
- 3이 아니면 옥텟이 4개가 아님

## 옥텟 추출 방법
- SUBSTRING_INDEX(ip, '.', 1) -- 첫 번째
- SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 2), '.', -1) -- 두 번째
- SUBSTRING_INDEX(SUBSTRING_INDEX(ip, '.', 3), '.', -1) -- 세 번째
- SUBSTRING_INDEX(ip, '.', -1) -- 네 번째

## 왜 CAST가 필요한가?
- 문자열 비교: '99' > '255' (잘못됨)
- 정수 비교: 99 < 255 (정확함)
- CAST(... AS UNSIGNED)로 정수 변환 필수

## Leading Zero 검사
- LIKE '0%' AND <> '0'
- '0'으로 시작하면서 '0' 자체가 아닌 경우 invalid

## 시간복잡도
O(n) - 단일 스캔으로 처리
