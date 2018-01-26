package wantstrong.event
{
   import flash.events.Event;
   
   public class WantStrongEvent extends Event
   {
      
      public static const ALREADYFINDBACK:String = "alreadyFindBack";
      
      public static const ALREADYUPDATETIME:String = "alreadyUpdateTime";
      
      public static const WANTSTRONG_OPENVIEW:String = "wantStrongOpenView";
      
      public static const WANTSTRONG_SETINFO:String = "wantStrongSetInfo";
       
      
      private var _data:Object;
      
      public function WantStrongEvent(param1:String, param2:Object = null){super(null,null,null);}
      
      public function get data() : Object{return null;}
   }
}
