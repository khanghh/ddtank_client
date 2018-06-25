package bagAndInfo.ReworkName{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.ReworkNameAnalyzer;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.FilterWordManager;   import ddt.utils.RequestVairableCreater;   import flash.display.Bitmap;   import flash.events.ErrorEvent;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.text.TextFormat;   import flash.utils.setTimeout;      public class ReworkNameFrame extends Frame   {            public static const Close:String = "close";            public static const ReworkDone:String = "ReworkDone";            public static const Aviable:String = "aviable";            public static const Unavialbe:String = "unaviable";            public static const Input:String = "input";                   protected var _tittleField:FilterFrameText;            protected var _nicknameInput:FilterFrameText;            protected var _inputBackground:Bitmap;            protected var _resultField:FilterFrameText;            protected var _checkButton:BaseButton;            protected var _submitButton:TextButton;            protected var _available:Boolean = true;            protected var _nicknameDetail:String;            private var _resultDefaultFormat:TextFormat;            private var _avialableFormat:TextFormat;            private var _unAviableFormat:TextFormat;            private var _disEnabledFilters:Array;            private var _complete:Boolean = true;            protected var _path:String = "NickNameCheck.ashx";            protected var _bagType:int;            protected var _place:int;            protected var _maxChars:int;            protected var _state:String;            protected var _isCanRework:Boolean;            private var checkCallBack:Function;            private var nickNameShield:String;            public function ReworkNameFrame() { super(); }
            protected function configUi() : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __onToStage(evt:Event) : void { }
            private function __onResponse(evt:FrameEvent) : void { }
            protected function __onInputChange(evt:Event) : void { }
            protected function __onCheckClick(evt:MouseEvent) : void { }
            protected function visibleCheckText() : void { }
            private function __onSubmitClick(evt:MouseEvent) : void { }
            protected function setCheckTxt(m:String) : void { }
            private function __onLoadError(evt:LoaderEvent) : void { }
            protected function createCheckLoader(callBack:Function) : BaseLoader { return null; }
            protected function checkNameCallBack(analyzer:ReworkNameAnalyzer) : void { }
            protected function reworkNameComplete() : void { }
            protected function __onAlertResponse(evt:FrameEvent) : void { }
            protected function submitCheckCallBack(analyzer:ReworkNameAnalyzer) : void { }
            protected function __onFrameResponse(evt:FrameEvent) : void { }
            protected function nameInputCheck() : Boolean { return false; }
            public function initialize(bagType:int, place:int) : void { }
            public function get state() : String { return null; }
            public function set state(val:String) : void { }
            public function get complete() : Boolean { return false; }
            public function set complete(val:Boolean) : void { }
            private function checkShieldNickName() : int { return 0; }
            private function loadNickNameShieldTxt() : void { }
            private function __onLoadNickNameShieldTxtComplete(event:Event) : void { }
            private function __onLoadNickNameShieldTxtError(event:ErrorEvent) : void { }
            public function close() : void { }
            override public function dispose() : void { }
   }}