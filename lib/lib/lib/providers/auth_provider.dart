import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Auth state model
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final String? verificationId;
  final bool isLoggedIn;

  const AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.verificationId,
    this.isLoggedIn = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    String? verificationId,
    bool? isLoggedIn,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      verificationId: verificationId ?? this.verificationId,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}

// Auth provider - sare auth functions yahan hain
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthNotifier() : super(const AuthState()) {
    _checkExistingUser();
  }

  // Check karo pehle se login hai ya nahi
  void _checkExistingUser() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        state = state.copyWith(user: user, isLoggedIn: true);
      } else {
        state = state.copyWith(user: null, isLoggedIn: false);
      }
    });
  }

  // OTP bhejo phone number par
  Future<void> sendOTP(String phoneNumber) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          state = state.copyWith(isLoading: false, isLoggedIn: true);
        },
        verificationFailed: (FirebaseAuthException e) {
          state = state.copyWith(
            isLoading: false,
            error: e.message ?? 'Verification failed',
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          state = state.copyWith(
            isLoading: false,
            verificationId: verificationId,
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // OTP verify karo
  Future<bool> verifyOTP(String smsCode) async {
    state = state.copyWith(isLoading: true);
    
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: smsCode,
      );
      
      await _auth.signInWithCredential(credential);
      state = state.copyWith(isLoading: false, isLoggedIn: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Invalid OTP. Please try again.',
      );
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
    await _storage.deleteAll();
    state = const AuthState();
  }
}
