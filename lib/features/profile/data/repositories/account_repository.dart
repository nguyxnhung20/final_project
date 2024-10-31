import 'package:final_project/features/profile/data/models/account_model.dart';
import 'package:final_project/features/profile/data/remote_data_source/account_firestore_data_source.dart';
import 'package:final_project/features/profile/domain/entities/account_entity.dart';
import 'package:final_project/features/profile/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountFirestoreDataSource remoteDatasource;
  AccountRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<void> createOrUpdateAccountData(
      String userId, AccountEntity accountDataEntity) {
    return remoteDatasource.updateOrCreateAccountData(
        userId,
        AccountModel(
          avatarUrl: accountDataEntity.avatarUrl,
          fullName: accountDataEntity.fullName,
          dob: accountDataEntity.dob,
          phoneNumber: accountDataEntity.phoneNumber,
          email: accountDataEntity.email,
          gender: accountDataEntity.gender,
        ));
  }

  @override
  Future<AccountEntity?> getAccountData(String userId) {
    return remoteDatasource.getAccountData(userId);
  }
}
