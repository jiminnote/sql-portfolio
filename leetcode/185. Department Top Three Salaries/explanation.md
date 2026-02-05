# 185. Department Top Three Salaries - 해설

## 난이도
Hard

## 핵심 개념
- 상관 서브쿼리 (Correlated Subquery)
- COUNT(DISTINCT) 활용
- JOIN을 통한 테이블 연결

## 접근 방식
1. 각 직원의 급여보다 높은 고유 급여가 몇 개인지 계산
2. 해당 개수가 3 미만이면 Top 3에 해당
3. 부서 테이블과 JOIN하여 부서명 출력

## 왜 상관 서브쿼리인가?
```sql
SELECT COUNT(DISTINCT e2.salary)
FROM Employee e2
WHERE e2.departmentId = e.departmentId
  AND e2.salary > e.salary
```
- 현재 행의 부서와 급여를 기준으로 비교
- 나보다 높은 급여가 0개 → 1위
- 나보다 높은 급여가 1개 → 2위
- 나보다 높은 급여가 2개 → 3위

## 대안: DENSE_RANK() 사용
```sql
SELECT Department, Employee, Salary
FROM (
    SELECT d.name AS Department,
           e.name AS Employee,
          # 185. Department Top Three Salaries - 해설

## 난이도
Hard

## 핵심 개념
- 상관 서브쿼리 (Correlated Subquery)
- COUNT(DIS d
## 난이도
Hard

## 핵심 개념
- 상?= Hard

## ??
##ENS- 상관 서브 R- COUNT(DISTINCT) 활용
- JOIN을 통한 ? - JOIN을 통한 테이 ?## 접근 방식
1. 각 직원?,21. 각 직원을?. 해당 개수가 3 미만이면 Top 3에 해당
3. 부서 테이블과??. 부서 테이블과 JOIN하여 부서명 출?-
## 왜 상관 서브쿼리인가?
```sql
SELECT don``` cd "/Users/jimin/Documents/포트폴리오/sql-portfolio/leetcode/185. Department Top Three Salaries" && cat > explanation.md << 'ENDOFFILE'
# 185. Department Top Three Salaries - 해설

## 난이도
Hard

## 핵심 개념
- 상관 서브쿼리 (Correlated Subquery)
- COUNT(DISTINCT) 활용
- JOIN을 통한 테이블 연결

## 접근 방식
1. 각 직원의 급여보다 높은 고유 급여가 몇 개인지 계산
2. 해당 개수가 3 미만이면 Top 3에 해당
3. 부서 테이블과 JOIN하여 부서명 출력

## 왜 상관 서브쿼리인가?
- 현재 행의 부서와 급여를 기준으로 비교
- 나보다 높은 급여가 0개 → 1위
- 나보다 높은 급여가 1개 → 2위
- 나보다 높은 급여가 2개 → 3위

## 대안: DENSE_RANK() 사용
- PARTITION BY로 부서별 그룹화
- ORDER BY salary DESC로 급여 순위 매기기

## 왜 DENSE_RANK인가?
- RANK(): 동점이면 다음 순위 건너뜀 (1,1,3)
- DENSE_RANK(): 동점이어도 연속 순위 (1,1,2) ← 이게 필요!
- ROW_N# 185. Department Top Three Salaries - 해설

## 난이도
Hard

## 핵심 개념
- 상관 서브쿼리 (Correlated Subquery)
- COUNT(DISTI??
## 난이도
Hard

## 핵심 개? cd "/Users/jimin/Documents/포트폴리오/sql-portfolio"
 exit
 pwd
 
 EOF
 ENDOFFILE
 
ENDOFFILE
 ^C
 cat > "/Users/jimin/Documents/포트폴리오/sql-portfolio/leetcode/262. Trips and Users/explanation.md" << 'EOF'
# 262. Trips and Users - 해설

## 난이도
Hard

## 핵심 개념
- 다중 JOIN (같은 테이블을 여러 번 JOIN)
- 조건부 집계 (CASE WHEN + SUM/COUNT)
- 날짜 범위 필터링
- ROUND 함수로 소수점 처리

## 접근 방식
1. Trips 테이블에서 client, driver 각각 Users 테이블과 JOIN
2. banned = 'no' 조건으로 유효한 trip만 필터링
3. 날짜별로 GROUP BY 후 취소율 계산
4. 소수점 둘째자리까지 반올림

## 왜 JOIN 조건에 banned 체크를 넣는가?
- WHERE 절보다 JOIN ON 절에서 필터링하면 초기에 불필요한 row 제거
- 성능 최적화에 유리

## 취소율 계산 공식
- cancelled_by_driver, cancelled_by_client 모두 포함
- LIKE 'cancelled%'로 간결하게 처리

## 시간복잡도
O(n) - 단일 스캔 후 집계
