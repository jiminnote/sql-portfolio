-- 문제: 잡은 물고기의 평균 길이 구하기
-- 출처: Programmers SQL
-- 테이블: FISH_INFO
-- 조건:
--   - LENGTH가 NULL일 경우 10cm로 계산
--   - 모든 데이터의 평균 길이를 구한 뒤
--   - 소수점 둘째 자리까지 반올림하여 출력

-- COALESCE(LENGTH, 10) 설명:
--   LENGTH이 NULL이면 10을 반환하고,
--   NULL이 아닐 경우 실제 값을 사용함.
--   문제 조건 "NULL은 10으로 간주"를 정확히 반영.

-- ROUND(…, 2):
--   평균값을 소수점 둘째 자리까지 반올림.

SELECT ROUND(AVG(COALESCE(LENGTH, 10)), 2) AS AVERAGE_LENGTH
FROM FISH_INFO;