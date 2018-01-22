package ddt.view.chat
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import flash.events.Event;
   import flash.utils.setTimeout;
   import road7th.utils.StringHelper;
   
   public class ChatBugleInputFrame extends BaseAlerFrame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _textBg:Scale9CornerImage;
      
      private var _textTitle:FilterFrameText;
      
      protected var _remainTxt:FilterFrameText;
      
      protected var _inputTxt:FilterFrameText;
      
      protected var _remainStr:String;
      
      public var templateID:int;
      
      public function ChatBugleInputFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("chat.BugleInputFrameTitleString"));
         _loc1_.moveEnable = false;
         _loc1_.submitLabel = LanguageMgr.GetTranslation("chat.BugleInputFrame.ok.text");
         _loc1_.customPos = ComponentFactory.Instance.creatCustomObject("chat.BugleInputFrame.ok.textPos");
         info = _loc1_;
         _bg = ComponentFactory.Instance.creatComponentByStylename("chat.BugleInputFrameBg");
         _textBg = ComponentFactory.Instance.creatComponentByStylename("chat.BugleInputFrameTextBg");
         _textTitle = ComponentFactory.Instance.creatComponentByStylename("chat.BugleInputTitleBitmap.text");
         _textTitle.text = LanguageMgr.GetTranslation("chat.BugleInputFrameBg.text");
         _remainTxt = ComponentFactory.Instance.creatComponentByStylename("chat.BugleInputFrameRemainText");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("chat.BugleInputFrameInputText");
         _remainStr = LanguageMgr.GetTranslation("chat.BugleInputFrameRemainString");
         _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
         addToContent(_bg);
         addToContent(_textBg);
         addToContent(_textTitle);
         addToContent(_remainTxt);
         addToContent(_inputTxt);
         addEventListener("addedToStage",__setFocus);
      }
      
      private function initEvents() : void
      {
         _submitButton.addEventListener("click",__onSubmitClick);
         _inputTxt.addEventListener("change",__upDateRemainTxt);
         addEventListener("response",__onResponse);
      }
      
      private function __setFocus(param1:Event) : void
      {
         setTimeout(_inputTxt.setFocus,100);
         initEvents();
      }
      
      protected function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               _inputTxt.text = "";
               _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
               if(parent)
               {
                  parent.removeChild(this);
                  break;
               }
               break;
            default:
               SoundManager.instance.play("008");
               _inputTxt.text = "";
               _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
               if(parent)
               {
                  parent.removeChild(this);
                  break;
               }
               break;
            case 3:
               SoundManager.instance.play("008");
               if(StringHelper.trim(_inputTxt.text).length <= 0)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("chat.BugleInputNull"));
                  return;
               }
               _loc2_ = FilterWordManager.filterWrod(_inputTxt.text);
               _loc3_ = /\r/gm;
               _loc2_ = _loc2_.replace(_loc3_,"");
               SocketManager.Instance.out.sendBBugle(_loc2_,templateID);
               _inputTxt.text = "";
               _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
               if(parent)
               {
                  parent.removeChild(this);
               }
               break;
         }
      }
      
      private function __upDateRemainTxt(param1:Event) : void
      {
         _remainTxt.text = _remainStr + (String(_inputTxt.maxChars - _inputTxt.text.length));
      }
      
      override public function dispose() : void
      {
         removeEventListener("addedToStage",__setFocus);
         _submitButton.removeEventListener("click",__onSubmitClick);
         _inputTxt.removeEventListener("change",__upDateRemainTxt);
         removeEventListener("response",__onResponse);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_textBg)
         {
            ObjectUtils.disposeObject(_textBg);
         }
         _textBg = null;
         if(_textTitle)
         {
            ObjectUtils.disposeObject(_textTitle);
         }
         _textTitle = null;
         if(_remainTxt)
         {
            ObjectUtils.disposeObject(_remainTxt);
         }
         _remainTxt = null;
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
         }
         _inputTxt = null;
         super.dispose();
      }
   }
}
