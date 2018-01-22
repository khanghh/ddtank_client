package room.view.smallMapInfoPanel
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.events.RoomPlayerEvent;
   import room.model.RoomInfo;
   import room.view.chooseMap.DungeonChooseMapFrame;
   
   public class DungeonSmallMapInfoPanel extends MissionRoomSmallMapInfoPanel
   {
       
      
      private var _btn:SimpleBitmapButton;
      
      public function DungeonSmallMapInfoPanel(){super();}
      
      private function removeEvents() : void{}
      
      override protected function initView() : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function showAlert() : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      override public function set info(param1:RoomInfo) : void{}
      
      private function __update(param1:RoomPlayerEvent) : void{}
      
      override protected function updateView() : void{}
      
      override protected function solvePath() : String{return null;}
      
      override public function dispose() : void{}
   }
}
