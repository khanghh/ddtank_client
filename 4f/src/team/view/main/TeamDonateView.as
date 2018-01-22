package team.view.main
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import team.view.mornui.TeamDonateViewUI;
   
   public class TeamDonateView extends TeamDonateViewUI
   {
       
      
      private var _price:int;
      
      private var _inputPoint:int;
      
      public function TeamDonateView(){super();}
      
      override protected function initialize() : void{}
      
      protected function __onTextInput() : void{}
      
      private function __onClickSubmit() : void{}
      
      private function __onAlertSubmit(param1:FrameEvent) : void{}
      
      private function __onClickClose() : void{}
      
      override public function dispose() : void{}
   }
}
