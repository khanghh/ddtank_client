package church.view.weddingRoomList
{
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import church.controller.ChurchRoomListController;
   import church.model.ChurchRoomListModel;
   import church.view.weddingRoomList.frame.HighClassWeddingFrame;
   import church.view.weddingRoomList.frame.WeddingRoomCreateView;
   import church.view.weddingRoomList.frame.WeddingUnmarryView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class WeddingRoomListNavView extends Sprite implements Disposeable
   {
      
      public static const DIVORCE_NUM:int = 5214;
       
      
      private var _controller:ChurchRoomListController;
      
      private var _model:ChurchRoomListModel;
      
      private var _bgNavAsset:MutipleImage;
      
      private var _highClassWeddingBtn:SimpleBitmapButton;
      
      private var _btnCreateAsset:BaseButton;
      
      private var _btnJoinAsset:BaseButton;
      
      private var _btnDivorceAsset:BaseButton;
      
      private var _createRoomFrame:WeddingRoomCreateView;
      
      private var _weddingUnmarryView:WeddingUnmarryView;
      
      public function WeddingRoomListNavView(param1:ChurchRoomListController, param2:ChurchRoomListModel)
      {
         super();
         _controller = param1;
         _model = param2;
         initialize();
      }
      
      protected function initialize() : void
      {
         setView();
         addEvent();
      }
      
      private function setView() : void
      {
         _bgNavAsset = ComponentFactory.Instance.creatComponentByStylename("churchroomlist.WeddingRoomListNavViewBG");
         addChild(_bgNavAsset);
         _highClassWeddingBtn = ComponentFactory.Instance.creatComponentByStylename("church.highClassWeddingBtn");
         addChild(_highClassWeddingBtn);
         _btnCreateAsset = ComponentFactory.Instance.creat("church.main.btnCreateAsset");
         addChild(_btnCreateAsset);
         _btnJoinAsset = ComponentFactory.Instance.creat("church.main.btnJoinAsset");
         addChild(_btnJoinAsset);
         _btnDivorceAsset = ComponentFactory.Instance.creat("church.main.btnDivorceAsset");
         addChild(_btnDivorceAsset);
         if(DivorcePromptFrame.Instance.isOpenDivorce == true)
         {
            _openDivorce();
            DivorcePromptFrame.Instance.isOpenDivorce = false;
         }
      }
      
      private function highClassWeddingBtnEnable() : Boolean
      {
         var _loc2_:Number = ServerConfigManager.instance.getSeniorMarryBegin().getTime();
         var _loc3_:Number = ServerConfigManager.instance.getSeniorMarryEnd().getTime();
         var _loc1_:Number = TimeManager.Instance.Now().getTime();
         if(_loc1_ >= _loc2_ && _loc1_ <= _loc3_)
         {
            return true;
         }
         return false;
      }
      
      private function removeView() : void
      {
         if(_bgNavAsset)
         {
            if(_bgNavAsset.parent)
            {
               _bgNavAsset.parent.removeChild(_bgNavAsset);
            }
         }
         _bgNavAsset = null;
         ObjectUtils.disposeObject(_highClassWeddingBtn);
         _highClassWeddingBtn = null;
         if(_btnCreateAsset)
         {
            if(_btnCreateAsset.parent)
            {
               _btnCreateAsset.parent.removeChild(_btnCreateAsset);
            }
            _btnCreateAsset.dispose();
         }
         _btnCreateAsset = null;
         if(_btnJoinAsset)
         {
            if(_btnJoinAsset.parent)
            {
               _btnJoinAsset.parent.removeChild(_btnJoinAsset);
            }
            _btnJoinAsset.dispose();
         }
         _btnJoinAsset = null;
         if(_btnDivorceAsset)
         {
            if(_btnDivorceAsset.parent)
            {
               _btnDivorceAsset.parent.removeChild(_btnDivorceAsset);
            }
            _btnDivorceAsset.dispose();
         }
         _btnDivorceAsset = null;
         if(_createRoomFrame)
         {
            if(_createRoomFrame.parent)
            {
               _createRoomFrame.parent.removeChild(_createRoomFrame);
            }
            _createRoomFrame.dispose();
         }
         _createRoomFrame = null;
      }
      
      private function addEvent() : void
      {
         _highClassWeddingBtn.addEventListener("click",onClickListener);
         _btnCreateAsset.addEventListener("click",onClickListener);
         _btnJoinAsset.addEventListener("click",onClickListener);
         _btnDivorceAsset.addEventListener("click",onClickListener);
      }
      
      private function removeEvent() : void
      {
         _highClassWeddingBtn.removeEventListener("click",onClickListener);
         _btnCreateAsset.removeEventListener("click",onClickListener);
         _btnJoinAsset.removeEventListener("click",onClickListener);
         _btnDivorceAsset.removeEventListener("click",onClickListener);
      }
      
      private function onClickListener(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:* = param1.currentTarget;
         if(_highClassWeddingBtn !== _loc2_)
         {
            if(_btnCreateAsset !== _loc2_)
            {
               if(_btnJoinAsset !== _loc2_)
               {
                  if(_btnDivorceAsset === _loc2_)
                  {
                     if(!PlayerManager.Instance.Self.IsMarried)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.weddingRoom.RoomListBtnPanel.clickListener"));
                        return;
                     }
                     _openDivorce();
                  }
               }
               else
               {
                  _controller.changeViewState("room list");
               }
            }
            else
            {
               showWeddingRoomCreateView();
            }
         }
         else
         {
            showHighClassWeddingFrame();
         }
      }
      
      private function _openDivorce() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(85),__mateTime);
         SocketManager.Instance.out.sendMateTime(PlayerManager.Instance.Self.SpouseID);
      }
      
      private function __mateTime(param1:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(85),__mateTime);
         var _loc3_:Date = param1.pkg.readDate();
         var _loc2_:int = CalculateDate.needMoney(_loc3_);
         showUnmarryFrame(_loc3_,_loc2_);
      }
      
      private function showHighClassWeddingFrame() : void
      {
         var _loc1_:int = 0;
         if(!PlayerManager.Instance.Self.IsMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.weddingRoom.WeddingRoomControler.showCreateFrame"));
            return;
         }
         if(ChurchManager.instance.selfRoom)
         {
            _loc1_ = ChurchManager.instance.selfRoom.seniorType;
            if(_loc1_ >= 1 && _loc1_ <= 3)
            {
               SocketManager.Instance.out.sendEnterRoom(0,"",2);
            }
            else
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("common.church.ChurchDialogueRejectPropose.creatWeddingTxt"));
            }
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(338),__onRequestSeniorChurch);
         SocketManager.Instance.out.sendRequestSeniorChurch();
      }
      
      private function __onRequestSeniorChurch(param1:PkgEvent) : void
      {
         SocketManager.Instance.removeEventListener(PkgEvent.format(338),__onRequestSeniorChurch);
         var _loc2_:HighClassWeddingFrame = ComponentFactory.Instance.creat("church.highClassWeddingFrame");
         _loc2_.setController(_controller);
         _loc2_.isSaleWedding = param1.pkg.readBoolean();
         if(_loc2_.isSaleWedding)
         {
            _loc2_.WeddingMoney = param1.pkg.readUTF();
         }
         else
         {
            _loc2_.WeddingMoney = ServerConfigManager.instance.firstSeniorMarryMoney();
         }
         _loc2_.initView();
         LayerManager.Instance.addToLayer(_loc2_,3,true,1);
      }
      
      public function showWeddingRoomCreateView() : void
      {
         var _loc1_:int = 0;
         if(!PlayerManager.Instance.Self.IsMarried)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.weddingRoom.WeddingRoomControler.showCreateFrame"));
            return;
         }
         if(ChurchManager.instance.selfRoom)
         {
            if(ChurchManager.instance.selfRoom.seniorType == 0)
            {
               _loc1_ = 1;
            }
            else if(ChurchManager.instance.selfRoom.seniorType == 4)
            {
               _loc1_ = 3;
            }
            else
            {
               _loc1_ = 2;
            }
            SocketManager.Instance.out.sendEnterRoom(0,"",_loc1_);
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _createRoomFrame = ComponentFactory.Instance.creat("church.main.weddingRoomList.weddingRoomCreateView");
         _createRoomFrame.setController(_controller,_model);
         _createRoomFrame.show();
      }
      
      public function showUnmarryFrame(param1:Date, param2:int) : void
      {
         _weddingUnmarryView = ComponentFactory.Instance.creat("church.weddingRoomList.frame.WeddingUnmarryView");
         _weddingUnmarryView.controller = _controller;
         var _loc3_:Array = CalculateDate.start(param1);
         _weddingUnmarryView.setText(_loc3_[0],param2.toString());
         _weddingUnmarryView.show(param2);
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
