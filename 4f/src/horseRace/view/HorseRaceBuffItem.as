package horseRace.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.MouseEvent;   import horseRace.controller.HorseRaceManager;   import horseRace.events.HorseRaceEvents;      public class HorseRaceBuffItem extends Sprite implements Disposeable   {                   private var _buffIndex:int;            private var _buffType:int;            private var _bg:Bitmap;            private var _daojishi:MovieClip;            private var _buffObj1:BaseButton;            private var _buffObj2:BaseButton;            private var _buffObj3:BaseButton;            private var _buffObj4:BaseButton;            private var _buffObj5:BaseButton;            private var _buffObj6:BaseButton;            private var _buffObj7:BaseButton;            private var _buffObj8:BaseButton;            private var buffConfig:Array;            public function HorseRaceBuffItem($buffType:int, $buffIndex:int) { super(); }
            private function getConfigByID(id:int) : int { return 0; }
            private function initView() : void { }
            public function setShowBuff($buffType:int, minute:int) : void { }
            public function setShowBuffObj($buffType:int) : void { }
            public function showBuffObjByType(type:int) : void { }
            private function _buffObjClick(e:MouseEvent) : void { }
            private function initEvent() : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}