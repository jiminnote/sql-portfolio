# 조건에 부합하는 중고거래 댓글 조회하기

## 1. 문제 설명

`USED_GOODS_BOARD` 테이블에는 중고거래 게시글 정보가,  
`USED_GOODS_REPLY` 테이블에는 각 게시글에 달린 댓글 정보가 저장되어 있다.

이 문제에서는 **2022년 10월에 작성된 게시글에 달린 모든 댓글**을 조회해야 한다.  
또한 댓글 작성일은 `'YYYY-MM-DD'` 형식으로 출력하며,  
정렬 조건은 다음과 같다:

1. 댓글 작성일(`CREATED_DATE`) 오름차순  
2. 게시글 제목(`TITLE`) 오름차순

---

## 2. 테이블 구조

### USED_GOODS_BOARD

| 컬럼명        | 타입     | 설명              |
|---------------|----------|-------------------|
| BOARD_ID      | INTEGER  | 게시글 ID (PK)    |
| TITLE         | VARCHAR  | 게시글 제목        |
| CONTENTS      | VARCHAR  | 게시글 내용        |
| CREATED_DATE  | DATE     | 게시글 작성일      |
| WRITER_ID     | VARCHAR  | 작성자 ID          |

### USED_GOODS_REPLY

| 컬럼명        | 타입     | 설명              |
|---------------|----------|-------------------|
| REPLY_ID      | INTEGER  | 댓글 ID (PK)      |
| BOARD_ID      | INTEGER  | 참조 게시글 ID     |
| WRITER_ID     | VARCHAR  | 댓글 작성자 ID     |
| CONTENTS      | VARCHAR  | 댓글 내용          |
| CREATED_DATE  | DATE     | 댓글 작성일        |

---

## 3. 요구사항

아래 조건을 만족하는 SQL을 작성하라.

1. **2022년 10월에 작성된 게시글**에 달린 댓글을 조회한다.
2. 댓글 작성일은 `YYYY-MM-DD` 포맷으로 변환하여 출력한다.
3. 출력해야 하는 컬럼:

| 컬럼명         | 설명              |
|----------------|-------------------|
| TITLE          | 게시글 제목        |
| BOARD_ID       | 게시글 ID          |
| REPLY_ID       | 댓글 ID            |
| WRITER_ID      | 댓글 작성자 ID      |
| CONTENTS       | 댓글 내용          |
| CREATED_DATE   | 댓글 작성일(변환)  |

4. 정렬 조건:

- 댓글 작성일 오름차순  
- 제목 오름차순  

---
