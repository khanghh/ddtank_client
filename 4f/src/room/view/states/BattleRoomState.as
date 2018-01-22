package room.view.states
{
   import battleSkill.BattleSkillManager;
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.states.BaseStateView;
   import ddt.utils.PositionUtils;
   import ddt.view.MainToolBar;
   import flash.events.Event;
   import room.RoomManager;
   import room.view.roomView.BattleRoomView;
   
   public class BattleRoomState extends BaseRoomState
   {
       
      
      public function BattleRoomState(){super();}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      override protected function __startLoading(param1:Event) : void{}
      
      override public function getType() : String{return null;}
      
      override public function getBackType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
   }
}
