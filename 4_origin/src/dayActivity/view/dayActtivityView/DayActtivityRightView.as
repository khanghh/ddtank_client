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
         var i:int = 0;
         var item:* = null;
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
         for(i = 0; i < 5; )
         {
            item = new DayActivityRightViewItem(_activeList[i]);
            item.y = (item.height + 3) * i + 158;
            item.x = 13;
            item.id = i + 1;
            addChild(item);
            _list.push(item);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         if(_dailyCollectionBtn)
         {
            _dailyCollectionBtn.addEventListener("click",__onDailyCollection);
         }
      }
      
      protected function __onDailyCollection(event:MouseEvent) : void
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
      
      public function updataBtn(id:int) : void
      {
         _list[id - 1].showBtn(true);
      }
      
      public function setBarValue($num:int) : void
      {
         _bar.initBar($num);
         var arr:Array = DayActivityManager.Instance.btnArr;
         if($num >= 30 && $num < 60)
         {
            setBtnState(1);
         }
         else if($num >= 60 && $num < 80)
         {
            setBtnState(2);
         }
         else if($num >= 80 && $num < 100)
         {
            setBtnState(3);
         }
         else if($num >= 100 && $num < 120)
         {
            setBtnState(4);
         }
         else if($num >= 120)
         {
            setBtnState(5);
         }
      }
      
      private function setBtnState(i:int) : void
      {
         var j:int = 0;
         for(j = 0; j < i; )
         {
            if(DayActivityManager.Instance.btnArr[j][1] == 0)
            {
               _list[j].showBtn(false);
            }
            else
            {
               _list[j].showBtn(true);
            }
            j++;
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
