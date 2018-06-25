package ddt.view.im
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.MinimizeFrame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.data.player.SelfInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import ddt.view.chat.ChatNamePanel;
   import ddt.view.common.LevelIcon;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import road7th.utils.StringHelper;
   import vip.VipController;
   
   public class PrivateChatFrame extends MinimizeFrame
   {
       
      
      private var _info:PlayerInfo;
      
      private var _outputBG:ScaleBitmapImage;
      
      private var _inputBG:ScaleBitmapImage;
      
      private var _output:TextArea;
      
      private var _input:TextArea;
      
      private var _send:TextButton;
      
      private var _record:SimpleBitmapButton;
      
      private var _recordFrame:PrivateRecordFrame;
      
      private var _show:Boolean = false;
      
      private var _selfPortrait:PlayerPortraitView;
      
      private var _selfLevelT:FilterFrameText;
      
      private var _selfLevel:LevelIcon;
      
      private var _selfName:FilterFrameText;
      
      private var _selfVipName:GradientText;
      
      private var _targetProtrait:PlayerPortraitView;
      
      private var _targetLevelT:FilterFrameText;
      
      private var _targetLevel:LevelIcon;
      
      private var _targetName:FilterFrameText;
      
      private var _targetVipName:GradientText;
      
      private var _warningBg:Bitmap;
      
      private var _warning:Bitmap;
      
      private var _warningWord:FilterFrameText;
      
      private var _nameTip:ChatNamePanel;
      
      public function PrivateChatFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("chat.frameTitle");
         _selfPortrait = ComponentFactory.Instance.creatCustomObject("chatFrame.selfPortrait",["right",PlayerManager.Instance.Self.IsShow]);
         _selfLevelT = ComponentFactory.Instance.creatComponentByStylename("chatFrame.selflevel");
         _selfLevel = ComponentFactory.Instance.creatCustomObject("chatFrame.selfLevelIcon");
         _targetProtrait = ComponentFactory.Instance.creatCustomObject("chatFrame.targetPortrait",["right",true]);
         _targetLevelT = ComponentFactory.Instance.creatComponentByStylename("chatFrame.targetlevel");
         _targetLevel = ComponentFactory.Instance.creatCustomObject("chatFrame.targetLevelIcon");
         _outputBG = ComponentFactory.Instance.creatComponentByStylename("chatFrame.outputBG");
         _inputBG = ComponentFactory.Instance.creatComponentByStylename("chatFrame.inputBG");
         _output = ComponentFactory.Instance.creatComponentByStylename("chatFrame.output");
         _input = ComponentFactory.Instance.creatComponentByStylename("chatFrame.input");
         _send = ComponentFactory.Instance.creatComponentByStylename("chatFrame.send");
         _send.text = LanguageMgr.GetTranslation("im.InviteDialogFrame.send");
         _record = ComponentFactory.Instance.creatComponentByStylename("chatFrame.record");
         _warningBg = ComponentFactory.Instance.creatBitmap("asset.chatFrame.worningbg");
         _warning = ComponentFactory.Instance.creatBitmap("asset.chatFrame.worning");
         _warningWord = ComponentFactory.Instance.creatComponentByStylename("chatFrame.warningword");
         addToContent(_selfPortrait);
         addToContent(_selfLevelT);
         addToContent(_selfLevel);
         addToContent(_targetProtrait);
         addToContent(_targetLevelT);
         addToContent(_targetLevel);
         addToContent(_outputBG);
         addToContent(_inputBG);
         addToContent(_output);
         addToContent(_input);
         addToContent(_send);
         addToContent(_record);
         addToContent(_warningBg);
         addToContent(_warningWord);
         addToContent(_warning);
         _targetProtrait.mouseEnabled = true;
         _input.textField.maxChars = 150;
         _send.tipStyle = "ddt.view.tips.OneLineTip";
         _send.tipDirctions = "0";
         _send.tipGapV = 5;
         _send.tipData = LanguageMgr.GetTranslation("IM.privateChatFrame.send.tipdata");
         var self:SelfInfo = PlayerManager.Instance.Self;
         _selfPortrait.info = self;
         _selfLevelT.text = LanguageMgr.GetTranslation("IM.ChatFrame.level");
         _selfLevel.setSize(1);
         _selfLevel.setInfo(self.Grade,self.ddtKingGrade,self.Repute,self.WinCount,self.TotalCount,self.FightPower,self.Offer,false,true);
         _selfLevel.mouseChildren = false;
         _selfLevel.mouseEnabled = false;
         _selfName = ComponentFactory.Instance.creatComponentByStylename("chatFrame.selfName");
         if(self.IsVIP)
         {
            _selfVipName = VipController.instance.getVipNameTxt(84,self.typeVIP);
            _selfVipName.textSize = 14;
            _selfVipName.x = _selfName.x;
            _selfVipName.y = _selfName.y;
            _selfVipName.text = self.NickName;
            addToContent(_selfVipName);
         }
         else
         {
            _selfName.text = self.NickName;
            addToContent(_selfName);
         }
         _targetLevelT.text = LanguageMgr.GetTranslation("IM.ChatFrame.level");
         _targetLevel.setSize(1);
         _targetLevel.mouseChildren = false;
         _targetLevel.mouseEnabled = false;
         _warningWord.text = LanguageMgr.GetTranslation("IM.ChatFrame.warning");
      }
      
      public function set playerInfo(info:PlayerInfo) : void
      {
         if(_info != info)
         {
            _input.text = "";
            _output.htmlText = "";
            closeRecordFrame();
         }
         _info = info;
         _targetProtrait.onHeadSelectChange(_info.IsShow);
         _targetProtrait.info = _info;
         _targetLevel.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,false,true);
         if(_targetName == null)
         {
            _targetName = ComponentFactory.Instance.creatComponentByStylename("chatFrame.targetName");
         }
         if(_info.IsVIP)
         {
            if(_targetVipName == null)
            {
               _targetVipName = VipController.instance.getVipNameTxt(84,_info.typeVIP);
               _targetVipName.textSize = 14;
               _targetVipName.x = _targetName.x;
               _targetVipName.y = _targetName.y;
               addToContent(_targetVipName);
            }
            if(_targetName)
            {
               _targetName.visible = false;
            }
            _targetVipName.visible = true;
            _targetVipName.text = _info.NickName;
         }
         else
         {
            addToContent(_targetName);
            if(_targetVipName)
            {
               _targetVipName.visible = false;
            }
            _targetName.visible = true;
            _targetName.text = _info.NickName;
         }
      }
      
      public function clearOutput() : void
      {
         _output.htmlText = "";
      }
      
      public function addMessage(msg:String) : void
      {
         _output.htmlText = _output.htmlText + (msg + "<br/>");
         _output.textField.setSelection(_output.text.length - 1,_output.text.length - 1);
         _output.upScrollArea();
      }
      
      public function addAllMessage(messages:Vector.<String>) : void
      {
         var i:int = 0;
         _output.htmlText = "";
         for(i = 0; i < messages.length; )
         {
            _output.htmlText = _output.htmlText + (messages[i] + "<br/>");
            i++;
         }
         _output.textField.setSelection(_output.text.length - 1,_output.text.length - 1);
         _output.upScrollArea();
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _info;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         _send.addEventListener("click",__sendHandler);
         _record.addEventListener("click",__recordHandler);
         _input.addEventListener("keyUp",__keyUpHandler);
         _input.addEventListener("keyDown",__keyDownHandler);
         _input.addEventListener("focusIn",__focusInHandler);
         _input.addEventListener("focusOut",__focusOutHandler);
         _targetProtrait.addEventListener("click",__targetProtraitClick);
         addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _send.removeEventListener("click",__sendHandler);
         _record.removeEventListener("click",__recordHandler);
         _input.removeEventListener("keyUp",__keyUpHandler);
         _input.removeEventListener("keyDown",__keyDownHandler);
         _input.removeEventListener("focusIn",__focusInHandler);
         _input.removeEventListener("focusOut",__focusOutHandler);
         _targetProtrait.removeEventListener("click",__targetProtraitClick);
         removeEventListener("addedToStage",__addToStageHandler);
      }
      
      protected function __targetProtraitClick(event:MouseEvent) : void
      {
         if(!_nameTip)
         {
            _nameTip = new ChatNamePanel();
         }
         _nameTip.x = event.stageX;
         _nameTip.y = event.stageY;
         _nameTip.playerName = _info.NickName;
         _nameTip.setVisible = true;
      }
      
      private function __keyDownHandler(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
      }
      
      protected function __addToStageHandler(event:Event) : void
      {
         _input.textField.setFocus();
      }
      
      protected function __focusOutHandler(event:FocusEvent) : void
      {
         IMManager.Instance.privateChatFocus = false;
      }
      
      protected function __focusInHandler(event:FocusEvent) : void
      {
         IMManager.Instance.privateChatFocus = true;
      }
      
      protected function __keyUpHandler(event:KeyboardEvent) : void
      {
         event.stopImmediatePropagation();
         event.stopPropagation();
         if(event.keyCode == 13)
         {
            __sendHandler(null);
         }
      }
      
      protected function __recordHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_recordFrame == null)
         {
            _recordFrame = ComponentFactory.Instance.creatComponentByStylename("privateRecordFrame");
            _recordFrame.addEventListener("response",__recordResponseHandler);
            _recordFrame.addEventListener("close",__recordCloseHandler);
            PositionUtils.setPos(_recordFrame,"recordFrame.pos");
         }
         if(!_show)
         {
            addToContent(_recordFrame);
            _recordFrame.playerId = _info.ID;
            _show = true;
         }
         else
         {
            closeRecordFrame();
         }
      }
      
      private function closeRecordFrame() : void
      {
         if(_recordFrame && _recordFrame.parent)
         {
            _recordFrame.parent.removeChild(_recordFrame);
         }
         _show = false;
      }
      
      protected function __recordCloseHandler(event:Event) : void
      {
         SoundManager.instance.play("008");
         _recordFrame.parent.removeChild(_recordFrame);
         _show = false;
      }
      
      protected function __recordResponseHandler(event:FrameEvent) : void
      {
         if(event.responseCode == 0)
         {
            SoundManager.instance.play("008");
            _recordFrame.parent.removeChild(_recordFrame);
            _show = false;
         }
      }
      
      protected function __sendHandler(event:MouseEvent) : void
      {
         var str:* = null;
         SoundManager.instance.play("008");
         if(_info.Grade < 5)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.other.noEnough.five"));
            return;
         }
         if(StringHelper.trim(_input.text) != "")
         {
            str = _input.text.replace(/</g,"&lt;").replace(/>/g,"&gt;");
            str = FilterWordManager.filterWrod(str);
            SocketManager.Instance.out.sendOneOnOneTalk(_info.ID,str);
            _input.text = "";
         }
         else
         {
            _input.text = "";
         }
         __addToStageHandler(null);
      }
      
      private function checkHtmlTag(str:String) : Boolean
      {
         if(str.indexOf("<") != -1 || FilterWordManager.isGotForbiddenWords(str))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IM.privateChatFrame.failWord"));
            return false;
         }
         return true;
      }
      
      protected function __responseHandler(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               IMManager.Instance.disposePrivateFrame(_info.ID);
               _output.htmlText = "";
               break;
            default:
               IMManager.Instance.disposePrivateFrame(_info.ID);
               _output.htmlText = "";
               break;
            default:
               IMManager.Instance.disposePrivateFrame(_info.ID);
               _output.htmlText = "";
               break;
            default:
               IMManager.Instance.disposePrivateFrame(_info.ID);
               _output.htmlText = "";
               break;
            case 5:
               IMManager.Instance.hidePrivateFrame(_info.ID);
         }
      }
      
      override public function dispose() : void
      {
         IMManager.Instance.privateChatFocus = false;
         removeEvent();
         super.dispose();
         if(_recordFrame)
         {
            _recordFrame.removeEventListener("response",__recordResponseHandler);
            _recordFrame.removeEventListener("close",__recordCloseHandler);
            _recordFrame.dispose();
            _recordFrame = null;
         }
         _info = null;
         if(_outputBG)
         {
            ObjectUtils.disposeObject(_outputBG);
         }
         _outputBG = null;
         if(_inputBG)
         {
            ObjectUtils.disposeObject(_inputBG);
         }
         _inputBG = null;
         if(_output)
         {
            ObjectUtils.disposeObject(_output);
         }
         _output = null;
         if(_input)
         {
            ObjectUtils.disposeObject(_input);
         }
         _input = null;
         if(_send)
         {
            ObjectUtils.disposeObject(_send);
         }
         _send = null;
         if(_record)
         {
            ObjectUtils.disposeObject(_record);
         }
         _record = null;
         if(_selfPortrait)
         {
            ObjectUtils.disposeObject(_selfPortrait);
         }
         _selfPortrait = null;
         if(_selfLevelT)
         {
            ObjectUtils.disposeObject(_selfLevelT);
         }
         _selfLevelT = null;
         if(_selfLevel)
         {
            ObjectUtils.disposeObject(_selfLevel);
         }
         _selfLevel = null;
         if(_selfName)
         {
            ObjectUtils.disposeObject(_selfName);
         }
         _selfName = null;
         if(_selfVipName)
         {
            ObjectUtils.disposeObject(_selfVipName);
         }
         _selfVipName = null;
         if(_targetProtrait)
         {
            ObjectUtils.disposeObject(_targetProtrait);
         }
         _targetProtrait = null;
         if(_targetLevelT)
         {
            ObjectUtils.disposeObject(_targetLevelT);
         }
         _targetLevelT = null;
         if(_targetLevel)
         {
            ObjectUtils.disposeObject(_targetLevel);
         }
         _targetLevel = null;
         if(_targetName)
         {
            ObjectUtils.disposeObject(_targetName);
         }
         _targetName = null;
         if(_targetVipName)
         {
            ObjectUtils.disposeObject(_targetVipName);
         }
         _targetVipName = null;
         if(_warningBg)
         {
            ObjectUtils.disposeObject(_warningBg);
         }
         _warningBg = null;
         if(_warning)
         {
            ObjectUtils.disposeObject(_warning);
         }
         _warning = null;
         if(_warningWord)
         {
            ObjectUtils.disposeObject(_warningWord);
         }
         _warningWord = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
