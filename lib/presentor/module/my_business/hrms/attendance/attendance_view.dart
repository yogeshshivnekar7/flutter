abstract class AttendanceView {
  onAttendanceError(var error);

  onAttendanceFailure(var failed);

  onAttendanceSuccess(var response);

  getAttendanceSuccess(var response);
}
