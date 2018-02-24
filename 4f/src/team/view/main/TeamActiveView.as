package team.view.main
{
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamInfo;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamActiveViewUI;
   
   public class TeamActiveView extends TeamActiveViewUI
   {
       
      
      private var _timer:Timer;
      
      public function TeamActiveView(){super();}
      
      override protected function initialize() : void{}
      
      private function __onClickDonate() : void{}
      
      protected function __onTimer(param1:TimerEvent) : void{}
      
      private function updateLoginTime(param1:Number) : void{}
      
      private function __onClickActiveAlert() : void{}
      
      private function __onRenderMemeber(param1:Box, param2:int) : void{}
      
      private function __onRenderActive(param1:Box, param2:int) : void{}
      
      private function convertString(param1:String) : String{return null;}
      
      protected function __onUpdateTeamInfo(param1:TeamEvent) : void{}
      
      protected function __onUpdateMmeber(param1:TeamEvent) : void{}
      
      protected function __onUpdateActive(param1:TeamEvent) : void{}
      
      public function update() : void{}
      
      public function updateView() : void{}
      
      private function updateMemeberList() : void{}
      
      override public function dispose() : void{}
   }
}
