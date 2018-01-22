package ddt.view.chat
{
   import baglocked.BaglockedManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.player.FriendListPlayer;
   import ddt.manager.ChatManager;
   import ddt.manager.DebugManager;
   import ddt.manager.IMEManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.Helpers;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import road7th.utils.StringHelper;
   
   public class ChatInputField extends Sprite
   {
      
      public static const INPUT_MAX_CHAT:int = 100;
       
      
      private var CHANNEL_KEY_SET:Array;
      
      private var CHANNEL_SET:Array;
      
      private var _channel:int = -1;
      
      private var _currentHistoryOffset:int = 0;
      
      private var _inputField:TextField;
      
      private var _maxInputWidth:Number = 300;
      
      private var _nameTextField:TextField;
      
      private var _privateChatName:String;
      
      private var _userID:int;
      
      private var _privateChatInfo:Object;
      
      public function ChatInputField()
      {
         CHANNEL_KEY_SET = ["d","x","w","g","p","s","k"];
         CHANNEL_SET = [0,1,2,3,4,5,15];
         super();
         if(!ShopManager.Instance.getMoneyShopItemByTemplateID(11100))
         {
            CHANNEL_KEY_SET.splice(CHANNEL_KEY_SET.indexOf("k"),1);
            CHANNEL_SET.splice(CHANNEL_SET.indexOf(15),1);
         }
         if(!ShopManager.Instance.getMoneyShopItemByTemplateID(11102))
         {
            CHANNEL_KEY_SET.splice(CHANNEL_KEY_SET.indexOf("d"),1);
            CHANNEL_SET.splice(CHANNEL_SET.indexOf(0),1);
         }
         if(!ShopManager.Instance.getMoneyShopItemByTemplateID(11101))
         {
            CHANNEL_KEY_SET.splice(CHANNEL_KEY_SET.indexOf("x"),1);
            CHANNEL_SET.splice(CHANNEL_SET.indexOf(1),1);
         }
         initView();
      }
      
      public function get channel() : int
      {
         return _channel;
      }
      
      public function set channel(param1:int) : void
      {
         if(_channel == param1)
         {
            return;
         }
         _channel = param1;
         setPrivateChatName("");
         setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
      }
      
      public function isFocus() : Boolean
      {
         var _loc1_:* = false;
         if(StageReferance.stage)
         {
            _loc1_ = StageReferance.stage.focus == _inputField;
         }
         return _loc1_;
      }
      
      public function set maxInputWidth(param1:Number) : void
      {
         _maxInputWidth = param1;
         updatePosAndSize();
      }
      
      public function get privateChatName() : String
      {
         return _privateChatName;
      }
      
      public function get privateUserID() : int
      {
         return _userID;
      }
      
      public function get privateChatInfo() : Object
      {
         return _privateChatInfo;
      }
      
      public function sendCurrnetText() : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = undefined;
         var _loc5_:* = null;
         var _loc2_:* = null;
         if(_channel == 1 || _channel == 0 || _channel == 15)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
         }
         var _loc4_:RegExp = /\/\S*\s?/;
         var _loc1_:Array = _loc4_.exec(_inputField.text);
         var _loc3_:String = _inputField.text.toLocaleLowerCase();
         var _loc8_:Boolean = false;
         var _loc7_:Boolean = false;
         if(_loc3_.indexOf("/") == 0)
         {
            _loc9_ = 0;
            while(_loc9_ < CHANNEL_KEY_SET.length)
            {
               if(_loc3_.indexOf("/" + CHANNEL_KEY_SET[_loc9_]) == 0)
               {
                  _loc8_ = true;
                  SoundManager.instance.play("008");
                  _inputField.text = _loc3_.substring(2);
                  dispatchEvent(new ChatEvent("inputChannelChanged",CHANNEL_SET[_loc9_]));
               }
               _loc9_++;
            }
            if(!_loc8_)
            {
               _loc6_ = ChatManager.Instance.model.customFastReply;
               _loc9_ = 0;
               while(_loc9_ < 5)
               {
                  if(_loc3_.indexOf("/" + (String(_loc9_ + 1))) == 0 && (_loc3_.length == 2 || _loc3_.charAt(2) == " "))
                  {
                     _loc7_ = true;
                     if(_loc6_.length > _loc9_)
                     {
                        _inputField.text = _loc6_[_loc9_];
                     }
                     else
                     {
                        _inputField.text = "";
                     }
                     break;
                  }
                  _loc9_++;
               }
            }
            if(_loc1_ && !_loc8_ && !_loc7_)
            {
               _loc5_ = String(_loc1_[0]).replace(" ","");
               _loc5_ = _loc5_.replace("/","");
               if(_loc5_ == "")
               {
                  return;
               }
               _inputField.text = _inputField.text.replace(_loc4_,"");
               dispatchEvent(new ChatEvent("customSetPrivateChatTo",{
                  "channel":2,
                  "nickName":_loc5_
               }));
               return;
            }
         }
         if(_loc3_.substr(0,2) != "/" + CHANNEL_KEY_SET[2])
         {
            _loc2_ = parasMsgs(_inputField.text);
            _inputField.text = "";
            if(_loc2_ == "")
            {
               return;
            }
            dispatchEvent(new ChatEvent("inputTextChanged",_loc2_));
         }
      }
      
      public function setFocus() : void
      {
         if(StageReferance.stage)
         {
            setTextFocus();
         }
         else
         {
            addEventListener("addedToStage",__onAddToStage);
         }
      }
      
      public function setInputText(param1:String) : void
      {
         if(param1.indexOf("&lt;") > -1 || param1.indexOf("&gt;") > -1)
         {
            _inputField.htmlText = param1;
            _inputField.textColor = ChatFormats.CHAT_COLORS[_channel];
         }
         else
         {
            _inputField.text = param1;
         }
         _inputField.setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
      }
      
      public function setPrivateChatName(param1:String, param2:int = 0, param3:Object = null) : void
      {
         var _loc4_:* = null;
         setTextFocus();
         _privateChatName = param1;
         _userID = param2;
         _privateChatInfo = param3;
         if(_privateChatName != "")
         {
            _loc4_ = "";
            _loc4_ = _privateChatName;
            _nameTextField.htmlText = LanguageMgr.GetTranslation("tank.view.chat.ChatInput.usernameField.text",_loc4_);
            if(_privateChatInfo && !(_privateChatInfo is FriendListPlayer))
            {
               _nameTextField.htmlText = LanguageMgr.GetTranslation("tank.view.chat.ChatInput.usernameField.textII",_privateChatInfo.areaName,_loc4_);
            }
         }
         else
         {
            _nameTextField.text = "";
         }
         updatePosAndSize();
      }
      
      private function __onAddToStage(param1:Event) : void
      {
         setTextFocus();
         removeEventListener("addedToStage",arguments.callee);
      }
      
      private function __onFieldKeyDown(param1:KeyboardEvent) : void
      {
         if(isFocus())
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
            if(param1.keyCode == 38)
            {
               currentHistoryOffset = Number(currentHistoryOffset) - 1;
               if(getHistoryChat(currentHistoryOffset) != "")
               {
                  _inputField.htmlText = getHistoryChat(currentHistoryOffset);
                  _inputField.setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
                  _inputField.addEventListener("enterFrame",__setSelectIndexSync);
               }
            }
            else if(param1.keyCode == 40)
            {
               currentHistoryOffset = Number(currentHistoryOffset) + 1;
               _inputField.text = getHistoryChat(currentHistoryOffset);
            }
         }
         if(param1.keyCode == 13 && !ChatManager.Instance.chatDisabled)
         {
            if(_inputField.text.substr(0,1) == "#")
            {
               DebugManager.getInstance().handle(_inputField.text);
               _inputField.text = "";
            }
            else if(_inputField.text != "" && parasMsgs(_inputField.text) != "" && ChatManager.Instance.input.parent != null)
            {
               if(isFocus())
               {
                  if(ChatManager.Instance.state != 16)
                  {
                     SoundManager.instance.play("008");
                     sendCurrnetText();
                     _currentHistoryOffset = ChatManager.Instance.model.resentChats.length;
                  }
               }
               else if(canUseKeyboardSetFocus())
               {
                  setFocus();
               }
            }
            else
            {
               ChatManager.Instance.switchVisible();
               if(canUseKeyboardSetFocus())
               {
                  ChatManager.Instance.setFocus();
               }
               if(ChatManager.Instance.visibleSwitchEnable)
               {
                  SoundManager.instance.play("008");
               }
            }
         }
         if(ChatManager.Instance.input.parent != null)
         {
            if(ChatManager.Instance.visibleSwitchEnable)
            {
               IMEManager.enable();
            }
         }
      }
      
      private function canUseKeyboardSetFocus() : Boolean
      {
         if(!ChatManager.Instance.focusFuncEnabled)
         {
            return false;
         }
         if(ChatManager.Instance.input.parent != null && (ChatManager.Instance.state == 1 || ChatManager.Instance.state == 8))
         {
            return true;
         }
         if(ChatManager.Instance.input.parent != null && StageReferance.stage.focus == null)
         {
            return true;
         }
         return false;
      }
      
      private function __onInputFieldChange(param1:Event) : void
      {
         if(_inputField.text)
         {
            _inputField.text = _inputField.text.replace("\n","").replace("\r","");
         }
      }
      
      private function __setSelectIndexSync(param1:Event) : void
      {
         _inputField.removeEventListener("enterFrame",__setSelectIndexSync);
         _inputField.setSelection(_inputField.text.length,_inputField.text.length);
      }
      
      private function get currentHistoryOffset() : int
      {
         return _currentHistoryOffset;
      }
      
      private function set currentHistoryOffset(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > ChatManager.Instance.model.resentChats.length - 1)
         {
            param1 = ChatManager.Instance.model.resentChats.length - 1;
         }
         _currentHistoryOffset = param1;
      }
      
      private function getHistoryChat(param1:int) : String
      {
         if(param1 == -1)
         {
            return "";
         }
         var _loc2_:String = Helpers.deCodeString(ChatManager.Instance.model.resentChats[param1].msg);
         return _loc2_;
      }
      
      private function initView() : void
      {
         var _loc1_:Point = ComponentFactory.Instance.creatCustomObject("chat.InputFieldTextFieldStartPos");
         _nameTextField = new TextField();
         _nameTextField.type = "dynamic";
         _nameTextField.mouseEnabled = false;
         _nameTextField.selectable = false;
         _nameTextField.autoSize = "left";
         _nameTextField.x = _loc1_.x;
         _nameTextField.y = _loc1_.y;
         addChild(_nameTextField);
         _inputField = new TextField();
         _inputField.type = "input";
         _inputField.autoSize = "none";
         _inputField.multiline = false;
         _inputField.wordWrap = false;
         _inputField.maxChars = 100;
         _inputField.x = _loc1_.x;
         _inputField.y = _loc1_.y;
         _inputField.height = 20;
         addChild(_inputField);
         _inputField.addEventListener("change",__onInputFieldChange);
         setTextFormat(new TextFormat("Arial",12,65280));
         updatePosAndSize();
         StageReferance.stage.addEventListener("keyDown",__onFieldKeyDown,false,2147483647);
      }
      
      private function parasMsgs(param1:String) : String
      {
         var _loc2_:* = param1;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
         return _loc2_;
      }
      
      private function setTextFocus() : void
      {
         StageReferance.stage.focus = _inputField;
         _inputField.setSelection(_inputField.text.length,_inputField.text.length);
      }
      
      private function setTextFormat(param1:TextFormat) : void
      {
         _nameTextField.defaultTextFormat = param1;
         _nameTextField.setTextFormat(param1);
         _inputField.defaultTextFormat = param1;
         _inputField.setTextFormat(param1);
      }
      
      private function updatePosAndSize() : void
      {
         _inputField.x = 70 + _nameTextField.textWidth;
         if(_nameTextField.textWidth > _maxInputWidth)
         {
            return;
         }
         _inputField.width = _maxInputWidth - _nameTextField.textWidth;
      }
   }
}
