package morn.core.events
{
   import flash.events.Event;
   
   public class UIEvent extends Event
   {
      
      public static const MOVE:String = "move";
      
      public static const RENDER_COMPLETED:String = "renderCompleted";
      
      public static const SHOW_TIP:String = "showTip";
      
      public static const HIDE_TIP:String = "hideTip";
      
      public static const IMAGE_LOADED:String = "imageLoaded";
      
      public static const SCROLL:String = "scroll";
      
      public static const FRAME_CHANGED:String = "frameChanged";
      
      public static const ITEM_RENDER:String = "listRender";
      
      public static const APP_DDT_MSG:String = "APP_DDT_MSG";
       
      
      private var _data;
      
      public function UIEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get data() : *{return null;}
      
      public function set data(param1:*) : void{}
      
      override public function clone() : Event{return null;}
   }
}
