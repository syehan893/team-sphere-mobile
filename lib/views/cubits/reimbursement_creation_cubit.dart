import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:team_sphere_mobile/core/enums/creation_status.dart';
import 'package:team_sphere_mobile/core/enums/fetch_status.dart';
import '../../data/data.dart';

class CreateReimbursementRequestState extends Equatable {
  final CreationStatus status;
  final FetchStatus downloadFileStatus;
  final ReimbursementRequest reimbursementRequest;
  final String? error;
  final String? fileName;
  final Uint8List? fileBytes;
  final String? filePublicUrl;

  const CreateReimbursementRequestState({
    this.status = CreationStatus.initial,
    this.downloadFileStatus = FetchStatus.initial,
    required this.reimbursementRequest,
    this.error,
    this.fileName,
    this.fileBytes,
    this.filePublicUrl,
  });

  CreateReimbursementRequestState copyWith({
    CreationStatus? status,
    ReimbursementRequest? reimbursementRequest,
    FetchStatus? downloadFileStatus,
    String? error,
    String? fileName,
    Uint8List? fileBytes,
    String? filePublicUrl,
  }) {
    return CreateReimbursementRequestState(
      status: status ?? this.status,
      reimbursementRequest: reimbursementRequest ?? this.reimbursementRequest,
      downloadFileStatus: downloadFileStatus ?? this.downloadFileStatus,
      error: error ?? this.error,
      fileName: fileName ?? this.fileName,
      fileBytes: fileBytes ?? this.fileBytes,
      filePublicUrl: filePublicUrl ?? this.filePublicUrl,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      reimbursementRequest,
      downloadFileStatus,
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
            amount: 0,
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
    emit(state.copyWith(status: CreationStatus.loading));
    try {
      if (state.fileBytes != null) {
        final uploadResult = await _storageRepository.uploadReimbursement(
          state.reimbursementRequest.employeeId,
          state.reimbursementRequest.receiptFilePath,
          state.fileBytes!,
        );

        if (!uploadResult) {
          emit(state.copyWith(
              status: CreationStatus.error, error: "Failed to upload file."));
          return;
        }
      }

      await _repository.createReimbursementRequest(state.reimbursementRequest);
      emit(state.copyWith(status: CreationStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: CreationStatus.error,
        error: e.toString(),
      ));
    }
  }

  Future<void> downloadFile(String filePath) async {
    emit(state.copyWith(downloadFileStatus: FetchStatus.loading));
    try {
      final response = await _storageRepository.downloadFile(filePath);
      emit(state.copyWith(
          downloadFileStatus: FetchStatus.loaded, filePublicUrl: response));
    } catch (e) {
      emit(state.copyWith(downloadFileStatus: FetchStatus.error));
    }
  }

  void selectFile(String originalFileName, Uint8List fileBytes) {
    final uniqueFileName =
        '${state.reimbursementRequest.employeeId}_${DateTime.now().millisecondsSinceEpoch}_$originalFileName';
    updateField(fileName: uniqueFileName);
    emit(state.copyWith(fileBytes: fileBytes));
  }

  void updateFilename(String originalFileName) {
    emit(state.copyWith(fileName: originalFileName));
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
