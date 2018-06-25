package groupPurchase.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import groupPurchase.GroupPurchaseManager;
   
   public class GroupPurchaseRankFrame extends Frame
   {
       
      
      private var _bg:Bitmap;
      
      private var _cellList:Vector.<GroupPurchaseRankCell>;
      
      private var _timer2:Timer;
      
      private var _endTime:Date;
      
      public function GroupPurchaseRankFrame()
      {
         super();
         initView();
         initEvent();
         initRefreshData();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var tmp:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.groupPurchase.rankViewBg");
         addToContent(_bg);
         _cellList = new Vector.<GroupPurchaseRankCell>();
         for(i = 0; i < 10; )
         {
            tmp = new GroupPurchaseRankCell();
            tmp.x = 9;
            tmp.y = 54 + 43 * i + i * 0.7;
            addToContent(tmp);
            _cellList.push(tmp);
            i++;
         }
      }
      
      private function initRefreshData() : void
      {
         _timer2 = new Timer(getRefreshDelay());
         _timer2.addEventListener("timer",requestRefreshData,false,0,true);
         _timer2.start();
         SocketManager.Instance.out.sendGroupPurchaseRefreshRankData();
      }
      
      private function requestRefreshData(event:TimerEvent) : void
      {
         SocketManager.Instance.out.sendGroupPurchaseRefreshRankData();
         _timer2.delay = getRefreshDelay();
      }
      
      private function getRefreshDelay() : int
      {
         _endTime = GroupPurchaseManager.instance.endTime;
         var differ:Number = (_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(differ > 3600)
         {
            return 180000;
         }
         return 15000;
      }
      
      private function refreshView(event:Event) : void
      {
         var i:int = 0;
         var dataList:Array = GroupPurchaseManager.instance.rankList;
         for(i = 0; i < 10; )
         {
            _cellList[i].refreshView(dataList[i]);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         GroupPurchaseManager.instance.addEventListener("GROUP_PURCHASE_REFRESH_RANK_DATA",refreshView);
      }
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__responseHandler);
         GroupPurchaseManager.instance.removeEventListener("GROUP_PURCHASE_REFRESH_RANK_DATA",refreshView);
         if(_timer2)
         {
            _timer2.removeEventListener("timer",requestRefreshData);
            _timer2.stop();
         }
         _timer2 = null;
         super.dispose();
         _bg = null;
         _cellList = null;
         _endTime = null;
      }
   }
}
