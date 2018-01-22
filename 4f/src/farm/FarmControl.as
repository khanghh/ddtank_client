package farm
{
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import ddt.manager.StateManager;
   import farm.viewx.FarmBuyFieldView;
   
   public class FarmControl
   {
      
      private static var _instance:FarmControl;
       
      
      public function FarmControl(){super();}
      
      public static function get instance() : FarmControl{return null;}
      
      public function setup() : void{}
      
      public function __onOpenView(param1:CEvent) : void{}
      
      public function openPayFieldFrame(param1:int) : void{}
   }
}
