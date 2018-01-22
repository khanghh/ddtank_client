package homeTemple.view
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class N_BitmapDataNumber
   {
       
      
      public var numList:Vector.<BitmapData>;
      
      public var dot:BitmapData;
      
      public var sprit:BitmapData;
      
      public var add:BitmapData;
      
      public var reduce:BitmapData;
      
      public var gap:Number = 1;
      
      private var _rect:Rectangle;
      
      private var _bitmapdata:BitmapData;
      
      private var _tempRect:Rectangle;
      
      private var _point:Point;
      
      public function N_BitmapDataNumber(){super();}
      
      public function getNumber(param1:String, param2:String = "left") : BitmapData{return null;}
      
      public function get rect() : Rectangle{return null;}
      
      public function set rect(param1:Rectangle) : void{}
   }
}
