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
      
      public function DDTMatchRedPacketView(){super();}
      
      private function initView() : void{}
      
      private function addEvent() : void{}
      
      private function __timerHandler(param1:TimerEvent) : void{}
      
      private function __updataList(param1:CrazyTankSocketEvent) : void{}
      
      private function updataRedPacketList() : void{}
      
      private function __sendPacketBtnHandler(param1:MouseEvent) : void{}
      
      private function __respose(param1:FrameEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
