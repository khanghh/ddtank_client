package defendisland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import defendisland.view.DefendislandFrame;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class DefendislandControl extends EventDispatcher
   {
      
      private static var _instance:DefendislandControl;
       
      
      public var _frame:DefendislandFrame;
      
      public function DefendislandControl(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : DefendislandControl
      {
         if(!_instance)
         {
            _instance = new DefendislandControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         DefendislandManager.instance.addEventListener("showMainView",__showHandler);
         DefendislandManager.instance.addEventListener("hideMainView",__hideHandler);
      }
      
      private function __showHandler(param1:Event) : void
      {
         if(!_frame)
         {
            _frame = ComponentFactory.Instance.creatCustomObject("ddt.defendisland.defendislandFrame");
            LayerManager.Instance.addToLayer(_frame,3,true,1);
         }
         else
         {
            _frame.setData();
         }
      }
      
      public function __hideHandler(param1:Event) : void
      {
         if(_frame != null)
         {
            _frame.dispose();
         }
         _frame = null;
      }
   }
}
