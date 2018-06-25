package sanXiao.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.ui.vo.AlertInfo;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.NumberSelecter;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;      public class SXBuyTimesFrame extends BaseAlerFrame   {                   public var buyFunction:Function;            public var clickFunction:Function;            private var _timesSelector:NumberSelecter;            private var _txt:FilterFrameText;            private var _target:Sprite;            public var autoClose:Boolean = true;            private var _timesLabel:FilterFrameText;            public function SXBuyTimesFrame() { super(); }
            public function set target($target:Sprite) : void { }
            private function initView() : void { }
            private function initEvents() : void { }
            protected function onMoneyChange(e:Event) : void { }
            private function removeEvnets() : void { }
            private function responseHander(e:FrameEvent) : void { }
            public function setTxt(str:String) : void { }
            override public function dispose() : void { }
   }}