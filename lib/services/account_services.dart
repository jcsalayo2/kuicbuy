import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuicbuy/models/account_model.dart';

class AccountServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<Account> getUser({required String userId}) async {
    var dSnapSHot = await users.doc(userId).get();
    print('QSNAPSHOT: ${dSnapSHot}');

    return Account.fromJson(dSnapSHot.data() as Map<String, dynamic>);
  }
}
