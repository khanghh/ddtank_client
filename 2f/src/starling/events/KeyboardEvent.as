package starling.events{   public class KeyboardEvent extends Event   {            public static const KEY_UP:String = "keyUp";            public static const KEY_DOWN:String = "keyDown";                   private var mCharCode:uint;            private var mKeyCode:uint;            private var mKeyLocation:uint;            private var mAltKey:Boolean;            private var mCtrlKey:Boolean;            private var mShiftKey:Boolean;            private var mIsDefaultPrevented:Boolean;            public function KeyboardEvent(type:String, charCode:uint = 0, keyCode:uint = 0, keyLocation:uint = 0, ctrlKey:Boolean = false, altKey:Boolean = false, shiftKey:Boolean = false) { super(null,null,null); }
            public function preventDefault() : void { }
            public function isDefaultPrevented() : Boolean { return false; }
            public function get charCode() : uint { return null; }
            public function get keyCode() : uint { return null; }
            public function get keyLocation() : uint { return null; }
            public function get altKey() : Boolean { return false; }
            public function get ctrlKey() : Boolean { return false; }
            public function get shiftKey() : Boolean { return false; }
   }}