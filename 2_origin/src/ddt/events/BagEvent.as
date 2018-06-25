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
      
      public function BagEvent(type:String, changedSlots:Dictionary)
      {
         _changedSlot = changedSlots;
         super(type);
      }
      
      public function get changedSlots() : Dictionary
      {
         return _changedSlot;
      }
      
      public function get passwordArray() : Array
      {
         return _passwordArray;
      }
      
      public function set passwordArray(value:Array) : void
      {
         _passwordArray = value;
      }
      
      public function get flag() : Boolean
      {
         return _flag;
      }
      
      public function set flag(value:Boolean) : void
      {
         this._flag = value;
      }
      
      public function get needSecond() : Boolean
      {
         return _needSecond;
      }
      
      public function set needSecond(value:Boolean) : void
      {
         _needSecond = value;
      }
   }
}
