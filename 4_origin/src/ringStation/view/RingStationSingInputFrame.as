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
         var _loc1_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("ringstation.view.signFrameTitle"));
         _loc1_.moveEnable = false;
         _loc1_.submitLabel = LanguageMgr.GetTranslation("ringstation.view.signFrameTitle.ok.text");
         _loc1_.customPos = ComponentFactory.Instance.creatCustomObject("ringstation.view.ok.textPos");
         info = _loc1_;
         _inputTxt.maxChars = 25;
         _remainTxt.text = _remainStr + _inputTxt.maxChars.toString();
      }
      
      override protected function __onResponse(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
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
               SocketManager.Instance.out.sendSignMsg(_loc2_);
               _loc4_ = new RingStationEvent("ringStation_sign",null,_loc2_);
               dispatchEvent(_loc4_);
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
