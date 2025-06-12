abstract class FailureDashboard {
  final String message;
  const FailureDashboard(this.message);
}

class ServerFailureDashboard extends FailureDashboard {
  ServerFailureDashboard(super.message);
}
