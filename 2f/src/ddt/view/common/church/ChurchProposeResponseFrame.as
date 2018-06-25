package ddt.view.common.church{   import bagAndInfo.info.PlayerInfoViewControl;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.text.TextArea;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.utils.StringHelper;      public class ChurchProposeResponseFrame extends BaseAlerFrame   {                   private var _spouseID:int;            private var _spouseName:String;            private var _love:String;            private var _bg:MutipleImage;            private var _loveTxt:TextArea;            private var _answerId:int;            private var _nameText:FilterFrameText;            private var _name_txt:FilterFrameText;            private var _btnLookEquip:TextButton;            private var _alertInfo:AlertInfo;            public function ChurchProposeResponseFrame() { super(); }
            private function initialize() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            public function get answerId() : int { return 0; }
            public function set answerId(value:int) : void { }
            public function get love() : String { return null; }
            public function set love(value:String) : void { }
            public function get spouseName() : String { return null; }
            public function set spouseName(value:String) : void { }
            public function get spouseID() : int { return 0; }
            public function set spouseID(value:int) : void { }
            private function __lookEquip(evt:MouseEvent) : void { }
            private function confirmSubmit() : void { }
            private function __cancel() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}