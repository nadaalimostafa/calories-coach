class GetResult {
  static int steps = 0;
  static void updateSteps(int newStep){
    steps = newStep;
  }
  static Future<String> getSteps() async {
    return steps.toString();
  }
}
