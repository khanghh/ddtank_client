package godCardRaise.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.NumberSelecter;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import flash.events.Event;   import godCardRaise.info.GodCardListInfo;      public class GodCardRaiseAtlasCardAlert extends BaseAlerFrame   {                   private var _alertInfo:AlertInfo;            private var _numberSelecter:NumberSelecter;            private var _contentTxt:FilterFrameText;            private var _useClipCountTxt:FilterFrameText;            private var _type:int;            private var _godCardListInfo:GodCardListInfo;            public function GodCardRaiseAtlasCardAlert() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function __numberSelecterHandler(event:Event) : void { }
            public function set setType($type:int) : void { }
            public function set setInfo($info:GodCardListInfo) : void { }
            public function show() : void { }
            public function get count() : Number { return 0; }
            public function set valueLimit(value:String) : void { }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}