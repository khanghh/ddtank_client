package ddt.events
{
   import flash.events.Event;
   
   public class DuowanInterfaceEvent extends Event
   {
      
      public static const ADD_ROLE:String = "addRole";
      
      public static const UP_GRADE:String = "upGrade";
      
      public static const ONLINE:String = "onLine";
      
      public static const OUTLINE:String = "outLine";
       
      
      public var data:Object;
      
      public function DuowanInterfaceEvent(param1:String, param2:Object = null){super(null);}
   }
}
