package yzhkof.ui.event
{
   import flash.events.Event;
   
   public class ComponentEvent extends Event
   {
      
      public static const DRAW_COMPLETE:String = "DRAW_COMPLETE";
      
      public static const SIZE_UPDATE:String = "SIZE_UPDATE";
      
      public static const COMPONENT_CHANGE:String = "COMPONENT_CHANGE";
       
      
      public function ComponentEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
