package room.view.states
{
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import room.RoomManager;
   import room.view.roomView.DungeonRoomView;
   import trainer.view.NewHandContainer;
   
   public class DungeonRoomState extends BaseRoomState
   {
       
      
      public function DungeonRoomState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
   }
}
