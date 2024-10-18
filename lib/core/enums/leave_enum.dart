enum LeaveStatus { approved, pending, declined }

class LeaveStatusMapper {
  static String leaveStatusToString(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return 'approved';
      case LeaveStatus.pending:
        return 'pending';
      case LeaveStatus.declined:
        return 'declined';
      default:
        return '';
    }
  }

  static LeaveStatus stringToLeaveStatus(String status) {
    switch (status) {
      case 'approved':
        return LeaveStatus.approved;
      case 'pending':
        return LeaveStatus.pending;
      case 'declined':
        return LeaveStatus.declined;
      default:
        return LeaveStatus.pending;
    }
  }
}
