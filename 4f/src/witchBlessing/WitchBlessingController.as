package witchBlessing
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import witchBlessing.view.WitchBlessingMainView;
   
   public class WitchBlessingController extends EventDispatcher
   {
      
      private static var _instance:WitchBlessingController;
       
      
      private var _frame:WitchBlessingMainView;
      
      public function WitchBlessingController(){super();}
      
      public static function get Instance() : WitchBlessingController{return null;}
      
      public function setup() : void{}
      
      public function get frame() : WitchBlessingMainView{return null;}
      
      private function __onShowFrame(param1:Event) : void{}
      
      private function __onHide(param1:Event) : void{}
   }
}
