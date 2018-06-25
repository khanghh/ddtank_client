package starlingPhy.maps{   import flash.display.BitmapData;   import flash.geom.Point;   import flash.geom.Rectangle;   import road7th.utils.MathUtils;      public class Ground3D extends Tile3D   {                   private var _bound:Rectangle;            public function Ground3D(bitmapData:BitmapData, digable:Boolean) { super(null,null); }
            public function IsEmpty(x:int, y:int) : Boolean { return false; }
            public function IsRectangleEmpty(rect:Rectangle) : Boolean { return false; }
            public function IsRectangeEmptyQuick(rect:Rectangle) : Boolean { return false; }
            public function IsCircleEmptyQuick(rect:Rectangle, rAngle:Number = 30) : Boolean { return false; }
            public function IsXLineEmpty(x:int, y:int, w:int) : Boolean { return false; }
            public function IsYLineEmtpy(x:int, y:int, h:int) : Boolean { return false; }
            public function IsBitmapDataEmpty(secondObject:BitmapData, secondBitmapDataPoint:Point = null) : Boolean { return false; }
            override public function dispose() : void { }
   }}