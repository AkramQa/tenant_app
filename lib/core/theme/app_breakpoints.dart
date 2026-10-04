/// Responsive layout breakpoints (logical pixels).
class AppBreakpoints {
  const AppBreakpoints._();

  /// Width from which the dashboard switches to a navigation rail and
  /// grids add columns.
  static const double wide = 600;

  /// Max width of scrollable page content on tablets / landscape.
  static const double maxContentWidth = 720;

  /// Max width of single-column forms (sign in).
  static const double maxFormWidth = 460;
}
