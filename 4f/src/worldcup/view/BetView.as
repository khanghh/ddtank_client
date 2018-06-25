package worldcup.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import morn.core.handlers.Handler;   import worldcup.WorldcupManager;   import worldcup.view.item.TeamItem;   import worldcup.view.mornui.BetViewUI;      public class BetView extends BetViewUI   {                   public function BetView() { super(); }
            override protected function initialize() : void { }
            private function __clearGuessHandler(evt:CEvent) : void { }
            public function checkBetState() : void { }
            private function betAgainclickHandler() : void { }
            private function betClickHandler() : void { }
            private function render(item:TeamItem, index:int) : void { }
            override public function dispose() : void { }
   }}