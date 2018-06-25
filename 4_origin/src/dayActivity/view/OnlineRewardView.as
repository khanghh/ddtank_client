package dayActivity.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.OnlineRewardModel;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import gradeAwardsBoxBtn.view.GradeAwardsFlyIntoBagViewWithPos;
   
   public class OnlineRewardView extends Sprite implements Disposeable
   {
       
      
      private var _onlineTimeHTf:FilterFrameText;
      
      private var _onlineTimeMTf:FilterFrameText;
      
      private var _onlineTimeSTf:FilterFrameText;
      
      private var _getBtn:SimpleBitmapButton;
      
      private var _canGetBtnMC:MovieClip;
      
      private var _timer:Timer;
      
      private var _itemArr:Array;
      
      private var _model:OnlineRewardModel;
      
      public function OnlineRewardView()
      {
         super();
         initView();
         initListener();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         _model = DayActivityManager.Instance.onlineRewardModel;
         UICreatShortcut.creatAndAdd("day.activity.onlineReward.bg",this);
         _onlineTimeHTf = UICreatShortcut.creatAndAdd("day.activity.onlineReward.onlineTimeHTf",this);
         _onlineTimeMTf = UICreatShortcut.creatAndAdd("day.activity.onlineReward.onlineTimeMTf",this);
         _onlineTimeSTf = UICreatShortcut.creatAndAdd("day.activity.onlineReward.onlineTimeSTf",this);
         _getBtn = UICreatShortcut.creatAndAdd("day.activity.onlineReward.getBtn",this);
         _getBtn.enable = false;
         _timer = new Timer(1000,2147483647);
         _timer.addEventListener("timer",onTimer);
         _timer.start();
         _itemArr = [];
         for(i = 0; i < _model.boxNum; )
         {
            item = new OnlineRewardItem(i);
            item.x = 33 + 135 * i;
            item.y = 172;
            this.addChild(item);
            _itemArr.push(item);
            i++;
         }
         update();
      }
      
      private function initListener() : void
      {
         _getBtn.addEventListener("click",onClick);
         DayActivityManager.Instance.addEventListener("event_online_reward_op_back_get",onOpBackGet);
         DayActivityManager.Instance.addEventListener("online_reward_status_change",update);
      }
      
      private function removeListener() : void
      {
         _getBtn.removeEventListener("click",onClick);
         _timer.removeEventListener("timer",onTimer);
         DayActivityManager.Instance.removeEventListener("event_online_reward_op_back_get",onOpBackGet);
         DayActivityManager.Instance.removeEventListener("online_reward_status_change",update);
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         SocketManager.Instance.out.getOnlineReward();
      }
      
      private function onTimer(evt:TimerEvent) : void
      {
         update();
      }
      
      private function update(evt:Event = null) : void
      {
         var arr:Array = TimeManager.getHHMMSSArr(_model.onlineSec);
         if(arr == null)
         {
            _onlineTimeHTf.text = "00";
            _onlineTimeMTf.text = "00";
            _onlineTimeSTf.text = "00";
         }
         else
         {
            _onlineTimeHTf.text = arr[0];
            _onlineTimeMTf.text = arr[1];
            _onlineTimeSTf.text = arr[2];
         }
         if(_model.canGetBox)
         {
            _getBtn.enable = true;
            if(!_canGetBtnMC)
            {
               _canGetBtnMC = UICreatShortcut.creatAndAdd("day.activity.onlineReward.btnMC",this);
               _canGetBtnMC.mouseChildren = false;
               _canGetBtnMC.mouseEnabled = false;
            }
         }
         else
         {
            _getBtn.enable = false;
            ObjectUtils.disposeObject(_canGetBtnMC);
            _canGetBtnMC && _canGetBtnMC.stop();
            _canGetBtnMC = null;
         }
         var _loc5_:int = 0;
         var _loc4_:* = _itemArr;
         for each(var item in _itemArr)
         {
            item.update();
         }
      }
      
      private function onOpBackGet(evt:Event) : void
      {
         var i:int = 0;
         var info:* = null;
         var point:* = null;
         update();
         var receiveGoodsArr:Array = _model.receiveGoodsArr;
         var infoArr:Array = [];
         var posArr:Array = [];
         for(i = 0; i < receiveGoodsArr.length; )
         {
            info = receiveGoodsArr[i];
            if(info)
            {
               infoArr.push(info);
               point = this.localToGlobal(new Point(53 + 135 * i,210));
               posArr.push(point);
            }
            i++;
         }
         new GradeAwardsFlyIntoBagViewWithPos().onFrameClose(infoArr,posArr);
      }
      
      public function dispose() : void
      {
         removeListener();
         ObjectUtils.disposeAllChildren(this);
         _onlineTimeHTf = null;
         _onlineTimeMTf = null;
         _onlineTimeSTf = null;
         _getBtn = null;
         _timer.stop();
         _timer = null;
         _canGetBtnMC && _canGetBtnMC.stop();
         _canGetBtnMC = null;
         _itemArr = null;
         _model = null;
      }
   }
}
