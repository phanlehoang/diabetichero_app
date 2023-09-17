class Draft {
  num recommendedInsulinUI;
  num insulinUI;
  Draft({required this.recommendedInsulinUI, this.insulinUI = 5});

  @override
  String toString() {
    return 'Draft(recommendedInsulinUI: $recommendedInsulinUI, insulinUI: $insulinUI)';
  }
}

dynamic draft2 = Draft(recommendedInsulinUI: 1);
dynamic draft = Draft(recommendedInsulinUI: 1, insulinUI: 0);

void main() {
  print(draft);
  print(draft2);
}
