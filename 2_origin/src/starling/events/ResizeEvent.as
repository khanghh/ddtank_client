package starling.events
{
   import flash.geom.Point;
   
   public class ResizeEvent extends Event
   {
      
      public static const RESIZE:String = "resize";
       
      
      public function ResizeEvent(type:String, width:int, height:int, bubbles:Boolean = false)
      {
         super(type,bubbles,new Point(width,height));
      }
      
      public function get width() : int
      {
         return (data as Point).x;
      }
      
      public function get height() : int
      {
         return (data as Point).y;
      }
   }
}
