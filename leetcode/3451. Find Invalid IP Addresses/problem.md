# 3451. Find Invalid IP Addresses

## 문제 요약
logs 테이블에서 유효하지 않은 IPv4 주소를 찾아 개수와 함께 출력하는 SQL 문제이다.
IPv4 주소가 Invalid 로 판단되는 경우는 다음 조건 중 하나라도 만족할 때이다.

### 변환 규칙
1. 옥텟(octet) 숫자가 255 초과
2. Leading Zero 포함 (예: 01, 단 0은 허용)
3. 옥텟 개수가 정확히 4개가 아님

### 출력 요구 사항
- 원본 내용(`original_text`)과 변환된 내용(`converted_text`)을 모두 반환한다.
- content_id 기준으로 출력한다.

---

## 입력 테이블 구조

### Table: logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| log_id      | int     |
| ip          | varchar |
| status_code | int     |
+-------------+---------+


---

## 출력 예시
| ip            | invalid_count |
| ------------- | ------------- |
| 256.1.2.3     | 2             |
| 192.168.001.1 | 2             |
| 192.168.1     | 1             |

---

