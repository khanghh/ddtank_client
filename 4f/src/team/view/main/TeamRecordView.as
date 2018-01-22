package team.view.main
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import morn.core.components.Box;
   import morn.core.components.Label;
   import morn.core.ex.LevelIconEx;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamRecordInfo;
   import team.view.mornui.TeamRecordViewUI;
   
   public class TeamRecordView extends TeamRecordViewUI
   {
       
      
      private var _bg:Bitmap;
      
      public function TeamRecordView(){super();}
      
      override protected function initialize() : void{}
      
      public function update() : void{}
      
      private function __onUpdateRecord(param1:TeamEvent) : void{}
      
      private function updateBgView() : void{}
      
      private function __onRenderFailList(param1:Box, param2:int) : void{}
      
      private function __onRenderWinList(param1:Box, param2:int) : void{}
      
      private function __onRenderTabList(param1:Box, param2:int) : void{}
      
      private function __onSelectTabList(param1:int) : void{}
      
      private function __onPageSelect(param1:int) : void{}
      
      public function updateGameInfo(param1:TeamRecordInfo) : void{}
      
      override public function dispose() : void{}
   }
}
