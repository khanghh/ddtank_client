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
      
      public function __onOpenView(e:CEvent) : void
      {
         var type:int = e.data.type;
         switch(int(type) - 1)
         {
            case 0:
               StateManager.setState("farm");
               break;
            case 1:
               openPayFieldFrame(e.data.fieldId);
         }
      }
      
      public function openPayFieldFrame(fieldId:int) : void
      {
         var buyfield:FarmBuyFieldView = new FarmBuyFieldView(fieldId);
         LayerManager.Instance.addToLayer(buyfield,3,true,1);
      }
   }
}
