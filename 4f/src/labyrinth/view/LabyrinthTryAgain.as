package labyrinth.view{   import baglocked.BaglockedManager;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import flash.events.MouseEvent;   import gameCommon.TryAgain;   import gameCommon.model.MissionAgainInfo;      public class LabyrinthTryAgain extends TryAgain   {                   public function LabyrinthTryAgain(info:MissionAgainInfo, isShowNum:Boolean = true) { super(null,null); }
            override protected function __tryagainClick(event:MouseEvent) : void { }
            override protected function onCheckComplete() : void { }
            override public function dispose() : void { }
   }}