package farm
{
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import ddt.manager.StateManager;
   import farm.viewx.FarmBuyFieldView;
   
   public class FarmControl
   {
      
      private static var _instance:FarmControl;
       
      
      public function FarmControl()
      {
         super();
      }
      
      public static function get instance() : FarmControl
      {
         if(_instance == null)
         {
            _instance = new FarmControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         FarmModelController.instance.addEventListener("openview",__onOpenView);
      }
      
      public function __onOpenView(param1:CEvent) : void
      {
         var _loc2_:int = param1.data.type;
         switch(int(_loc2_) - 1)
         {
            case 0:
               StateManager.setState("farm");
               break;
            case 1:
               openPayFieldFrame(param1.data.fieldId);
         }
      }
      
      public function openPayFieldFrame(param1:int) : void
      {
         var _loc2_:FarmBuyFieldView = new FarmBuyFieldView(param1);
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
   }
}
