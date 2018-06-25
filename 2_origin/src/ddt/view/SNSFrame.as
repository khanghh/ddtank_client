package ddt.view
{
   import academy.AcademyManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SharedManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.net.URLVariables;
   
   public class SNSFrame extends BaseAlerFrame
   {
       
      
      private var _inputBG:Bitmap;
      
      private var _SNSFrameBg1:Scale9CornerImage;
      
      private var _shareBtn:TextButton;
      
      private var _visibleBtn:SelectedCheckButton;
      
      private var _text:FilterFrameText;
      
      private var _textinput:FilterFrameText;
      
      private var _alertInfo:AlertInfo;
      
      private var _textInputBgPoint:Point;
      
      private var _inputText:TextArea;
      
      public var typeId:int;
      
      public var backgroundServerTxt:String;
      
      public function SNSFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         submitButtonStyle = "core.simplebt";
         _alertInfo = new AlertInfo(LanguageMgr.GetTranslation("ddt.view.SnsFrame.titleText"),LanguageMgr.GetTranslation("ddt.view.SnsFrame.shareBtnText"),LanguageMgr.GetTranslation("cancel"),true,true);
         _alertInfo.moveEnable = false;
         info = _alertInfo;
         this.escEnable = true;
         this.titleText = LanguageMgr.GetTranslation("ddt.view.SnsFrame.titleText");
         _inputText = ComponentFactory.Instance.creatComponentByStylename("Microcobol.inputText");
         addToContent(_inputText);
         _inputBG = ComponentFactory.Instance.creatBitmap("ddt.view.SNSFrameBg");
         addToContent(_inputBG);
         _textInputBgPoint = ComponentFactory.Instance.creatCustomObject("core.SNSFramePoint");
         _inputText.x = _textInputBgPoint.x;
         _inputText.y = _textInputBgPoint.y;
         if(_inputText)
         {
            StageReferance.stage.focus = _inputText.textField;
         }
         _text = ComponentFactory.Instance.creat("core.SNSFrameViewText");
         this.addToContent(_text);
         _visibleBtn = ComponentFactory.Instance.creatComponentByStylename("core.SNSFrameCheckBox");
         _visibleBtn.text = LanguageMgr.GetTranslation("ddt.view.SnsFrame.visibleBtnText");
         _visibleBtn.selected = SharedManager.Instance.autoSnsSend;
         this.addToContent(_visibleBtn);
      }
      
      private function _getStr() : String
      {
         var str:String = "";
         switch(int(typeId) - 1)
         {
            case 0:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextI");
               break;
            case 1:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextII");
               break;
            case 2:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextIII");
               break;
            case 3:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextIV");
               break;
            case 4:
            case 5:
            case 6:
            case 7:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextV");
               break;
            case 8:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextVI");
               break;
            case 9:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextVII");
               break;
            case 10:
               str = LanguageMgr.GetTranslation("ddt.view.SnsFrame.inputTextVIII");
         }
         return str;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameEventHandler);
         _inputText.addEventListener("click",_clickInputText);
         _visibleBtn.addEventListener("click",__visibleBtnClick);
         StageReferance.stage.addEventListener("click",_clickStage);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameEventHandler);
         _inputText.removeEventListener("click",_clickInputText);
         if(_visibleBtn)
         {
            _visibleBtn.removeEventListener("click",__visibleBtnClick);
         }
         StageReferance.stage.removeEventListener("click",_clickStage);
      }
      
      private function _clickInputText(e:MouseEvent) : void
      {
         _inputText.removeEventListener("click",_clickInputText);
         _inputText.text = "";
      }
      
      private function _clickStage(e:MouseEvent) : void
      {
         if(_inputText.text == "" && StageReferance.stage.focus != _inputText.textField)
         {
            _inputText.text = _getStr();
         }
      }
      
      protected function __shareBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         sendDynamic();
      }
      
      protected function __visibleBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SharedManager.Instance.autoSnsSend = _visibleBtn.selected;
      }
      
      private function __frameEventHandler(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(evt.responseCode))
         {
            case 0:
            case 1:
               dispose();
               dispatchEvent(new Event("close"));
               break;
            case 2:
            case 3:
            case 4:
               sendDynamic();
               dispatchEvent(new Event("submit"));
         }
      }
      
      public function set receptionistTxt($txt:String) : void
      {
         if(_text.text == $txt)
         {
            return;
         }
         _text.text = $txt;
      }
      
      public function show() : void
      {
         if(SharedManager.Instance.allowSnsSend || !PathManager.CommunityExist())
         {
            dispose();
            return;
         }
         if(AcademyManager.Instance.isFighting())
         {
            return;
         }
         if(SharedManager.Instance.autoSnsSend)
         {
            sendDynamic();
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,2);
         }
         if(_inputText)
         {
            _inputText.text = _getStr();
         }
      }
      
      private function sendDynamic() : void
      {
         var uv:URLVariables = new URLVariables();
         uv.typeId = typeId;
         uv.playerTest = _getStr();
         var _loc3_:* = uv.typeId;
         if(6 !== _loc3_)
         {
            if(7 !== _loc3_)
            {
               if(8 !== _loc3_)
               {
                  if(9 !== _loc3_)
                  {
                     if(10 !== _loc3_)
                     {
                        if(11 !== _loc3_)
                        {
                        }
                     }
                     addr35:
                     uv.typeId = uv.typeId - 3;
                  }
                  §§goto(addr35);
               }
               addr68:
               uv.serverId = ServerManager.Instance.AgentID;
               uv.fuid = PlayerManager.Instance.Account.Account;
               uv.inviteCaption = backgroundServerTxt;
               if(_inputText)
               {
                  uv.playerTest = _inputText.text;
               }
               uv.ran = Math.random();
               SocketManager.Instance.out.sendSnsMsg(typeId);
               var load:BaseLoader = LoadResourceManager.Instance.createLoader(PathManager.getSnsPath(),6,uv);
               LoadResourceManager.Instance.startLoad(load);
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("socialContact.microcobol.succeed"));
               dispose();
               return;
            }
            addr27:
            uv.typeId = 4;
            §§goto(addr68);
         }
         §§goto(addr27);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_text);
         _text = null;
         _inputText = null;
         ObjectUtils.disposeObject(_textinput);
         _textinput = null;
         ObjectUtils.disposeObject(_shareBtn);
         _shareBtn = null;
         ObjectUtils.disposeObject(_visibleBtn);
         _visibleBtn = null;
         ObjectUtils.disposeObject(_inputBG);
         _inputBG = null;
         ObjectUtils.disposeObject(_SNSFrameBg1);
         _SNSFrameBg1 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
