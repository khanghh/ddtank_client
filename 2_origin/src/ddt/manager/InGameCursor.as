package ddt.manager
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.ui.Mouse;
   
   public class InGameCursor extends EventDispatcher
   {
      
      private static const LOADING_CURSOR_CLASS:String = "cursor.LoadingCursor";
      
      private static var _instance:InGameCursor;
      
      public static var _disabled:Boolean;
       
      
      private var _setuped:Boolean;
      
      public function InGameCursor(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      public static function set disabled(value:Boolean) : void
      {
         _disabled = value;
      }
      
      public static function get Instance() : InGameCursor
      {
         if(_instance == null)
         {
            _instance = new InGameCursor();
         }
         return _instance;
      }
      
      public static function hide() : void
      {
         Mouse.hide();
         if(_disabled)
         {
            return;
         }
      }
      
      public static function show() : void
      {
         Mouse.show();
         if(_disabled)
         {
            return;
         }
      }
      
      public function set cursorType(value:String) : void
      {
      }
   }
}
