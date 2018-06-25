package gameStarling.view.effects{   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.utils.PositionUtils;   import flash.geom.Point;   import gameCommon.BloodNumberCreater;   import road7th.StarlingMain;   import starling.display.Image;   import starling.display.Sprite;   import starling.events.Event;      public class ShootPercentView3D extends Sprite   {                   private var _type:int;            private var _isAdd:Boolean;            private var _picBmp:Sprite;            private var add:Boolean = true;            private var tmp:int = 0;            public function ShootPercentView3D(n:int, type:int = 1, isadd:Boolean = false) { super(); }
            override public function dispose() : void { }
            private function __addToStage(evt:Event) : void { }
            private function __enterFrame(evt:Event) : void { }
            private function doShowType1() : void { }
            private function doShowType2() : void { }
            public function getPercent(n:int) : Sprite { return null; }
            private function returnNum(arr:Array) : Array { return null; }
   }}