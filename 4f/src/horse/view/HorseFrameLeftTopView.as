package horse.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import horse.HorseManager;   import horse.data.HorseEvent;      public class HorseFrameLeftTopView extends Sprite implements Disposeable   {                   private var _leftArrowBtn:SimpleBitmapButton;            private var _rightArrowBtn:SimpleBitmapButton;            private var _useBtn:SimpleBitmapButton;            private var _takeBackBtn:SimpleBitmapButton;            private var _preLevelUpBtn:SimpleBitmapButton;            private var _nameTxt:FilterFrameText;            private var _horseMc:MovieClip;            private var _horseNameStrList:Array;            private var _curIndex:int;            private var _maxIndex:int;            private var _horseAmuletTips:Component;            public function HorseFrameLeftTopView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            private function upHorseHandler(event:Event) : void { }
            private function changeHorseHandler(event:HorseEvent) : void { }
            private function refreshHorseShowView(index:int) : void { }
            private function refreshHorseUseView() : void { }
            private function refreshArrowView() : void { }
            private function leftArrowClickHandler(event:MouseEvent) : void { }
            private function rightArrowClickHandler(event:MouseEvent) : void { }
            private function useClickHandler(event:MouseEvent) : void { }
            private function takeBackClickHandler(event:MouseEvent) : void { }
            private function preLevelUpOverHandler(event:MouseEvent) : void { }
            private function preLevelUpOutHandler(event:MouseEvent) : void { }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}