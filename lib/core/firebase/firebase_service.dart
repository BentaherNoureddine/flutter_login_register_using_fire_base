import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forest_reporter/firebase_options.dart';


class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;






  //initialize firebase
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseService();
  }

  FirebaseAuth getAuth() {
    return _firebaseAuth;
  }
}
