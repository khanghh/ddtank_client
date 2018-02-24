package team.view.create
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.view.mornui.TeamCreateInfoViewUI;
   
   public class TeamCreateInfoView extends TeamCreateInfoViewUI
   {
       
      
      public function TeamCreateInfoView(){super();}
      
      override protected function initialize() : void{}
      
      private function __onCreateComplete(param1:TeamEvent) : void{}
      
      private function __onCheckInput(param1:PkgEvent) : void{}
      
      protected function __onClickCheckTag() : void{}
      
      protected function __onClickCheckName() : void{}
      
      protected function __onClickCreate() : void{}
      
      private function __onAlertCreate(param1:FrameEvent) : void{}
      
      protected function __onClickEsc() : void{}
      
      private function checkTag() : Boolean{return false;}
      
      private function checkName() : Boolean{return false;}
      
      private function checkChange(param1:int, param2:Boolean, param3:int = 0) : void{}
      
      override public function dispose() : void{}
   }
}
