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
      
      override public function enter(prev:BaseStateView, data:Object = null) : void
      {
         super.enter(prev,data);
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
      
      private function __activeChange(event:Event) : void
      {
         if(event.type == "deactivate")
         {
            _isActive = false;
         }
         else
         {
            _isActive = true;
         }
      }
      
      private function roomAddOrUpdate(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var roomVO:HotSpringRoomInfo = new HotSpringRoomInfo();
         roomVO.roomNumber = pkg.readInt();
         roomVO.roomID = pkg.readInt();
         roomVO.roomName = pkg.readUTF();
         roomVO.roomPassword = pkg.readUTF();
         roomVO.effectiveTime = pkg.readInt();
         roomVO.curCount = pkg.readInt();
         roomVO.playerID = pkg.readInt();
         roomVO.playerName = pkg.readUTF();
         roomVO.startTime = pkg.readDate();
         roomVO.roomIntroduction = pkg.readUTF();
         roomVO.roomType = pkg.readInt();
         roomVO.maxCount = pkg.readInt();
         roomVO.roomIsPassword = roomVO.roomPassword != "" && roomVO.roomPassword.length > 0;
         if(HotSpringManager.instance.roomCurrently && roomVO.roomID == HotSpringManager.instance.roomCurrently.roomID)
         {
            HotSpringManager.instance.roomCurrently = roomVO;
         }
      }
      
      private function roomPlayerAdd(event:CrazyTankSocketEvent) : void
      {
         var playerVO:* = null;
         var pkg:PackageIn = event.pkg;
         var playerID:int = pkg.readInt();
         if(playerID == PlayerManager.Instance.Self.ID)
         {
            playerVO = _model.selfVO;
         }
         else
         {
            playerVO = new PlayerVO();
         }
         var playerInfo:PlayerInfo = PlayerManager.Instance.findPlayer(playerID);
         playerInfo.beginChanges();
         playerInfo.Grade = pkg.readInt();
         playerInfo.Hide = pkg.readInt();
         playerInfo.Repute = pkg.readInt();
         playerInfo.NickName = pkg.readUTF();
         playerInfo.typeVIP = pkg.readByte();
         playerInfo.VIPLevel = pkg.readInt();
         playerInfo.Sex = pkg.readBoolean();
         playerInfo.Style = pkg.readUTF();
         playerInfo.Colors = pkg.readUTF();
         playerInfo.Skin = pkg.readUTF();
         var playerPos:Point = new Point(pkg.readInt(),pkg.readInt());
         playerInfo.FightPower = pkg.readInt();
         playerInfo.WinCount = pkg.readInt();
         playerInfo.TotalCount = pkg.readInt();
         playerVO.playerDirection = pkg.readInt();
         playerInfo.commitChanges();
         playerVO.playerInfo = playerInfo;
         playerVO.playerPos = playerPos;
         if(playerID == PlayerManager.Instance.Self.ID)
         {
            _model.selfVO = playerVO;
         }
         _model.roomPlayerAddOrUpdate(playerVO);
      }
      
      public function roomPlayerRemoveSend(messageTip:String = "") : void
      {
         HotSpringManager.instance.messageTip = messageTip;
         SocketManager.Instance.out.sendHotSpringRoomPlayerRemove();
      }
      
      private function roomPlayerRemoveNotice(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var playerID:int = pkg.readInt();
         _model.roomPlayerRemove(playerID);
      }
      
      public function roomPlayerTargetPointSend(playerVO:PlayerVO) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomPlayerTargetPoint(playerVO);
      }
      
      private function roomPlayerTargetPoint(event:CrazyTankSocketEvent) : void
      {
         var i:* = 0;
         var p:* = null;
         var pkg:PackageIn = event.pkg;
         var pathStr:String = pkg.readUTF();
         var playerID:int = pkg.readInt();
         var lastStartX:int = pkg.readInt();
         var lastStartY:int = pkg.readInt();
         var arr:Array = pathStr.split(",");
         var path:Array = [];
         for(i = uint(0); i < arr.length; )
         {
            p = new Point(arr[i],arr[i + 1]);
            path.push(p);
            i = uint(i + 2);
         }
         var playerVO:PlayerVO = _model.roomPlayerList[playerID] as PlayerVO;
         if(!playerVO)
         {
            return;
         }
         if(_isActive)
         {
            playerVO.currentWalkStartPoint = new Point(lastStartX,lastStartY);
            playerVO.walkPath = path;
            _model.roomPlayerAddOrUpdate(playerVO);
         }
         else
         {
            playerVO.playerPos = path.pop();
         }
      }
      
      public function roomRenewalFee(roomVO:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomRenewalFee(roomVO.roomID);
      }
      
      public function roomEdit(roomVO:HotSpringRoomInfo) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomEdit(roomVO);
      }
      
      public function roomPlayerContinue(isContinue:Boolean) : void
      {
         SocketManager.Instance.out.sendHotSpringRoomPlayerContinue(isContinue);
      }
      
      override public function leaving(next:BaseStateView) : void
      {
         if(!FunnyGamesManager.getInstance().status)
         {
            roomPlayerRemoveSend();
         }
         dispose();
         super.leaving(next);
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
