import 'package:delicias_da_auzi/src/models/user_model.dart';
import 'package:delicias_da_auzi/src/pages/auth/repository/auth_repository.dart';
import 'package:delicias_da_auzi/src/pages_routes/app_pages.dart';
import 'package:delicias_da_auzi/src/services/utils_services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../constants/storage_keys.dart';
import '../result/auth_result.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final authRepository = AuthRepository();
  final utilServices = UtilsServices();

  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> changePassword({required String currentPassword, required String newPassword}) async {
    isLoading.value = true;
    final result = await authRepository.changePassword(
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
      token: user.token!,
    );
    isLoading.value = false;
    if(result){
      //Mensagem
      utilServices.showToast(message: 'A senha foi atualizada com sucesso');
      //Logout
      signOut();
    }
    else{
      utilServices.showToast(message: 'A senha atual está incorreta',isError: true);
    }
  }

  Future<void> validateToken() async {
    //Recuperar o dado salvo localmente
    String? token = await utilServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.signInRoute);
      return;
    } else {
      AuthResult result = await authRepository.validateToken(token);
      result.when(
        success: (user) {
          this.user = user;
          saveTokenAndProceedToBase();
        },
        error: (message) {
          signOut();
        },
      );
    }
  }

  Future<void> signOut() async {
    //Zerar o user
    user = UserModel();
    //Remover o token localmente
    utilServices.removeLocalData(StorageKeys.token);
    //Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

  void saveTokenAndProceedToBase() {
    //Salvar o token
    utilServices.saveLocalData(
      key: StorageKeys.token,
      data: this.user.token!,
    );
    //Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await authRepository.signUp(user);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenAndProceedToBase();
      },
      error: (message) {
        utilServices.showToast(message: message, isError: true);
      },
    );
    isLoading.value = false;
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.signIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      saveTokenAndProceedToBase();
    }, error: (message) {
      utilServices.showToast(message: message, isError: true);
    });
  }

  Future<void> resetPassword(String email) async {
    await authRepository.resetPassword(email);
  }
}
