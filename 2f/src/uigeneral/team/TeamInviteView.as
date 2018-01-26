package uigeneral.team
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import uigeneral.mornui.TeamInviteViewUI;
   
   public class TeamInviteView extends TeamInviteViewUI
   {
       
      
      private var _info:TeamInfo;
      
      private var _userID:int;
      
      private var _teamID:int;
      
      public function TeamInviteView(){super();}
      
      override protected function initialize() : void{}
      
      private function __onUpdateTeamInfo(param1:TeamEvent) : void{}
      
      private function getLastSeasonInfo(param1:int) : String{return null;}
      
      private function __onClickEsc() : void{}
      
      public function update(param1:int, param2:int) : void{}
      
      override public function dispose() : void{}
   }
}
