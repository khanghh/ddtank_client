package ddt.view.chat
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.ChatManager;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.utils.Helpers;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class ChatInputView extends Sprite
   {
      
      public static const BIG_BUGLE:uint = 0;
      
      public static const SMALL_BUGLE:uint = 1;
      
      public static const PRIVATE:uint = 2;
      
      public static const CONSORTIA:uint = 3;
      
      public static const TEAM:uint = 4;
      
      public static const CURRENT:uint = 5;
      
      public static const SYS_NOTICE:uint = 6;
      
      public static const SYS_TIP:uint = 7;
      
      public static const ADMIN_NOTICE:int = 8;
      
      public static const CHURCH_CHAT:int = 9;
      
      public static const DEFENSE_TIP:int = 10;
      
      public static const DEFY_AFFICHE:uint = 11;
      
      public static const CROSS_NOTICE:uint = 12;
      
      public static const HOTSPRING_ROOM:uint = 13;
      
      public static const GM_NOTICE:uint = 14;
      
      public static const CROSS_BUGLE:uint = 15;
      
      public static const WORLDBOSS_ROOM:uint = 20;
      
      public static const COMPLEX_NOTICE:uint = 21;
      
      public static const CHRISTMAS_CHAT:uint = 25;
      
      public static const CATCH_INSECT_CHAT:uint = 99;
      
      public static const HOME_CHAT:uint = 27;
      
      public static const ONE_NOTICE:uint = 28;
      
      public static const SUPERWINNER_CHAT:uint = 26;
      
      public static const DEMON_CHI_YOU:uint = 35;
      
      public static const PUTFIREWORKS:uint = 29;
      
      public static const TASK:uint = 31;
       
      
      private var _preChannel:int = -1;
      
      private var _bg:Bitmap;
      
      private var _btnEnter:BaseButton;
      
      private var _channel:int = 0;
      
      private var _channelBtn:Sprite;
      
      private var _channelPanel:ChatChannelPanel;
      
      private var _channelState:ScaleFrameImage;
      
      private var _faceBtn:BaseButton;
      
      private var _facePanel:ChatFacePanel;
      
      private var _fastReplyBtn:BaseButton;
      
      private var _fastReplyPanel:ChatFastReplyPanel;
      
      private var _friendListBtn:BaseButton;
      
      private var _friendListPanel:ChatFriendListPanel;
      
      private var _inputField:ChatInputField;
      
      private var _lastRecentSendTime:int = -30000;
      
      private var _lastSendChatTime:int = -30000;
      
      private var _chatPrivateFrame:ChatPrivateFrame;
      
      private var _friendListPanelPos:Point;
      
      private var _fastReplyPanelPos:Point;
      
      private var _facePanelPos:Point;
      
      private var _channelPanelPos:Point;
      
      private var _imBtnInGame:SimpleBitmapButton;
      
      private var _faceBtnInGame:SimpleBitmapButton;
      
      private var _fastReplyBtnInGame:SimpleBitmapButton;
      
      private var channelII:uint;
      
      public function ChatInputView()
      {
         super();
         init();
         initEvent();
      }
      
      public function set enableGameState(value:Boolean) : void
      {
         if(value)
         {
            _facePanelPos.x = _facePanelPos.x - 23;
            addChild(_fastReplyBtnInGame);
            addChild(_faceBtnInGame);
            addChild(_imBtnInGame);
            if(_faceBtn.parent)
            {
               removeChild(_faceBtn);
            }
            if(_fastReplyBtn.parent)
            {
               removeChild(_fastReplyBtn);
            }
            if(_friendListBtn.parent)
            {
               removeChild(_friendListBtn);
            }
         }
         else
         {
            _facePanelPos.x = _facePanelPos.x + 23;
            if(_fastReplyBtnInGame.parent)
            {
               removeChild(_fastReplyBtnInGame);
            }
            if(_faceBtnInGame.parent)
            {
               removeChild(_faceBtnInGame);
            }
            if(_imBtnInGame.parent)
            {
               removeChild(_imBtnInGame);
            }
            addChild(_faceBtn);
            addChild(_fastReplyBtn);
            addChild(_friendListBtn);
         }
      }
      
      public function savePreChannel() : void
      {
         if(_channel == 4)
         {
            _preChannel = 5;
         }
         _preChannel = 5;
      }
      
      public function revertChannel() : void
      {
         if(_preChannel != -1)
         {
            channel = _preChannel;
            _preChannel = -1;
         }
      }
      
      public function get fastReplyPanel() : ChatFastReplyPanel
      {
         return _fastReplyPanel;
      }
      
      public function set channel($channel:int) : void
      {
         $channel = $channel;
         ChatManager.Instance.view.addChild(this);
         ChatManager.Instance.setFocus();
         if(_channel == $channel)
         {
            return;
         }
         _channel = $channel;
         _channelState.setFrame(_channel == 20?6:Number(_channel + 1));
         _inputField.channel = _channel;
         if(_channel == 2)
         {
            onBagAndInfoLoaded = function():void
            {
               _chatPrivateFrame = ComponentFactory.Instance.creatComponentByStylename("chat.PrivateFrame");
               _chatPrivateFrame.info = new AlertInfo(LanguageMgr.GetTranslation("tank.view.scenechatII.PrivateChatIIView.privatename"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"));
               _chatPrivateFrame.addEventListener("response",__frameEventHandler);
               LayerManager.Instance.addToLayer(_chatPrivateFrame,3,true,2);
            };
            new HelperUIModuleLoad().loadUIModule(["ddtbagandinfo"],onBagAndInfoLoaded);
         }
      }
      
      private function __onCustomSetPrivateChatTo(e:ChatEvent) : void
      {
         _channel = int(e.data.channel);
         _channelState.setFrame(_channel + 1);
         _inputField.channel = _channel;
         ChatManager.Instance.setFocus();
         setPrivateChatTo(e.data.nickName);
      }
      
      private function __frameEventHandler(e:FrameEvent) : void
      {
         var name:* = null;
         SoundManager.instance.play("008");
         switch(int(e.responseCode))
         {
            case 0:
            case 1:
               channel = 5;
               break;
            case 2:
            case 3:
            case 4:
               name = (e.currentTarget as ChatPrivateFrame).currentFriend;
               if(!name)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.view.chat.SelectPlayerChatView.name"));
                  return;
               }
               setPrivateChatTo(name);
               break;
         }
         _chatPrivateFrame.dispose();
         _chatPrivateFrame = null;
         ChatManager.Instance.setFocus();
      }
      
      public function set faceEnabled(value:Boolean) : void
      {
         _faceBtn.enable = value;
         _faceBtnInGame.enable = value;
      }
      
      public function getCurrentInputChannel() : int
      {
         if(_channel != 5)
         {
            return _channel;
         }
         var result:int = _channel;
         var _loc2_:* = ChatManager.Instance.state;
         if(4 !== _loc2_)
         {
            if(18 !== _loc2_)
            {
               if(19 !== _loc2_)
               {
                  if(24 !== _loc2_)
                  {
                     if(25 !== _loc2_)
                     {
                        if(28 !== _loc2_)
                        {
                           if(21 !== _loc2_)
                           {
                              if(32 !== _loc2_)
                              {
                                 if(33 !== _loc2_)
                                 {
                                    if(34 !== _loc2_)
                                    {
                                       if(31 !== _loc2_)
                                       {
                                          if(35 !== _loc2_)
                                          {
                                             if(35 === _loc2_)
                                             {
                                                result = 35;
                                             }
                                          }
                                          else
                                          {
                                             result = 35;
                                          }
                                       }
                                       else
                                       {
                                          result = 26;
                                       }
                                    }
                                    else
                                    {
                                       result = 27;
                                    }
                                 }
                                 else
                                 {
                                    result = 27;
                                 }
                              }
                              else
                              {
                                 result = 99;
                              }
                           }
                           else
                           {
                              result = 25;
                           }
                        }
                        else
                        {
                           result = 20;
                        }
                     }
                     else
                     {
                        result = 5;
                     }
                  }
               }
               addr32:
               result = 13;
            }
            §§goto(addr32);
         }
         else
         {
            result = 9;
         }
         return result;
      }
      
      public function get inputField() : ChatInputField
      {
         return _inputField;
      }
      
      public function sendCurrentText() : void
      {
         _inputField.sendCurrnetText();
      }
      
      public function setInputText(txt:String) : void
      {
         _inputField.setInputText(txt);
      }
      
      public function setPrivateChatTo(nickname:String, uid:int = 0, info:Object = null) : void
      {
         if(_friendListPanel.parent)
         {
            _friendListPanel.parent.removeChild(_friendListPanel);
         }
         _channel = 2;
         _channelState.setFrame(_channel + 1);
         _inputField.channel = _channel;
         _inputField.setPrivateChatName(nickname,uid,info);
         if(ChatManager.Instance.visibleSwitchEnable)
         {
            ChatManager.Instance.view.addChild(this);
         }
      }
      
      public function hidePanel() : void
      {
         if(_channelPanel.parent)
         {
            _channelPanel.parent.removeChild(_channelPanel);
         }
         if(_friendListPanel.parent)
         {
            _friendListPanel.parent.removeChild(_friendListPanel);
         }
         if(_fastReplyPanel.parent)
         {
            _fastReplyPanel.parent.removeChild(_fastReplyPanel);
         }
         if(_facePanel.parent)
         {
            _facePanel.parent.removeChild(_facePanel);
         }
      }
      
      public function showFastReplypanel() : void
      {
         _fastReplyPanel.setText();
      }
      
      private function __panelBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         e.stopImmediatePropagation();
         var _loc2_:* = e.currentTarget;
         if(_channelBtn !== _loc2_)
         {
            if(_friendListBtn !== _loc2_)
            {
               if(_fastReplyBtn !== _loc2_)
               {
                  if(_fastReplyBtnInGame !== _loc2_)
                  {
                     if(_faceBtn !== _loc2_)
                     {
                        if(_faceBtnInGame !== _loc2_)
                        {
                           if(_imBtnInGame === _loc2_)
                           {
                              if(PlayerManager.Instance.Self.Grade < 11)
                              {
                                 MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.functionLimitTip",11));
                                 return;
                              }
                              IMManager.Instance.show();
                           }
                        }
                     }
                     showPanel(_facePanel,_facePanelPos);
                  }
               }
               showPanel(_fastReplyPanel,_fastReplyPanelPos);
            }
            else
            {
               showPanel(_friendListPanel,_friendListPanelPos);
               _friendListPanel.refreshAllList();
            }
         }
         else
         {
            showPanel(_channelPanel,_channelPanelPos);
         }
      }
      
      private function showPanel(target:ChatBasePanel, pos:Point) : void
      {
         target.x = localToGlobal(new Point(pos.x,pos.y)).x;
         target.y = localToGlobal(new Point(pos.x,pos.y)).y;
         target.setVisible = true;
      }
      
      private function __onChannelSelected(e:ChatEvent) : void
      {
         var selectedChannel:int = e.data;
         if((StateManager.currentStateType == "consortia_domain" || StateManager.currentStateType == "consortiaGuard") && selectedChannel == 5)
         {
            channel = 3;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("consortiadomain.cannotUseCurrentChannel"));
         }
         else
         {
            channel = selectedChannel;
         }
      }
      
      private function __onEnterClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendCurrentText();
      }
      
      private function __onFaceSelect(event:Event) : void
      {
         ChatManager.Instance.sendFace(_facePanel.selected);
      }
      
      private function __onFastSelect(event:Event) : void
      {
         setInputText(_fastReplyPanel.selectedWrod);
         sendCurrentText();
      }
      
      private function __onInputTextChanged(event:ChatEvent) : void
      {
         var ifCanSend:Boolean = false;
         var data:ChatData = new ChatData();
         channelII = getCurrentInputChannel();
         data.channel = getCurrentInputChannel();
         data.msg = String(event.data);
         data.sender = PlayerManager.Instance.Self.NickName;
         data.senderID = PlayerManager.Instance.Self.ID;
         data.receiver = _inputField.privateChatName;
         data.sender = ChatFormats.replaceUnacceptableChar(data.sender);
         data.receiver = ChatFormats.replaceUnacceptableChar(_inputField.privateChatName);
         data.zoneID = PlayerManager.Instance.Self.ZoneID;
         if(_inputField.privateChatInfo && !(_inputField.privateChatInfo is FriendListPlayer))
         {
            data.zoneID = _inputField.privateChatInfo.areaID;
            data.zoneName = _inputField.privateChatInfo.areaName;
         }
         if(checkCanSendChannel(data))
         {
            ifCanSend = false;
            ifCanSend = data.channel == 15 || data.channel == 0 || data.channel == 1 || checkCanSendTime();
            if(ifCanSend)
            {
               ChatManager.Instance.sendChat(data);
               if(data.channel != 0 && data.channel != 1 && data.channel != 15)
               {
                  data.msg = Helpers.enCodeString(data.msg);
                  ChatManager.Instance.chat(data);
               }
            }
         }
         ChatManager.Instance.output.currentOffset = 0;
      }
      
      private function checkCanSendChannel(data:ChatData) : Boolean
      {
         if(data.channel == 2 && data.receiver == PlayerManager.Instance.Self.NickName && data.zoneID == PlayerManager.Instance.Self.ZoneID)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.ChatManagerII.cannot"));
            return false;
         }
         if(data.channel == 3 && PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.ChatManagerII.you"));
            return false;
         }
         if(data.channel == 4)
         {
            if(ChatManager.Instance.state != 5 && ChatManager.Instance.state != 1 && ChatManager.Instance.state != 8 && ChatManager.Instance.state != 10 && ChatManager.Instance.state != 9)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.manager.ChatManagerII.now"));
               return false;
            }
         }
         return true;
      }
      
      private function checkCanSendTime() : Boolean
      {
         trace(_channel,channelII);
         if(channelII == 9)
         {
            if(getTimer() - _lastSendChatTime < 5000)
            {
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.view.chat.ChatInput.time1"));
               return false;
            }
            _lastSendChatTime = getTimer();
         }
         else
         {
            if(getTimer() - _lastSendChatTime < 1000)
            {
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.view.chat.ChatInput.time2"));
               return false;
            }
            _lastSendChatTime = getTimer();
         }
         if(_channel != 5)
         {
            return true;
         }
         if(getTimer() - _lastRecentSendTime < 30000)
         {
            if((ChatManager.Instance.state == 3 || ChatManager.Instance.state == 7 || ChatManager.Instance.state == 6 || ChatManager.Instance.state == 0 || ChatManager.Instance.state == 12 || ChatManager.Instance.state == 2 || ChatManager.Instance.state == 14 || ChatManager.Instance.state == 15 || ChatManager.Instance.state == 25 || ChatManager.Instance.state == 17 || ChatManager.Instance.state == 26 || ChatManager.Instance.state == 27 || ChatManager.Instance.state == 37) && _channel == 5)
            {
               ChatManager.Instance.sysChatRed(LanguageMgr.GetTranslation("tank.view.chat.ChatInputView.channel"));
               return false;
            }
            _lastRecentSendTime = getTimer();
         }
         else
         {
            _lastRecentSendTime = getTimer();
         }
         return true;
      }
      
      private function init() : void
      {
         _channelBtn = new Sprite();
         _bg = ComponentFactory.Instance.creatBitmap("asset.chat.InputBg");
         _channelState = ComponentFactory.Instance.creatComponentByStylename("chat.ChannelState");
         _btnEnter = ComponentFactory.Instance.creatComponentByStylename("chat.InputEnterBtn");
         _friendListBtn = ComponentFactory.Instance.creatComponentByStylename("chat.InputFriendListBtn");
         _fastReplyBtn = ComponentFactory.Instance.creatComponentByStylename("chat.InputFastReplyBtn");
         _faceBtn = ComponentFactory.Instance.creatComponentByStylename("chat.InputFaceBtn");
         _faceBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.InputFaceInGameBtn");
         _fastReplyBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.InputFastReplyInGameBtn");
         _imBtnInGame = ComponentFactory.Instance.creatComponentByStylename("chat.InputIMBtn");
         _inputField = ComponentFactory.Instance.creatCustomObject("chat.InputField");
         _channelPanel = ComponentFactory.Instance.creatCustomObject("chat.ChannelPanel");
         _channelPanelPos = ComponentFactory.Instance.creatCustomObject("chat.ChannelPanelPosT" + _channelPanel.btnLen);
         _facePanel = ComponentFactory.Instance.creatCustomObject("chat.FacePanel");
         _facePanelPos = ComponentFactory.Instance.creatCustomObject("chat.FacePanelPos");
         _fastReplyPanel = ComponentFactory.Instance.creatCustomObject("chat.FastReplyPanel");
         _fastReplyPanelPos = ComponentFactory.Instance.creatCustomObject("chat.FastReplyPanelPos");
         _friendListPanel = ComponentFactory.Instance.creatCustomObject("chat.FriendListPanel");
         _friendListPanelPos = ComponentFactory.Instance.creatCustomObject("chat.FriendListPanelPos");
         _btnEnter.tipData = LanguageMgr.GetTranslation("chat.Send");
         _friendListBtn.tipData = LanguageMgr.GetTranslation("chat.FriendList");
         var _loc1_:* = LanguageMgr.GetTranslation("chat.FastReply");
         _fastReplyBtn.tipData = _loc1_;
         _fastReplyBtnInGame.tipData = _loc1_;
         _loc1_ = LanguageMgr.GetTranslation("chat.Expression");
         _faceBtn.tipData = _loc1_;
         _faceBtnInGame.tipData = _loc1_;
         _imBtnInGame.tipData = LanguageMgr.GetTranslation("chat.Friend");
         _channelState.setFrame(1);
         _friendListPanel.setup(setPrivateChatTo,false);
         addChild(_bg);
         addChild(_btnEnter);
         addChild(_friendListBtn);
         addChild(_fastReplyBtn);
         addChild(_faceBtn);
         addChild(_inputField);
         addChild(_channelBtn);
         _channelBtn.addChild(_channelState);
      }
      
      private function initEvent() : void
      {
         _channelBtn.buttonMode = true;
         _channelPanel.addEventListener("inputChannelChanged",__onChannelSelected);
         _fastReplyPanel.addEventListener("select",__onFastSelect);
         _facePanel.addEventListener("select",__onFaceSelect);
         _channelBtn.addEventListener("click",__panelBtnClick);
         _friendListBtn.addEventListener("click",__panelBtnClick);
         _fastReplyBtn.addEventListener("click",__panelBtnClick);
         _faceBtn.addEventListener("click",__panelBtnClick);
         _faceBtnInGame.addEventListener("click",__panelBtnClick);
         _fastReplyBtnInGame.addEventListener("click",__panelBtnClick);
         _imBtnInGame.addEventListener("click",__panelBtnClick);
         _inputField.addEventListener("inputChannelChanged",__onChannelSelected);
         _inputField.addEventListener("inputTextChanged",__onInputTextChanged);
         _inputField.addEventListener("customSetPrivateChatTo",__onCustomSetPrivateChatTo);
         _btnEnter.addEventListener("click",__onEnterClick);
      }
   }
}
