package ddtmatch.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddtmatch.data.RedPacketInfo;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   
   public class DDTMatchRedPacketView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _sendTimeTxt:FilterFrameText;
      
      private var _sendPacketBtn:SimpleBitmapButton;
      
      private var _listAllPanel:ScrollPanel;
      
      private var _listPlayerPanel:ScrollPanel;
      
      private var _vBoxAll:VBox;
      
      private var _vBoxPlayer:VBox;
      
      private var _allRedPacketVec:Vector.<DDTMatchRedPacketItem>;
      
      private var _playerRedPacketVec:Vector.<DDTMatchRedPacketItem>;
      
      private var _timer:Timer;
      
      private var allList:Vector.<RedPacketInfo>;
      
      private var playerList:Vector.<RedPacketInfo>;
      
      private var sendView:DDTMatchRedPacketSendView;
      
      public function DDTMatchRedPacketView()
      {
         _timer = new Timer(10000);
         super();
         initView();
         addEvent();
         SocketManager.Instance.out.getRedPacketInfo();
         _timer.start();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacketBg");
         addChild(_bg);
         _sendTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.sendTimeTxt");
         addChild(_sendTimeTxt);
         var str:String = "";
         var arr:Array = ServerConfigManager.instance.getSysRedEnvelopePublishInfo().split("|");
         for(i = 0; i < arr.length; )
         {
            str = str + arr[i].split(",")[0] + ":00 ";
            i++;
         }
         _sendTimeTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.systemPacket.sendTime",str);
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.activityTimeTxt");
         addChild(_activityTimeTxt);
         _activityTimeTxt.text = ServerConfigManager.instance.getRedEnvelopeBeginTime() + "--" + ServerConfigManager.instance.getRedEnvelopeEndTime();
         _sendPacketBtn = ComponentFactory.Instance.creatComponentByStylename("asset.ddtmatch.redPacket.sendPacketBtn");
         addChild(_sendPacketBtn);
         _vBoxAll = new VBox();
         _vBoxAll.spacing = 0;
         _listAllPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.allScrollPanel");
         _listAllPanel.setView(_vBoxAll);
         addChild(_listAllPanel);
         _vBoxPlayer = new VBox();
         _vBoxPlayer.spacing = 2;
         _listPlayerPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.playerScrollPanel");
         _listPlayerPanel.setView(_vBoxPlayer);
         addChild(_listPlayerPanel);
      }
      
      private function addEvent() : void
      {
         _timer.addEventListener("timer",__timerHandler);
         _sendPacketBtn.addEventListener("click",__sendPacketBtnHandler);
         DDTMatchManager.instance.addEventListener("updataRedPacketList",__updataList);
      }
      
      private function __timerHandler(e:TimerEvent) : void
      {
         SocketManager.Instance.out.getRedPacketInfo();
      }
      
      private function __updataList(e:CrazyTankSocketEvent) : void
      {
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = e.pkg;
         var redPacketListCount:int = pkg.readInt();
         allList = new Vector.<RedPacketInfo>();
         playerList = new Vector.<RedPacketInfo>();
         for(i = 0; i < redPacketListCount; )
         {
            info = new RedPacketInfo();
            info.id = pkg.readInt();
            info.name = pkg.readUTF();
            info.type = pkg.readByte();
            info.userID = pkg.readInt();
            info.nickName = pkg.readUTF();
            info.totalMoney = pkg.readInt();
            info.giftCount = pkg.readInt();
            info.holdCount = pkg.readInt();
            info.status = pkg.readByte();
            info.ifGet = pkg.readBoolean();
            if(info.type == 0)
            {
               allList.push(info);
            }
            else if(info.type == 1)
            {
               playerList.push(info);
            }
            i++;
         }
         updataRedPacketList();
      }
      
      private function updataRedPacketList() : void
      {
         var i:int = 0;
         var item:* = null;
         var j:int = 0;
         var item1:* = null;
         _allRedPacketVec = new Vector.<DDTMatchRedPacketItem>();
         _vBoxAll.removeAllChild();
         for(i = 0; i < allList.length; )
         {
            item = new DDTMatchRedPacketItem(1,i);
            _vBoxAll.addChild(item);
            item.info = allList[i];
            _allRedPacketVec.push(item);
            i++;
         }
         _listAllPanel.setView(_vBoxAll);
         _listAllPanel.invalidateViewport();
         _playerRedPacketVec = new Vector.<DDTMatchRedPacketItem>();
         _vBoxPlayer.removeAllChild();
         for(j = 0; j < playerList.length; )
         {
            item1 = new DDTMatchRedPacketItem(2,j);
            _vBoxPlayer.addChild(item1);
            item1.info = playerList[j];
            _playerRedPacketVec.push(item1);
            j++;
         }
         _listPlayerPanel.setView(_vBoxPlayer);
         _listPlayerPanel.invalidateViewport();
      }
      
      private function __sendPacketBtnHandler(e:MouseEvent) : void
      {
         sendView = ComponentFactory.Instance.creatComponentByStylename("redPacketSendViewFrame");
         sendView.addEventListener("response",__respose);
         LayerManager.Instance.addToLayer(sendView,3,true,2);
      }
      
      private function __respose(e:FrameEvent) : void
      {
         if(e.responseCode == 0 || e.responseCode == 1)
         {
            sendView.parent.removeChild(sendView);
         }
      }
      
      private function removeEvent() : void
      {
         _timer.removeEventListener("timer",__timerHandler);
         _sendPacketBtn.removeEventListener("click",__sendPacketBtnHandler);
         DDTMatchManager.instance.removeEventListener("updataRedPacketList",__updataList);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _timer.stop();
         _timer = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sendTimeTxt);
         _sendTimeTxt = null;
         ObjectUtils.disposeObject(_activityTimeTxt);
         _activityTimeTxt = null;
         ObjectUtils.disposeObject(_sendPacketBtn);
         _sendPacketBtn = null;
         ObjectUtils.disposeObject(_listAllPanel);
         _listAllPanel = null;
         ObjectUtils.disposeObject(_listPlayerPanel);
         _listPlayerPanel = null;
         ObjectUtils.disposeObject(_vBoxAll);
         _vBoxAll = null;
         ObjectUtils.disposeObject(_vBoxPlayer);
         _vBoxPlayer = null;
         ObjectUtils.disposeObject(sendView);
         sendView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
