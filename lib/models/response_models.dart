part of 'models.dart';

class QurbaniListResponse extends ApiResponse<List<QurbaniModel>> {
  QurbaniListResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory QurbaniListResponse.success(
    List<(Map<String, dynamic>, String)> data,
  ) {
    return QurbaniListResponse(
      data:
          (data as List?)
              ?.map((e) => QurbaniModel.fromJson(e.$1, e.$2))
              .toList() ??
          [],
      message: "Fetched successfully".tr(),
      status: true,
    );
  }

  factory QurbaniListResponse.error() {
    return QurbaniListResponse(
      data: null,
      message: "There was an error getting qurbani data".tr(),
      status: false,
    );
  }

  factory QurbaniListResponse.networkError() {
    return QurbaniListResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}

class QurbaniSaveResponse extends GenericApiResponse {
  QurbaniSaveResponse({required super.message, required super.status});

  factory QurbaniSaveResponse.success() {
    return QurbaniSaveResponse(
      message: "Saved successfully".tr(),
      status: true,
    );
  }

  factory QurbaniSaveResponse.error() {
    return QurbaniSaveResponse(
      message: "There was an error saving qurbani data".tr(),
      status: false,
    );
  }

  factory QurbaniSaveResponse.networkError() {
    return QurbaniSaveResponse(message: "Network error".tr(), status: false);
  }
}

class QurbaniCreateResponse extends ApiResponse<QurbaniModel> {
  QurbaniCreateResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory QurbaniCreateResponse.success(QurbaniModel data) {
    return QurbaniCreateResponse(
      data: data,
      message: "Created successfully".tr(),
      status: true,
    );
  }

  factory QurbaniCreateResponse.error() {
    return QurbaniCreateResponse(
      data: null,
      message: "There was an error saving qurbani data".tr(),
      status: false,
    );
  }

  factory QurbaniCreateResponse.networkError() {
    return QurbaniCreateResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}

class ExpenseListResponse extends ApiResponse<List<ExpenseModel>> {
  ExpenseListResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory ExpenseListResponse.success(
    List<(Map<String, dynamic>, String, String)> data,
  ) {
    return ExpenseListResponse(
      data:
          (data as List?)
              ?.map((e) => ExpenseModel.fromJson(e.$1, e.$2, e.$3))
              .toList() ??
          [],
      message: "Fetched successfully".tr(),
      status: true,
    );
  }

  factory ExpenseListResponse.error() {
    return ExpenseListResponse(
      data: null,
      message: "There was an error getting expense data".tr(),
      status: false,
    );
  }

  factory ExpenseListResponse.networkError() {
    return ExpenseListResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}

class ExpenseSaveResponse extends GenericApiResponse {
  ExpenseSaveResponse({required super.message, required super.status});

  factory ExpenseSaveResponse.success() {
    return ExpenseSaveResponse(
      message: "Expenses saved successfully".tr(),
      status: true,
    );
  }

  factory ExpenseSaveResponse.error() {
    return ExpenseSaveResponse(
      message: "There was an error saving expenses".tr(),
      status: false,
    );
  }

  factory ExpenseSaveResponse.networkError() {
    return ExpenseSaveResponse(message: "Network error".tr(), status: false);
  }
}

class ExpenseCreateResponse extends ApiResponse<ExpenseModel> {
  ExpenseCreateResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory ExpenseCreateResponse.success(ExpenseModel data) {
    return ExpenseCreateResponse(
      data: data,
      message: "Created successfully".tr(),
      status: true,
    );
  }

  factory ExpenseCreateResponse.error() {
    return ExpenseCreateResponse(
      data: null,
      message: "There was an error saving expenses".tr(),
      status: false,
    );
  }

  factory ExpenseCreateResponse.networkError() {
    return ExpenseCreateResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}

class ContributionListResponse extends ApiResponse<List<ContributionModel>> {
  ContributionListResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory ContributionListResponse.success(
    List<(Map<String, dynamic>, String, String)> data,
  ) {
    return ContributionListResponse(
      data:
          (data as List?)
              ?.map((e) => ContributionModel.fromJson(e.$1, e.$2, e.$3))
              .toList() ??
          [],
      message: "Fetched successfully".tr(),
      status: true,
    );
  }

  factory ContributionListResponse.error() {
    return ContributionListResponse(
      data: null,
      message: "There was an error getting contribution data".tr(),
      status: false,
    );
  }

  factory ContributionListResponse.networkError() {
    return ContributionListResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}

class ContributionSaveResponse extends GenericApiResponse {
  ContributionSaveResponse({required super.message, required super.status});

  factory ContributionSaveResponse.success() {
    return ContributionSaveResponse(
      message: "Contributions saved successfully".tr(),
      status: true,
    );
  }

  factory ContributionSaveResponse.error() {
    return ContributionSaveResponse(
      message: "There was an error saving contributions".tr(),
      status: false,
    );
  }

  factory ContributionSaveResponse.networkError() {
    return ContributionSaveResponse(message: "Network error".tr(), status: false);
  }
}

class ContributionCreateResponse extends ApiResponse<ContributionModel> {
  ContributionCreateResponse({
    required super.message,
    required super.status,
    required super.data,
  });

  factory ContributionCreateResponse.success(ContributionModel data) {
    return ContributionCreateResponse(
      data: data,
      message: "Created successfully".tr(),
      status: true,
    );
  }

  factory ContributionCreateResponse.error() {
    return ContributionCreateResponse(
      data: null,
      message: "There was an error saving contributions".tr(),
      status: false,
    );
  }

  factory ContributionCreateResponse.networkError() {
    return ContributionCreateResponse(
      data: null,
      message: "Network error".tr(),
      status: false,
    );
  }
}
