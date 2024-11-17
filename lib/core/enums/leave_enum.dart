enum LeaveStatus { approved, pending, declined }

class LeaveStatusMapper {
  static String leaveStatusToString(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.approved:
        return 'Approved';
      case LeaveStatus.pending:
        return 'Pending';
      case LeaveStatus.declined:
        return 'Declined';
      default:
        return '';
    }
  }

  static LeaveStatus stringToLeaveStatus(String status) {
    switch (status) {
      case 'Approved':
        return LeaveStatus.approved;
      case 'Pending':
        return LeaveStatus.pending;
      case 'Declined':
        return LeaveStatus.declined;
      default:
        return LeaveStatus.pending;
    }
  }
}
