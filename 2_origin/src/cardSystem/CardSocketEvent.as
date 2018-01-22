package cardSystem
{
   import flash.events.Event;
   
   public class CardSocketEvent extends Event
   {
      
      public static const SETSPROP_INIT_COMPLETE:String = "setsPropIntComplete";
      
      public static const PROPLIST_INIT_COMPLETE:String = "propListInitComplete";
      
      public static const SETSSORTRULE_INIT_COMPLETE:String = "setsSortRuleInitComplete";
      
      public static const SELECT_CARDS:String = "select_cards";
      
      public static const CHANGE_SOUL:String = "change_soul";
      
      public static const SETSELECTCARD_COMPLETE:String = "setSelectCardComplete";
       
      
      public var data:Object;
      
      public function CardSocketEvent(param1:String, param2:Object = null)
      {
         super(param1);
         data = param2;
      }
   }
}
