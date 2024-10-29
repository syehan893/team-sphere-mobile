import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import '../../data/data.dart';

enum CreateReimbursementRequestStatus { initial, loading, success, error }

class CreateReimbursementRequestState extends Equatable {
  final CreateReimbursementRequestStatus status;
  final ReimbursementRequest reimbursementRequest;
  final String? error;
  final String? fileName;
  final Uint8List? fileBytes;

  const CreateReimbursementRequestState({
    this.status = CreateReimbursementRequestStatus.initial,
    required this.reimbursementRequest,
    this.error,
    this.fileName,
    this.fileBytes,
  });

  CreateReimbursementRequestState copyWith({
    CreateReimbursementRequestStatus? status,
    ReimbursementRequest? reimbursementRequest,
    String? error,
    String? fileName,
    Uint8List? fileBytes,
  }) {
    return CreateReimbursementRequestState(
      status: status ?? this.status,
      reimbursementRequest: reimbursementRequest ?? this.reimbursementRequest,
      error: error ?? this.error,
      fileName: fileName ?? this.fileName,
      fileBytes: fileBytes ?? this.fileBytes,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      reimbursementRequest,
      error,
      fileName,
      fileBytes,
    ];
  }
}

@injectable
class CreateReimbursementRequestCubit
    extends Cubit<CreateReimbursementRequestState> {
  final ReimbursementRequestRepository _repository;
  final ReimbursementStorageRepository _storageRepository;

  CreateReimbursementRequestCubit(this._repository, this._storageRepository)
      : super(CreateReimbursementRequestState(
          reimbursementRequest: ReimbursementRequest(
            employeeId: '',
            requestDate:
                DateFormat('yyyy-MM-dd').parse(DateTime.now().toString()),
            expenseDate: DateTime.now(),
            expenseType: 'Software',
            amount: 100000,
            currency: 'IDR',
            description: '',
            receiptFilePath: '',
            status: 'Pending',
            managerId: '',
            managerComment: 'N/A',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            employee: null,
            requestId: null,
          ),
        ));

  Future<void> createReimbursementRequest() async {
    emit(state.copyWith(status: CreateReimbursementRequestStatus.loading));
    try {
      if (state.fileBytes != null && state.fileName != null) {
        final uploadResult = await _storageRepository.uploadReimbursement(
          state.reimbursementRequest.employeeId,
          state.fileName!,
          state.fileBytes!,
        );

        if (!uploadResult) {
          emit(state.copyWith(
              status: CreateReimbursementRequestStatus.error,
              error: "Failed to upload file."));
          return;
        }
      }

      await _repository.createReimbursementRequest(state.reimbursementRequest);
      emit(state.copyWith(status: CreateReimbursementRequestStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: CreateReimbursementRequestStatus.error,
        error: e.toString(),
      ));
    }
  }

  void selectFile(String originalFileName, Uint8List fileBytes) {
    final uniqueFileName =
        '${state.reimbursementRequest.employeeId}_${DateTime.now().millisecondsSinceEpoch}_$originalFileName';
    emit(state.copyWith(fileName: uniqueFileName, fileBytes: fileBytes));
  }

  void updateField({
    String? title,
    DateTime? date,
    String? type,
    String? fileName,
    int? amount,
    String? employeeId,
    String? managerId,
  }) {
    emit(state.copyWith(
      reimbursementRequest: state.reimbursementRequest.copyWith(
        description: title ?? state.reimbursementRequest.description,
        expenseDate: date ?? state.reimbursementRequest.expenseDate,
        expenseType: type ?? state.reimbursementRequest.expenseType,
        receiptFilePath: fileName ?? state.reimbursementRequest.receiptFilePath,
        amount: amount ?? state.reimbursementRequest.amount,
        employeeId: employeeId ?? state.reimbursementRequest.employeeId,
        managerId: managerId ?? state.reimbursementRequest.managerId,
      ),
    ));
  }
}
