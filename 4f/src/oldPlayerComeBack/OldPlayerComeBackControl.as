package oldPlayerComeBack
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   import ddtBuried.BuriedManager;
   import ddtBuried.event.BuriedEvent;
   import flash.events.Event;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import oldPlayerComeBack.data.ComeBackAwardItemsInfo;
   import oldPlayerComeBack.view.OldPlayerComeBackFrame;
   
   public class OldPlayerComeBackControl extends CoreController
   {
      
      private static var _instance:OldPlayerComeBackControl;
       
      
      private var _frame:OldPlayerComeBackFrame;
      
      private var _moveStep:int = 0;
      
      private var timeStep:uint;
      
      public function OldPlayerComeBackControl(){super();}
      
      public static function get instance() : OldPlayerComeBackControl{return null;}
      
      public function setup() : void{}
      
      private function __loadModuleResHandler(param1:Event) : void{}
      
      private function __openViewHandler() : void{}
      
      private function requestAwardItem() : void{}
      
      private function initEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function diceOverHandler(param1:BuriedEvent) : void{}
      
      private function __responseHandler(param1:FrameEvent) : void{}
      
      private function __updateViewHandler(param1:Event) : void{}
      
      private function __rollDiceResultHandler(param1:CEvent) : void{}
      
      private function __rollOverHandler(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
