package team.view.main
{
   import calendar.CalendarManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelpFrameUtils;
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.ProgressBar;
   import morn.core.handlers.Handler;
   import roomList.pveRoomList.DungeonListController;
   import roomList.pvpRoomList.RoomListController;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamActiveInfo;
   import team.view.mornui.TeamActiveAlertViewUI;
   
   public class TeamActiveAlertView extends TeamActiveAlertViewUI
   {
       
      
      private var _btnHelp:BaseButton;
      
      public function TeamActiveAlertView(){super();}
      
      override protected function initialize() : void{}
      
      private function __onUpdateSelfActive(param1:TeamEvent) : void{}
      
      private function __onRenderActive(param1:Box, param2:int) : void{}
      
      private function __onSelectActive(param1:int) : void{}
      
      private function __onClickClose() : void{}
      
      override public function dispose() : void{}
   }
}
