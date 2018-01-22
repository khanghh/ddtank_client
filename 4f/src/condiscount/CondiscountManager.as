package condiscount
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import condiscount.model.CondiscountModel;
   import condiscount.view.CondiscountFrame;
   import ddt.CoreManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   
   public class CondiscountManager extends CoreManager
   {
      
      private static var _instance:CondiscountManager;
       
      
      public var model:CondiscountModel;
      
      private var _frame:CondiscountFrame;
      
      public function CondiscountManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : CondiscountManager{return null;}
      
      override protected function start() : void{}
      
      private function onComplete() : void{}
      
      public function setup() : void{}
      
      public function showIcon() : void{}
   }
}
