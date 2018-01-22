package starling.events
{
   import flash.geom.Point;
   
   public class ResizeEvent extends Event
   {
      
      public static const RESIZE:String = "resize";
       
      
      public function ResizeEvent(param1:String, param2:int, param3:int, param4:Boolean = false){super(null,null,null);}
      
      public function get width() : int{return 0;}
      
      public function get height() : int{return 0;}
   }
}
