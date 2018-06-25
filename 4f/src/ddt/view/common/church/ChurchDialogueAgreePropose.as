package ddt.view.common.church{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.display.Bitmap;   import flash.events.Event;      public class ChurchDialogueAgreePropose extends BaseAlerFrame   {                   private var _bg:Bitmap;            public var isShowed:Boolean = true;            private var _alertInfo:AlertInfo;            private var _msgInfo:String;            private var _name_txt:FilterFrameText;            private var _contentTxt:FilterFrameText;            public function ChurchDialogueAgreePropose() { super(); }
            public function get msgInfo() : String { return null; }
            public function set msgInfo(value:String) : void { }
            private function initialize() : void { }
            private function onFrameResponse(evt:FrameEvent) : void { }
            private function confirmSubmit() : void { }
            public function show() : void { }
            override public function dispose() : void { }
   }}