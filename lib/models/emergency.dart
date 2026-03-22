class Emergency {
  final String id;
  final String title;
  final String icon;
  final String color;
  final List<EmergencyStep> steps;

  const Emergency({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.steps,
  });

  int get totalSteps => steps.length;
}

class EmergencyStep {
  final int step;
  final String title;
  final String description;
  final String? image;

  const EmergencyStep({
    required this.step,
    required this.title,
    required this.description,
    this.image,
  });
}
