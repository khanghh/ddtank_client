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
      
      public function FightLibState(){super();}
      
      override public function dispose() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function __startLoading(param1:Event) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function leaving(param1:BaseStateView) : void{}
   }
}
