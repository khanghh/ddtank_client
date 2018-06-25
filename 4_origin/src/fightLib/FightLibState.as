package fightLib
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.states.BaseStateView;
   import ddt.view.MainToolBar;
   import flash.display.Shape;
   import flash.events.Event;
   import gameCommon.GameControl;
   import par.ParticleManager;
   import room.RoomManager;
   import roomLoading.view.RoomLoadingView;
   
   public class FightLibState extends BaseStateView
   {
      
      public static const LibLevelMin:int = 15;
      
      public static const GuildOne:int = 1;
      
      public static const GuildTwo:int = 2;
       
      
      private var _container:Shape;
      
      private var _roomLoading:RoomLoadingView;
      
      public function FightLibState()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_roomLoading)
         {
            ObjectUtils.disposeObject(_roomLoading);
            _roomLoading = null;
         }
         super.dispose();
      }
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
         ParticleManager.initPartical(PathManager.FLASHSITE);
         GameControl.Instance.addEventListener("StartLoading",__startLoading);
         _container = new Shape();
         _container.graphics.beginFill(0,1);
         _container.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageHeight);
         _container.graphics.endFill();
         addChild(_container);
         PlayerManager.Instance.Self.sendOverTimeListByBody();
         GameInSocketOut.sendGameStart();
      }
      
      private function __startLoading(evt:Event) : void
      {
         ChatManager.Instance.input.faceEnabled = false;
         ChatManager.Instance.state = 9;
         LayerManager.Instance.clearnGameDynamic();
         RoomManager.Instance.current.selfRoomPlayer.resetCharacter();
         _roomLoading = new RoomLoadingView(GameControl.Instance.Current);
         addChild(_roomLoading);
         addChild(ChatManager.Instance.view);
         MainToolBar.Instance.hide();
         FightLibManager.Instance.lastInfo = null;
         FightLibManager.Instance.lastWin = false;
         FightLibControl.Instance.lastFightLibMission = null;
      }
      
      override public function getBackType() : String
      {
         return "main";
      }
      
      override public function getType() : String
      {
         return "fightLib";
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         GameControl.Instance.removeEventListener("StartLoading",__startLoading);
         PlayerManager.Instance.Self.isUpGradeInGame = false;
         FightLibManager.Instance.lastInfo = null;
         FightLibManager.Instance.lastWin = false;
         if(_roomLoading)
         {
            ObjectUtils.disposeObject(_roomLoading);
            _roomLoading = null;
         }
         if(next.getType() != "fightLabGameView")
         {
            GameInSocketOut.sendGamePlayerExit();
            RoomManager.Instance.reset();
         }
         PlayerManager.Instance.Self.sendOverTimeListByBody();
      }
   }
}
