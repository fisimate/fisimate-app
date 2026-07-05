import 'package:get/get.dart';

// Unity is disabled for now — flutter_unity_widget isn't in pubspec.yaml and
// android/unityLibrary isn't wired up, see docs/MIGRATION.md. Every method
// below is a no-op stub that still updates the observable state the rest of
// the simulation UI reads, so screens using GameController keep working.
enum DisplacementDirection { left, right }

class GameController extends GetxController {
  dynamic _unityWidgetController;

  RxBool isGameLoaded = false.obs;
  RxString gameSceneName = ''.obs;
  RxBool isObjectMoving = false.obs;

  @override
  void onClose() {
    _unityWidgetController?.dispose();
    super.onClose();
  }

  void startMovement() {
    _unityWidgetController?.postMessage(
      'Car',
      'StartCarMovement',
      'true',
    );
    isObjectMoving.value = true;
    update();
  }

  void stopMovement() {
    _unityWidgetController?.postMessage(
      'Car',
      'StopCarMovement',
      'true',
    );
    isObjectMoving.value = false;
    update();
  }

  void setMovementDistance(String distance) {
    _unityWidgetController?.postMessage(
      'Car',
      'SetDistance',
      distance,
    );
  }

  void setMovementTime(String time) {
    _unityWidgetController?.postMessage(
      'Car',
      'SetTime',
      time,
    );
  }

  void setAppliedForce(String force) {
    _unityWidgetController?.postMessage(
      'Block',
      'SetAppliedForce',
      force,
    );
  }

  void setForceDuration(String duration) {
    _unityWidgetController?.postMessage(
      'Block',
      'SetForceDuration',
      duration,
    );
  }

  void setFrictionCoefficient(String friction) {
    _unityWidgetController?.postMessage(
      'Block',
      'SetFrictionCoefficient',
      friction,
    );
  }

  void setMass(String mass) {
    _unityWidgetController?.postMessage(
      'Block',
      'SetMass',
      mass,
    );
  }

  void setDisplacementDirection(DisplacementDirection direction) {
    String stringDirection = direction == DisplacementDirection.left ? 'left' : 'right';
    _unityWidgetController?.postMessage(
      'Block',
      'SetDisplacementDirection',
      stringDirection,
    );
  }

  void startBlockMovement() {
    _unityWidgetController?.postMessage(
      'Block',
      'StartBlockMovement',
      'true',
    );
    isObjectMoving.value = true;
    update();
  }

  void stopBlockMovement() {
    _unityWidgetController?.postMessage(
      'Block',
      'StopBlockMovement',
      'true',
    );
    isObjectMoving.value = false;
    update();
  }

  void setScene(String sceneName) {
    Future.delayed(Duration(seconds: 5), () {
      _unityWidgetController?.postMessage(
        'Main Camera',
        'LoadScene',
        sceneName,
      );
    });
    Future.delayed(Duration(seconds: 6), () {
      gameSceneName.value = sceneName;
      isGameLoaded.value = true;
      update();
    });
  }

  // void exitGame() async {
  //   // _unityWidgetController?.postMessage(
  //   //   'Main Camera',
  //   //   'ExitGame',
  //   //   'true',
  //   // );
  //   await _unityWidgetController?.unload()?.then((value) {
  //     Get.back();
  //   });
  //   isGameLoaded.value = false;
  //   isObjectMoving.value = false;
  //   update();
  // }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
    if (message == 'Car movement stopped' || message == 'Block movement stopped') {
      isObjectMoving.value = false;
      update();
    }
  }

  void onUnitySceneLoaded(dynamic scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    } else {
      print('Received scene loaded from unity: null');
    }
  }

  void onUnityCreated(controller) {
    controller.resume();
    _unityWidgetController = controller;
  }
}
