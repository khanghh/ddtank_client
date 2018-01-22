package catchInsect.event
{
   import flash.events.Event;
   
   public class InsectEvent extends Event
   {
      
      public static const CATCHINSECT_OPENVIEW:String = "catchInsectOpenView";
      
      public static const CATCHINSECT_DISPOSEENTERICON:String = "catchInsectDisposeEnterIcon";
      
      public static const CATCHINSECT_LOADMAP:String = "catchInsectLoadMap";
      
      public static const UPDATE_MONSTER_STATE:String = "update_monster_state";
      
      public static const MONSTER_ACTIVE_START:String = "monster_active_start";
      
      public static const USE_PROP:String = "useProp";
       
      
      public var data:Object;
      
      public function InsectEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1);
      }
   }
}
