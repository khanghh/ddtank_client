package newYearRice.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.BossBoxManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import ddt.view.UIModuleSmallLoading;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import invite.InviteFrame;
   import invite.InviteManager;
   import newYearRice.NewYearRiceController;
   import newYearRice.NewYearRiceManager;
   import road7th.comm.PackageIn;
   import room.RoomManager;
   
   public class NewYearRiceOpenFrameView extends Frame
   {
       
      
      private var _main:MovieClip;
      
      private var _openBtn:BaseButton;
      
      private var _inviteBtn:BaseButton;
      
      private var _playerItems:Vector.<PlayerCell>;
      
      private var _startInvite:Boolean = false;
      
      private var _inviteFrame:InviteFrame;
      
      private var _bg:Bitmap;
      
      private var _playerID:int;
      
      private var _isRoomPlayer:Boolean;
      
      private var _nameID:int;
      
      private var _alert1:BaseAlerFrame;
      
      private var _roomPlayerID:int;
      
      public function NewYearRiceOpenFrameView()
      {
         super();
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var cell:* = null;
         NewYearRiceManager.IsOpenFrame = true;
         InviteManager.Instance.enabled = false;
         if(RoomManager.Instance.current != null)
         {
            RoomManager.Instance.current = null;
         }
         BossBoxManager.instance.deleteBoxButton();
         NewYearRiceController.instance.openFrameView = this;
         _main = ClassUtils.CreatInstance("asset.newYearRice.view") as MovieClip;
         _main.gotoAndStop(2);
         PositionUtils.setPos(_main,"asset.newYearRice.view.pos");
         addToContent(_main);
         _openBtn = ComponentFactory.Instance.creat("NewYearRiceOpenFrameView.openBtn");
         addToContent(_openBtn);
         _inviteBtn = ComponentFactory.Instance.creat("NewYearRiceOpenFrameView.inviteBtn");
         addToContent(_inviteBtn);
         _playerItems = new Vector.<PlayerCell>();
         for(i = 0; i < 6; )
         {
            cell = ComponentFactory.Instance.creatCustomObject("NewYearRiceOpenFrameView.playerCell." + i);
            cell.mouseEnabled = true;
            addToContent(cell);
            cell.addEventListener("click",__cellClick);
            _playerItems.push(cell);
            i++;
         }
      }
      
      private function __cellClick(e:MouseEvent) : void
      {
         var cell:PlayerCell = e.currentTarget as PlayerCell;
         if(cell.info != null && cell.info.ID != _roomPlayerID && _roomPlayerID > 0)
         {
            _nameID = cell.info.ID;
            _alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceOpenFrameView.view.QuitPlayer",cell.nikeName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _alert1.addEventListener("response",__quitPlayer);
         }
      }
      
      private function __quitPlayer(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__quitPlayer);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
         {
            SocketManager.Instance.out.sendQuitNewYearRiceRoom(_nameID);
         }
      }
      
      public function roomPlayerItem(id:int) : void
      {
         _roomPlayerID = id;
         _playerItems[0].setNickName(id,"right");
      }
      
      public function updatePlayerItem(players:Array) : void
      {
         var i:int = 0;
         for(i = 0; i < players.length; )
         {
            _playerItems[i].removePlayerCell();
            if(_playerItems[i].info == null)
            {
               _playerItems[i].setNickName(players[i].ID,i <= 2?"right":"left",players[i].Style,players[i].NikeName,players[i].Sex);
            }
            i++;
         }
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__responseHandler);
         _openBtn.addEventListener("click",__openBtnHandler);
         _inviteBtn.addEventListener("click",__inviteBtnHandler);
         NewYearRiceManager.instance.addEventListener("exitYearFoodRoom",__exitYearFoodRoom);
         NewYearRiceController.instance.addEventListener("updateView",__updateView);
         NewYearRiceManager.instance.addEventListener("yearFoodCreateFood",__quitYearFoodRoom);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__responseHandler);
         _openBtn.removeEventListener("click",__openBtnHandler);
         _inviteBtn.removeEventListener("click",__inviteBtnHandler);
         NewYearRiceManager.instance.removeEventListener("exitYearFoodRoom",__exitYearFoodRoom);
         NewYearRiceController.instance.removeEventListener("updateView",__updateView);
         NewYearRiceManager.instance.addEventListener("yearFoodCreateFood",__quitYearFoodRoom);
      }
      
      private function __quitYearFoodRoom(event:CrazyTankSocketEvent) : void
      {
         dispose();
      }
      
      private function __updateView(e:Event) : void
      {
         var i:int = 0;
         var playerArr:Array = NewYearRiceManager.instance.model.playersArray;
         for(i = 1; i < playerArr.length; )
         {
            _playerItems[i].removePlayerCell();
            if(_playerItems[i].info == null)
            {
               _playerItems[i].setNickName(playerArr[i].ID,i <= 2?"right":"left",playerArr[i].Style,playerArr[i].NikeName,playerArr[i].Sex);
            }
            i++;
         }
      }
      
      public function setBtnEnter() : void
      {
         var _loc1_:* = false;
         _openBtn.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _openBtn.mouseChildren = _loc1_;
         _openBtn.enable = _loc1_;
         _loc1_ = false;
         _inviteBtn.mouseEnabled = _loc1_;
         _loc1_ = _loc1_;
         _inviteBtn.mouseChildren = _loc1_;
         _inviteBtn.enable = _loc1_;
      }
      
      private function __exitYearFoodRoom(event:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var pkg:PackageIn = event.pkg;
         _isRoomPlayer = pkg.readBoolean();
         _playerID = pkg.readInt();
         if(_isRoomPlayer)
         {
            if(_inviteFrame)
            {
               _inviteFrame.removeEventListener("complete",__onInviteComplete);
               ObjectUtils.disposeObject(_inviteFrame);
               _inviteFrame = null;
            }
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("NewYearRiceOpenFrameView.RoomPlayer.Exit"));
            dispose();
         }
         else if(_playerItems && _playerItems.length > 1)
         {
            for(i = 1; i < _playerItems.length; )
            {
               if(_playerItems[i].playerID == _playerID)
               {
                  _playerItems[i].removePlayerCell();
               }
               i++;
            }
         }
      }
      
      public function setViewFrame(index:int) : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(index == 1)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.DinnerBG");
         }
         else if(index == 2)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.BanquetBG");
         }
         else
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.HanBG");
         }
         _bg.x = 66;
         _bg.y = -23;
         addToContent(_bg);
      }
      
      private function __openBtnHandler(evt:MouseEvent) : void
      {
         _startInvite = false;
         NewYearRiceManager.instance.model.yearFoodInfo = 0;
         SocketManager.Instance.out.sendNewYearRiceOpen(NewYearRiceManager.instance.model.playerNum);
      }
      
      private function __inviteBtnHandler(evt:MouseEvent) : void
      {
         if(_inviteFrame != null)
         {
            SoundManager.instance.play("008");
            __onInviteComplete(null);
         }
         else
         {
            startInvite();
         }
      }
      
      protected function startInvite() : void
      {
         if(!_startInvite && _inviteFrame == null)
         {
            _startInvite = true;
            loadInviteRes();
         }
      }
      
      private function loadInviteRes() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.addEventListener("uiModuleError",__onInviteResError);
         UIModuleSmallLoading.Instance.progress = 0;
         UIModuleSmallLoading.Instance.show();
         UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
         UIModuleLoader.Instance.addUIModuleImp("ddtinvite");
      }
      
      private function __onClose(event:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onInviteResComplete(evt:UIModuleEvent) : void
      {
         if(evt.module == "ddtinvite")
         {
            UIModuleSmallLoading.Instance.hide();
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
            UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
            if(_startInvite && _inviteFrame == null)
            {
               _inviteFrame = ComponentFactory.Instance.creatComponentByStylename("asset.ddtInviteFrame");
               LayerManager.Instance.addToLayer(_inviteFrame,2,true,2);
               _inviteFrame.addEventListener("complete",__onInviteComplete);
               _startInvite = false;
            }
         }
      }
      
      private function __onInviteComplete(evt:Event) : void
      {
         _inviteFrame.removeEventListener("complete",__onInviteComplete);
         ObjectUtils.disposeObject(_inviteFrame);
         _inviteFrame = null;
      }
      
      private function __onInviteResError(evt:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
         {
            SoundManager.instance.play("008");
            SocketManager.Instance.out.sendExitYearFoodRoom();
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvents();
         InviteManager.Instance.enabled = true;
         NewYearRiceController.instance.openFrameView = null;
         NewYearRiceManager.instance.model.playerNum = 0;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(_alert1)
         {
            ObjectUtils.disposeObject(_alert1);
            _alert1 = null;
         }
         if(_inviteFrame)
         {
            ObjectUtils.disposeObject(_inviteFrame);
            _inviteFrame = null;
         }
      }
   }
}
