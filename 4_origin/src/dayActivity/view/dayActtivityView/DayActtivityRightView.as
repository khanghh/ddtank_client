package dayActivity.view.dayActtivityView
{
   import calendar.CalendarControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.items.DayAcBar;
   import dayActivity.items.DayActivityRightViewItem;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainbutton.MainButtnController;
   
   public class DayActtivityRightView extends Sprite implements Disposeable
   {
       
      
      private var _back:MutipleImage;
      
      private var _todayABitMap:Bitmap;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _bar:DayAcBar;
      
      private var _rfl:Bitmap;
      
      private var _lfl:Bitmap;
      
      private var _dailyCollectionBtn:SimpleBitmapButton;
      
      private var _list:Vector.<DayActivityRightViewItem>;
      
      private var _activeList:Array;
      
      public function DayActtivityRightView()
      {
         _activeList = [30,60,80,100,120];
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _list = new Vector.<DayActivityRightViewItem>();
         _back = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.right.SignedAwardBack");
         addChild(_back);
         _rfl = ComponentFactory.Instance.creat("day.activity.huawen");
         _rfl.x = 9;
         _rfl.y = 11;
         addChild(_rfl);
         _lfl = ComponentFactory.Instance.creat("day.activity.huawen");
         _lfl.x = 382;
         _lfl.y = 11;
         _lfl.scaleX = -1;
         addChild(_lfl);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.right.txt1");
         _txt1.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityGoods");
         addChild(_txt1);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.right.txt2");
         _txt2.text = LanguageMgr.GetTranslation("ddt.dayActivity.activityLimit");
         addChild(_txt2);
         _todayABitMap = ComponentFactory.Instance.creat("day.todayActivie");
         addChild(_todayABitMap);
         if(PlayerManager.Instance.Self.Grade >= 5 && MainButtnController.instance.DailyAwardState)
         {
            _dailyCollectionBtn = ComponentFactory.Instance.creatComponentByStylename("day.activity.dailyCollectionBtn");
            addChild(_dailyCollectionBtn);
         }
         _bar = new DayAcBar();
         _bar.x = 60;
         _bar.y = 75;
         addChild(_bar);
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new DayActivityRightViewItem(_activeList[_loc2_]);
            _loc1_.y = (_loc1_.height + 3) * _loc2_ + 158;
            _loc1_.x = 13;
            _loc1_.id = _loc2_ + 1;
            addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         if(_dailyCollectionBtn)
         {
            _dailyCollectionBtn.addEventListener("click",__onDailyCollection);
         }
      }
      
      protected function __onDailyCollection(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CalendarControl.getInstance().reciveDayAward();
         deleteDailyBtn();
      }
      
      private function deleteDailyBtn() : void
      {
         if(_dailyCollectionBtn)
         {
            _dailyCollectionBtn.removeEventListener("click",__onDailyCollection);
            _dailyCollectionBtn.dispose();
            _dailyCollectionBtn = null;
         }
      }
      
      public function updataBtn(param1:int) : void
      {
         _list[param1 - 1].showBtn(true);
      }
      
      public function setBarValue(param1:int) : void
      {
         _bar.initBar(param1);
         var _loc2_:Array = DayActivityManager.Instance.btnArr;
         if(param1 >= 30 && param1 < 60)
         {
            setBtnState(1);
         }
         else if(param1 >= 60 && param1 < 80)
         {
            setBtnState(2);
         }
         else if(param1 >= 80 && param1 < 100)
         {
            setBtnState(3);
         }
         else if(param1 >= 100 && param1 < 120)
         {
            setBtnState(4);
         }
         else if(param1 >= 120)
         {
            setBtnState(5);
         }
      }
      
      private function setBtnState(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            if(DayActivityManager.Instance.btnArr[_loc2_][1] == 0)
            {
               _list[_loc2_].showBtn(false);
            }
            else
            {
               _list[_loc2_].showBtn(true);
            }
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         deleteDailyBtn();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _list = null;
      }
   }
}
