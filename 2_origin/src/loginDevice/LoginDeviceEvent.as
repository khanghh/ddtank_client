package loginDevice
{
   import flash.events.Event;
   
   public class LoginDeviceEvent extends Event
   {
      
      public static const CHECKUA:String = "check_ua";
      
      public static const REWARDVIEWUPDATE:String = "reward_view_update";
       
      
      public function LoginDeviceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         super(type,bubbles,cancelable);
      }
   }
}
