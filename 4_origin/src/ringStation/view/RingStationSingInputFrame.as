package ringStation.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.vo.AlertInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.view.chat.ChatBugleInputFrame;
   import ringStation.event.RingStationEvent;
   import road7th.utils.StringHelper;
   
   public class RingStationSingInputFrame extends ChatBugleInputFrame
   {
       
      
      public function RingStationSingInputFrame()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         var alertInfo:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ringstation.view.signFrameTitle"));
         alertInfo.moveEnable = false;
         alertInfo.submitLabel = LanguageMgr.GetTranslation("ringstation.view.signFrameTitle.ok.text");
         alertInfo.customPos = ComponentFactory.Instance.creatCustomObject("ringstation.view.ok.textPos");
         info = alertInfo;
         _inputTxt.maxChars = 25;
         _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
      }
      
      override protected function __onResponse(e:FrameEvent) : void
      {
         var str:* = null;
         var reg:* = null;
         var signEvent:* = null;
         switch(int(e.responseCode))
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
               str = FilterWordManager.filterWrod(_inputTxt.text);
               reg = /\r/gm;
               str = str.replace(reg,"");
               SocketManager.Instance.out.sendSignMsg(str);
               signEvent = new RingStationEvent("ringStation_sign",null,str);
               dispatchEvent(signEvent);
               _inputTxt.text = "";
               _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
               if(parent)
               {
                  parent.removeChild(this);
               }
               break;
         }
      }
   }
}
