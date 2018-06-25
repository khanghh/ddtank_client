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
      
      public function OldPlayerComeBackControl()
      {
         super();
      }
      
      public static function get instance() : OldPlayerComeBackControl
      {
         if(!_instance)
         {
            _instance = new OldPlayerComeBackControl();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         OldPlayerComeBackManager.instance.addEventListener("oldPlayerOpenView",__loadModuleResHandler);
      }
      
      private function __loadModuleResHandler(evt:Event) : void
      {
         evt = evt;
         new HelperUIModuleLoad().loadUIModule(["oldPlayerComeBack"],function():void
         {
            __openViewHandler();
         });
      }
      
      private function __openViewHandler() : void
      {
         dispose();
         _frame = ComponentFactory.Instance.creatComponentByStylename("oldPlayerComeBack.frame");
         if(_frame)
         {
            _frame.initControl = this;
            LayerManager.Instance.addToLayer(_frame,3,true,1);
            initEvent();
            requestAwardItem();
         }
      }
      
      private function requestAwardItem() : void
      {
         if(_frame)
         {
            _frame.rollDiceComplete = false;
         }
         if(timeStep > 0)
         {
            clearInterval(timeStep);
            timeStep = 0;
         }
         OldPlayerComeBackManager.instance.requestAwardItem();
      }
      
      private function initEvent() : void
      {
         BuriedManager.Instance.addEventListener("diceover",diceOverHandler);
         OldPlayerComeBackManager.instance.addEventListener("UpdateTurntableView",__updateViewHandler);
         OldPlayerComeBackManager.instance.addEventListener("rollDiceResult",__rollDiceResultHandler);
         if(_frame)
         {
            _frame.addEventListener("response",__responseHandler);
         }
      }
      
      private function removeEvent() : void
      {
         BuriedManager.Instance.removeEventListener("diceover",diceOverHandler);
         if(_frame)
         {
            _frame.removeEventListener("response",__responseHandler);
         }
         OldPlayerComeBackManager.instance.removeEventListener("UpdateTurntableView",__updateViewHandler);
         OldPlayerComeBackManager.instance.removeEventListener("rollDiceResult",__rollDiceResultHandler);
      }
      
      private function diceOverHandler(e:BuriedEvent) : void
      {
         _frame.comeBackView.moveToTargetPos(_moveStep,__rollOverHandler);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            if(_frame)
            {
               ObjectUtils.disposeObject(_frame);
               dispose();
               _frame = null;
            }
         }
      }
      
      private function __updateViewHandler(evt:Event) : void
      {
         var awardInfo:ComeBackAwardItemsInfo = OldPlayerComeBackManager.instance.curAwardInfo;
         if(awardInfo == null || _frame == null || _frame.comeBackView == null)
         {
            return;
         }
         _frame.comeBackView.updateView(awardInfo);
         if(_frame)
         {
            _frame.rollDiceComplete = true;
         }
      }
      
      private function __rollDiceResultHandler(evt:CEvent) : void
      {
         var temFrame:* = null;
         _moveStep = int(evt.data);
         switch(int(_moveStep) - 1)
         {
            case 0:
               temFrame = "one";
               break;
            case 1:
               temFrame = "two";
               break;
            case 2:
               temFrame = "three";
               break;
            case 3:
               temFrame = "four";
               break;
            case 4:
               temFrame = "five";
               break;
            case 5:
               temFrame = "six";
         }
         _frame.diceRollMc.setCrFrame(temFrame);
         _frame.diceRollMc.play();
      }
      
      private function __rollOverHandler(value:int) : void
      {
         if(value >= 35)
         {
            if(timeStep)
            {
               clearInterval(timeStep);
            }
            timeStep = setInterval(requestAwardItem,2000);
         }
         else if(_frame)
         {
            _frame.rollDiceComplete = true;
            _frame.updateDiceCount();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearInterval(timeStep);
         timeStep = 0;
         _frame = null;
      }
   }
}
