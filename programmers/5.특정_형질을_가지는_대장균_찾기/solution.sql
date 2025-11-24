-- 문제: 특정 형질을 가지는 대장균 찾기
-- 출처: Programmers SQL
-- 개념: 비트마스크 기반 형질 판별

-- GENOTYPE 비트 구조
-- 1번 형질: 001 (1)
-- 2번 형질: 010 (2)
-- 3번 형질: 100 (4)

-- 조건:
-- 1) 2번 형질은 없어야 함 → (GENOTYPE & 2) = 0
-- 2) 1번 형질 또는 3번 형질은 반드시 있어야 함
--      (GENOTYPE & 1) = 1
--      OR (GENOTYPE & 4) = 4

SELECT
  COUNT(*) AS COUNT  
FROM ECOLI_DATA  
WHERE  
  (GENOTYPE & 2) = 0             -- 2번 형질이 없는 경우  
  AND (
    (GENOTYPE & 1) = 1           -- 1번 형질이 있는 경우
    OR (GENOTYPE & 4) = 4        -- 3번 형질이 있는 경우
  )