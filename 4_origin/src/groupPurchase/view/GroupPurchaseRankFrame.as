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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.groupPurchase.rankViewBg");
         addToContent(_bg);
         _cellList = new Vector.<GroupPurchaseRankCell>();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new GroupPurchaseRankCell();
            _loc1_.x = 9;
            _loc1_.y = 54 + 43 * _loc2_ + _loc2_ * 0.7;
            addToContent(_loc1_);
            _cellList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initRefreshData() : void
      {
         _timer2 = new Timer(getRefreshDelay());
         _timer2.addEventListener("timer",requestRefreshData,false,0,true);
         _timer2.start();
         SocketManager.Instance.out.sendGroupPurchaseRefreshRankData();
      }
      
      private function requestRefreshData(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.sendGroupPurchaseRefreshRankData();
         _timer2.delay = getRefreshDelay();
      }
      
      private function getRefreshDelay() : int
      {
         _endTime = GroupPurchaseManager.instance.endTime;
         var _loc1_:Number = (_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(_loc1_ > 3600)
         {
            return 180000;
         }
         return 15000;
      }
      
      private function refreshView(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = GroupPurchaseManager.instance.rankList;
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _cellList[_loc3_].refreshView(_loc2_[_loc3_]);
            _loc3_++;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         GroupPurchaseManager.instance.addEventListener("GROUP_PURCHASE_REFRESH_RANK_DATA",refreshView);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0)
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
