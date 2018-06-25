package starling.display.util
{
   import starling.display.graphics.StrokeVertex;
   
   public class StrokeVertexUtil
   {
       
      
      public function StrokeVertexUtil()
      {
         super();
      }
      
      public static function removeStrokeVertexAt(vector:Vector.<StrokeVertex>, index:int) : StrokeVertex
      {
         var i:int = 0;
         var length:uint = vector.length;
         if(index < 0)
         {
            index = index + length;
         }
         if(index < 0)
         {
            index = 0;
         }
         else if(index >= length)
         {
            index = length - 1;
         }
         var value:StrokeVertex = vector[index];
         for(i = index + 1; i < length; )
         {
            vector[i - 1] = vector[i];
            i++;
         }
         vector.length = length - 1;
         return value;
      }
   }
}
