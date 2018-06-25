package conRecharge.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.bossbox.TimeCountDown;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.PlayerCurInfo;
   
   public class ConRechargeFrame extends Frame
   {
       
      
      private var _topBg:Bitmap;
      
      private var _rightBg:Bitmap;
      
      private var _leftBg:Bitmap;
      
      private var _activityTime:FilterFrameText;
      
      private var _totalRechargeTxt:FilterFrameText;
      
      private var _rechargeBtn:BaseButton;
      
      private var _leftView:ConRechargeLeftItem;
      
      private var _rightView:ConRechargeRightItem;
      
      private var _time:TimeCountDown;
      
      public function ConRechargeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var reMoney:int = 0;
         var i:int = 0;
         var j:int = 0;
         var info:* = null;
         var whatDate:* = null;
         var str:* = null;
         _time = new TimeCountDown(1000);
         _topBg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.topBg");
         addToContent(_topBg);
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.leftBg");
         addToContent(_leftBg);
         _rightBg = ComponentFactory.Instance.creatBitmap("asset.conRecharge.rightBg");
         addToContent(_rightBg);
         _leftView = new ConRechargeLeftItem();
         addToContent(_leftView);
         PositionUtils.setPos(_leftView,"conRecharge.leftView.pos");
         _rightView = new ConRechargeRightItem();
         addToContent(_rightView);
         PositionUtils.setPos(_rightView,"conRecharge.rightView.pos");
         _activityTime = ComponentFactory.Instance.creatComponentByStylename("conRecharge.activityTime.txt");
         addToContent(_activityTime);
         var arr:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
         for(i = 0; i < arr.length; )
         {
            if(arr[i].statusID == 0)
            {
               reMoney = arr[i].statusValue;
               break;
            }
            i++;
         }
         _totalRechargeTxt = ComponentFactory.Instance.creatComponentByStylename("conRecharge.totalRecharge.txt");
         addToContent(_totalRechargeTxt);
         _totalRechargeTxt.text = LanguageMgr.GetTranslation("ddt.conRecharge.totalRecharge",reMoney);
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rechargeBtn");
         addToContent(_rechargeBtn);
         var tipStr:String = LanguageMgr.GetTranslation("ddt.conRecharge.chargeTip");
         var arr1:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
         for(j = 0; j < arr1.length; )
         {
            info = arr1[j];
            if(info.statusID != 0)
            {
               whatDate = String(info.statusID);
               str = whatDate.substr(0,4) + "/" + whatDate.substr(4,2) + "/" + whatDate.substr(6,2);
               tipStr = tipStr + ("\n" + LanguageMgr.GetTranslation("ddt.conRecharge.moneyTxt",str + "--" + String(info.statusValue)));
            }
            j++;
         }
         _rechargeBtn.tipData = tipStr;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         _time.addEventListener("TIME_countdown_complete",_timeOver);
         _time.addEventListener("countdown_one",_timeOne);
         var hour:int = DateUtils.getHourDifference(DateUtils.getDateByStr(ConRechargeManager.instance.beginTime).valueOf(),DateUtils.getDateByStr(ConRechargeManager.instance.endTime).valueOf());
         _time.setTimeOnMinute(hour * 60);
         _rechargeBtn.addEventListener("click",__onSupplyClick);
      }
      
      private function __onSupplyClick(evnet:MouseEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      private function _timeOver(e:Event) : void
      {
      }
      
      private function _timeOne(e:Event) : void
      {
         var end:Date = DateUtils.getDateByStr(ConRechargeManager.instance.endTime);
         var str:String = TimeManager.Instance.getMaxRemainDateStr(end);
         _activityTime.text = LanguageMgr.GetTranslation("ddt.conRecharge.activityTime",str);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _time.removeEventListener("TIME_countdown_complete",_timeOver);
         _time.removeEventListener("countdown_one",_timeOne);
         _time.dispose();
         _rechargeBtn.removeEventListener("click",__onSupplyClick);
      }
      
      protected function _responseHandle(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               dispose();
               break;
            default:
               dispose();
               break;
            default:
               dispose();
               break;
            case 4:
         }
      }
      
      override public function dispose() : void
      {
         SocketManager.Instance.out.requestWonderfulActInit(2);
         removeEvent();
         super.dispose();
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_activityTime);
         _activityTime = null;
         ObjectUtils.disposeObject(_totalRechargeTxt);
         _totalRechargeTxt = null;
         ObjectUtils.disposeObject(_rechargeBtn);
         _rechargeBtn = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
      }
   }
}
