package wantstrong
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import wantstrong.event.WantStrongEvent;
   import wantstrong.model.WantStrongModel;
   import wantstrong.view.WantStrongFrame;
   
   public class WantStrongControl extends EventDispatcher
   {
      
      private static var _instance:WantStrongControl;
       
      
      private var _frame:Frame;
      
      private var _initState;
      
      private var _isTimeUpdated:Boolean;
      
      public function WantStrongControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : WantStrongControl{return null;}
      
      public function setup() : void{}
      
      private function setData() : void{}
      
      public function setFindBackData(param1:int) : void{}
      
      protected function __onSetCurrentInfo(param1:WantStrongEvent) : void{}
      
      public function setCurrentInfo(param1:* = null, param2:Boolean = false) : void{}
      
      protected function __onOpenView(param1:WantStrongEvent) : void{}
      
      public function setinitState(param1:*) : void{}
      
      public function get isTimeUpdated() : Boolean{return false;}
      
      public function set isTimeUpdated(param1:Boolean) : void{}
      
      public function close() : void{}
   }
}
