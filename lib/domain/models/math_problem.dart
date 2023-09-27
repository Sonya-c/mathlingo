class MathProblem {
  final int num1, num2, answer;
  final String op;

  MathProblem(this.num1, this.num2, this.op, this.answer);

  @override
  String toString() {
    return "$num1 $op $num2 = ";
  }
}
