package ddt.manager
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class StageFocusManager
   {
      
      public static const GAME_WIDTH:int = 1000;
      
      public static const GAME_HEIGHT:int = 600;
      
      private static var instance:StageFocusManager;
       
      
      private var _count:int;
      
      private var _stage:Stage;
      
      private var _view:Sprite;
      
      private var _currentActiveObject:InteractiveObject;
      
      public function StageFocusManager()
      {
         super();
      }
      
      public static function getInstance() : StageFocusManager
      {
         if(instance == null)
         {
            instance = new StageFocusManager();
         }
         return instance;
      }
      
      public function setup(param1:Stage) : void
      {
         _stage = param1;
         _view = new Sprite();
         _view.graphics.beginFill(0,0.75);
         _view.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _view.graphics.endFill();
         _view.buttonMode = true;
         _view.addChild(ComponentFactory.Instance.creatCustomObject("tip.StageFocus"));
         addEvent();
      }
      
      private function updateView() : void
      {
         var _loc1_:* = null;
         if(StageReferance.isStageResize())
         {
            _view.graphics.clear();
            _view.graphics.beginFill(0,0.75);
            _view.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
            _view.graphics.endFill();
            _loc1_ = _view.getChildAt(0);
            _loc1_.x = StageReferance.stageWidth - _loc1_.width >> 1;
            _loc1_.y = StageReferance.stageHeight - _loc1_.height >> 1;
         }
      }
      
      public function removeEvent() : void
      {
         _stage.removeEventListener("deactivate",__deactivateHandler);
         _stage.removeEventListener("activate",__activateHandler);
      }
      
      public function addEvent() : void
      {
         _stage.addEventListener("deactivate",__deactivateHandler);
         _stage.addEventListener("activate",__activateHandler);
      }
      
      private function __deactivateHandler(param1:Event) : void
      {
         updateView();
         _stage.addChild(_view);
         fadein();
         ShowTipManager.Instance.removeAllTip();
      }
      
      private function __activateHandler(param1:Event) : void
      {
         stopFade();
         if(_view.stage && _currentActiveObject)
         {
            _view.stage.focus = _currentActiveObject;
         }
         if(_view.parent)
         {
            _view.parent.removeChild(_view);
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         _count = Number(_count) + 1;
         if(_count >= 2)
         {
            _view.removeEventListener("enterFrame",__enterFrameHandler);
            if(_view.parent)
            {
               _view.parent.removeChild(_view);
            }
            _count = 0;
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      public function setActiveFocus(param1:InteractiveObject) : void
      {
         _currentActiveObject = param1;
      }
      
      private function fadein() : void
      {
         _view.alpha = 0;
         _view.addEventListener("enterFrame",__onFadein);
      }
      
      private function stopFade() : void
      {
         _view.alpha = 1;
         _view.removeEventListener("enterFrame",__onFadein);
      }
      
      private function __onFadein(param1:Event) : void
      {
         if(_view.alpha < 0.95)
         {
            _view.alpha = _view.alpha + 0.05;
         }
         else
         {
            _view.alpha = 1;
            _view.removeEventListener("enterFrame",__onFadein);
         }
      }
   }
}
