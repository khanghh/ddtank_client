package church.view.weddingRoom
{
   import baglocked.BaglockedManager;
   import church.ChurchManager;
   import church.controller.ChurchRoomController;
   import church.events.WeddingRoomEvent;
   import church.model.ChurchRoomModel;
   import church.view.churchFire.ChurchFireView;
   import church.view.invite.ChurchInviteController;
   import church.view.weddingRoom.frame.WeddingRoomConfigView;
   import church.view.weddingRoom.frame.WeddingRoomContinuationView;
   import church.view.weddingRoom.frame.WeddingRoomGiftFrameForGuest;
   import church.view.weddingRoom.frame.WeddingRoomGuestListView;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.view.chat.ChatData;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import giftSystem.GiftManager;
   
   public class WeddingRoomToolView extends Sprite implements Disposeable
   {
      
      private static const LEAST_GIFT_MONEY:int = 100;
       
      
      private var _controller:ChurchRoomController;
      
      private var _model:ChurchRoomModel;
      
      private var _churchRoomControler:ChurchRoomController;
      
      private var _toolBg:Bitmap;
      
      private var _toolSwitchBg:BaseButton;
      
      private var _toolSwitch:Bitmap;
      
      private var _switchEnable:Boolean = true;
      
      private var _toolBtnRoomAdmin:BaseButton;
      
      private var _toolBtnInviteGuest:BaseButton;
      
      private var _toolBtnGift:BaseButton;
      
      private var _toolBtnFire:BaseButton;
      
      private var _toolBtnFill:BaseButton;
      
      private var _toolBtnExit:BaseButton;
      
      private var _toolBtnBack:BaseButton;
      
      private var _alertExit:BaseAlerFrame;
      
      private var _alertStartWedding:BaseAlerFrame;
      
      private var _fireLoader:BaseLoader;
      
      private var _churchFireView:ChurchFireView;
      
      private var _toolAdminBg:Bitmap;
      
      private var _startWeddingTip:Bitmap;
      
      private var _startWeddingTip2:Bitmap;
      
      private var _toolBtnStartWedding:BaseButton;
      
      private var _toolBtnAdminInviteGuest:BaseButton;
      
      private var _toolBtnGuestList:BaseButton;
      
      private var _toolBtnContinuation:BaseButton;
      
      private var _toolBtnModify:BaseButton;
      
      private var _adminToolVisible:Boolean = true;
      
      private var _sendGifeToolVisible:Boolean = false;
      
      private var _weddingRoomGiftFrameViewForGuest:WeddingRoomGiftFrameForGuest;
      
      private var _weddingRoomConfigView:WeddingRoomConfigView;
      
      private var _weddingRoomContinuationView:WeddingRoomContinuationView;
      
      private var _weddingRoomGuestListView:WeddingRoomGuestListView;
      
      private var _churchInviteController:ChurchInviteController;
      
      private var _startTipTween:TweenLite;
      
      private var _switchTween:TweenLite;
      
      private var _sendGiftToolBg:Bitmap;
      
      private var _toolSendGiftBtn:BaseButton;
      
      public var _toolSendCashBtn:BaseButton;
      
      public var _toolSendCashBtnForGuest:BaseButton;
      
      private var _isplayerStartTipMovieState:int = 0;
      
      public function WeddingRoomToolView()
      {
         super();
         initialize();
      }
      
      public function get controller() : ChurchRoomController
      {
         return _controller;
      }
      
      public function set controller(value:ChurchRoomController) : void
      {
         _controller = value;
      }
      
      public function set churchRoomModel(value:ChurchRoomModel) : void
      {
         _model = value;
      }
      
      public function set churchRoomControler(value:ChurchRoomController) : void
      {
         _churchRoomControler = value;
      }
      
      public function set inventBtnEnabled(value:Boolean) : void
      {
         this._toolBtnInviteGuest.enable = value;
      }
      
      private function initialize() : void
      {
         setView();
         setEvent();
      }
      
      private function setView() : void
      {
         loadFire();
         _toolBg = ComponentFactory.Instance.creat("asset.church.room.toolBgAsset");
         addChild(_toolBg);
         _toolSwitchBg = ComponentFactory.Instance.creat("church.room.toolSwitchBgAsset");
         addChild(_toolSwitchBg);
         _toolSwitch = ComponentFactory.Instance.creat("asset.church.room.toolSwitchAsset");
         addChild(_toolSwitch);
         _toolBtnGift = ComponentFactory.Instance.creat("church.room.toolBtnGiftBtnAsset");
         addChild(_toolBtnGift);
         _toolBtnFire = ComponentFactory.Instance.creat("church.room.toolBtnFireBtnAsset");
         addChild(_toolBtnFire);
         _toolBtnFill = ComponentFactory.Instance.creat("church.room.toolBtnFillBtnAsset");
         addChild(_toolBtnFill);
         _toolBtnExit = ComponentFactory.Instance.creat("church.room.toolBtnExitBtnAsset");
         addChild(_toolBtnExit);
         _toolBtnBack = ComponentFactory.Instance.creat("church.room.toolBtnBackBtnAsset");
         _toolBtnBack.visible = false;
         addChild(_toolBtnBack);
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            showAdminToolView();
         }
         else
         {
            _toolBtnInviteGuest = ComponentFactory.Instance.creat("church.room.toolBtnInviteGuestBtnAsset");
            addChild(_toolBtnInviteGuest);
            if(!ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
            {
               if(_toolBtnInviteGuest)
               {
                  _toolBtnInviteGuest.enable = ChurchManager.instance.currentRoom.canInvite;
               }
            }
         }
         showGiftToolView();
         GiftToolVisible = _sendGifeToolVisible;
      }
      
      private function setEvent() : void
      {
         _toolSwitchBg.addEventListener("click",toolSwitch);
         _toolBtnGift.addEventListener("click",onToolMenuClick);
         _toolBtnFire.addEventListener("click",onToolMenuClick);
         _toolBtnFill.addEventListener("click",onToolMenuClick);
         _toolBtnExit.addEventListener("click",onToolMenuClick);
         _toolBtnBack.addEventListener("click",onToolMenuClick);
         _toolSendGiftBtn.addEventListener("click",onToolMenuClick);
         _toolSendCashBtn.addEventListener("click",onToolMenuClick);
         _toolSendCashBtnForGuest.addEventListener("click",onToolMenuClick);
         if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            _toolBtnGuestList.addEventListener("click",onToolMenuClick);
            _toolBtnContinuation.addEventListener("click",onToolMenuClick);
            _toolBtnModify.addEventListener("click",onToolMenuClick);
            _toolBtnRoomAdmin.addEventListener("click",onToolMenuClick);
            _toolBtnAdminInviteGuest.addEventListener("click",onToolMenuClick);
            _toolBtnStartWedding.addEventListener("click",onToolMenuClick);
         }
         else
         {
            _toolBtnInviteGuest.addEventListener("click",onToolMenuClick);
         }
         ChurchManager.instance.currentRoom.addEventListener("wedding status change",__weddingStatusChange);
         ChurchManager.instance.addEventListener("scene change",__updateBtn);
      }
      
      public function resetView() : void
      {
         if(ChurchManager.instance.currentScene == 0)
         {
            if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
            {
               _toolBtnStartWedding.enable = false;
               _startWeddingTip.visible = false;
               _startWeddingTip2.visible = false;
               if(_startWeddingTip)
               {
                  _startWeddingTip.visible = false;
               }
               if(_startWeddingTip2)
               {
                  _startWeddingTip2.visible = false;
               }
            }
            _toolBtnBack.visible = true;
            _toolBtnExit.visible = false;
         }
         else
         {
            if(ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
            {
               _toolBtnStartWedding.enable = true;
               _startWeddingTip.visible = true;
               _startWeddingTip2.visible = true;
               if(_adminToolVisible)
               {
                  if(_startWeddingTip)
                  {
                     _startWeddingTip.visible = true;
                  }
                  if(_startWeddingTip2)
                  {
                     _startWeddingTip2.visible = true;
                  }
               }
               else
               {
                  if(_startWeddingTip)
                  {
                     _startWeddingTip.visible = false;
                  }
                  if(_startWeddingTip2)
                  {
                     _startWeddingTip2.visible = false;
                  }
               }
            }
            _toolBtnBack.visible = false;
            _toolBtnExit.visible = true;
         }
      }
      
      private function __weddingStatusChange(event:WeddingRoomEvent) : void
      {
         if(ChurchManager.instance.currentScene == 0)
         {
            return;
         }
         if(_startWeddingTip)
         {
            if(_startWeddingTip.parent)
            {
               _startWeddingTip.parent.removeChild(_startWeddingTip);
            }
         }
         if(_startWeddingTip2)
         {
            if(_startWeddingTip2.parent)
            {
               _startWeddingTip2.parent.removeChild(_startWeddingTip2);
            }
         }
         _startTipTween = null;
         var status:String = ChurchManager.instance.currentRoom.status;
         if(!ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            if(_toolBtnInviteGuest)
            {
               _toolBtnInviteGuest.enable = ChurchManager.instance.currentRoom.canInvite;
            }
         }
         if(status == "wedding_ing")
         {
            if(_toolBtnStartWedding)
            {
               _toolBtnStartWedding.enable = false;
            }
            if(_toolBtnAdminInviteGuest)
            {
               _toolBtnAdminInviteGuest.enable = false;
            }
            if(_toolBtnInviteGuest)
            {
               _toolBtnInviteGuest.enable = false;
            }
            if(_toolBtnFire)
            {
               _toolBtnFire.enable = false;
            }
            if(_churchFireView && _churchFireView.parent)
            {
               _churchFireView.parent.removeChild(_churchFireView);
            }
         }
         else
         {
            if(_toolBtnStartWedding)
            {
               _toolBtnStartWedding.enable = true;
            }
            if(_toolBtnAdminInviteGuest)
            {
               _toolBtnAdminInviteGuest.enable = true;
            }
            if(_toolBtnInviteGuest)
            {
               _toolBtnInviteGuest.enable = ChurchManager.instance.currentRoom.canInvite;
            }
            if(_toolBtnFire)
            {
               _toolBtnFire.enable = true;
            }
            if(_toolBtnExit)
            {
               _toolBtnExit.enable = true;
            }
            if(_toolBtnBack)
            {
               _toolBtnBack.enable = true;
            }
         }
      }
      
      private function __updateBtn(evt:WeddingRoomEvent) : void
      {
         if(_churchInviteController)
         {
            _churchInviteController.hide();
         }
         if(ChurchManager.instance.currentScene == 0)
         {
            _toolBtnBack.visible = false;
            _toolBtnExit.visible = true;
         }
         else
         {
            _toolBtnBack.visible = true;
            _toolBtnExit.visible = false;
         }
      }
      
      private function showAdminToolView() : void
      {
         _toolAdminBg = ComponentFactory.Instance.creat("asset.church.room.toolAdminBgAsset");
         addChild(_toolAdminBg);
         _toolBtnStartWedding = ComponentFactory.Instance.creat("church.room.toolBtnStartWeddingBtnAsset");
         addChild(_toolBtnStartWedding);
         _toolBtnRoomAdmin = ComponentFactory.Instance.creat("church.room.toolBtnRoomAdminBtnAsset");
         addChild(_toolBtnRoomAdmin);
         _toolBtnGuestList = ComponentFactory.Instance.creat("church.room.toolBtnGuestListBtnAsset");
         addChild(_toolBtnGuestList);
         _toolBtnContinuation = ComponentFactory.Instance.creat("church.room.toolBtnContinuationBtnAsset");
         addChild(_toolBtnContinuation);
         _toolBtnAdminInviteGuest = ComponentFactory.Instance.creat("church.room.toolBtnAdminInviteGuestBtnAsset");
         addChild(_toolBtnAdminInviteGuest);
         if(!ChurchManager.instance.isAdmin(PlayerManager.Instance.Self))
         {
            if(_toolBtnInviteGuest)
            {
               _toolBtnInviteGuest.enable = ChurchManager.instance.currentRoom.canInvite;
            }
         }
         _toolBtnModify = ComponentFactory.Instance.creat("church.room.toolBtnModifyBtnAsset");
         addChild(_toolBtnModify);
         if(PlayerManager.Instance.Self.ID != ChurchManager.instance.currentRoom.createID)
         {
            _toolBtnModify.enable = false;
         }
         if(!_startWeddingTip)
         {
            _startWeddingTip = ComponentFactory.Instance.creatBitmap("asset.church.room.startWeddingTipAsset");
         }
         addChild(_startWeddingTip);
         if(!_startWeddingTip2)
         {
            _startWeddingTip2 = ComponentFactory.Instance.creatBitmap("asset.church.room.startWeddingTip2Asset");
         }
         addChild(_startWeddingTip2);
         playerStartTipMovie();
      }
      
      private function set adminToolVisible(value:Boolean) : void
      {
         if(_toolAdminBg)
         {
            _toolAdminBg.visible = value;
         }
         if(_toolBtnStartWedding)
         {
            _toolBtnStartWedding.visible = value;
         }
         if(_toolBtnGuestList)
         {
            _toolBtnGuestList.visible = value;
         }
         if(_toolBtnContinuation)
         {
            _toolBtnContinuation.visible = value;
         }
         if(_toolBtnAdminInviteGuest)
         {
            _toolBtnAdminInviteGuest.visible = value;
         }
         if(_toolBtnModify)
         {
            _toolBtnModify.visible = value;
         }
         if(_startWeddingTip)
         {
            _startWeddingTip.visible = value;
         }
         if(_startWeddingTip2)
         {
            _startWeddingTip2.visible = value;
         }
         if(ChurchManager.instance.currentScene == 0)
         {
            if(_startWeddingTip)
            {
               _startWeddingTip.visible = false;
            }
            if(_startWeddingTip2)
            {
               _startWeddingTip2.visible = false;
            }
         }
      }
      
      private function showGiftToolView() : void
      {
         _sendGiftToolBg = ComponentFactory.Instance.creat("asset.church.room.toolAdminBgAsset");
         _sendGiftToolBg.width = 120;
         _sendGiftToolBg.x = 60;
         addChild(_sendGiftToolBg);
         _toolSendGiftBtn = ComponentFactory.Instance.creat("church.room.toolBtnSendGiftAsset");
         addChild(_toolSendGiftBtn);
         _toolSendCashBtn = ComponentFactory.Instance.creat("asset.church.room.adminToGuest");
         _toolSendCashBtn.enable = false;
         addChild(_toolSendCashBtn);
         _toolSendCashBtn.visible = false;
         _toolSendCashBtnForGuest = ComponentFactory.Instance.creat("church.room.toolBtnSendCashAsset");
         this.addChild(_toolSendCashBtnForGuest);
         _toolSendCashBtnForGuest.visible = false;
      }
      
      private function set GiftToolVisible(value:Boolean) : void
      {
         if(_toolSendGiftBtn)
         {
            _toolSendGiftBtn.visible = value;
         }
         if(_sendGiftToolBg)
         {
            _sendGiftToolBg.visible = value;
         }
         if(!value)
         {
            var _loc2_:Boolean = false;
            _toolSendCashBtnForGuest.visible = _loc2_;
            _toolSendCashBtn.visible = _loc2_;
         }
         else if(isGuest())
         {
            _toolSendCashBtnForGuest.visible = true;
            _toolSendCashBtn.visible = false;
         }
         else
         {
            _toolSendCashBtnForGuest.visible = false;
            _toolSendCashBtn.visible = true;
         }
      }
      
      private function playerStartTipMovie() : void
      {
         if(_isplayerStartTipMovieState == 1)
         {
            _isplayerStartTipMovieState = 0;
            _startTipTween = TweenLite.to(_startWeddingTip2,0.3,{
               "y":_startWeddingTip2.y - 10,
               "ease":Sine.easeInOut,
               "onComplete":playerStartTipMovie
            });
         }
         else
         {
            _isplayerStartTipMovieState = 1;
            _startTipTween = TweenLite.to(_startWeddingTip2,0.3,{
               "y":_startWeddingTip2.y + 10,
               "ease":Sine.easeInOut,
               "onComplete":playerStartTipMovie
            });
         }
      }
      
      private function isGuest() : Boolean
      {
         var tempArr:Array = [ChurchManager.instance.currentRoom.groomName,ChurchManager.instance.currentRoom.brideName];
         var tempIndex:int = tempArr.indexOf(PlayerManager.Instance.Self.NickName);
         return tempIndex >= 0?false:true;
      }
      
      private function onToolMenuClick(evt:MouseEvent) : void
      {
         var _loc2_:* = evt.currentTarget;
         if(_toolBtnGift !== _loc2_)
         {
            if(_toolBtnFire !== _loc2_)
            {
               if(_toolBtnFill !== _loc2_)
               {
                  if(_toolBtnBack !== _loc2_)
                  {
                     if(_toolBtnExit !== _loc2_)
                     {
                        if(_toolBtnRoomAdmin !== _loc2_)
                        {
                           if(_toolBtnModify !== _loc2_)
                           {
                              if(_toolBtnContinuation !== _loc2_)
                              {
                                 if(_toolBtnGuestList !== _loc2_)
                                 {
                                    if(_toolBtnInviteGuest !== _loc2_)
                                    {
                                       if(_toolBtnAdminInviteGuest !== _loc2_)
                                       {
                                          if(_toolBtnStartWedding !== _loc2_)
                                          {
                                             if(_toolSendGiftBtn !== _loc2_)
                                             {
                                                if(_toolSendCashBtn !== _loc2_)
                                                {
                                                   if(_toolSendCashBtnForGuest === _loc2_)
                                                   {
                                                      SoundManager.instance.play("008");
                                                      giftView();
                                                   }
                                                }
                                                else
                                                {
                                                   SoundManager.instance.play("008");
                                                   giftViewForGuest();
                                                }
                                             }
                                             else
                                             {
                                                SoundManager.instance.play("008");
                                                GiftManager.Instance.inChurch = true;
                                                GiftManager.Instance.show();
                                             }
                                          }
                                          else
                                          {
                                             SoundManager.instance.play("008");
                                             openStartWedding();
                                          }
                                       }
                                    }
                                    SoundManager.instance.play("008");
                                    openInviteGuest();
                                 }
                                 else
                                 {
                                    SoundManager.instance.play("008");
                                    openGuestList();
                                 }
                              }
                              else
                              {
                                 if(PlayerManager.Instance.Self.bagLocked)
                                 {
                                    BaglockedManager.Instance.show();
                                    SoundManager.instance.play("008");
                                    return;
                                 }
                                 SoundManager.instance.play("008");
                                 openRoomContinuation();
                              }
                           }
                           else
                           {
                              SoundManager.instance.play("008");
                              openRoomConfig();
                           }
                        }
                        else
                        {
                           SoundManager.instance.play("008");
                           GiftToolVisible = false;
                           _sendGifeToolVisible = false;
                           adminToolVisible = !_adminToolVisible;
                           _adminToolVisible = !_adminToolVisible;
                        }
                     }
                     else
                     {
                        if(_toolBtnExit.enable == true)
                        {
                           SoundManager.instance.play("008");
                        }
                        if(!_alertExit)
                        {
                           _alertExit = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("church.weddingRoom.WeddingRoomControler.leaveRoom"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
                           _alertExit.addEventListener("response",exitResponse);
                        }
                     }
                  }
                  else
                  {
                     if(_toolBtnBack.enable == true)
                     {
                        SoundManager.instance.play("008");
                     }
                     exitRoom();
                  }
               }
               else
               {
                  LeavePageManager.leaveToFillPath();
               }
            }
            else
            {
               if(_toolBtnFire.enable == true)
               {
                  SoundManager.instance.play("008");
               }
               openFireList();
            }
         }
         else
         {
            SoundManager.instance.play("008");
            GiftToolVisible = !_sendGifeToolVisible;
            _sendGifeToolVisible = !_sendGifeToolVisible;
            adminToolVisible = false;
            _adminToolVisible = false;
         }
      }
      
      public function giftViewForGuest() : void
      {
         trace(PlayerManager.Instance.Self.bagLocked,"9999999999999999999999");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         SocketManager.Instance.out.requestRefund();
      }
      
      public function giftView() : void
      {
         var msg:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < 100)
         {
            msg = new ChatData();
            msg.channel = 6;
            msg.msg = LanguageMgr.GetTranslation("church.churchScene.SceneControler.startWedding.Money",100);
            ChatManager.Instance.chat(msg);
            return;
         }
         if(_weddingRoomGiftFrameViewForGuest)
         {
            if(_weddingRoomGiftFrameViewForGuest.parent)
            {
               _weddingRoomGiftFrameViewForGuest.parent.removeChild(_weddingRoomGiftFrameViewForGuest);
            }
            _weddingRoomGiftFrameViewForGuest.removeEventListener("close",closeRoomGift);
            _weddingRoomGiftFrameViewForGuest.dispose();
            _weddingRoomGiftFrameViewForGuest = null;
         }
         else
         {
            _weddingRoomGiftFrameViewForGuest = ComponentFactory.Instance.creat("church.weddingRoom.frame.WeddingRoomGiftFrameViewForGuest");
            trace(_weddingRoomGiftFrameViewForGuest,"-=-=-=->");
            _weddingRoomGiftFrameViewForGuest.addEventListener("close",closeRoomGift);
            _weddingRoomGiftFrameViewForGuest.controller = _controller;
            _weddingRoomGiftFrameViewForGuest.show();
         }
      }
      
      private function exitResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               if(_alertExit)
               {
                  if(_alertExit.parent)
                  {
                     _alertExit.parent.removeChild(_alertExit);
                  }
                  _alertExit.dispose();
               }
               _alertExit = null;
               break;
            case 2:
            case 3:
            case 4:
               exitRoom();
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function exitRoom() : void
      {
         if(ChurchManager.instance.currentScene == 0 && ChurchManager.instance.currentRoom.status == "wedding_none")
         {
            ChurchManager.instance.currentScene = ChurchManager.instance.lastScene;
         }
         else
         {
            StateManager.setState("ddtchurchroomlist");
         }
      }
      
      private function toolSwitch(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_switchEnable)
         {
            _switchTween = null;
            _switchTween = TweenLite.to(this,0.5,{
               "x":stage.stageWidth - this.width + (this.width - 34),
               "ease":Sine.easeInOut
            });
            _switchEnable = false;
         }
         else
         {
            _switchTween = null;
            _switchTween = TweenLite.to(this,0.5,{
               "x":stage.stageWidth - this.width,
               "ease":Sine.easeInOut
            });
            _switchEnable = true;
         }
      }
      
      public function loadFire() : void
      {
         _fireLoader = LoadResourceManager.Instance.createLoader(PathManager.solveCatharineSwf(),4,null,"GET",null,false);
         LoadResourceManager.Instance.startLoad(_fireLoader,false,false);
      }
      
      private function get isFireLoaded() : Boolean
      {
         var fireClass:* = null;
         try
         {
            fireClass = ClassUtils.uiSourceDomain.getDefinition("tank.church.fireAcect.FireItemAccect02") as Class;
            if(fireClass)
            {
               var _loc3_:Boolean = true;
               return _loc3_;
            }
            var _loc4_:Boolean = false;
            return _loc4_;
         }
         catch(e:Error)
         {
            var _loc5_:Boolean = false;
            return _loc5_;
         }
         return false;
      }
      
      private function openFireList() : void
      {
         closeRoomGuestList();
         closeInviteGuest();
         if(!isFireLoaded)
         {
            AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("church.churchScene.SceneUI.switchVisibleFireList"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
            return;
         }
         if(!_churchFireView)
         {
            _churchFireView = ComponentFactory.Instance.creatCustomObject("church.churchFire.ChurchFireView",[_controller,_model]);
         }
         if(_churchFireView.parent)
         {
            _churchFireView.parent.removeChild(_churchFireView);
         }
         else
         {
            LayerManager.Instance.addToLayer(_churchFireView,2);
         }
      }
      
      private function openRoomConfig() : void
      {
         if(_weddingRoomConfigView)
         {
            if(_weddingRoomConfigView.parent)
            {
               _weddingRoomConfigView.parent.removeChild(_weddingRoomConfigView);
            }
            _weddingRoomConfigView.removeEventListener("close",closeRoomConfig);
            _weddingRoomConfigView.dispose();
            _weddingRoomConfigView = null;
         }
         else
         {
            _weddingRoomConfigView = ComponentFactory.Instance.creat("church.weddingRoom.frame.WeddingRoomConfigView");
            _weddingRoomConfigView.addEventListener("close",closeRoomConfig);
            _weddingRoomConfigView.controller = _controller;
            _weddingRoomConfigView.show();
         }
      }
      
      private function openRoomContinuation() : void
      {
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("church.churchScene.cannotContinuation.costly2"));
      }
      
      private function openGuestList() : void
      {
         closeFireList();
         closeInviteGuest();
         if(_weddingRoomGuestListView)
         {
            if(_weddingRoomGuestListView.parent)
            {
               _weddingRoomGuestListView.parent.removeChild(_weddingRoomGuestListView);
            }
            _weddingRoomGuestListView.removeEventListener("close",closeRoomGuestList);
            _weddingRoomGuestListView.dispose();
            _weddingRoomGuestListView = null;
         }
         else
         {
            _weddingRoomGuestListView = ComponentFactory.Instance.creatCustomObject("church.weddingRoom.frame.WeddingRoomGuestListView",[_controller,_model]);
            _weddingRoomGuestListView.addEventListener("close",closeRoomGuestList);
            _weddingRoomGuestListView.show();
         }
      }
      
      private function openInviteGuest() : void
      {
         closeFireList();
         closeRoomGuestList();
         if(_churchInviteController == null)
         {
            _churchInviteController = new ChurchInviteController();
         }
         if(_churchInviteController.getView().parent)
         {
            _churchInviteController.getView().parent.removeChild(_churchInviteController.getView());
         }
         else
         {
            _churchInviteController.refleshList(0);
            _churchInviteController.showView();
         }
      }
      
      private function openStartWedding() : void
      {
         if(_toolBtnStartWedding.enable == true)
         {
            SoundManager.instance.play("008");
         }
         _alertStartWedding = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.view.task.TaskCatalogContentView.tip"),LanguageMgr.GetTranslation("are.you.sure.to.marry"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,false,false,2);
         _alertStartWedding.addEventListener("response",startWeddingResponse);
      }
      
      private function startWeddingResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               closeStartWedding();
               break;
            case 2:
            case 3:
            case 4:
               _controller.startWedding();
               closeStartWedding();
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function closeStartWedding() : void
      {
         if(_alertStartWedding)
         {
            if(_alertStartWedding.parent)
            {
               _alertStartWedding.parent.removeChild(_alertStartWedding);
            }
            _alertStartWedding.dispose();
         }
         _alertStartWedding = null;
      }
      
      private function closeFireList() : void
      {
         if(_churchFireView && _churchFireView.parent)
         {
            _churchFireView.parent.removeChild(_churchFireView);
         }
      }
      
      private function closeRoomGift(evt:Event = null) : void
      {
         if(_weddingRoomGiftFrameViewForGuest)
         {
            _weddingRoomGiftFrameViewForGuest.removeEventListener("close",closeRoomGift);
            if(_weddingRoomGiftFrameViewForGuest.parent)
            {
               _weddingRoomGiftFrameViewForGuest.parent.removeChild(_weddingRoomGiftFrameViewForGuest);
            }
            _weddingRoomGiftFrameViewForGuest.dispose();
         }
         _weddingRoomGiftFrameViewForGuest = null;
      }
      
      private function closeRoomConfig(evt:Event = null) : void
      {
         if(_weddingRoomConfigView)
         {
            _weddingRoomConfigView.removeEventListener("close",closeRoomConfig);
            if(_weddingRoomConfigView.parent)
            {
               _weddingRoomConfigView.parent.removeChild(_weddingRoomConfigView);
            }
            _weddingRoomConfigView.dispose();
         }
         _weddingRoomConfigView = null;
      }
      
      private function closeRoomContinuation(evt:Event = null) : void
      {
         if(_weddingRoomContinuationView)
         {
            _weddingRoomContinuationView.removeEventListener("close",closeRoomContinuation);
            if(_weddingRoomContinuationView.parent)
            {
               _weddingRoomContinuationView.parent.removeChild(_weddingRoomContinuationView);
            }
            _weddingRoomContinuationView.dispose();
         }
         _weddingRoomContinuationView = null;
      }
      
      private function closeRoomGuestList(evt:Event = null) : void
      {
         if(_weddingRoomGuestListView)
         {
            _weddingRoomGuestListView.removeEventListener("close",closeRoomGuestList);
            if(_weddingRoomGuestListView.parent)
            {
               _weddingRoomGuestListView.parent.removeChild(_weddingRoomGuestListView);
            }
            _weddingRoomGuestListView.dispose();
         }
         _weddingRoomGuestListView = null;
      }
      
      private function closeInviteGuest(evt:Event = null) : void
      {
         if(_churchInviteController && _churchInviteController.getView() && _churchInviteController.getView().parent)
         {
            _churchInviteController.getView().parent.removeChild(_churchInviteController.getView());
         }
      }
      
      private function removeView() : void
      {
         if(_toolBg)
         {
            if(_toolBg.parent)
            {
               _toolBg.parent.removeChild(_toolBg);
            }
            _toolBg.bitmapData.dispose();
            _toolBg.bitmapData = null;
         }
         _toolBg = null;
         if(_startWeddingTip2)
         {
            if(_startWeddingTip2.parent)
            {
               _startWeddingTip2.parent.removeChild(_startWeddingTip2);
            }
            _startWeddingTip2.bitmapData.dispose();
            _startWeddingTip2.bitmapData = null;
         }
         _startWeddingTip2 = null;
         if(_toolSwitchBg)
         {
            if(_toolSwitchBg.parent)
            {
               _toolSwitchBg.parent.removeChild(_toolSwitchBg);
            }
            _toolSwitchBg.dispose();
         }
         _toolSwitchBg = null;
         if(_toolSwitch)
         {
            if(_toolSwitch.parent)
            {
               _toolSwitch.parent.removeChild(_toolSwitch);
            }
            _toolSwitch.bitmapData.dispose();
            _toolSwitch.bitmapData = null;
         }
         _toolSwitch = null;
         if(_toolAdminBg)
         {
            if(_toolAdminBg.parent)
            {
               _toolAdminBg.parent.removeChild(_toolAdminBg);
            }
            _toolAdminBg.bitmapData.dispose();
            _toolAdminBg.bitmapData = null;
         }
         _toolAdminBg = null;
         if(_startWeddingTip)
         {
            if(_startWeddingTip.parent)
            {
               _startWeddingTip.parent.removeChild(_startWeddingTip);
            }
            _startWeddingTip.bitmapData.dispose();
            _startWeddingTip.bitmapData = null;
         }
         _startWeddingTip = null;
         if(_toolBtnRoomAdmin)
         {
            if(_toolBtnRoomAdmin.parent)
            {
               _toolBtnRoomAdmin.parent.removeChild(_toolBtnRoomAdmin);
            }
            _toolBtnRoomAdmin.dispose();
         }
         _toolBtnRoomAdmin = null;
         if(_toolBtnGift)
         {
            if(_toolBtnGift.parent)
            {
               _toolBtnGift.parent.removeChild(_toolBtnGift);
            }
            _toolBtnGift.dispose();
         }
         _toolBtnGift = null;
         if(_toolBtnFire)
         {
            if(_toolBtnFire.parent)
            {
               _toolBtnFire.parent.removeChild(_toolBtnFire);
            }
            _toolBtnFire.dispose();
         }
         _toolBtnFire = null;
         if(_toolBtnFill)
         {
            if(_toolBtnFill.parent)
            {
               _toolBtnFill.parent.removeChild(_toolBtnFill);
            }
            _toolBtnFill.dispose();
         }
         _toolBtnFill = null;
         if(_toolBtnExit)
         {
            if(_toolBtnExit.parent)
            {
               _toolBtnExit.parent.removeChild(_toolBtnExit);
            }
            _toolBtnExit.dispose();
         }
         _toolBtnExit = null;
         if(_toolBtnBack)
         {
            if(_toolBtnBack.parent)
            {
               _toolBtnBack.parent.removeChild(_toolBtnBack);
            }
            _toolBtnBack.dispose();
         }
         _toolBtnBack = null;
         if(_toolBtnStartWedding)
         {
            if(_toolBtnStartWedding.parent)
            {
               _toolBtnStartWedding.parent.removeChild(_toolBtnStartWedding);
            }
            _toolBtnStartWedding.dispose();
         }
         _toolBtnStartWedding = null;
         if(_toolBtnAdminInviteGuest)
         {
            if(_toolBtnAdminInviteGuest.parent)
            {
               _toolBtnAdminInviteGuest.parent.removeChild(_toolBtnAdminInviteGuest);
            }
            _toolBtnAdminInviteGuest.dispose();
         }
         _toolBtnAdminInviteGuest = null;
         if(_toolBtnGuestList)
         {
            if(_toolBtnGuestList.parent)
            {
               _toolBtnGuestList.parent.removeChild(_toolBtnGuestList);
            }
            _toolBtnGuestList.dispose();
         }
         _toolBtnGuestList = null;
         if(_toolBtnContinuation)
         {
            if(_toolBtnContinuation.parent)
            {
               _toolBtnContinuation.parent.removeChild(_toolBtnContinuation);
            }
            _toolBtnContinuation.dispose();
         }
         _toolBtnContinuation = null;
         if(_toolBtnModify)
         {
            if(_toolBtnModify.parent)
            {
               _toolBtnModify.parent.removeChild(_toolBtnModify);
            }
            _toolBtnModify.dispose();
         }
         _toolBtnModify = null;
         if(_alertExit)
         {
            if(_alertExit.parent)
            {
               _alertExit.parent.removeChild(_alertExit);
            }
            _alertExit.dispose();
         }
         _alertExit = null;
         _fireLoader = null;
         if(_churchFireView)
         {
            if(_churchFireView.parent)
            {
               _churchFireView.parent.removeChild(_churchFireView);
            }
            _churchFireView.dispose();
         }
         _churchFireView = null;
         if(_weddingRoomGiftFrameViewForGuest)
         {
            if(_weddingRoomGiftFrameViewForGuest.parent)
            {
               _weddingRoomGiftFrameViewForGuest.parent.removeChild(_weddingRoomGiftFrameViewForGuest);
            }
            _weddingRoomGiftFrameViewForGuest.dispose();
         }
         _weddingRoomGiftFrameViewForGuest = null;
         if(_weddingRoomConfigView)
         {
            if(_weddingRoomConfigView.parent)
            {
               _weddingRoomConfigView.parent.removeChild(_weddingRoomConfigView);
            }
            _weddingRoomConfigView.dispose();
         }
         _weddingRoomConfigView = null;
         if(_weddingRoomContinuationView)
         {
            if(_weddingRoomContinuationView.parent)
            {
               _weddingRoomContinuationView.parent.removeChild(_weddingRoomContinuationView);
            }
            _weddingRoomContinuationView.dispose();
         }
         _weddingRoomContinuationView = null;
         if(_weddingRoomGuestListView)
         {
            if(_weddingRoomGuestListView.parent)
            {
               _weddingRoomGuestListView.parent.removeChild(_weddingRoomGuestListView);
            }
            _weddingRoomGuestListView.dispose();
         }
         _weddingRoomGuestListView = null;
         if(_toolBtnInviteGuest)
         {
            if(_toolBtnInviteGuest.parent)
            {
               _toolBtnInviteGuest.parent.removeChild(_toolBtnInviteGuest);
            }
            _toolBtnInviteGuest.dispose();
         }
         _toolBtnInviteGuest = null;
         if(_alertStartWedding)
         {
            if(_alertStartWedding.parent)
            {
               _alertStartWedding.parent.removeChild(_alertStartWedding);
            }
            _alertStartWedding.dispose();
         }
         _alertStartWedding = null;
         if(_sendGiftToolBg)
         {
            if(_sendGiftToolBg.parent)
            {
               _sendGiftToolBg.parent.removeChild(_sendGiftToolBg);
            }
            ObjectUtils.disposeObject(_sendGiftToolBg);
         }
         _sendGiftToolBg = null;
         if(_toolSendGiftBtn)
         {
            if(_toolSendGiftBtn.parent)
            {
               _toolSendGiftBtn.parent.removeChild(_toolSendGiftBtn);
            }
            ObjectUtils.disposeObject(_toolSendGiftBtn);
         }
         _toolSendGiftBtn = null;
         if(_toolSendCashBtn)
         {
            if(_toolSendCashBtn.parent)
            {
               _toolSendCashBtn.parent.removeChild(_toolSendCashBtn);
            }
            ObjectUtils.disposeObject(_toolSendCashBtn);
         }
         _toolSendCashBtn = null;
         if(_toolSendCashBtnForGuest)
         {
            if(_toolSendCashBtnForGuest.parent)
            {
               _toolSendCashBtnForGuest.parent.removeChild(_toolSendCashBtnForGuest);
            }
            ObjectUtils.disposeObject(_toolSendCashBtnForGuest);
         }
         _toolSendCashBtnForGuest = null;
         if(_churchInviteController)
         {
            _churchInviteController.dispose();
         }
         _churchInviteController = null;
         if(_switchTween)
         {
            _switchTween.kill();
         }
         _switchTween = null;
         if(_startTipTween)
         {
            _startTipTween.kill();
         }
         _startTipTween = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function removeEvent() : void
      {
         ChurchManager.instance.currentRoom.removeEventListener("wedding status change",__weddingStatusChange);
         ChurchManager.instance.removeEventListener("scene change",__updateBtn);
         _toolSwitchBg.removeEventListener("click",toolSwitch);
         _toolBtnGift.removeEventListener("click",onToolMenuClick);
         _toolBtnFire.removeEventListener("click",onToolMenuClick);
         _toolBtnFill.removeEventListener("click",onToolMenuClick);
         _toolBtnExit.removeEventListener("click",onToolMenuClick);
         _toolSendGiftBtn.removeEventListener("click",onToolMenuClick);
         _toolSendCashBtn.removeEventListener("click",onToolMenuClick);
         _toolSendCashBtnForGuest.removeEventListener("click",onToolMenuClick);
         if(_toolBtnRoomAdmin)
         {
            _toolBtnRoomAdmin.removeEventListener("click",onToolMenuClick);
         }
         if(_toolBtnModify)
         {
            _toolBtnModify.removeEventListener("click",onToolMenuClick);
         }
         if(_toolBtnContinuation)
         {
            _toolBtnContinuation.removeEventListener("click",onToolMenuClick);
         }
         if(_toolBtnGuestList)
         {
            _toolBtnGuestList.removeEventListener("click",onToolMenuClick);
         }
         if(_toolBtnStartWedding)
         {
            _toolBtnStartWedding.removeEventListener("click",onToolMenuClick);
         }
         if(_toolBtnAdminInviteGuest)
         {
            _toolBtnAdminInviteGuest.removeEventListener("click",onToolMenuClick);
         }
         if(_weddingRoomGiftFrameViewForGuest)
         {
            _weddingRoomGiftFrameViewForGuest.removeEventListener("close",closeRoomGift);
         }
         if(_weddingRoomConfigView)
         {
            _weddingRoomConfigView.removeEventListener("close",closeRoomConfig);
         }
         if(_weddingRoomContinuationView)
         {
            _weddingRoomContinuationView.removeEventListener("close",closeRoomContinuation);
         }
         if(_weddingRoomGuestListView)
         {
            _weddingRoomGuestListView.removeEventListener("close",closeRoomGuestList);
         }
         if(_alertExit)
         {
            _alertExit.removeEventListener("response",exitResponse);
         }
         if(_alertStartWedding)
         {
            _alertStartWedding.removeEventListener("response",startWeddingResponse);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         removeView();
      }
   }
}
