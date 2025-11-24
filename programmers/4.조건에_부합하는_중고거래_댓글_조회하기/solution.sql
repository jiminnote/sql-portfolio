-- 문제: 조건에 부합하는 중고거래 댓글 조회하기
-- 출처: Programmers SQL
-- 조건:
--   - 2022년 10월에 작성된 중고거래 게시물에 달린 댓글 조회
--   - 날짜는 'YYYY-MM-DD' 형식으로 출력
--   - 댓글 작성일 오름차순 → 제목 오름차순 정렬

-- 실무적 고려:
--   - WHERE 절에서 TO_CHAR(CREATED_DATE, 'YYYY-MM') 사용 시 인덱스가 무효화됨
--   - 날짜 비교는 범위 조건을 사용해야 성능이 향상됨

SELECT
    B.TITLE,
    B.BOARD_ID,
    R.REPLY_ID,
    R.WRITER_ID,
    R.CONTENTS,
    TO_CHAR(R.CREATED_DATE, 'YYYY-MM-DD') AS CREATED_DATE
FROM USED_GOODS_BOARD B
JOIN USED_GOODS_REPLY R
    ON B.BOARD_ID = R.BOARD_ID
WHERE B.CREATED_DATE >= DATE '2022-10-01'
  AND B.CREATED_DATE <  DATE '2022-11-01'
ORDER BY R.CREATED_DATE ASC, B.TITLE ASC;