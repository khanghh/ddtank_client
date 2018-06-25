package witchBlessing.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.NumberSelecter;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.Event;      public class WitchBlessingFrame extends BaseAlerFrame   {                   private var _alertInfo:AlertInfo;            private var _text:FilterFrameText;            private var _numberSelecter:NumberSelecter;            private var _needText:FilterFrameText;            public function WitchBlessingFrame() { super(); }
            private function initView() : void { }
            public function show(needCount:int, needExp:int, max:int, allNeedMax:int) : void { }
            private function isDoubleTime(doubleTime:String) : Boolean { return false; }
            private function __seleterChange(event:Event) : void { }
            public function get count() : int { return 0; }
            override public function dispose() : void { }
            private function removeView() : void { }
   }}