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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         prev = prev;
         data = data;
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
      
      override protected function __startLoading(e:Event) : void
      {
         super.__startLoading(e);
      }
      
      override public function getType() : String
      {
         return "battleRoom";
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         MainToolBar.Instance.hide();
         super.leaving(next);
      }
   }
}
