package ddt.view.bossbox{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.BossBoxManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.MouseEvent;   import flash.geom.Point;      public class SmallBoxButton extends Sprite implements Disposeable   {            public static const showTypeWait:int = 1;            public static const showTypeCountDown:int = 2;            public static const showTypeOpenbox:int = 3;            public static const showTypeHide:int = 4;            public static const HALL_POINT:int = 0;            public static const PVR_ROOMLIST_POINT:int = 1;            public static const PVP_ROOM_POINT:int = 2;            public static const PVE_ROOMLIST_POINT:int = 3;            public static const PVE_ROOM_POINT:int = 4;            public static const HOTSPRING_ROOMLIST_POINT:int = 5;            public static const HOTSPRING_ROOM_POINT:int = 6;                   private var _closeBox:MovieImage;            private var _openBoxAsset:MovieImage;            private var _openBox:Sprite;            private var _delayText:Sprite;            private var timeText:FilterFrameText;            private var _timeSprite:TimeTip;            private var _pointArray:Vector.<Point>;            public function SmallBoxButton(type:int) { super(); }
            private function init(type:int) : void { }
            private function _getPoint() : void { }
            private function initEvent() : void { }
            public function updateTime(second:int) : void { }
            public function showType(value:int) : void { }
            private function _click(e:MouseEvent) : void { }
            private function _updateSmallBoxState(evt:TimeBoxEvent) : void { }
            private function _updateTimeCount(evt:TimeBoxEvent) : void { }
            override public function get width() : Number { return 0; }
            private function removeEvent() : void { }
            public function dispose() : void { }
   }}