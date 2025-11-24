-- 문제: 잔챙이(길이 ≤ 10) 개체 수 구하기 (NULL 값은 길이 10으로 간주)
-- 테이블: FISH_INFO

-- 비고:
--   LENGTH가 NULL이면 측정 불가 → 10으로 계산해야 함.
--   단순히 LENGTH IS NULL을 OR 조건에 넣으면 문제 의도와 달라 오답 발생.

-- 잘못된 접근 (오답):
-- SELECT COUNT(*) FROM FISH_INFO
-- WHERE LENGTH <= 10 OR LENGTH IS NULL;
-- NULL을 10으로 치환하지 않고 조건에 포함시킨 것이 오답 원인.

-- 올바른 접근:
-- COALESCE를 사용해 LENGTH가 NULL이면 10으로 변환 후 비교

SELECT COUNT(*) AS FISH_COUNT
FROM FISH_INFO
WHERE COALESCE(LENGTH, 10) <= 10;