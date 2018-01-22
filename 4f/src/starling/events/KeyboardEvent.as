package starling.events
{
   public class KeyboardEvent extends Event
   {
      
      public static const KEY_UP:String = "keyUp";
      
      public static const KEY_DOWN:String = "keyDown";
       
      
      private var mCharCode:uint;
      
      private var mKeyCode:uint;
      
      private var mKeyLocation:uint;
      
      private var mAltKey:Boolean;
      
      private var mCtrlKey:Boolean;
      
      private var mShiftKey:Boolean;
      
      private var mIsDefaultPrevented:Boolean;
      
      public function KeyboardEvent(param1:String, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false){super(null,null,null);}
      
      public function preventDefault() : void{}
      
      public function isDefaultPrevented() : Boolean{return false;}
      
      public function get charCode() : uint{return null;}
      
      public function get keyCode() : uint{return null;}
      
      public function get keyLocation() : uint{return null;}
      
      public function get altKey() : Boolean{return false;}
      
      public function get ctrlKey() : Boolean{return false;}
      
      public function get shiftKey() : Boolean{return false;}
   }
}
