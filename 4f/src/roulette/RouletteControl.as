package roulette
{
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   
   public class RouletteControl
   {
      
      private static var _instance:RouletteControl;
       
      
      private var _rouletteView:RouletteFrame;
      
      private var _content:Sprite;
      
      public function RouletteControl(){super();}
      
      public static function get instance() : RouletteControl{return null;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:CEvent) : void{}
      
      private function loadComplete() : void{}
      
      private function __onCloseView(param1:CEvent) : void{}
      
      private function __buttonClick(param1:RouletteFrameEvent) : void{}
      
      private function __isVisible(param1:RouletteFrameEvent) : void{}
      
      public function setRouletteFramenull() : void{}
   }
}
