package effortView
{
   import ddt.manager.EffortManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class EffortController extends EventDispatcher
   {
       
      
      private var _currentRightViewType:int;
      
      private var _currentViewType:int;
      
      private var _isSelf:Boolean;
      
      public function EffortController()
      {
         super();
         _currentRightViewType = 0;
         _currentViewType = 0;
         _isSelf = true;
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
      }
      
      public function set currentRightViewType(param1:int) : void
      {
         _currentRightViewType = param1;
         if(_isSelf)
         {
            updateRightView(_currentRightViewType);
         }
         else
         {
            updateTempRightView(_currentRightViewType);
         }
      }
      
      public function get currentRightViewType() : int
      {
         return _currentRightViewType;
      }
      
      public function set currentViewType(param1:int) : void
      {
         _currentViewType = param1;
         if(_isSelf)
         {
            updateView(_currentViewType);
         }
         else
         {
            updateTempView(_currentViewType);
         }
      }
      
      public function get currentViewType() : int
      {
         return _currentViewType;
      }
      
      private function updateRightView(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               break;
            case 1:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getRoleEffort();
               break;
            case 2:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTaskEffort();
               break;
            case 3:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getDuplicateEffort();
               break;
            case 4:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getCombatEffort();
               break;
            case 5:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getIntegrationEffort();
            default:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getIntegrationEffort();
         }
         dispatchEvent(new Event("change"));
      }
      
      private function updateView(param1:int) : void
      {
         EffortManager.Instance.setEffortType(param1);
      }
      
      private function updateTempRightView(param1:int) : void
      {
         switch(int(param1))
         {
            case 0:
               break;
            case 1:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempRoleEffort();
               break;
            case 2:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempTaskEffort();
               break;
            case 3:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempDuplicateEffort();
               break;
            case 4:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempCombatEffort();
               break;
            case 5:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempIntegrationEffort();
            default:
               EffortManager.Instance.currentEffortList = EffortManager.Instance.getTempIntegrationEffort();
         }
         dispatchEvent(new Event("change"));
      }
      
      private function updateTempView(param1:int) : void
      {
         EffortManager.Instance.setTempEffortType(param1);
      }
   }
}
