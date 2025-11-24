# 185. Department Top Three Salaries

## 요약
- 각 부서에서 급여 기준 상위 3위 안에 드는 직원을 조회한다.
- 동일한 급여가 존재할 수 있으므로 distinct salary 기준 Top 3를 판단해야 한다.
- 부서 이름, 직원 이름, 급여를 출력한다.

## 테이블
### Employee
(id, name, salary, departmentId)

### Department
(id, name)

## 조건
- 부서별 상위 3개의 고유 급여를 가진 직원만 반환
- 급여가 동일하면 모두 포함
- 출력 순서 제한 없음