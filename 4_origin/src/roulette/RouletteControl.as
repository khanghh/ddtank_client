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
      
      public function RouletteControl()
      {
         super();
      }
      
      public static function get instance() : RouletteControl
      {
         if(!_instance)
         {
            _instance = new RouletteControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         LeftGunRouletteManager.instance.addEventListener("openview",__onOpenView);
      }
      
      private function __onOpenView(e:CEvent) : void
      {
         _content = e.data as Sprite;
         new HelperUIModuleLoad().loadUIModule(["roulette"],loadComplete);
      }
      
      private function loadComplete() : void
      {
         if(!_rouletteView)
         {
            _rouletteView = new RouletteFrame();
            _rouletteView.addEventListener("roulette_visible",__isVisible);
            _rouletteView.addEventListener("button_click",__buttonClick);
            LeftGunRouletteManager.instance.addEventListener("closeView",__onCloseView);
         }
         if(_content)
         {
            _content.addChild(_rouletteView);
         }
         else
         {
            LayerManager.Instance.addToLayer(_rouletteView,2,true,1,true);
         }
         PositionUtils.setPos(_rouletteView,"asset.rouletteFramePos");
      }
      
      private function __onCloseView(e:CEvent) : void
      {
         if(_rouletteView)
         {
            _rouletteView.removeEventListener("roulette_visible",__isVisible);
            _rouletteView.removeEventListener("button_click",__buttonClick);
            LeftGunRouletteManager.instance.removeEventListener("closeView",__onCloseView);
            _rouletteView.dispose();
            _rouletteView = null;
         }
         _content = null;
      }
      
      private function __buttonClick(event:RouletteFrameEvent) : void
      {
         LeftGunRouletteManager.instance.showTipFrame(LeftGunRouletteManager.instance.reward);
      }
      
      private function __isVisible(event:RouletteFrameEvent) : void
      {
         LeftGunRouletteManager.instance.isvisible = false;
         LeftGunRouletteManager.instance.reward = event.reward;
      }
      
      public function setRouletteFramenull() : void
      {
         _rouletteView = null;
      }
   }
}
