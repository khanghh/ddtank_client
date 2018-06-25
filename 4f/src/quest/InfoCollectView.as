package quest{   import baglocked.BaglockedManager;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.RequestVairableCreater;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.net.URLVariables;   import road7th.utils.StringHelper;      public class InfoCollectView extends Sprite implements Disposeable   {                   public var Type:int = 2;            protected var _dataLabel:FilterFrameText;            protected var _validateLabel:FilterFrameText;            protected var _inputData:FilterFrameText;            protected var _inputValidate:FilterFrameText;            protected var _dataAlert:FilterFrameText;            protected var _valiAlert:FilterFrameText;            private var _submitBtn:TextButton;            private var _sendBtn:TextButton;            private var _resetBtn:TextButton;            private var _id:int;            public function InfoCollectView(id:int) { super(); }
            private function init() : void { }
            protected function addResetBtn() : void { }
            protected function modifyView() : void { }
            protected function addLabel() : void { }
            protected function validate() : void { }
            protected function __onSendBtn(evt:MouseEvent) : void { }
            protected function _onSubmitBtn(evt:MouseEvent) : void { }
            protected function __onRestBtn(evt:MouseEvent) : void { }
            protected function sendData() : void { }
            public function getPhoneData() : void { }
            protected function fillArgs(args:URLVariables) : URLVariables { return null; }
            private function __onDataLoad(e:LoaderEvent) : void { }
            private function __onPhoneDataLoad(e:LoaderEvent) : void { }
            private function __onLoadError(e:LoaderEvent) : void { }
            private function __onDataFocusOut(e:Event) : void { }
            protected function updateHelper(value:String) : String { return null; }
            protected function dalert(alertString:String) : void { }
            protected function alert(alertString:String) : void { }
            protected function dalertVali(alertString:String) : void { }
            protected function alertVali(alertString:String) : void { }
            private function sendValidate() : void { }
            public function dispose() : void { }
   }}