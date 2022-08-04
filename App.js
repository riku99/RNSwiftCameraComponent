import React from 'react';
import {
  Pressable,
  requireNativeComponent,
  StyleSheet,
  View,
} from 'react-native';

// AAAManagerでRCT_EXTERN_MODULEに登録した場合、Managerは自動的に切り取られ、AAAで呼び出す
const RCTCamera = requireNativeComponent('RCTCamara');

const App = () => {
  return (
    <View style={styles.container}>
      <RCTCamera style={styles.camera} />
      <Pressable style={styles.button} />
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
