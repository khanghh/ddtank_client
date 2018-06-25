package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddtmatch.data.RedPacketInfo;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import road7th.comm.PackageIn;
   
   public class DDTMatchRedPacketRecord extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _playerTxt:FilterFrameText;
      
      private var _messageTxt:FilterFrameText;
      
      private var _moneyNumberTxt:FilterFrameText;
      
      private var _recordTxt:FilterFrameText;
      
      private var _info:RedPacketInfo;
      
      private var _listPanel:ScrollPanel;
      
      public function DDTMatchRedPacketRecord()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacket.recordBg");
         addToContent(_bg);
         _playerTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.info.playerTxt");
         addToContent(_playerTxt);
         _messageTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.info.messageTxt");
         addToContent(_messageTxt);
         _moneyNumberTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.info.moneyNumberTxt");
         addToContent(_moneyNumberTxt);
         _recordTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redPacket.info.recordTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.info.scrollPanel");
         _listPanel.setView(_recordTxt);
         _listPanel.invalidateViewport();
         addToContent(_listPanel);
         DDTMatchManager.instance.addEventListener("redpacketRecord",__updataList);
      }
      
      private function __updataList(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var name:* = null;
         var num:int = 0;
         var date:* = null;
         var dateStr:* = null;
         var pkg:PackageIn = e.pkg;
         pkg.readBoolean();
         var redPacketListCount:int = pkg.readInt();
         _recordTxt.text = "";
         for(i = 0; i < redPacketListCount; )
         {
            info = new RedPacketInfo();
            name = pkg.readUTF();
            num = pkg.readInt();
            date = pkg.readDate();
            dateStr = date.fullYear.toString() + "-" + (date.month + 1).toString() + "-" + date.date.toString() + " " + date.hours.toString() + ":" + date.minutes.toString();
            _recordTxt.text = _recordTxt.text + (LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.record.info",name,num,dateStr) + "\n");
            i++;
         }
      }
      
      public function setInfo(info:RedPacketInfo) : void
      {
         _info = info;
         _playerTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.record.name",_info.nickName);
         _messageTxt.text = _info.name;
         _moneyNumberTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.record.money",_info.totalMoney);
         SocketManager.Instance.out.getRedPacketRecord(_info.id);
      }
      
      override public function dispose() : void
      {
         DDTMatchManager.instance.removeEventListener("redpacketRecord",__updataList);
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_playerTxt);
         _playerTxt = null;
         ObjectUtils.disposeObject(_messageTxt);
         _messageTxt = null;
         ObjectUtils.disposeObject(_moneyNumberTxt);
         _moneyNumberTxt = null;
         ObjectUtils.disposeObject(_recordTxt);
         _recordTxt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         super.dispose();
      }
   }
}
