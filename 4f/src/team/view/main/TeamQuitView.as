package team.view.main
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import team.view.mornui.TeamQuitViewUI;
   
   public class TeamQuitView extends TeamQuitViewUI
   {
       
      
      public function TeamQuitView(){super();}
      
      override protected function initialize() : void{}
      
      protected function __onClickConfirm() : void{}
      
      protected function __onClickEsc() : void{}
   }
}
