enum AnalyticTypesEvent {
  COPY,
  TABLET,
  DESKTOP;

  String describe() {
    switch (this) {
      case AnalyticTypesEvent.COPY:
        return 'Mobile';
      case AnalyticTypesEvent.TABLET:
        return 'Tablet';
      case AnalyticTypesEvent.DESKTOP:
        return 'Desktop';
    }
  }
}
