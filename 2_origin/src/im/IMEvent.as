package im
{
   import flash.events.Event;
   
   public class IMEvent extends Event
   {
      
      public static const IM_OPENVIEW:String = "imOpenView";
      
      public static const ADDNEW_FRIEND:String = "addnewfriend";
      
      public static const ADD_NEW_GROUP:String = "addNewGroup";
      
      public static const UPDATE_GROUP:String = "updateGroup";
      
      public static const DELETE_GROUP:String = "deleteGroup";
       
      
      public var data:Object;
      
      public function IMEvent(type:String, obj:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         data = obj;
         super(type,bubbles,cancelable);
      }
   }
}
