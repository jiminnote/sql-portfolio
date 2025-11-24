-- 문제: 한 해(2021년)에 잡은 물고기 수 구하기
-- 출처: Programmers SQL
-- 테이블: FISH_INFO

-- 조건:
--   - TIME 컬럼의 연도가 2021인 데이터만 집계
--   - 결과는 전체 행 개수(FISH_COUNT)로 반환

-- 자료형 고려:
--   1) TIME이 DATE/DATETIME → 범위 필터링이 가장 효율적
--   2) TIME이 STRING(YYYYMMDD 또는 YYYY-MM-DD) → LIKE '2021%' 가능

-- [DATE 타입 기준 Best Practice]
-- SELECT COUNT(*) FROM FISH_INFO
-- WHERE TIME >= DATE '2021-01-01'
--   AND TIME <  DATE '2022-01-01';

SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE TIME LIKE '2021%';