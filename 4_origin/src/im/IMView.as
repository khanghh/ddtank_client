package im
{
   import academy.AcademyManager;
   import bagAndInfo.BagAndInfoManager;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.list.DropList;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.Base64;
   import com.pickgliss.utils.MD5;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.PlayerState;
   import ddt.data.player.SelfInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.ConfirmAlertData;
   import ddt.utils.HelperBuyAlert;
   import ddt.view.PlayerPortraitView;
   import ddt.view.common.LevelIcon;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import oldplayerintegralshop.IntegralShopController;
   import road7th.comm.PackageIn;
   import road7th.utils.StringHelper;
   import team.TeamManager;
   import team.event.TeamEvent;
   import vip.VipController;
   
   public class IMView extends Frame
   {
      
      private static const ALL_STATE:Array = [new PlayerState(1,1),new PlayerState(2,1),new PlayerState(3,1),new PlayerState(5,1),new PlayerState(4,1),new PlayerState(6,1)];
      
      public static const FRIEND_LIST:int = 0;
      
      public static const CMFRIEND_LIST:int = 2;
      
      public static const CONSORTIA_LIST:int = 1;
      
      public static const LIKEFRIEND_LIST:int = 3;
      
      public static const TEAM_LIST:int = 2;
       
      
      private var _IMSelectedBtn:SelectedTextButton;
      
      private var _likePersonSelectedBtn:SelectedTextButton;
      
      private var _addBlackFrame:AddBlackFrame;
      
      private var _addBleak:TextButton;
      
      private var _addFriend:TextButton;
      
      private var _myAcademyBtn:TextButton;
      
      private var _teamList:TeamListView;
      
      private var _inviteBtn:TextButton;
      
      private var _teamListBtn:SelectedTextButton;
      
      private var _addFriendFrame:AddFriendFrame;
      
      private var _bg:MutipleImage;
      
      private var _consortiaListBtn:SelectedTextButton;
      
      private var _levelIcon:LevelIcon;
      
      private var _selectedButtonGroup:SelectedButtonGroup;
      
      private var _currentListType:int;
      
      private var _friendList:IMListView;
      
      private var _consortiaList:ConsortiaListView;
      
      private var _CMfriendList:CMFriendList;
      
      private var _likeFriendList:LikeFriendListView;
      
      private var _listContent:Sprite;
      
      private var _selfName:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _playerPortrait:PlayerPortraitView;
      
      private var _imLookupView:IMLookupView;
      
      private var _stateSelectBtn:StateIconButton;
      
      private var _stateList:DropList;
      
      private var _replyInput:AutoReplyInput;
      
      private var _state:FilterFrameText;
      
      private var _uploadGirlHeadPhotoBtn:SimpleBitmapButton;
      
      private var _selectGirlHeadPhotoBtn:SimpleBitmapButton;
      
      private var _hBox:HBox;
      
      private var _integralShop:SimpleBitmapButton;
      
      public function IMView()
      {
         super();
         super.init();
         initContent();
         initEvent();
      }
      
      private function initContent() : void
      {
         titleText = LanguageMgr.GetTranslation("tank.game.ToolStripView.friend");
         _bg = ComponentFactory.Instance.creatComponentByStylename("IM.BGMovieImage");
         addToContent(_bg);
         _selfName = ComponentFactory.Instance.creatComponentByStylename("IM.IMList.selfName");
         _selfName.text = PlayerManager.Instance.Self.NickName;
         if(PlayerManager.Instance.Self.IsVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(138,PlayerManager.Instance.Self.typeVIP);
            _vipName.textSize = 18;
            _vipName.x = _selfName.x;
            _vipName.y = _selfName.y;
            _vipName.text = _selfName.text;
            addToContent(_vipName);
         }
         else
         {
            addToContent(_selfName);
         }
         _hBox = ComponentFactory.Instance.creatComponentByStylename("IM.btnHbox");
         addToContent(_hBox);
         _IMSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.IMSelectedBtn");
         _IMSelectedBtn.text = LanguageMgr.GetTranslation("tank.view.im.Friend");
         _hBox.addChild(_IMSelectedBtn);
         _consortiaListBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.consortiaListBtn");
         _consortiaListBtn.text = LanguageMgr.GetTranslation("tank.view.im.consorita");
         _hBox.addChild(_consortiaListBtn);
         _teamListBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.teamListBtn");
         _teamListBtn.text = LanguageMgr.GetTranslation("tank.view.im.team");
         _hBox.addChild(_teamListBtn);
         if(!(SharedManager.Instance.isCommunity && PathManager.CommunityExist()))
         {
            _likePersonSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.LikeSelectedBtnII");
         }
         else
         {
            _likePersonSelectedBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.LikeSelectedBtn");
         }
         _likePersonSelectedBtn.text = LanguageMgr.GetTranslation("tank.view.im.Like");
         _hBox.addChild(_likePersonSelectedBtn);
         _selectedButtonGroup = new SelectedButtonGroup();
         _selectedButtonGroup.addSelectItem(_IMSelectedBtn);
         _selectedButtonGroup.addSelectItem(_consortiaListBtn);
         _selectedButtonGroup.addSelectItem(_teamListBtn);
         _selectedButtonGroup.addSelectItem(_likePersonSelectedBtn);
         _selectedButtonGroup.selectIndex = 0;
         _hBox.arrange();
         _addFriend = ComponentFactory.Instance.creatComponentByStylename("IM.AddFriendBtn");
         _addFriend.text = LanguageMgr.GetTranslation("tank.view.im.addFriendBtn");
         _addFriend.tipData = LanguageMgr.GetTranslation("tank.view.im.AddFriendFrame.add");
         addToContent(_addFriend);
         _addBleak = ComponentFactory.Instance.creatComponentByStylename("IM.AddBleakBtn");
         _addBleak.text = LanguageMgr.GetTranslation("tank.view.im.addBleakBtn");
         _addBleak.tipData = LanguageMgr.GetTranslation("tank.view.im.AddBlackListFrame.btnText");
         addToContent(_addBleak);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("IM.imView.LevelIcon");
         _levelIcon.setSize(0);
         addToContent(_levelIcon);
         _listContent = new Sprite();
         addToContent(_listContent);
         _imLookupView = new IMLookupView();
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("IM.IMView.IMLookupViewPos");
         _imLookupView.x = _loc2_.x;
         _imLookupView.y = _loc2_.y;
         addToContent(_imLookupView);
         _myAcademyBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.myAcademyBtn");
         _myAcademyBtn.text = LanguageMgr.GetTranslation("tank.view.im.addAcadeBtn");
         _myAcademyBtn.tipData = LanguageMgr.GetTranslation("im.IMView.myAcademyBtnTips");
         addToContent(_myAcademyBtn);
         _stateSelectBtn = ComponentFactory.Instance.creatCustomObject("IM.stateIconButton");
         addToContent(_stateSelectBtn);
         _stateList = ComponentFactory.Instance.creatComponentByStylename("IMView.stateList");
         _stateList.targetDisplay = _stateSelectBtn;
         _stateList.showLength = 6;
         _state = ComponentFactory.Instance.creatComponentByStylename("IM.stateIconBtn.stateNameTxt");
         _state.text = "[" + PlayerManager.Instance.Self.playerState.convertToString() + "]";
         addToContent(_state);
         _replyInput = ComponentFactory.Instance.creatCustomObject("im.autoReplyInput");
         addToContent(_replyInput);
         var _loc1_:SelfInfo = PlayerManager.Instance.Self;
         _levelIcon.setInfo(_loc1_.Grade,_loc1_.ddtKingGrade,_loc1_.Repute,_loc1_.WinCount,_loc1_.TotalCount,_loc1_.FightPower,_loc1_.Offer,true,false);
         showFigure();
         _currentListType = 0;
         setListType();
         __onStateChange(new PlayerPropertyEvent("*",new Dictionary()));
         _integralShop = ComponentFactory.Instance.creatComponentByStylename("IMView.integralShopBtn");
         addToContent(_integralShop);
         _uploadGirlHeadPhotoBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.uploadGirlHeadPicBtn");
         _uploadGirlHeadPhotoBtn.enable = canUploadGirlHeadPhoto();
         _selectGirlHeadPhotoBtn = ComponentFactory.Instance.creatComponentByStylename("IMView.changeGirlHeadPicBtn");
         _selectGirlHeadPhotoBtn.enable = PlayerManager.Instance.Self.ImagePath != "";
         if(PathManager.girdHeadEnable)
         {
            addToContent(_uploadGirlHeadPhotoBtn);
            addToContent(_selectGirlHeadPhotoBtn);
         }
      }
      
      private function canUploadGirlHeadPhoto() : Boolean
      {
         return PlayerManager.Instance.Self.Grade >= 50 || PlayerManager.Instance.Self.IsVIP && PlayerManager.Instance.Self.VIPLevel >= 6;
      }
      
      private function initEvent() : void
      {
         _IMSelectedBtn.addEventListener("click",__IMBtnClick);
         _teamListBtn.addEventListener("click",__teamListBtnClick);
         _consortiaListBtn.addEventListener("click",__consortiaListBtnClick);
         _likePersonSelectedBtn.addEventListener("click",__likeBtnClick);
         _addFriend.addEventListener("click",__addFriendBtnClick);
         _addBleak.addEventListener("click",__addBleakBtnClick);
         _selectedButtonGroup.addEventListener("change",__buttonGroupChange);
         if(_myAcademyBtn)
         {
            _myAcademyBtn.addEventListener("click",__myAcademyClick);
         }
         _stateSelectBtn.addEventListener("click",__stateSelectClick);
         StageReferance.stage.addEventListener("click",__hideStateList);
         PlayerManager.Instance.Self.addEventListener("propertychange",__onStateChange);
         _integralShop.addEventListener("click",__onIntegralShop);
         if(_uploadGirlHeadPhotoBtn.enable)
         {
            _uploadGirlHeadPhotoBtn.addEventListener("click",onUploadBtnClick);
         }
         if(_selectGirlHeadPhotoBtn.enable)
         {
            _selectGirlHeadPhotoBtn.addEventListener("click",onChangeBtnClick);
         }
         PlayerManager.Instance.addEventListener("girl_head_photo_change",onHeadSelectChange);
         SocketManager.Instance.addEventListener(PkgEvent.format(339),onUseGirlNewPhoto);
      }
      
      private function __teamListBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.teamID <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.teamText"));
            _selectedButtonGroup.selectIndex = _currentListType;
            return;
         }
         LoadResourceManager.Instance.startLoad(LoaderCreate.Instance.createTeamMemeberLoader());
         TeamManager.instance.addEventListener("updateteammember",showTeamIM);
      }
      
      private function showTeamIM(param1:TeamEvent) : void
      {
         TeamManager.instance.removeEventListener("updateteammember",showTeamIM);
         _currentListType = 2;
         setListType();
      }
      
      protected function onHeadSelectChange(param1:CEvent) : void
      {
         _playerPortrait.onHeadSelectChange(PlayerManager.Instance.Self.IsShow);
      }
      
      protected function onChangeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         escEnable = false;
         var _loc2_:GirlHeadSelectView = new GirlHeadSelectView();
         _loc2_.x = 345;
         _loc2_.y = 17;
         _loc2_.onUseNewPic = onUseNewPic;
         _loc2_.onCurHeadSelected = onGirlHeadSelected;
         _loc2_.onClose = onGirlHeadClose;
         LayerManager.Instance.addToLayer(_loc2_,3,false,1);
      }
      
      private function onUseNewPic() : void
      {
         __onCheckOut = function():void
         {
            _selectGirlHeadPhotoBtn.enable = false;
            GameInSocketOut.sendUseGirlNewPhoto(__data.isBind);
         };
         var __msg:String = LanguageMgr.GetTranslation("im.changeGirlPic.confirm");
         var __data:ConfirmAlertData = new ConfirmAlertData();
         HelperBuyAlert.getInstance().alert(__msg,__data,null,__onCheckOut);
      }
      
      private function onUseGirlNewPhoto(param1:PkgEvent) : void
      {
         var _loc3_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:Boolean = _loc4_.readBoolean();
         if(_loc2_)
         {
            _uploadGirlHeadPhotoBtn.enable = canUploadGirlHeadPhoto();
            _selectGirlHeadPhotoBtn.enable = false;
            _selectGirlHeadPhotoBtn.addEventListener("click",onChangeBtnClick);
            IMManager.Instance.onDeleteGirlPic();
            openUploadSite();
         }
         else
         {
            _uploadGirlHeadPhotoBtn.enable = canUploadGirlHeadPhoto();
            _selectGirlHeadPhotoBtn.enable = true;
            _loc3_ = LanguageMgr.GetTranslation("im.changeGirlPic.useMoneyFailed");
            MessageTipManager.getInstance().show(_loc3_,0,false,1);
         }
      }
      
      private function onGirlHeadSelected(param1:Boolean) : void
      {
         IMManager.Instance.girlHeadSelectedBtnClicked(param1);
      }
      
      private function onGirlHeadClose() : void
      {
         escEnable = true;
      }
      
      protected function onUploadBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         openUploadSite();
      }
      
      private function openUploadSite() : void
      {
         if(canUploadGirlHeadPhoto() == false)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("imview.uploadBtn.notAccord"));
            return;
         }
         var _loc5_:String = "http://ddthead.7road.com";
         var _loc4_:String = PlayerManager.Instance.Self.NickName;
         var _loc2_:String = PlayerManager.Instance.Self.SubName;
         var _loc12_:String = "7road_ddthead";
         var _loc3_:String = TimeManager.Instance.Now().time.toString();
         var _loc8_:String = encodeURI(Base64.encode(_loc4_)).replace("+","%2B").replace("=","%3D").replace("/","%2F");
         var _loc10_:String = encodeURI(Base64.encode(_loc2_)).replace("+","%2B").replace("=","%3D").replace("/","%2F");
         var _loc7_:String = PlayerManager.Instance.Self.SubID.toString();
         var _loc1_:String = PlayerManager.Instance.Self.ID.toString();
         var _loc9_:String = MD5.hash(_loc3_ + _loc7_ + _loc1_ + _loc12_);
         var _loc11_:String = _loc5_ + "/?SubID=" + _loc7_ + "&UserID=" + _loc1_ + "&timestamp=" + _loc3_ + "&nick=" + _loc8_ + "&subname=" + _loc10_ + "&key=" + _loc9_;
         var _loc6_:URLRequest = new URLRequest(_loc11_);
         return;
         §§push(navigateToURL(_loc6_,"_blank"));
      }
      
      protected function __onIntegralShop(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         IntegralShopController.instance.show();
      }
      
      private function __CMBtnClick(param1:MouseEvent) : void
      {
         IMManager.Instance.createConsortiaLoader();
         IMManager.Instance.addEventListener("CMFriendComplete",__CMFriendLoadComplete);
         SoundManager.instance.play("008");
      }
      
      private function __CMFriendLoadComplete(param1:Event) : void
      {
         IMControl.Instance.removeEventListener("CMFriendComplete",__CMFriendLoadComplete);
         _currentListType = 2;
         setListType();
      }
      
      private function __IMBtnClick(param1:MouseEvent) : void
      {
         _currentListType = 0;
         setListType();
         SoundManager.instance.play("008");
      }
      
      private function __inviteBtnClick(param1:MouseEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.inviteInfo"));
         SoundManager.instance.play("008");
         if(!StringHelper.isNullOrEmpty(PathManager.CommunityInvite()))
         {
            _loc4_ = new URLRequest(PathManager.CommunityInvite());
            _loc3_ = new URLVariables();
            _loc3_["fuid"] = String(PlayerManager.Instance.Self.LoginName);
            _loc3_["fnick"] = PlayerManager.Instance.Self.NickName;
            _loc3_["tuid"] = _CMfriendList.currentCMFInfo.UserName;
            _loc3_["serverid"] = String(ServerManager.Instance.AgentID);
            _loc3_["rnd"] = Math.random();
            _loc4_.data = _loc3_;
            _loc2_ = new URLLoader(_loc4_);
            _loc2_.load(_loc4_);
         }
      }
      
      private function __consortiaListBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.ConsortiaID <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.infoText"));
            _selectedButtonGroup.selectIndex = _currentListType;
            return;
         }
         _currentListType = 1;
         setListType();
      }
      
      private function __likeBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _currentListType = 3;
         setListType();
      }
      
      private function __addBleakBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_addFriendFrame && _addFriendFrame.parent)
         {
            _addFriendFrame.dispose();
            _addFriendFrame = null;
         }
         if(_addBlackFrame && _addBlackFrame.parent)
         {
            _addBlackFrame.dispose();
            _addBlackFrame = null;
            return;
         }
         _addBlackFrame = ComponentFactory.Instance.creat("AddBlackFrame");
         LayerManager.Instance.addToLayer(_addBlackFrame,3);
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = false;
         }
         if(StateManager.currentStateType == "fighting")
         {
            ComponentSetting.SEND_USELOG_ID(127);
         }
      }
      
      private function __buttonGroupChange(param1:Event) : void
      {
         _hBox.arrange();
      }
      
      private function __myAcademyClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade >= 8)
         {
            if(PlayerManager.Instance.Self.apprenticeshipState != 0)
            {
               AcademyManager.Instance.myAcademy();
            }
            else
            {
               AcademyFrameManager.Instance.showAcademyPreviewFrame();
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("im.IMView.academyInfo"));
         }
      }
      
      private function __addFriendBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_currentListType == 0 || _currentListType == 1 || _currentListType == 3)
         {
            if(_addBlackFrame && _addBlackFrame.parent)
            {
               _addBlackFrame.dispose();
               _addBlackFrame = null;
            }
            if(_addFriendFrame && _addFriendFrame.parent)
            {
               _addFriendFrame.dispose();
               _addFriendFrame = null;
               return;
            }
            _addFriendFrame = ComponentFactory.Instance.creat("AddFriendFrame");
            LayerManager.Instance.addToLayer(_addFriendFrame,3);
         }
         else if(_CMfriendList && _CMfriendList.currentCMFInfo && _CMfriendList.currentCMFInfo.IsExist)
         {
            IMManager.Instance.addFriend(_CMfriendList.currentCMFInfo.NickName);
         }
         if(StateManager.currentStateType == "main")
         {
            ChatManager.Instance.lock = false;
         }
         if(StateManager.currentStateType == "fighting")
         {
            ComponentSetting.SEND_USELOG_ID(126);
         }
      }
      
      private function showFigure() : void
      {
         var _loc1_:PlayerInfo = PlayerManager.Instance.Self;
         _playerPortrait = ComponentFactory.Instance.creatCustomObject("im.PlayerPortrait",["right",PlayerManager.Instance.Self.IsShow]);
         _playerPortrait.info = _loc1_;
         addToContent(_playerPortrait);
      }
      
      private function setListType() : void
      {
         if(_friendList && _friendList.parent)
         {
            _friendList.parent.removeChild(_friendList);
            _friendList.dispose();
            _friendList = null;
         }
         if(_consortiaList && _consortiaList.parent)
         {
            _consortiaList.parent.removeChild(_consortiaList);
            _consortiaList.dispose();
            _consortiaList = null;
         }
         if(_CMfriendList && _CMfriendList.parent)
         {
            _CMfriendList.parent.removeChild(_CMfriendList);
            _CMfriendList.dispose();
            _CMfriendList = null;
         }
         if(_likeFriendList && _likeFriendList.parent)
         {
            _likeFriendList.parent.removeChild(_likeFriendList);
            _likeFriendList.dispose();
            _likeFriendList = null;
         }
         if(_teamList && _teamList.parent)
         {
            _teamList.parent.removeChild(_teamList);
            _teamList.dispose();
            _teamList = null;
         }
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("IM.IMList.listPos");
         switch(int(_currentListType))
         {
            case 0:
               _friendList = new IMListView();
               _friendList.x = 8;
               _friendList.y = _loc1_.x;
               _listContent.addChild(_friendList);
               _addBleak.visible = true;
               _addFriend.visible = true;
               _myAcademyBtn.visible = true;
               _imLookupView.listType = 0;
               break;
            case 1:
               _consortiaList = new ConsortiaListView();
               _consortiaList.x = 8;
               _consortiaList.y = _loc1_.x;
               _listContent.addChild(_consortiaList);
               _addBleak.visible = true;
               _addFriend.visible = true;
               _myAcademyBtn.visible = true;
               _imLookupView.listType = 0;
               break;
            case 2:
               _teamList = new TeamListView();
               _teamList.x = 8;
               _teamList.y = _loc1_.x;
               if(_listContent)
               {
                  _listContent.addChild(_teamList);
               }
               _imLookupView.listType = 2;
               break;
            case 3:
               _likeFriendList = new LikeFriendListView();
               _likeFriendList.x = 8;
               _likeFriendList.y = _loc1_.x;
               if(_listContent)
               {
                  _listContent.addChild(_likeFriendList);
               }
               _addBleak.visible = true;
               _addFriend.visible = true;
               _myAcademyBtn.visible = true;
               _imLookupView.listType = 3;
         }
         if(AcademyManager.Instance.isFighting())
         {
            if(_myAcademyBtn)
            {
               _myAcademyBtn.visible = false;
            }
         }
      }
      
      private function copyGirlHeadDataByList(param1:Array, param2:Array) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = param2;
         for each(var _loc4_ in param2)
         {
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for each(var _loc3_ in param1)
            {
               if(_loc4_.ID == _loc3_.ID)
               {
                  _loc4_.IsShow = _loc3_.IsShow;
                  _loc4_.ImagePath = _loc3_.ImagePath;
               }
            }
         }
      }
      
      private function __giftClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         BagAndInfoManager.Instance.showBagAndInfo(1);
      }
      
      private function __onStateChange(param1:PlayerPropertyEvent) : void
      {
         if(PlayerManager.Instance.Self.playerState.StateID == 1)
         {
            _replyInput.visible = false;
         }
         else
         {
            _replyInput.visible = true;
         }
         if(param1.changedProperties["State"])
         {
            _state.text = "[" + PlayerManager.Instance.Self.playerState.convertToString() + "]";
            _stateSelectBtn.setFrame(PlayerManager.Instance.Self.playerState.StateID);
         }
      }
      
      private function __hideStateList(param1:MouseEvent) : void
      {
         if(_stateList.parent)
         {
            _stateList.parent.removeChild(_stateList);
         }
      }
      
      private function __stateSelectClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         if(_stateList.parent == null)
         {
            addToContent(_stateList);
         }
         _stateList.dataList = ALL_STATE;
      }
      
      private function removeEvent() : void
      {
         _IMSelectedBtn.removeEventListener("click",__IMBtnClick);
         _teamListBtn.removeEventListener("click",__teamListBtnClick);
         _consortiaListBtn.removeEventListener("click",__consortiaListBtnClick);
         _likePersonSelectedBtn.removeEventListener("click",__likeBtnClick);
         _addFriend.removeEventListener("click",__addFriendBtnClick);
         _addBleak.removeEventListener("click",__addBleakBtnClick);
         IMManager.Instance.removeEventListener("CMFriendComplete",__CMFriendLoadComplete);
         if(_myAcademyBtn)
         {
            _myAcademyBtn.removeEventListener("click",__myAcademyClick);
         }
         _stateSelectBtn.removeEventListener("click",__stateSelectClick);
         StageReferance.stage.removeEventListener("click",__hideStateList);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__onStateChange);
         _integralShop.removeEventListener("click",__onIntegralShop);
         _uploadGirlHeadPhotoBtn.removeEventListener("click",onUploadBtnClick);
         _selectGirlHeadPhotoBtn.removeEventListener("click",onChangeBtnClick);
         PlayerManager.Instance.removeEventListener("girl_head_photo_change",onHeadSelectChange);
         SocketManager.Instance.removeEventListener(PkgEvent.format(339),onUseGirlNewPhoto);
      }
      
      override public function dispose() : void
      {
         IMControl.Instance.isShow = false;
         removeEvent();
         ShowTipManager.Instance.removeTip(_uploadGirlHeadPhotoBtn);
         if(_bg && _bg.parent)
         {
            _bg.parent.removeChild(_bg);
            _bg.dispose();
            _bg = null;
         }
         if(_listContent && _listContent.parent)
         {
            _listContent.parent.removeChild(_listContent);
            _listContent = null;
         }
         if(_selfName && _selfName.parent)
         {
            _selfName.parent.removeChild(_selfName);
            _selfName.dispose();
            _selfName = null;
         }
         if(_levelIcon && _levelIcon.parent)
         {
            _levelIcon.parent.removeChild(_levelIcon);
            _levelIcon.dispose();
            _levelIcon = null;
         }
         if(_consortiaListBtn && _consortiaListBtn.parent)
         {
            _consortiaListBtn.parent.removeChild(_consortiaListBtn);
            _consortiaListBtn.dispose();
            _consortiaListBtn = null;
         }
         if(_likePersonSelectedBtn)
         {
            ObjectUtils.disposeObject(_likePersonSelectedBtn);
         }
         _likePersonSelectedBtn = null;
         if(_addFriend && _addFriend.parent)
         {
            _addFriend.parent.removeChild(_addFriend);
            _addFriend.dispose();
            _addFriend = null;
         }
         if(_addBleak && _addBleak.parent)
         {
            _addBleak.parent.removeChild(_addBleak);
            _addBleak.dispose();
            _addBleak = null;
         }
         if(_IMSelectedBtn && _IMSelectedBtn.parent)
         {
            _IMSelectedBtn.parent.removeChild(_IMSelectedBtn);
            _IMSelectedBtn.dispose();
            _IMSelectedBtn = null;
         }
         if(_teamListBtn)
         {
            ObjectUtils.disposeObject(_teamListBtn);
            _teamListBtn = null;
         }
         if(_imLookupView && _imLookupView.parent)
         {
            _imLookupView.parent.removeChild(_imLookupView);
            _imLookupView.dispose();
            _imLookupView = null;
         }
         if(_friendList && _friendList.parent)
         {
            _friendList.parent.removeChild(_friendList);
            _friendList.dispose();
            _friendList = null;
         }
         if(_consortiaList && _consortiaList.parent)
         {
            _consortiaList.parent.removeChild(_consortiaList);
            _consortiaList.dispose();
            _consortiaList = null;
         }
         if(_uploadGirlHeadPhotoBtn)
         {
            ObjectUtils.disposeObject(_uploadGirlHeadPhotoBtn);
            _uploadGirlHeadPhotoBtn = null;
         }
         if(_selectGirlHeadPhotoBtn)
         {
            ObjectUtils.disposeObject(_selectGirlHeadPhotoBtn);
            _selectGirlHeadPhotoBtn = null;
         }
         if(_CMfriendList && _CMfriendList.parent)
         {
            _CMfriendList.parent.removeChild(_CMfriendList);
            _CMfriendList.dispose();
            _CMfriendList = null;
         }
         if(_addFriendFrame)
         {
            _addFriendFrame.dispose();
            _addFriendFrame = null;
         }
         if(_addBlackFrame)
         {
            _addBlackFrame.dispose();
            _addBlackFrame = null;
         }
         if(_myAcademyBtn)
         {
            _myAcademyBtn.dispose();
            _myAcademyBtn = null;
         }
         if(_stateList)
         {
            _stateList.dispose();
            _stateList = null;
         }
         if(_stateSelectBtn)
         {
            _stateSelectBtn.dispose();
            _stateSelectBtn = null;
         }
         if(_likeFriendList)
         {
            _likeFriendList.dispose();
            _likeFriendList = null;
         }
         if(_vipName)
         {
            ObjectUtils.disposeObject(_vipName);
         }
         _vipName = null;
         _selectedButtonGroup.dispose();
         _selectedButtonGroup = null;
         if(_integralShop)
         {
            _integralShop.dispose();
            _integralShop = null;
         }
         super.dispose();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
