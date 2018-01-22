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
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.redPacketBg");
         addChild(_bg);
         _sendTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.redpacket.sendTimeTxt");
         addChild(_sendTimeTxt);
         var _loc1_:String = "";
         var _loc2_:Array = ServerConfigManager.instance.getSysRedEnvelopePublishInfo().split("|");
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = _loc1_ + _loc2_[_loc3_].split(",")[0] + ":00 ";
            _loc3_++;
         }
         _sendTimeTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.redpacket.systemPacket.sendTime",_loc1_);
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
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.getRedPacketInfo();
      }
      
      private function __updataList(param1:CrazyTankSocketEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         allList = new Vector.<RedPacketInfo>();
         playerList = new Vector.<RedPacketInfo>();
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = new RedPacketInfo();
            _loc4_.id = _loc3_.readInt();
            _loc4_.name = _loc3_.readUTF();
            _loc4_.type = _loc3_.readByte();
            _loc4_.userID = _loc3_.readInt();
            _loc4_.nickName = _loc3_.readUTF();
            _loc4_.totalMoney = _loc3_.readInt();
            _loc4_.giftCount = _loc3_.readInt();
            _loc4_.holdCount = _loc3_.readInt();
            _loc4_.status = _loc3_.readByte();
            _loc4_.ifGet = _loc3_.readBoolean();
            if(_loc4_.type == 0)
            {
               allList.push(_loc4_);
            }
            else if(_loc4_.type == 1)
            {
               playerList.push(_loc4_);
            }
            _loc5_++;
         }
         updataRedPacketList();
      }
      
      private function updataRedPacketList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         _allRedPacketVec = new Vector.<DDTMatchRedPacketItem>();
         _vBoxAll.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ < allList.length)
         {
            _loc2_ = new DDTMatchRedPacketItem(1,_loc4_);
            _vBoxAll.addChild(_loc2_);
            _loc2_.info = allList[_loc4_];
            _allRedPacketVec.push(_loc2_);
            _loc4_++;
         }
         _listAllPanel.setView(_vBoxAll);
         _listAllPanel.invalidateViewport();
         _playerRedPacketVec = new Vector.<DDTMatchRedPacketItem>();
         _vBoxPlayer.removeAllChild();
         _loc3_ = 0;
         while(_loc3_ < playerList.length)
         {
            _loc1_ = new DDTMatchRedPacketItem(2,_loc3_);
            _vBoxPlayer.addChild(_loc1_);
            _loc1_.info = playerList[_loc3_];
            _playerRedPacketVec.push(_loc1_);
            _loc3_++;
         }
         _listPlayerPanel.setView(_vBoxPlayer);
         _listPlayerPanel.invalidateViewport();
      }
      
      private function __sendPacketBtnHandler(param1:MouseEvent) : void
      {
         sendView = ComponentFactory.Instance.creatComponentByStylename("redPacketSendViewFrame");
         sendView.addEventListener("response",__respose);
         LayerManager.Instance.addToLayer(sendView,3,true,2);
      }
      
      private function __respose(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
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
