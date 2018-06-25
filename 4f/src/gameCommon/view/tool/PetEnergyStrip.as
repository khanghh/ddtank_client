package gameCommon.view.tool{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.core.ITipedDisplay;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.LivingEvent;   import ddt.manager.LanguageMgr;   import ddt.view.tips.ChangeNumToolTipInfo;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import gameCommon.model.Pet;      public class PetEnergyStrip extends Sprite implements Disposeable, ITipedDisplay   {                   private var _pet:Pet;            private var _text:FilterFrameText;            private var _bg:MovieClip;            private var _mp:int;            private var _maxMp:int = 100;            private var _TipInfo:ChangeNumToolTipInfo;            public function PetEnergyStrip($pet:Pet) { super(); }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function onChange(event:LivingEvent) : void { }
            private function initView() : void { }
            private function get schedule() : int { return 0; }
            public function get tipData() : Object { return null; }
            public function set tipData(value:Object) : void { }
            public function get tipDirctions() : String { return null; }
            public function set tipDirctions(value:String) : void { }
            public function get tipGapH() : int { return 0; }
            public function set tipGapH(value:int) : void { }
            public function get tipGapV() : int { return 0; }
            public function set tipGapV(value:int) : void { }
            public function get tipStyle() : String { return null; }
            public function set tipStyle(value:String) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}