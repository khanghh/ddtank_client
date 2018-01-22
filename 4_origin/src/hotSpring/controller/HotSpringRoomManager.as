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
      
      public function HotSpringRoomManager()
      {
         super();
      }
      
      override public function prepare() : void
      {
         super.prepare();
      }
      
      override public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         super.enter(param1,param2);
         HotSpringManager.instance.removeLoadingEvent();
         _model = HotSpringRoomModel.Instance;
         if(_view)
         {
            _view.hide();
            _view.dispose();
         }
         _view = null;
         _view = new HotSpringRoomView(this,_model);
         _view.show();
         if(StateManager.lastStateType == "minGameCubes")
         {
            StateManager.lastStateType = "";
            HappyLittleGameManager.instance.show();
         }
         graphics.beginFill(0);
         graphics.drawRect(0,0,1000,600);
         graphics.endFill();
         setEvent();
      }
      
      private function setEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(173),roomAddOrUpdate);
         SocketManager.Instance.addEventListener(PkgEvent.format(198),roomPlayerAdd);
         SocketManager.Instance.addEventListener(PkgEvent.format(199),roomPlayerRemoveNotice);
         SocketManager.Instance.addEventListener(PkgEvent.format(191,1),roomPlayerTargetPoint);
      }
      
      private function removeEvent() : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(173),roomAddOrUpdate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(198),roomPlayerAdd);
         SocketManager.Instance.removeEventListener(PkgEvent.format(199),roomPlayerRemoveNotice);
         SocketManager.Instance.removeEventListener(PkgEvent.format(191,1),roomPlayerTargetPoint);
         removeEventListener("activate",__activeChange);
         removeEventListener("deactivate",__activeChange);
         removeEventListener("click",__activeChange);
      }
      
      private function __activeChange(param1:Event) : void
      {
         if(param1.type == "deactivate")
         {
            _isActive = false;
         }
         else
         {
            _isActive = true;
         }
      }
      
      private function roomAddOrUpdate(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:HotSpringRoomInfo = new HotSpringRoomInfo();
         _loc3_.roomNumber = _loc2_.readInt();
         _loc3_.roomID = _loc2_.readInt();
         _loc3_.roomName = _loc2_.readUTF();
         _loc3_.roomPassword = _loc2_.readUTF();
         _loc3_.effectiveTime = _loc2_.readInt();
         _loc3_.curCount = _loc2_.readInt();
         _loc3_.playerID = _loc2_.readInt();
         _loc3_.playerName = _loc2_.readUTF();
         _loc3_.startTime = _loc2_.readDate();
         _loc3_.roomIntroduction = _loc2_.readUTF();
         _loc3_.roomType = _loc2_.readInt();
         _loc3_.maxCount = _loc2_.readInt();
         _loc3_.roomIsPassword = _loc3_.roomPassword != "" && _loc3_.roomPassword.length > 0;
         if(HotSpringManager.instance.roomCurrently && _loc3_.roomID == HotSpringManager.instance.roomCurrently.roomID)
         {
            HotSpringManager.instance.roomCurrently = _loc3_;
         }
      }
      
      private function roomPlayerAdd(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            _loc3_ = _model.selfVO;
         }
         else
         {
            _loc3_ = new PlayerVO();
         }
         var _loc5_:PlayerInfo = PlayerManager.Instance.findPlayer(_loc2_);
         _loc5_.beginChanges();
         _loc5_.Grade = _loc4_.readInt();
         _loc5_.Hide = _loc4_.readInt();
         _loc5_.Repute = _loc4_.readInt();
         _loc5_.NickName = _loc4_.readUTF();
         _loc5_.typeVIP = _loc4_.readByte();
         _loc5_.VIPLevel = _loc4_.readInt();
         _loc5_.Sex = _loc4_.readBoolean();
         _loc5_.Style = _loc4_.readUTF();
         _loc5_.Colors = _loc4_.readUTF();
         _loc5_.Skin = _loc4_.readUTF();
         var _loc6_:Point = new Point(_loc4_.readInt(),_loc4_.readInt());
         _loc5_.FightPower = _loc4_.readInt();
         _loc5_.WinCount = _loc4_.readInt();
         _loc5_.TotalCount = _loc4_.readInt();
         _loc3_.playerDirection = _loc4_.readInt();
         _loc5_.commitChanges();
         _loc3_.playerInfo = _loc5_;
         _loc3_.playerPos = _loc6_;
         if(_loc2_ == PlayerManager.Instance.Self.ID)
         {
            _model.selfVO = _loc3_;
         }
         _model.roomPlayerAddOrUpdate(_loc3_);
      }
      
      public function roomPlayerRemoveSend(param1:String = "") : void
      {
         HotSpringManager.instance.messageTip = param1;
         SocketManager.Instance.out.sendHotSpringRoomPlayerRemove();
      }
      
      private function roomPlayerRemoveNotice(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         _model.roomPlayerRemove(_loc2_);
      }
      
      public function roomPlayerTargetPointSend(param1:PlayerVO) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomPlayerTargetPoint(param1);
      }
      
      private function roomPlayerTargetPoint(param1:CrazyTankSocketEvent) : void
      {
         var _loc11_:* = 0;
         var _loc7_:* = null;
         var _loc9_:PackageIn = param1.pkg;
         var _loc10_:String = _loc9_.readUTF();
         var _loc4_:int = _loc9_.readInt();
         var _loc3_:int = _loc9_.readInt();
         var _loc2_:int = _loc9_.readInt();
         var _loc5_:Array = _loc10_.split(",");
         var _loc8_:Array = [];
         _loc11_ = uint(0);
         while(_loc11_ < _loc5_.length)
         {
            _loc7_ = new Point(_loc5_[_loc11_],_loc5_[_loc11_ + 1]);
            _loc8_.push(_loc7_);
            _loc11_ = uint(_loc11_ + 2);
         }
         var _loc6_:PlayerVO = _model.roomPlayerList[_loc4_] as PlayerVO;
         if(!_loc6_)
         {
            return;
         }
         if(_isActive)
         {
            _loc6_.currentWalkStartPoint = new Point(_loc3_,_loc2_);
            _loc6_.walkPath = _loc8_;
            _model.roomPlayerAddOrUpdate(_loc6_);
         }
         else
         {
            _loc6_.playerPos = _loc8_.pop();
         }
      }
      
      public function roomRenewalFee(param1:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomRenewalFee(param1.roomID);
      }
      
      public function roomEdit(param1:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEdit(param1);
      }
      
      public function roomPlayerContinue(param1:Boolean) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomPlayerContinue(param1);
      }
      
      override public function leaving(param1:BaseStateView) : void
      {
         if(!FunnyGamesManager.getInstance().status)
         {
            roomPlayerRemoveSend();
         }
         dispose();
         super.leaving(param1);
      }
      
      override public function getBackType() : String
      {
         return "hotSpringRoomList";
      }
      
      override public function getType() : String
      {
         return "hotSpringRoom";
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_view)
         {
            _view.hide();
            _view.dispose();
         }
         _view = null;
         if(_model)
         {
            _model.dispose();
         }
         _model = null;
      }
   }
}
