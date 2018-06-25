package hotSpring.controller{   import ddt.data.HotSpringRoomInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.PkgEvent;   import ddt.manager.HotSpringManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.states.BaseStateView;   import flash.events.Event;   import flash.geom.Point;   import funnyGames.FunnyGamesManager;   import hotSpring.model.HotSpringRoomModel;   import hotSpring.view.HotSpringRoomView;   import hotSpring.vo.PlayerVO;   import road7th.comm.PackageIn;   import uiModeManager.bombUI.HappyLittleGameManager;      public class HotSpringRoomManager extends BaseStateView   {                   private var _model:HotSpringRoomModel;            private var _view:HotSpringRoomView;            private var _isActive:Boolean = true;            private var _messageTip:String;            public function HotSpringRoomManager() { super(); }
            override public function prepare() : void { }
            override public function enter(prev:BaseStateView, data:Object = null) : void { }
            private function setEvent() : void { }
            private function removeEvent() : void { }
            private function __activeChange(event:Event) : void { }
            private function roomAddOrUpdate(event:CrazyTankSocketEvent) : void { }
            private function roomPlayerAdd(event:CrazyTankSocketEvent) : void { }
            public function roomPlayerRemoveSend(messageTip:String = "") : void { }
            private function roomPlayerRemoveNotice(event:CrazyTankSocketEvent) : void { }
            public function roomPlayerTargetPointSend(playerVO:PlayerVO) : void { }
            private function roomPlayerTargetPoint(event:CrazyTankSocketEvent) : void { }
            public function roomRenewalFee(roomVO:HotSpringRoomInfo) : void { }
            public function roomEdit(roomVO:HotSpringRoomInfo) : void { }
            public function roomPlayerContinue(isContinue:Boolean) : void { }
            override public function leaving(next:BaseStateView) : void { }
            override public function getBackType() : String { return null; }
            override public function getType() : String { return null; }
            override public function dispose() : void { }
   }}