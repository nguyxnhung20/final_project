import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/core/services/logger_service.dart';
import 'package:final_project/features/profile/data/models/account_model.dart';

abstract class AccountFirestoreDataSource {
  Future<AccountModel?> getAccountData(String userId);
  Future<void> updateOrCreateAccountData(String userId, AccountModel account);
}

class AccountFirestoreDataSourceImpl implements AccountFirestoreDataSource {
  @override
  Future<AccountModel?> getAccountData(String userId) async {
    final db = FirebaseFirestore.instance;
    final accountRef = db.collection('accounts').doc(userId);
    final result = await accountRef.get();
    final data = result.data();
    if (result.exists && data != null) {
      return AccountModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Future<void> updateOrCreateAccountData(
      String userId, AccountModel account) async {
    final db = FirebaseFirestore.instance;
    DocumentReference userDocRef = db.collection('accounts').doc(userId);
    DocumentSnapshot docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      await userDocRef.update(account.toJsonForNonNullItems());
      printS("Account Info updated!");
    } else {
      await userDocRef.set(account.toJsonForNonNullItems());
      printS("Account Info created!");
    }
  }
}
