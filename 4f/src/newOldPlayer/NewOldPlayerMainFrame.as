package newOldPlayer{   import ddt.data.quest.QuestInfo;   import ddt.events.TaskEvent;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import morn.core.handlers.Handler;   import newOldPlayer.newOldPlayerUI.view.NewOldPlayerMainUI;   import quest.TaskManager;      public class NewOldPlayerMainFrame extends NewOldPlayerMainUI   {            private static const POWERTARGETID:int = 20;            private static const MONEYTARGETID:int = 21;            private static const LEVELTARGETID:int = 22;            private static const ALIVETARGETID:int = 23;            private static const targetIDArr:Array = [20,21,22,23];                   private var _curIndex:int = 0;            public function NewOldPlayerMainFrame() { super(); }
            private function init() : void { }
            private function updateTime() : void { }
            private function __taskChange(e:TaskEvent) : void { }
            private function update() : void { }
            private function select(index:int) : void { }
            private function setVisibleByIndex(index:int) : void { }
            private function close() : void { }
            override public function dispose() : void { }
   }}