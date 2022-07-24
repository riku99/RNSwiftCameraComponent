import React from 'react';
import {requireNativeComponent, StyleSheet, View} from 'react-native';

// AAAManagerでRCT_EXTERN_MODULEに登録した場合、Managerは自動的に切り取られ、AAAで呼び出す
const RCTCamera = requireNativeComponent('RCTCamara');

const App = () => {
  return (
    <View style={styles.container}>
      <RCTCamera style={StyleSheet.absoluteFill} />
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
});

export default App;
