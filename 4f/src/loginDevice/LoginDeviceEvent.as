package loginDevice
{
   import flash.events.Event;
   
   public class LoginDeviceEvent extends Event
   {
      
      public static const CHECKUA:String = "check_ua";
      
      public static const REWARDVIEWUPDATE:String = "reward_view_update";
       
      
      public function LoginDeviceEvent(param1:String, param2:Boolean = false, param3:Boolean = false){super(null,null,null);}
   }
}
