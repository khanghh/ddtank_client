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
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = null;
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
         var _loc2_:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
         _loc9_ = 0;
         while(_loc9_ < _loc2_.length)
         {
            if(_loc2_[_loc9_].statusID == 0)
            {
               _loc6_ = _loc2_[_loc9_].statusValue;
               break;
            }
            _loc9_++;
         }
         _totalRechargeTxt = ComponentFactory.Instance.creatComponentByStylename("conRecharge.totalRecharge.txt");
         addToContent(_totalRechargeTxt);
         _totalRechargeTxt.text = LanguageMgr.GetTranslation("ddt.conRecharge.totalRecharge",_loc6_);
         _rechargeBtn = ComponentFactory.Instance.creatComponentByStylename("conRecharge.rechargeBtn");
         addToContent(_rechargeBtn);
         var _loc5_:String = LanguageMgr.GetTranslation("ddt.conRecharge.chargeTip");
         var _loc4_:Array = WonderfulActivityManager.Instance.getActivityInitDataById(ConRechargeManager.instance.actId).statusArr;
         _loc7_ = 0;
         while(_loc7_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc7_];
            if(_loc8_.statusID != 0)
            {
               _loc3_ = String(_loc8_.statusID);
               _loc1_ = _loc3_.substr(0,4) + "/" + _loc3_.substr(4,2) + "/" + _loc3_.substr(6,2);
               _loc5_ = _loc5_ + ("\n" + LanguageMgr.GetTranslation("ddt.conRecharge.moneyTxt",_loc1_ + "--" + String(_loc8_.statusValue)));
            }
            _loc7_++;
         }
         _rechargeBtn.tipData = _loc5_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_responseHandle);
         _time.addEventListener("TIME_countdown_complete",_timeOver);
         _time.addEventListener("countdown_one",_timeOne);
         var _loc1_:int = DateUtils.getHourDifference(DateUtils.getDateByStr(ConRechargeManager.instance.beginTime).valueOf(),DateUtils.getDateByStr(ConRechargeManager.instance.endTime).valueOf());
         _time.setTimeOnMinute(_loc1_ * 60);
         _rechargeBtn.addEventListener("click",__onSupplyClick);
      }
      
      private function __onSupplyClick(param1:MouseEvent) : void
      {
         LeavePageManager.leaveToFillPath();
      }
      
      private function _timeOver(param1:Event) : void
      {
      }
      
      private function _timeOne(param1:Event) : void
      {
         var _loc3_:Date = DateUtils.getDateByStr(ConRechargeManager.instance.endTime);
         var _loc2_:String = TimeManager.Instance.getMaxRemainDateStr(_loc3_);
         _activityTime.text = LanguageMgr.GetTranslation("ddt.conRecharge.activityTime",_loc2_);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_responseHandle);
         _time.removeEventListener("TIME_countdown_complete",_timeOver);
         _time.removeEventListener("countdown_one",_timeOne);
         _time.dispose();
         _rechargeBtn.removeEventListener("click",__onSupplyClick);
      }
      
      protected function _responseHandle(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         switch(int(param1.responseCode))
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
