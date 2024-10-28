import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);
  final RxString userName = ''.obs;

  @override
  void onInit() {
    firebaseUser.bindStream(_auth.authStateChanges());
    ever(firebaseUser, _setUserName); // Automatically update the username whenever user changes
    super.onInit();
  }

  Future<void> _setUserName(User? user) async {
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
      userName.value = userDoc['fullName'] ?? '';
    } else {
      userName.value = '';
    }
  }

  String getUserName() {
    return userName.value;
  }

  Future<void> signUp(String email, String password, String fullName, String role) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user information to Firestore with role
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'fullName': fullName,
        'email': email,
        'role': role, // Store role as "employee" or "supervisor"
      });

      Get.snackbar('Success', 'Account created successfully');
      Get.offNamed('/login');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Retrieve the user's role from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user?.uid).get();
      String role = userDoc['role'];

      // Navigate based on the user's role
      if (role == 'supervisor') {
        Get.offAllNamed('/supervisorScreen');
      } else {
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
