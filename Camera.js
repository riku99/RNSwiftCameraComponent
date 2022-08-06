import React from 'react';
import {
  findNodeHandle,
  NativeModules,
  requireNativeComponent,
} from 'react-native';

// AAAManagerでRCT_EXTERN_MODULEに登録した場合、Managerは自動的に切り取られ、AAAで呼び出す
const NativeCamera = requireNativeComponent('RCTCamara');
const CameraModule = NativeModules.CamaraManager;

export class Camera extends React.Component {
  ref;

  constructor(props) {
    super(props);
    this.ref = React.createRef();
  }

  getNode() {
    const node = findNodeHandle(this.ref.current);
    return node;
  }

  async capture() {
    await CameraModule.capture(this.getNode());
  }

  render() {
    return <NativeCamera {...this.props} ref={this.ref} />;
  }
}
