import React, {useRef} from 'react';
import {
  NativeModules,
  Pressable,
  requireNativeComponent,
  StyleSheet,
  View,
} from 'react-native';

// AAAManagerでRCT_EXTERN_MODULEに登録した場合、Managerは自動的に切り取られ、AAAで呼び出す
const RCTCamera = requireNativeComponent('RCTCamara');
const CameraModule = NativeModules.CamaraManager;

const App = () => {
  const cameraRef = useRef(null);

  const onPress = async () => {
    // await CameraModule?.capture();
    console.log(cameraRef.current._nativeTag);
    cameraRef.current?.call();
  };

  return (
    <View style={styles.container}>
      <RCTCamera style={styles.camera} ref={cameraRef} />
      <Pressable style={styles.button} onPress={onPress} />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  camera: {
    flex: 1,
  },
  button: {
    width: 80,
    height: 80,
    borderRadius: 80,
    backgroundColor: 'white',
    position: 'absolute',
    bottom: 70,
    alignSelf: 'center',
  },
});

export default App;
