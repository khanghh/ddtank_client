package playerDress.event
{
   import flash.events.Event;
   
   public class PlayerDressEvent extends Event
   {
      
      public static const PLAYERDRESS_OPEN:String = "playerDressOpen";
      
      public static const PLAYERDRESS_DISPOSE:String = "playerDressDispose";
      
      public static const DRESSVIEW_COMPLETE:String = "dressViewComplete";
      
      public static const BAGVIEW_COMPLETE:String = "bagViewComplete";
      
      public static const SET_BTN_STATUS:String = "setBtnStatus";
      
      public static const UPDATE_PLAYERINFO:String = "updatePlayerinfo";
       
      
      public var info;
      
      public var data:Object;
      
      public function PlayerDressEvent(param1:String, param2:Object = null)
      {
         this.data = param2;
         super(param1);
      }
   }
}
