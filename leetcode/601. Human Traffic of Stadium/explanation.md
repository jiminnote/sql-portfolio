# 601. Human Traffic of Stadium - 해설

## 난이도
Hard

## 핵심 개념
- ROW_NUMBER() 윈도우 함수
- 연속 구간 탐지 기법 (id - ROW_NUMBER)
- CTE를 활용한 단계별 처리
- HAVING으로 그룹 필터링

## 접근 방식
1. people >= 100인 행만 필터링
2. id - ROW_NUMBER()로 연속 그룹 식별
3. 그룹별 개수가 3개 이상인 그룹만 선택
4. 해당 그룹의 모든 행 출력

## 핵심 기법: 연속 구간 탐지
- id - ROW_NUMBER() OVER (ORDER BY id) AS grp
- 연속된 id는 같은 grp 값을 가짐
- 끊어지면 grp 값이 달라짐

## 왜 이 방식이 작동하는가?
- id가 연속이면: (n+1) - (m+1) = n - m (차이 유지)
- id가 끊어지면: (n+k) - (m+1) ≠ n - m (차이 증가)

## 3개 이상 필터링
- WHERE grp IN (SELECT grp FROM cte GROUP BY grp HAVING COUNT(*) >= 3)

## 시간복잡도
O(n log n) - 윈도우 함수 정렬
