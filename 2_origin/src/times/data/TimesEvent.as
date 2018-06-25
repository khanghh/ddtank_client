package times.data
{
   import flash.events.Event;
   
   public class TimesEvent extends Event
   {
      
      public static const PURCHASE:String = "purchase";
      
      public static const PLAY_SOUND:String = "playSound";
      
      public static const GOTO_HOME_PAGE:String = "gotoHomepage";
      
      public static const GOTO_CONTENT:String = "gotoContent";
      
      public static const GOTO_PRE_CONTENT:String = "gotoPreContent";
      
      public static const GOTO_NEXT_CONTENT:String = "gotoNextContent";
      
      public static const PUSH_TIP_ITEMS:String = "pushTipItems";
      
      public static const PUSH_TIP_CELLS:String = "pushTipCells";
      
      public static const THUMBNAIL_LOAD_COMPLETE:String = "thumbnailLoadComplete";
      
      public static const CLOSE_VIEW:String = "closeView";
      
      public static const GOT_EGG:String = "gotEgg";
       
      
      public var info:TimesPicInfo;
      
      public var params:Array;
      
      public function TimesEvent(type:String, $info:TimesPicInfo = null, $params:Array = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         info = $info;
         params = $params;
         super(type,bubbles,cancelable);
      }
   }
}
