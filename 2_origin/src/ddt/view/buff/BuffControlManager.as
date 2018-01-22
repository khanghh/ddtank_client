package ddt.view.buff
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class BuffControlManager extends EventDispatcher
   {
      
      private static var _instance:BuffControlManager;
       
      
      private var _buff:BuffControl;
      
      public function BuffControlManager(param1:IEventDispatcher = null)
      {
         super(param1);
         _buff = new BuffControl();
      }
      
      public static function get instance() : BuffControlManager
      {
         if(!_instance)
         {
            _instance = new BuffControlManager();
         }
         return _instance;
      }
      
      public function get buff() : BuffControl
      {
         if(!_buff)
         {
            _buff = new BuffControl();
         }
         return _buff;
      }
      
      public function set buff(param1:BuffControl) : void
      {
         _buff = param1;
      }
   }
}
