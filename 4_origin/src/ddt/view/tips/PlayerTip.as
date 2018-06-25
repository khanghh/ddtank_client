package ddt.view.tips
{
   import academy.AcademyManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.GridBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.BasePlayer;
   import ddt.data.player.PlayerInfo;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.AcademyFrameManager;
   import ddt.manager.ChatManager;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import ddt.view.common.VipLevelIcon;
   import ddt.view.im.IMFriendPhotoCell;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.system.System;
   import flash.utils.Timer;
   import giftSystem.GiftManager;
   import im.MarkFrame;
   import room.RoomManager;
   import vip.VipController;
   
   public class PlayerTip extends Sprite implements Disposeable
   {
      
      public static const CHALLENGE:String = "challenge";
      
      public static const X_MARGINAL:int = 10;
      
      public static const Y_MARGINAL:int = 20;
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var btnChallenge:IconButton;
      
      private var _chanllageEnable:Boolean = false;
      
      private var _currentData:Object;
      
      private var _info:BasePlayer;
      
      private var _btnAddFriend:IconButton;
      
      private var _btnCopyName:IconButton;
      
      private var _btnDemote:TextButton;
      
      private var _btnExpel:TextButton;
      
      private var _btnInvite:TextButton;
      
      private var _btnPromote:TextButton;
      
      private var _btnPresentGift:IconButton;
      
      private var _btnPrivateChat:IconButton;
      
      private var _btnMark:IconButton;
      
      private var _btnPropose:BaseButton;
      
      private var _btnViewInfo:IconButton;
      
      private var _btnAcademy:IconButton;
      
      private var _One_one_chat:IconButton;
      
      private var _transferFriend:IconButton;
      
      private var _nameTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _clubTxt:FilterFrameText;
      
      private var _iconBtnsContainer:GridBox;
      
      private var _headPhoto:PlayerPortraitView;
      
      private var _bottomBtnsContainer:Sprite;
      
      private var _bottomBg:Bitmap;
      
      private var _vipIcon:VipLevelIcon;
      
      private var _photo:IMFriendPhotoCell;
      
      private var _friendGroup:FriendGroupTip;
      
      private var _timer:Timer;
      
      private var _friendOver:Boolean = false;
      
      public function PlayerTip()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bottomBtnsContainer = new Sprite();
         _bg = ComponentFactory.Instance.creatComponentByStylename("playerTip.BG");
         _line = ComponentFactory.Instance.creatComponentByStylename("playerTip.line");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("playerTip.NameTxt");
         _vipIcon = ComponentFactory.Instance.creatCustomObject("playerTip.VipIcon");
         _clubTxt = ComponentFactory.Instance.creatComponentByStylename("playerTip.ClubTxt");
         _iconBtnsContainer = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemGridContainer");
         _iconBtnsContainer.columnNumber = 1;
         _iconBtnsContainer.cellHeght = 19;
         btnChallenge = ComponentFactory.Instance.creatComponentByStylename("playerTip.Challenge");
         _btnPresentGift = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemPresentGift");
         _btnAddFriend = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemMakeFriend");
         _btnPrivateChat = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemPrivateChat");
         _btnMark = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemMark");
         _btnCopyName = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemCopyName");
         _btnViewInfo = ComponentFactory.Instance.creatComponentByStylename("playerTip.ItemInfo");
         _btnAcademy = ComponentFactory.Instance.creatComponentByStylename("playerTip.academyIcon");
         _One_one_chat = ComponentFactory.Instance.creatComponentByStylename("playerTip.OneOnOneChat");
         _transferFriend = ComponentFactory.Instance.creatComponentByStylename("PlayerTip.transferFriend");
         _btnPropose = ComponentFactory.Instance.creatComponentByStylename("playerTip.ProposeBtn");
         _bottomBg = ComponentFactory.Instance.creatBitmap("asset.playerTip.PlayerTipBottomBg");
         _bottomBg.width = 205;
         _btnInvite = ComponentFactory.Instance.creatComponentByStylename("playerTip.PlayerTipInviteBtn");
         _btnPromote = ComponentFactory.Instance.creatComponentByStylename("playerTip.PlayerTipPromoteBtn");
         _btnDemote = ComponentFactory.Instance.creatComponentByStylename("playerTip.PlayerTipDemoteBtn");
         _btnExpel = ComponentFactory.Instance.creatComponentByStylename("playerTip.PlayerTipExpelBtn");
         PositionUtils.setPos(_bottomBtnsContainer,"playerTip.BottomPos");
         _btnInvite.text = LanguageMgr.GetTranslation("tank.menu.Invite");
         _btnPromote.text = LanguageMgr.GetTranslation("tank.menu.Up");
         _btnDemote.text = LanguageMgr.GetTranslation("tank.menu.Down");
         _btnExpel.text = LanguageMgr.GetTranslation("tank.menu.fire");
         graphics.beginFill(0,0);
         graphics.drawRect(-3000,-3000,6000,6000);
         graphics.endFill();
         addChild(_bg);
         addChild(_line);
         addChild(_clubTxt);
         _iconBtnsContainer.addChild(btnChallenge);
         _iconBtnsContainer.addChild(_btnPresentGift);
         _iconBtnsContainer.addChild(_btnAddFriend);
         _iconBtnsContainer.addChild(_btnPrivateChat);
         _iconBtnsContainer.addChild(_btnMark);
         _iconBtnsContainer.addChild(_btnCopyName);
         _iconBtnsContainer.addChild(_btnViewInfo);
         _iconBtnsContainer.addChild(_btnAcademy);
         _iconBtnsContainer.addChild(_One_one_chat);
         _iconBtnsContainer.addChild(_transferFriend);
         addChild(_iconBtnsContainer);
         if(PathManager.solveChurchEnable())
         {
            addChild(_btnPropose);
         }
         _bottomBtnsContainer.addChild(_bottomBg);
         _bottomBtnsContainer.addChild(_btnInvite);
         _bottomBtnsContainer.addChild(_btnPromote);
         _bottomBtnsContainer.addChild(_btnDemote);
         _bottomBtnsContainer.addChild(_btnExpel);
         addChild(_bottomBtnsContainer);
         _friendGroup = new FriendGroupTip();
         PositionUtils.setPos(_friendGroup,"groupTip.pos");
         _timer = new Timer(200);
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__mouseClick);
         btnChallenge.addEventListener("click",__buttonsClick);
         _btnPropose.addEventListener("click",__buttonsClick);
         _btnInvite.addEventListener("click",__buttonsClick);
         _btnPromote.addEventListener("click",__buttonsClick);
         _btnDemote.addEventListener("click",__buttonsClick);
         _btnExpel.addEventListener("click",__buttonsClick);
         _btnPresentGift.addEventListener("click",__buttonsClick);
         _btnAddFriend.addEventListener("click",__buttonsClick);
         _btnPrivateChat.addEventListener("click",__buttonsClick);
         _btnMark.addEventListener("click",__buttonsClick);
         _btnCopyName.addEventListener("click",__buttonsClick);
         _btnViewInfo.addEventListener("click",__buttonsClick);
         _btnAcademy.addEventListener("click",__buttonsClick);
         _One_one_chat.addEventListener("click",__buttonsClick);
         _transferFriend.addEventListener("mouseOver",__overHandler);
         _transferFriend.addEventListener("mouseOut",__outHandler);
         _friendGroup.addEventListener("mouseOver",__friendOverHandler);
         _friendGroup.addEventListener("mouseOut",__friendOutHandler);
         _friendGroup.addEventListener("click",__friendClickHandler);
         _timer.addEventListener("timer",__timerHandler);
         _friendGroup.addEventListener("addedToStage",__groupAddToStage);
      }
      
      protected function __groupAddToStage(event:Event) : void
      {
         PositionUtils.setPos(_friendGroup,"groupTip.pos");
         if(this.y + 211 + _friendGroup.height > StageReferance.stageHeight)
         {
            _friendGroup.y = StageReferance.stageHeight - _friendGroup.height - this.y;
         }
      }
      
      protected function __friendClickHandler(event:MouseEvent) : void
      {
         removeChild(_friendGroup);
         _timer.stop();
         hide();
      }
      
      protected function __friendOverHandler(event:MouseEvent) : void
      {
         _friendOver = true;
      }
      
      protected function __friendOutHandler(event:MouseEvent) : void
      {
         _friendOver = false;
      }
      
      protected function __timerHandler(event:TimerEvent) : void
      {
         if(!_friendOver)
         {
            removeChild(_friendGroup);
            _timer.stop();
         }
      }
      
      protected function __overHandler(event:MouseEvent) : void
      {
         _friendGroup.update(_info.NickName);
         addChild(_friendGroup);
         _timer.stop();
      }
      
      protected function __outHandler(event:MouseEvent) : void
      {
         _timer.reset();
         _timer.start();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_headPhoto);
         _headPhoto = null;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get info() : BasePlayer
      {
         return _info;
      }
      
      public function set playerInfo(value:BasePlayer) : void
      {
         if(_info)
         {
            _info.removeEventListener("propertychange",__onPropChange);
         }
         _info = value;
         _info.addEventListener("propertychange",__onPropChange);
         update();
      }
      
      public function proposeEnable(b:Boolean) : void
      {
         _btnPropose.enable = b;
      }
      
      public function setSelfDisable(value:Boolean) : void
      {
         if(value)
         {
            var _loc2_:* = false;
            _btnPresentGift.enable = _loc2_;
            _loc2_ = _loc2_;
            btnChallenge.enable = _loc2_;
            _loc2_ = _loc2_;
            _btnPropose.enable = _loc2_;
            _loc2_ = _loc2_;
            _btnAddFriend.enable = _loc2_;
            _btnPrivateChat.enable = _loc2_;
            _loc2_ = 0.7;
            _btnPresentGift.alpha = _loc2_;
            _loc2_ = _loc2_;
            btnChallenge.alpha = _loc2_;
            _loc2_ = _loc2_;
            _btnPropose.alpha = _loc2_;
            _loc2_ = _loc2_;
            _btnAddFriend.alpha = _loc2_;
            _btnPrivateChat.alpha = _loc2_;
         }
         else
         {
            if(checkShowPresent())
            {
               _btnPresentGift.enable = false;
               _btnPresentGift.alpha = 0.7;
            }
            else
            {
               _btnPresentGift.enable = true;
               _btnPresentGift.alpha = 1;
            }
            _loc2_ = true;
            btnChallenge.enable = _loc2_;
            _loc2_ = _loc2_;
            _btnPropose.enable = _loc2_;
            _loc2_ = _loc2_;
            _btnAddFriend.enable = _loc2_;
            _btnPrivateChat.enable = _loc2_;
            _loc2_ = 1;
            btnChallenge.alpha = _loc2_;
            _loc2_ = _loc2_;
            _btnPropose.alpha = _loc2_;
            _loc2_ = _loc2_;
            _btnAddFriend.alpha = _loc2_;
            _btnPrivateChat.alpha = _loc2_;
         }
      }
      
      private function checkShowPresent() : Boolean
      {
         if(PlayerManager.Instance.Self.Grade < 16)
         {
            return true;
         }
         if(StateManager.currentStateType == "fighting" || StateManager.currentStateType == "auction" || StateManager.currentStateType == "shop" || StateManager.currentStateType == "fightLabGameView")
         {
            return true;
         }
         if(!StateManager.isExitRoom(StateManager.currentStateType))
         {
            if(RoomManager.Instance.findRoomPlayer(PlayerManager.Instance.Self.ID).isReady || RoomManager.Instance.findRoomPlayer(PlayerManager.Instance.Self.ID).isViewer || RoomManager.Instance.current.started)
            {
               return true;
            }
         }
         return false;
      }
      
      public function show(yOffset:int) : void
      {
         LayerManager.Instance.addToLayer(this,3);
         var pos:Point = new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY);
         x = pos.x - _bg.width;
         y = yOffset - _bg.height - (!!_bottomBtnsContainer.visible?_bottomBg.height:0);
         if(x < 10)
         {
            x = 10;
         }
         if(y < 20)
         {
            y = 20;
         }
         _btnPropose.enable = !PlayerManager.Instance.Self.IsMarried && !_info.IsMarried && PlayerManager.Instance.Self.Sex != _info.Sex;
      }
      
      public function update() : void
      {
         var __info:* = null;
         var tInfo:* = null;
         if(_headPhoto != null)
         {
            ObjectUtils.disposeObject(_headPhoto);
            _headPhoto = null;
         }
         if(_info)
         {
            if(_info.IsShow && _info.ImagePath != "")
            {
               if(_headPhoto == null)
               {
                  _headPhoto = new PlayerPortraitView("left",true);
               }
               __info = new PlayerInfo();
               ObjectUtils.copyProperties(__info,_info);
               _headPhoto.info = __info;
               _headPhoto.x = 95;
               _headPhoto.y = 53;
               addChild(_headPhoto);
            }
            _nameTxt.text = _info.NickName;
            if(_info.ID == PlayerManager.Instance.Self.ID)
            {
               tInfo = PlayerManager.Instance.Self;
            }
            else
            {
               tInfo = _info;
            }
            if(tInfo.IsVIP)
            {
               ObjectUtils.disposeObject(_vipName);
               _vipName = VipController.instance.getVipNameTxt(138,tInfo.typeVIP);
               _vipName.x = _nameTxt.x;
               _vipName.y = _nameTxt.y;
               _vipName.text = _nameTxt.text;
               addChild(_vipName);
               DisplayUtils.removeDisplay(_nameTxt);
            }
            else
            {
               addChild(_nameTxt);
               DisplayUtils.removeDisplay(_vipName);
            }
            if(tInfo.ID == PlayerManager.Instance.Self.ID || tInfo.IsVIP)
            {
               _vipIcon.setInfo(tInfo);
               if(tInfo.IsVIP || PlayerManager.Instance.Self.IsVIP)
               {
                  _vipIcon.filters = null;
               }
               else
               {
                  _vipIcon.filters = ComponentFactory.Instance.creatFilters("grayFilter");
               }
               addChild(_vipIcon);
            }
            else if(contains(_vipIcon))
            {
               removeChild(_vipIcon);
            }
            _clubTxt.text = LanguageMgr.GetTranslation("tank.menu.ClubName") + (!!tInfo.ConsortiaName?tInfo.ConsortiaName:"");
         }
         else
         {
            var _loc3_:* = "";
            _clubTxt.text = _loc3_;
            _loc3_ = _loc3_;
            _vipName.text = _loc3_;
            _nameTxt.text = _loc3_;
         }
         if(tInfo.ID == PlayerManager.Instance.Self.ID || tInfo.Grade < 5 || PlayerManager.Instance.Self.Grade < 5)
         {
            _One_one_chat.enable = false;
            _One_one_chat.alpha = 0.7;
         }
         else
         {
            _One_one_chat.enable = true;
            _One_one_chat.alpha = 1;
         }
         if(tInfo.ID == PlayerManager.Instance.Self.ID)
         {
            btnChallenge.enable = false;
         }
         else
         {
            btnChallenge.enable = PlayerManager.Instance.Self.Grade >= 12 && (StateManager.currentStateType == "main" || StateManager.currentStateType == "roomlist" || StateManager.currentStateType == "dungeon");
            if(!btnChallenge.enable)
            {
               btnChallenge.alpha = 0.7;
            }
            else
            {
               btnChallenge.alpha = 1;
            }
         }
         if(PlayerManager.Instance.hasInFriendList(_info.ID) && _info.ID != PlayerManager.Instance.Self.ID)
         {
            _transferFriend.enable = true;
            _transferFriend.alpha = 1;
         }
         else
         {
            _transferFriend.enable = false;
            _transferFriend.alpha = 0.7;
         }
         if(tInfo && tInfo.DutyLevel > PlayerManager.Instance.Self.DutyLevel && tInfo.ID != PlayerManager.Instance.Self.ID)
         {
            if(tInfo.ConsortiaID != 0 && tInfo.ConsortiaID == PlayerManager.Instance.Self.ConsortiaID)
            {
               _btnExpel.visible = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,32);
               _btnExpel.enable = true;
               _btnPromote.visible = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,2048);
               _btnPromote.enable = tInfo.DutyLevel > PlayerManager.Instance.Self.DutyLevel + 1;
               _btnDemote.visible = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,2048);
               _btnDemote.enable = tInfo.DutyLevel != 5;
               _btnInvite.visible = false;
            }
            else
            {
               _btnPromote.visible = false;
               _btnDemote.visible = false;
               _btnExpel.visible = false;
            }
            _bottomBtnsContainer.visible = _btnExpel.visible || _btnInvite.visible || _btnPromote.visible || _btnDemote.visible;
         }
         else
         {
            _btnPromote.visible = false;
            _btnDemote.visible = false;
            _btnExpel.visible = false;
            _bottomBtnsContainer.visible = false;
            if(tInfo.ConsortiaID == 0 && PlayerManager.Instance.Self.ConsortiaID != 0 && tInfo.ConsortiaName == "" && tInfo.ID != PlayerManager.Instance.Self.ID)
            {
               _btnInvite.visible = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,2) && tInfo.ConsortiaID == 0;
               _bottomBtnsContainer.visible = _btnInvite.visible;
            }
         }
         if((tInfo.apprenticeshipState == 0 || tInfo.apprenticeshipState == 2) && tInfo.ID != PlayerManager.Instance.Self.ID && tInfo.ID != PlayerManager.Instance.Self.masterID && tInfo.Grade >= 8)
         {
            _btnAcademy.enable = true;
            _btnAcademy.alpha = 1;
         }
         else
         {
            _btnAcademy.enable = false;
            _btnAcademy.alpha = 0.7;
         }
         if(PlayerManager.isShowPHP)
         {
            if(!_photo)
            {
               _photo = new IMFriendPhotoCell();
               PositionUtils.setPos(_photo,"playerTip.PhotoPos");
               addChild(_photo);
            }
            _photo.userID = String(tInfo.LoginName);
         }
         if(IMManager.isInIM)
         {
            _iconBtnsContainer.removeAllChild();
            _iconBtnsContainer.addChild(btnChallenge);
            _iconBtnsContainer.addChild(_btnPresentGift);
            _iconBtnsContainer.addChild(_btnAddFriend);
            _iconBtnsContainer.addChild(_btnPrivateChat);
            _iconBtnsContainer.addChild(_btnMark);
            _iconBtnsContainer.addChild(_btnCopyName);
            _iconBtnsContainer.addChild(_btnViewInfo);
            _iconBtnsContainer.addChild(_btnAcademy);
            _iconBtnsContainer.addChild(_One_one_chat);
            _iconBtnsContainer.addChild(_transferFriend);
            _iconBtnsContainer.arrange();
            _bg.height = 257;
            _btnPropose.y = 212;
            _bottomBtnsContainer.y = _bg.height - 3;
         }
         else
         {
            _btnMark.parent && _iconBtnsContainer.removeChild(_btnMark);
            _bg.height = 236;
            _bottomBtnsContainer.y = _bg.height - 3;
            _btnPropose.y = 195;
            _iconBtnsContainer.arrange();
         }
         IMManager.isInIM = false;
      }
      
      private function __buttonsClick(event:MouseEvent) : void
      {
         var alert:* = null;
         var markFrame:* = null;
         if(_info)
         {
            var _loc4_:* = event.currentTarget;
            if(_btnPromote !== _loc4_)
            {
               if(_btnDemote !== _loc4_)
               {
                  if(_btnExpel !== _loc4_)
                  {
                     if(_btnInvite !== _loc4_)
                     {
                        if(_btnPropose !== _loc4_)
                        {
                           if(btnChallenge !== _loc4_)
                           {
                              if(_btnPrivateChat !== _loc4_)
                              {
                                 if(_btnMark !== _loc4_)
                                 {
                                    if(_btnViewInfo !== _loc4_)
                                    {
                                       if(_btnAddFriend !== _loc4_)
                                       {
                                          if(_btnCopyName !== _loc4_)
                                          {
                                             if(_btnPresentGift !== _loc4_)
                                             {
                                                if(_btnAcademy !== _loc4_)
                                                {
                                                   if(_One_one_chat === _loc4_)
                                                   {
                                                      hide();
                                                      IMManager.Instance.alertPrivateFrame(_info.ID);
                                                   }
                                                }
                                                else
                                                {
                                                   requestApprentice();
                                                }
                                             }
                                             else
                                             {
                                                GiftManager.Instance.show();
                                             }
                                          }
                                          else
                                          {
                                             System.setClipboard(_info.NickName);
                                          }
                                       }
                                       else
                                       {
                                          hide();
                                          IMManager.Instance.addFriend(_info.NickName);
                                       }
                                    }
                                    else
                                    {
                                       hide();
                                       PlayerInfoViewControl.viewByID(_info.ID,-1,true,false);
                                       PlayerInfoViewControl.isOpenFromBag = false;
                                       PlayerManager.Instance.Self.isViewOther = true;
                                    }
                                 }
                                 else
                                 {
                                    hide();
                                    markFrame = ComponentFactory.Instance.creatComponentByStylename("IM.markFrame");
                                    LayerManager.Instance.addToLayer(markFrame,7,true,1);
                                 }
                              }
                              else
                              {
                                 hide();
                                 ChatManager.Instance.privateChatTo(_info.NickName,_info.ID);
                              }
                           }
                           else
                           {
                              IMManager.Instance.dispatchEvent(new Event("challenge"));
                           }
                        }
                        else
                        {
                           ChurchManager.instance.sendValidateMarry(_info);
                        }
                     }
                     else
                     {
                        if(PlayerManager.Instance.Self.bagLocked)
                        {
                           BaglockedManager.Instance.show();
                           return;
                        }
                        if(_info.Grade < 17)
                        {
                           MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortion.playerTip.notInvite",17));
                        }
                        else
                        {
                           SocketManager.Instance.out.sendConsortiaInvate(_info.NickName);
                        }
                     }
                  }
                  else
                  {
                     if(PlayerManager.Instance.Self.bagLocked)
                     {
                        BaglockedManager.Instance.show();
                        return;
                     }
                     alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.consortia.myconsortia.frame.DeleteMemberFrame.titleText"),LanguageMgr.GetTranslation("tank.menu.fireConfirm",_info.NickName),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
                     alert.addEventListener("response",__frameEventHandler);
                  }
               }
               else
               {
                  if(PlayerManager.Instance.Self.bagLocked)
                  {
                     BaglockedManager.Instance.show();
                     return;
                  }
                  SocketManager.Instance.out.sendConsortiaMemberGrade(_info.ID,false);
               }
            }
            else
            {
               if(PlayerManager.Instance.Self.bagLocked)
               {
                  BaglockedManager.Instance.show();
                  return;
               }
               SocketManager.Instance.out.sendConsortiaMemberGrade(_info.ID,true);
            }
         }
      }
      
      private function requestApprentice() : void
      {
         if(AcademyManager.Instance.compareState(_info,PlayerManager.Instance.Self))
         {
            if(PlayerManager.Instance.Self.Grade >= 21)
            {
               if(AcademyManager.Instance.isFreezes(false))
               {
                  AcademyFrameManager.Instance.showAcademyRequestApprenticeFrame(_info);
               }
            }
            else if(AcademyManager.Instance.isFreezes(true))
            {
               AcademyFrameManager.Instance.showAcademyRequestMasterFrame(_info);
            }
         }
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var frame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         switch(int(e.responseCode) - 2)
         {
            case 0:
            case 1:
               SocketManager.Instance.out.sendConsortiaOut(_info.ID);
         }
         frame.dispose();
         frame = null;
      }
      
      private function __mouseClick(event:Event) : void
      {
         hide();
         SoundManager.instance.play("008");
         event.stopImmediatePropagation();
      }
      
      private function __onPropChange(e:PlayerPropertyEvent) : void
      {
         if(e.changedProperties["DutyLevel"])
         {
            _btnPromote.enable = _info.DutyLevel != 2;
            _btnDemote.enable = _info.DutyLevel != 5;
            _btnExpel.enable = ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,32);
         }
      }
      
      private function __sendBandChat(e:MouseEvent) : void
      {
         SocketManager.Instance.out.sendForbidSpeak(_info.ID,true);
      }
      
      private function __sendNoBandChat(e:MouseEvent) : void
      {
         SocketManager.Instance.out.sendForbidSpeak(_info.ID,false);
      }
      
      private function ok() : void
      {
         SocketManager.Instance.out.sendConsortiaOut(_info.ID);
      }
   }
}
