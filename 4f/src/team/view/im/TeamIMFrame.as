package team.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.im.TeamRecordFrame;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import morn.core.components.Box;
   import morn.core.components.Clip;
   import morn.core.ex.LevelIconEx;
   import morn.core.ex.NameTextEx;
   import morn.core.handlers.Handler;
   import road7th.utils.StringHelper;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamMemberInfo;
   import team.view.mornui.TeamChat.TeamChatUI;
   
   public class TeamIMFrame extends TeamChatUI
   {
       
      
      private var _teamRecordFrame:TeamRecordFrame;
      
      private var _moveRect:Sprite;
      
      private var _show:Boolean = false;
      
      private var _info:PlayerInfo;
      
      private var _myColorMatrix_filter:ColorMatrixFilter;
      
      public function TeamIMFrame(){super();}
      
      private function initView() : void{}
      
      private function get teamChatPlayer() : Array{return null;}
      
      private function __updateTeamChatList(param1:TeamEvent) : void{}
      
      private function __onRenderMemeber(param1:Box, param2:int) : void{}
      
      private function addEvent() : void{}
      
      private function __textInput(param1:MouseEvent) : void{}
      
      private function __recordHanlder(param1:MouseEvent) : void{}
      
      private function closeRecordFrame() : void{}
      
      protected function __recordCloseHandler(param1:Event) : void{}
      
      protected function __recordResponseHandler(param1:FrameEvent) : void{}
      
      private function __minChatView(param1:MouseEvent) : void{}
      
      public function addMessage(param1:String) : void{}
      
      public function addAllMessage(param1:Vector.<String>) : void{}
      
      protected function __keyUpHandler(param1:KeyboardEvent) : void{}
      
      protected function __sendHandler(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function __closeChat(param1:MouseEvent) : void{}
      
      private function updateMoveRect() : void{}
      
      protected function __onFrameMoveStart(param1:MouseEvent) : void{}
      
      protected function __onFrameMoveStop(param1:MouseEvent) : void{}
      
      protected function __onMoveWindow(param1:MouseEvent) : void{}
      
      override public function dispose() : void{}
   }
}
