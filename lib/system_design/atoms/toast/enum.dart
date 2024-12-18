enum ToastType {
  success,
  info,
  warning,
  dark,
  error,
}

enum ToastAlign {
  small(24),
  medium(85);

  const ToastAlign(this.value);

  final double value;
}
