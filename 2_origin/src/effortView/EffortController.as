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
      
      public function set isSelf(isSelf:Boolean) : void
      {
         _isSelf = isSelf;
      }
      
      public function set currentRightViewType(type:int) : void
      {
         _currentRightViewType = type;
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
      
      public function set currentViewType(type:int) : void
      {
         _currentViewType = type;
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
      
      private function updateRightView(type:int) : void
      {
         switch(int(type))
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
      
      private function updateView(type:int) : void
      {
         EffortManager.Instance.setEffortType(type);
      }
      
      private function updateTempRightView(type:int) : void
      {
         switch(int(type))
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
      
      private function updateTempView(type:int) : void
      {
         EffortManager.Instance.setTempEffortType(type);
      }
   }
}
