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
      
      public function StrokeVertex()
      {
         super();
      }
      
      public static function getInstance() : StrokeVertex
      {
         if(poolLength == 0)
         {
            return new StrokeVertex();
         }
         poolLength = Number(poolLength) - 1;
         return pool.pop();
      }
      
      public static function returnInstance(param1:StrokeVertex) : void
      {
         pool[poolLength] = param1;
         poolLength = Number(poolLength) + 1;
      }
      
      public static function returnInstances(param1:Vector.<StrokeVertex>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            pool[poolLength] = param1[_loc3_];
            poolLength = Number(poolLength) + 1;
            _loc3_++;
         }
      }
      
      public function clone() : StrokeVertex
      {
         var _loc1_:StrokeVertex = getInstance();
         _loc1_.x = x;
         _loc1_.y = y;
         _loc1_.r1 = r1;
         _loc1_.g1 = g1;
         _loc1_.b1 = b1;
         _loc1_.a1 = a1;
         _loc1_.u = u;
         _loc1_.v = v;
         _loc1_.degenerate = degenerate;
         return _loc1_;
      }
   }
}
