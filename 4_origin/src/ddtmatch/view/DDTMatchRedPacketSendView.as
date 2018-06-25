package ddtmatch.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.NumberSelecter;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   
   public class DDTMatchRedPacketSendView extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _btn:SimpleBitmapButton;
      
      private var select:NumberSelecter;
      
      private var _sendMoneyTxt:FilterFrameText;
      
      private var _messageTxt:FilterFrameText;
      
      public function DDTMatchRedPacketSendView()
      {
         super();
         addEvent();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.sendPacketBg");
         addToContent(_bg);
         _btn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.redPacket.moneyInPacket");
         addToContent(_btn);
         select = new NumberSelecter();
         addToContent(select);
         PositionUtils.setPos(select,"ddtmatch.redPacket.selectPos");
         _sendMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.sendMoneyTxt");
         addToContent(_sendMoneyTxt);
         _sendMoneyTxt.maxChars = 8;
         _sendMoneyTxt.restrict = "0-9";
         _sendMoneyTxt.text = "1";
         _messageTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.messageTxt");
         addToContent(_messageTxt);
         _messageTxt.maxChars = 20;
         _messageTxt.text = LanguageMgr.GetTranslation("ddt.DDTmatch.redpacket.defaultMsg");
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(e:MouseEvent) : void
      {
         var money:int = parseInt(_sendMoneyTxt.text);
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_messageTxt.text == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.messageBlank"));
            return;
         }
         if(PlayerManager.Instance.Self.Money < money)
         {
            LeavePageManager.showFillFrame();
            return;
         }
         if(select.number > money)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.moneyCountError"));
            return;
         }
         SocketManager.Instance.out.getRedPacketpublish(_messageTxt.text,money,select.number);
         onResponse(1);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(select);
         select = null;
         ObjectUtils.disposeObject(_sendMoneyTxt);
         _sendMoneyTxt = null;
         ObjectUtils.disposeObject(_messageTxt);
         _messageTxt = null;
         super.dispose();
      }
   }
}
