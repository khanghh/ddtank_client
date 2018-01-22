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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("NewYearRiceOpenFrameView.playerCell." + _loc2_);
            _loc1_.mouseEnabled = true;
            addToContent(_loc1_);
            _loc1_.addEventListener("click",__cellClick);
            _playerItems.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __cellClick(param1:MouseEvent) : void
      {
         var _loc2_:PlayerCell = param1.currentTarget as PlayerCell;
         if(_loc2_.info != null && _loc2_.info.ID != _roomPlayerID && _roomPlayerID > 0)
         {
            _nameID = _loc2_.info.ID;
            _alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("NewYearRiceOpenFrameView.view.QuitPlayer",_loc2_.nikeName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _alert1.addEventListener("response",__quitPlayer);
         }
      }
      
      private function __quitPlayer(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__quitPlayer);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendQuitNewYearRiceRoom(_nameID);
         }
      }
      
      public function roomPlayerItem(param1:int) : void
      {
         _roomPlayerID = param1;
         _playerItems[0].setNickName(param1,"right");
      }
      
      public function updatePlayerItem(param1:Array) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _playerItems[_loc2_].removePlayerCell();
            if(_playerItems[_loc2_].info == null)
            {
               _playerItems[_loc2_].setNickName(param1[_loc2_].ID,_loc2_ <= 2?"right":"left",param1[_loc2_].Style,param1[_loc2_].NikeName,param1[_loc2_].Sex);
            }
            _loc2_++;
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
      
      private function __quitYearFoodRoom(param1:CrazyTankSocketEvent) : void
      {
         dispose();
      }
      
      private function __updateView(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = NewYearRiceManager.instance.model.playersArray;
         _loc3_ = 1;
         while(_loc3_ < _loc2_.length)
         {
            _playerItems[_loc3_].removePlayerCell();
            if(_playerItems[_loc3_].info == null)
            {
               _playerItems[_loc3_].setNickName(_loc2_[_loc3_].ID,_loc3_ <= 2?"right":"left",_loc2_[_loc3_].Style,_loc2_[_loc3_].NikeName,_loc2_[_loc3_].Sex);
            }
            _loc3_++;
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
      
      private function __exitYearFoodRoom(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         _isRoomPlayer = _loc2_.readBoolean();
         _playerID = _loc2_.readInt();
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
            _loc3_ = 1;
            while(_loc3_ < _playerItems.length)
            {
               if(_playerItems[_loc3_].playerID == _playerID)
               {
                  _playerItems[_loc3_].removePlayerCell();
               }
               _loc3_++;
            }
         }
      }
      
      public function setViewFrame(param1:int) : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(param1 == 1)
         {
            _bg = ComponentFactory.Instance.creatBitmap("asset.newYearRice.DinnerBG");
         }
         else if(param1 == 2)
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
      
      private function __openBtnHandler(param1:MouseEvent) : void
      {
         _startInvite = false;
         NewYearRiceManager.instance.model.yearFoodInfo = 0;
         SocketManager.Instance.out.sendNewYearRiceOpen(NewYearRiceManager.instance.model.playerNum);
      }
      
      private function __inviteBtnHandler(param1:MouseEvent) : void
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
      
      private function __onClose(param1:Event) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
      }
      
      private function __onInviteResComplete(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtinvite")
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
      
      private function __onInviteComplete(param1:Event) : void
      {
         _inviteFrame.removeEventListener("complete",__onInviteComplete);
         ObjectUtils.disposeObject(_inviteFrame);
         _inviteFrame = null;
      }
      
      private function __onInviteResError(param1:UIModuleEvent) : void
      {
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onInviteResComplete);
         UIModuleLoader.Instance.removeEventListener("uiModuleError",__onInviteResError);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
