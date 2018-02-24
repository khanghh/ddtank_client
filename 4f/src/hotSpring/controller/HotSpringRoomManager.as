package hotSpring.controller
{
   import ddt.data.HotSpringRoomInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.HotSpringManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.states.BaseStateView;
   import flash.events.Event;
   import flash.geom.Point;
   import funnyGames.FunnyGamesManager;
   import hotSpring.model.HotSpringRoomModel;
   import hotSpring.view.HotSpringRoomView;
   import hotSpring.vo.PlayerVO;
   import road7th.comm.PackageIn;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class HotSpringRoomManager extends BaseStateView
   {
       
      
      private var _model:HotSpringRoomModel;
      
      private var _view:HotSpringRoomView;
      
      private var _isActive:Boolean = true;
      
      private var _messageTip:String;
      
      public function HotSpringRoomManager(){super();}
      
      override public function prepare() : void{}
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void{}
      
      private function setEvent() : void{}
      
      private function removeEvent() : void{}
      
      private function __activeChange(param1:Event) : void{}
      
      private function roomAddOrUpdate(param1:CrazyTankSocketEvent) : void{}
      
      private function roomPlayerAdd(param1:CrazyTankSocketEvent) : void{}
      
      public function roomPlayerRemoveSend(param1:String = "") : void{}
      
      private function roomPlayerRemoveNotice(param1:CrazyTankSocketEvent) : void{}
      
      public function roomPlayerTargetPointSend(param1:PlayerVO) : void{}
      
      private function roomPlayerTargetPoint(param1:CrazyTankSocketEvent) : void{}
      
      public function roomRenewalFee(param1:HotSpringRoomInfo) : void{}
      
      public function roomEdit(param1:HotSpringRoomInfo) : void{}
      
      public function roomPlayerContinue(param1:Boolean) : void{}
      
      override public function leaving(param1:BaseStateView) : void{}
      
      override public function getBackType() : String{return null;}
      
      override public function getType() : String{return null;}
      
      override public function dispose() : void{}
   }
}
