import React, {useRef} from 'react';
import {Pressable, StyleSheet, View} from 'react-native';
import {Camera} from './Camera';

const App = () => {
  const cameraRef = useRef(null);

  const onPress = async () => {
    await cameraRef.current?.capture();
  };

  return (
    <View style={styles.container}>
      <Camera style={styles.camera} ref={cameraRef} />
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
