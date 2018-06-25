package ddtBuried.map{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import ddtBuried.BuriedControl;   import ddtBuried.BuriedManager;   import ddtBuried.event.BuriedEvent;   import ddtBuried.role.BuriedPlayer;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.KeyboardEvent;   import flash.events.TimerEvent;   import flash.utils.Timer;      public class Maps extends Sprite   {                   private var w:uint;            private var h:uint;            private var wh:uint;            private var goo:Number;            private var map:Sprite;            private var mapArr:Array;            private var roadMen:MovieClip;            private var roadList:Array;            private var roadTimer:Timer;            private var timer_i:uint = 0;            private var mapDataArray:Array;            private var role:BuriedPlayer;            public function Maps($arr:Array, $w:int, $h:int) { super(); }
            private function init() : void { }
            public function startMove(xpos:int, ypos:int) : void { }
            private function MC_play(roadList:Array) : void { }
            private function goMap(evt:TimerEvent) : void { }
            private function createMaps() : void { }
            private function clearMaps() : void { }
            public function getMapArray() : Array { return null; }
            private function keyDowns(evt:KeyboardEvent) : void { }
            private function drawRect(mapPoint:uint) : MovieClip { return null; }
            private function roleCallback(role:BuriedPlayer, isLoadSucceed:Boolean) : void { }
            private function roadMens() : void { }
            public function setRoadMan(px:int, py:int) : void { }
            public function dispose() : void { }
   }}