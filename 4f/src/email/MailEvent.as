package email
{
   import flash.events.Event;
   
   public class MailEvent extends Event
   {
      
      public static const EMAIL_OPENVIEW:String = "emailOpenView";
      
      public static const EMAIL_SHOWWRITING:String = "emailShowWriting";
      
      public static const EMAIL_HIDE:String = "emailHide";
       
      
      private var _info:Object;
      
      public function MailEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false){super(null,null,null);}
      
      public function get info() : Object{return null;}
   }
}
