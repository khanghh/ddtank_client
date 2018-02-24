package starling.display.graphics
{
   public class StrokeVertex
   {
      
      private static var pool:Vector.<StrokeVertex> = new Vector.<StrokeVertex>();
      
      private static var poolLength:int = 0;
       
      
      public var x:Number;
      
      public var y:Number;
      
      public var u:Number;
      
      public var v:Number;
      
      public var r1:Number;
      
      public var g1:Number;
      
      public var b1:Number;
      
      public var a1:Number;
      
      public var r2:Number;
      
      public var g2:Number;
      
      public var b2:Number;
      
      public var a2:Number;
      
      public var thickness:Number;
      
      public var degenerate:uint;
      
      public function StrokeVertex(){super();}
      
      public static function getInstance() : StrokeVertex{return null;}
      
      public static function returnInstance(param1:StrokeVertex) : void{}
      
      public static function returnInstances(param1:Vector.<StrokeVertex>) : void{}
      
      public function clone() : StrokeVertex{return null;}
   }
}
