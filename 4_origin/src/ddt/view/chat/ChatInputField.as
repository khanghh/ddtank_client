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
      
      public function set channel(channel:int) : void
      {
         if(_channel == channel)
         {
            return;
         }
         _channel = channel;
         setPrivateChatName("");
         setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
      }
      
      public function isFocus() : Boolean
      {
         var isF:* = false;
         if(StageReferance.stage)
         {
            isF = StageReferance.stage.focus == _inputField;
         }
         return isF;
      }
      
      public function set maxInputWidth($width:Number) : void
      {
         _maxInputWidth = $width;
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
         var i:int = 0;
         var list:* = undefined;
         var name:* = null;
         var msgs:* = null;
         if(_channel == 1 || _channel == 0 || _channel == 15)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
         }
         var reg:RegExp = /\/\S*\s?/;
         var result:Array = reg.exec(_inputField.text);
         var allLowString:String = _inputField.text.toLocaleLowerCase();
         var isChangedChannel:Boolean = false;
         var isFastReply:Boolean = false;
         if(allLowString.indexOf("/") == 0)
         {
            for(i = 0; i < CHANNEL_KEY_SET.length; )
            {
               if(allLowString.indexOf("/" + CHANNEL_KEY_SET[i]) == 0)
               {
                  isChangedChannel = true;
                  SoundManager.instance.play("008");
                  _inputField.text = allLowString.substring(2);
                  dispatchEvent(new ChatEvent("inputChannelChanged",CHANNEL_SET[i]));
               }
               i++;
            }
            if(!isChangedChannel)
            {
               list = ChatManager.Instance.model.customFastReply;
               for(i = 0; i < 5; )
               {
                  if(allLowString.indexOf("/" + (String(i + 1))) == 0 && (allLowString.length == 2 || allLowString.charAt(2) == " "))
                  {
                     isFastReply = true;
                     if(list.length > i)
                     {
                        _inputField.text = list[i];
                     }
                     else
                     {
                        _inputField.text = "";
                     }
                     break;
                  }
                  i++;
               }
            }
            if(result && !isChangedChannel && !isFastReply)
            {
               name = String(result[0]).replace(" ","");
               name = name.replace("/","");
               if(name == "")
               {
                  return;
               }
               _inputField.text = _inputField.text.replace(reg,"");
               dispatchEvent(new ChatEvent("customSetPrivateChatTo",{
                  "channel":2,
                  "nickName":name
               }));
               return;
            }
         }
         if(allLowString.substr(0,2) != "/" + CHANNEL_KEY_SET[2])
         {
            msgs = parasMsgs(_inputField.text);
            _inputField.text = "";
            if(msgs == "")
            {
               return;
            }
            dispatchEvent(new ChatEvent("inputTextChanged",msgs));
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
      
      public function setInputText(text:String) : void
      {
         if(text.indexOf("&lt;") > -1 || text.indexOf("&gt;") > -1)
         {
            _inputField.htmlText = text;
            _inputField.textColor = ChatFormats.CHAT_COLORS[_channel];
         }
         else
         {
            _inputField.text = text;
         }
         _inputField.setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
      }
      
      public function setPrivateChatName(name:String, useID:int = 0, info:Object = null) : void
      {
         var txt:* = null;
         setTextFocus();
         _privateChatName = name;
         _userID = useID;
         _privateChatInfo = info;
         if(_privateChatName != "")
         {
            txt = "";
            txt = _privateChatName;
            _nameTextField.htmlText = LanguageMgr.GetTranslation("tank.view.chat.ChatInput.usernameField.text",txt);
            if(_privateChatInfo && !(_privateChatInfo is FriendListPlayer))
            {
               _nameTextField.htmlText = LanguageMgr.GetTranslation("tank.view.chat.ChatInput.usernameField.textII",_privateChatInfo.areaName,txt);
            }
         }
         else
         {
            _nameTextField.text = "";
         }
         updatePosAndSize();
      }
      
      private function __onAddToStage(e:Event) : void
      {
         setTextFocus();
         removeEventListener("addedToStage",arguments.callee);
      }
      
      private function __onFieldKeyDown(event:KeyboardEvent) : void
      {
         if(isFocus())
         {
            event.stopImmediatePropagation();
            event.stopPropagation();
            if(event.keyCode == 38)
            {
               currentHistoryOffset = Number(currentHistoryOffset) - 1;
               if(getHistoryChat(currentHistoryOffset) != "")
               {
                  _inputField.htmlText = getHistoryChat(currentHistoryOffset);
                  _inputField.setTextFormat(ChatFormats.getTextFormatByChannel(_channel));
                  _inputField.addEventListener("enterFrame",__setSelectIndexSync);
               }
            }
            else if(event.keyCode == 40)
            {
               currentHistoryOffset = Number(currentHistoryOffset) + 1;
               _inputField.text = getHistoryChat(currentHistoryOffset);
            }
         }
         if(event.keyCode == 13 && !ChatManager.Instance.chatDisabled)
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
      
      private function __onInputFieldChange(e:Event) : void
      {
         if(_inputField.text)
         {
            _inputField.text = _inputField.text.replace("\n","").replace("\r","");
         }
      }
      
      private function __setSelectIndexSync(event:Event) : void
      {
         _inputField.removeEventListener("enterFrame",__setSelectIndexSync);
         _inputField.setSelection(_inputField.text.length,_inputField.text.length);
      }
      
      private function get currentHistoryOffset() : int
      {
         return _currentHistoryOffset;
      }
      
      private function set currentHistoryOffset(value:int) : void
      {
         if(value < 0)
         {
            value = 0;
         }
         if(value > ChatManager.Instance.model.resentChats.length - 1)
         {
            value = ChatManager.Instance.model.resentChats.length - 1;
         }
         _currentHistoryOffset = value;
      }
      
      private function getHistoryChat(chatOffset:int) : String
      {
         if(chatOffset == -1)
         {
            return "";
         }
         var str:String = Helpers.deCodeString(ChatManager.Instance.model.resentChats[chatOffset].msg);
         return str;
      }
      
      private function initView() : void
      {
         var startPos:Point = ComponentFactory.Instance.creatCustomObject("chat.InputFieldTextFieldStartPos");
         _nameTextField = new TextField();
         _nameTextField.type = "dynamic";
         _nameTextField.mouseEnabled = false;
         _nameTextField.selectable = false;
         _nameTextField.autoSize = "left";
         _nameTextField.x = startPos.x;
         _nameTextField.y = startPos.y;
         addChild(_nameTextField);
         _inputField = new TextField();
         _inputField.type = "input";
         _inputField.autoSize = "none";
         _inputField.multiline = false;
         _inputField.wordWrap = false;
         _inputField.maxChars = 100;
         _inputField.x = startPos.x;
         _inputField.y = startPos.y;
         _inputField.height = 20;
         addChild(_inputField);
         _inputField.addEventListener("change",__onInputFieldChange);
         setTextFormat(new TextFormat("Arial",12,65280));
         updatePosAndSize();
         StageReferance.stage.addEventListener("keyDown",__onFieldKeyDown,false,2147483647);
      }
      
      private function parasMsgs(fieldText:String) : String
      {
         var result:* = fieldText;
         result = StringHelper.trim(result);
         result = FilterWordManager.filterWrod(result);
         result = StringHelper.rePlaceHtmlTextField(result);
         return result;
      }
      
      private function setTextFocus() : void
      {
         StageReferance.stage.focus = _inputField;
         _inputField.setSelection(_inputField.text.length,_inputField.text.length);
      }
      
      private function setTextFormat(textFormat:TextFormat) : void
      {
         _nameTextField.defaultTextFormat = textFormat;
         _nameTextField.setTextFormat(textFormat);
         _inputField.defaultTextFormat = textFormat;
         _inputField.setTextFormat(textFormat);
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
