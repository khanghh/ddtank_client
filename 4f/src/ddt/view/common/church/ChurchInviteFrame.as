package ddt.view.common.church{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddtBuried.BuriedManager;   import flash.display.Bitmap;      public class ChurchInviteFrame extends BaseAlerFrame   {                   private var _inviteName:String;            private var _roomid:int;            private var _password:String;            private var _sceneIndex:int;            private var _name_txt:FilterFrameText;            private var _bmTitle:Bitmap;            private var _bmMsg:Bitmap;            private var _alertInfo:AlertInfo;            public function ChurchInviteFrame() { super(); }
            private function initialize() : void { }
            private function confirmSubmit() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            public function set msgInfo(value:Object) : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}