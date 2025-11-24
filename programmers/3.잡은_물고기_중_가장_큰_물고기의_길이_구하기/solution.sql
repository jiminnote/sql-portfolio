-- 문제: 잡은 물고기 중 가장 큰 물고기의 길이를 조회
-- 테이블: FISH_INFO
-- 요구사항: 결과는 'XXcm' 형태의 문자열로 출력

-- 컬럼 설명:
-- LENGTH: 물고기의 길이(cm)
-- NULL 처리: MAX 집계 함수는 NULL 값을 자동 무시함

-- 접근 방식:
-- 1) MAX(LENGTH)로 가장 큰 길이 조회
-- 2) CONCAT으로 단위(cm) 추가

SELECT CONCAT(MAX(LENGTH), 'cm') AS MAX_LENGTH
FROM FISH_INFO;