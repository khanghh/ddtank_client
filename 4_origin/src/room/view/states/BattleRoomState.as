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
       
      
      public function BattleRoomState()
      {
         super();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         prev = param1;
         data = param2;
         _roomView = new BattleRoomView(RoomManager.Instance.current);
         PositionUtils.setPos(_roomView,"asset.ddtroom.battleroomstate.pos");
         addChild(_roomView);
         super.enter(prev,data);
         SocketManager.Instance.out.battleGroundUpdata(1);
         BattleSkillManager.instance.loadTempleResource(function():*
         {
            var /*UnknownSlot*/:* = function():void
            {
               GameInSocketOut.sendGetBattleSkillInfo();
            };
            return function():void
            {
               GameInSocketOut.sendGetBattleSkillInfo();
            };
         }());
         if(!BoneMovieFactory.instance.model.hasLoadingBones("gamebones"))
         {
            BonesLoaderManager.instance.loadBonesStyle("gamebones",PathManager.getBonesPath("gamebones"));
         }
      }
      
      override protected function __startLoading(param1:Event) : void
      {
         super.__startLoading(param1);
      }
      
      override public function getType() : String
      {
         return "battleRoom";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(param1);
      }
   }
}
