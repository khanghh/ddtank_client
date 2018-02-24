package starlingPhy.maps
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import road7th.utils.MathUtils;
   
   public class Ground3D extends Tile3D
   {
       
      
      private var _bound:Rectangle;
      
      public function Ground3D(param1:BitmapData, param2:Boolean){super(null,null);}
      
      public function IsEmpty(param1:int, param2:int) : Boolean{return false;}
      
      public function IsRectangleEmpty(param1:Rectangle) : Boolean{return false;}
      
      public function IsRectangeEmptyQuick(param1:Rectangle) : Boolean{return false;}
      
      public function IsCircleEmptyQuick(param1:Rectangle, param2:Number = 30) : Boolean{return false;}
      
      public function IsXLineEmpty(param1:int, param2:int, param3:int) : Boolean{return false;}
      
      public function IsYLineEmtpy(param1:int, param2:int, param3:int) : Boolean{return false;}
      
      public function IsBitmapDataEmpty(param1:BitmapData, param2:Point = null) : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
