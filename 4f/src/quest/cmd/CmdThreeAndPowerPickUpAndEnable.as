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
      
      public function CmdThreeAndPowerPickUpAndEnable(){super();}
      
      public function excute(param1:int) : void{}
      
      private function closeTaskView() : void{}
      
      private function enableThreeAndPower() : void{}
      
      private function pickUpThreeAndPower() : void{}
      
      private function onUimoduleLoadProgress(param1:UIModuleEvent) : void{}
      
      private function loadCompleteHandler(param1:UIModuleEvent) : void{}
      
      private function creatToolForPick(param1:String) : void{}
      
      private function __pickTool(param1:MouseEvent) : void{}
      
      private function onEF(param1:Event) : void{}
      
      protected function showConfirm() : void{}
      
      protected function PickUpAnimationSuccess() : void{}
      
      protected function __explainEnter(param1:Event) : void{}
      
      private function disposeToolForPick() : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
   }
}
