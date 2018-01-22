package room.view.roomView
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import room.RoomManager;
   import room.model.RoomInfo;
   import room.view.RoomPlayerItem;
   import room.view.RoomViewerItem;
   
   public class TeamRoomView extends MatchRoomView
   {
       
      
      public function TeamRoomView(param1:RoomInfo){super(null);}
      
      override protected function initView() : void{}
      
      override protected function updateButtons() : void{}
      
      override protected function __startClick(param1:MouseEvent) : void{}
      
      override protected function initPlayerItems() : void{}
   }
}
