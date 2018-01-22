package quest.cmd
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import quest.TaskManager;
   import trainer.view.ExplainPowerThree;
   
   public class CmdThreeAndPowerPickUpAndEnable
   {
       
      
      private var toolForPick:MovieClip;
      
      private var _picked:Boolean = false;
      
      private var flyAwayMC:MovieClip;
      
      private var explainPowerThree:ExplainPowerThree;
      
      public function CmdThreeAndPowerPickUpAndEnable()
      {
         super();
      }
      
      public function excute(param1:int) : void
      {
         if(param1 == 561)
         {
            closeTaskView();
            enableThreeAndPower();
            pickUpThreeAndPower();
         }
      }
      
      private function closeTaskView() : void
      {
         TaskManager.instance.taskFrameHide();
      }
      
      private function enableThreeAndPower() : void
      {
         SocketManager.Instance.out.syncWeakStep(10);
         SocketManager.Instance.out.syncWeakStep(12);
      }
      
      private function pickUpThreeAndPower() : void
      {
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadCompleteHandler);
         UIModuleLoader.Instance.addEventListener("uiMoudleProgress",onUimoduleLoadProgress);
         UIModuleLoader.Instance.addUIModuleImp("trainer3");
      }
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void
      {
         if(param1.module == "trainer3")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "trainer3")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadCompleteHandler);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",onUimoduleLoadProgress);
            creatToolForPick("asset.trainer.getPowerThreeAsset");
         }
      }
      
      private function creatToolForPick(param1:String) : void
      {
         toolForPick = ClassUtils.CreatInstance(param1) as MovieClip;
         toolForPick.buttonMode = true;
         toolForPick.addEventListener("click",__pickTool);
         PositionUtils.setPos(toolForPick,"trainer3.pickup.point");
         toolForPick.addEventListener("mouseOver",__overHandler);
         toolForPick.addEventListener("mouseOut",__outHandler);
         LayerManager.Instance.addToLayer(toolForPick,3,false,1);
         SoundManager.instance.play("156");
      }
      
      private function __pickTool(param1:MouseEvent) : void
      {
         _picked = true;
         SoundManager.instance.play("008");
         SoundManager.instance.play("157");
         disposeToolForPick();
         flyAwayMC = ClassUtils.CreatInstance("asset.trainer.getPowerThreeMove");
         flyAwayMC.stop();
         flyAwayMC.addEventListener("enterFrame",onEF);
         LayerManager.Instance.addToLayer(flyAwayMC,3,false,1);
         flyAwayMC.play();
         NoviceDataManager.instance.saveNoviceData(560,PathManager.userName(),PathManager.solveRequestPath());
      }
      
      private function onEF(param1:Event) : void
      {
         if(flyAwayMC.currentFrame == flyAwayMC.totalFrames)
         {
            flyAwayMC.removeEventListener("enterFrame",onEF);
            PickUpAnimationSuccess();
         }
         else if(flyAwayMC.currentFrame == flyAwayMC.totalFrames - 8)
         {
            showConfirm();
         }
      }
      
      protected function showConfirm() : void
      {
         explainPowerThree = ComponentFactory.Instance.creatCustomObject("trainer.ExplainPowerThree");
         explainPowerThree.addEventListener("explainEnter",__explainEnter);
         explainPowerThree.show();
      }
      
      protected function PickUpAnimationSuccess() : void
      {
         ObjectUtils.disposeObject(flyAwayMC);
         flyAwayMC = null;
      }
      
      protected function __explainEnter(param1:Event) : void
      {
         NoviceDataManager.instance.saveNoviceData(570,PathManager.userName(),PathManager.solveRequestPath());
         explainPowerThree.removeEventListener("explainEnter",__explainEnter);
         explainPowerThree.dispose();
         explainPowerThree = null;
      }
      
      private function disposeToolForPick() : void
      {
         ObjectUtils.disposeObject(toolForPick);
         toolForPick.removeEventListener("click",__pickTool);
         toolForPick.removeEventListener("mouseOver",__overHandler);
         toolForPick.removeEventListener("mouseOut",__outHandler);
         toolForPick = null;
         _picked = false;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         toolForPick.filters = null;
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         toolForPick.filters = [new GlowFilter(16737792,1,30,30,2)];
      }
   }
}
