package quest.cmd{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.manager.NoviceDataManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import ddt.view.UIModuleSmallLoading;   import flash.display.MovieClip;   import flash.events.Event;   import flash.events.MouseEvent;   import flash.filters.GlowFilter;   import quest.TaskManager;   import trainer.view.ExplainPowerThree;      public class CmdThreeAndPowerPickUpAndEnable   {                   private var toolForPick:MovieClip;            private var _picked:Boolean = false;            private var flyAwayMC:MovieClip;            private var explainPowerThree:ExplainPowerThree;            public function CmdThreeAndPowerPickUpAndEnable() { super(); }
            public function excute(questID:int) : void { }
            private function closeTaskView() : void { }
            private function enableThreeAndPower() : void { }
            private function pickUpThreeAndPower() : void { }
            private function onUimoduleLoadProgress(event:UIModuleEvent) : void { }
            private function loadCompleteHandler(event:UIModuleEvent) : void { }
            private function creatToolForPick(style:String) : void { }
            private function __pickTool(event:MouseEvent) : void { }
            private function onEF(e:Event) : void { }
            protected function showConfirm() : void { }
            protected function PickUpAnimationSuccess() : void { }
            protected function __explainEnter(e:Event) : void { }
            private function disposeToolForPick() : void { }
            private function __outHandler(event:MouseEvent) : void { }
            private function __overHandler(event:MouseEvent) : void { }
   }}