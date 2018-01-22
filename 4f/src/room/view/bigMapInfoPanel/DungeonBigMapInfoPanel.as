package room.view.bigMapInfoPanel
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.events.RoomEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.MainToolBar;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.view.chooseMap.DungeonChooseMapFrame;
   
   public class DungeonBigMapInfoPanel extends MissionRoomBigMapInfoPanel
   {
       
      
      private var _chooseBtn:SimpleBitmapButton;
      
      public function DungeonBigMapInfoPanel(){super();}
      
      override protected function initEvents() : void{}
      
      private function __clickHandler(param1:MouseEvent) : void{}
      
      private function __outHandler(param1:MouseEvent) : void{}
      
      private function __overHandler(param1:MouseEvent) : void{}
      
      override protected function removeEvents() : void{}
      
      override protected function initView() : void{}
      
      private function leaveAlert() : void{}
      
      private function showAlert() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      private function __onGameStarted(param1:RoomEvent) : void{}
      
      override protected function __onMapChanged(param1:RoomEvent) : void{}
      
      private function __playerStateChange(param1:RoomEvent) : void{}
      
      private function __openBossChange(param1:RoomEvent) : void{}
      
      override protected function updateMap() : void{}
      
      override protected function solvePath() : String{return null;}
      
      override public function dispose() : void{}
   }
}
