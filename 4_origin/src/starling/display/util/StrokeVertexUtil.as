package starling.display.util
{
   import starling.display.graphics.StrokeVertex;
   
   public class StrokeVertexUtil
   {
       
      
      public function StrokeVertexUtil()
      {
         super();
      }
      
      public static function removeStrokeVertexAt(param1:Vector.<StrokeVertex>, param2:int) : StrokeVertex
      {
         var _loc5_:int = 0;
         var _loc4_:uint = param1.length;
         if(param2 < 0)
         {
            param2 = param2 + _loc4_;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         else if(param2 >= _loc4_)
         {
            param2 = _loc4_ - 1;
         }
         var _loc3_:StrokeVertex = param1[param2];
         _loc5_ = param2 + 1;
         while(_loc5_ < _loc4_)
         {
            param1[_loc5_ - 1] = param1[_loc5_];
            _loc5_++;
         }
         param1.length = _loc4_ - 1;
         return _loc3_;
      }
   }
}
