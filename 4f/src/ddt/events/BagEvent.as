package ddt.events
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class BagEvent extends Event
   {
      
      public static const UPDATE:String = "update";
      
      public static const PSDPRO:String = "password protection";
      
      public static const BACK_STEP:String = "backStep";
      
      public static const CHANGEPSW:String = "changePassword";
      
      public static const DELPSW:String = "deletePassword";
      
      public static const AFTERDEL:String = "afterDel";
      
      public static const NEEDPRO:String = "needprotection";
      
      public static const UPDATE_SUCCESS:String = "updateSuccess";
      
      public static const CLEAR:String = "clearSuccess";
      
      public static const PSW_CLOSE:String = "passwordClose";
      
      public static const SHOW_BEAD:String = "showBead";
      
      public static const QUICK_BUG_CARDS:String = "quickBugCards";
      
      public static const GEMSTONE_BUG_COUNT:String = "gemstone_buy_count";
       
      
      private var _flag:Boolean;
      
      private var _needSecond:Boolean;
      
      private var _changedSlot:Dictionary;
      
      private var _passwordArray:Array;
      
      public function BagEvent(param1:String, param2:Dictionary){super(null);}
      
      public function get changedSlots() : Dictionary{return null;}
      
      public function get passwordArray() : Array{return null;}
      
      public function set passwordArray(param1:Array) : void{}
      
      public function get flag() : Boolean{return false;}
      
      public function set flag(param1:Boolean) : void{}
      
      public function get needSecond() : Boolean{return false;}
      
      public function set needSecond(param1:Boolean) : void{}
   }
}
