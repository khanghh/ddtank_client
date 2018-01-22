package welfareCenter.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.DateUtils;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import welfareCenter.WelfareCenterManager;
   
   public class OldPlayerGradeGiftView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _awardBg:ScaleBitmapImage;
      
      private var _progress:MovieClip;
      
      private var _awardArrow:Bitmap;
      
      private var _giftBtnList:Vector.<OldPlayerGradeGiftBox>;
      
      private var _hBox:HBox;
      
      private var _gainProgress:int;
      
      private var _timeText:FilterFrameText;
      
      private var _timer:TimerJuggler;
      
      private const goodsIDList:Array = [[11025,9024,12559],[11025,40002,313000,12559],[11150,100100,40002,334102,12559,11994],[11150,100100,40002,334102,20150,12559]];
      
      private const goodsCountList:Array = [[20,2,1],[50,10,5,1],[3,30,15,3,2,1],[5,50,20,8,3,3]];
      
      private const gradeList:Array = [12,20,30,35];
      
      public function OldPlayerGradeGiftView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _gainProgress = WelfareCenterManager.instance.gradeGiftProgress;
         _bg = ComponentFactory.Instance.creatBitmap("asset.welfareCeneter.gift.bg");
         _awardArrow = ComponentFactory.Instance.creatBitmap("asset.welfareCeneter.gift.awardArrow");
         _awardBg = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.gift.awardBg");
         _progress = ComponentFactory.Instance.creat("asset.welfareCeneter.gift.progress");
         _progress.gotoAndStop(_gainProgress + 1);
         PositionUtils.setPos(_progress,"welfareCenter.gradeGiftView.ProgressPos");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.gift.hBox");
         _giftBtnList = new Vector.<OldPlayerGradeGiftBox>();
         _timeText = ComponentFactory.Instance.creatComponentByStylename("callbacklotterydraw.nextCDTimeTf");
         PositionUtils.setPos(_timeText,"welfareCenter.gradeGiftView.timeTextPos");
         addChild(_bg);
         addChild(_awardBg);
         addChild(_awardArrow);
         addChild(_progress);
         addChild(_hBox);
         addChild(_timeText);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.gift.btn" + _loc2_);
            _loc1_.addEventListener("click",__onClickGiftBtn);
            addChild(_loc1_);
            _giftBtnList.push(_loc1_);
            _loc2_++;
         }
         WelfareCenterManager.instance.addEventListener("change",__onGainComplete);
         updateAwardView(_gainProgress + 1);
         updateGiftView();
         __onUpdateTimer(null);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__onUpdateTimer);
         _timer.start();
      }
      
      private function __onGainComplete(param1:Event) : void
      {
         _giftBtnList[_gainProgress].isShine = false;
         _gainProgress = WelfareCenterManager.instance.gradeGiftProgress;
         updateGiftView();
      }
      
      public function updateAwardView(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:* = null;
         PositionUtils.setPos(_awardArrow,"welfareCenter.gradeGiftView.arrowPos" + param1);
         _hBox.clearAllChild();
         var _loc3_:Array = goodsIDList[param1 - 1];
         var _loc4_:Array = goodsCountList[param1 - 1];
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc5_ = ItemManager.fillByID(_loc3_[_loc6_]);
            _loc5_.IsBinds = true;
            _loc5_.Count = _loc4_[_loc6_];
            _loc2_ = new BagCell(0,_loc5_);
            _loc2_.width = 70;
            _loc2_.height = 70;
            _hBox.addChild(_loc2_);
            _loc6_++;
         }
      }
      
      private function __onClickGiftBtn(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.playButtonSound();
         _loc2_ = 0;
         while(_loc2_ < _giftBtnList.length)
         {
            if(_giftBtnList[_loc2_] == param1.currentTarget)
            {
               if(_loc2_ == _gainProgress && isGainAward())
               {
                  SocketManager.Instance.out.sendGainOldPlayerGift();
               }
               updateAwardView(_loc2_ + 1);
               return;
            }
            _loc2_++;
         }
      }
      
      private function updateGiftView() : void
      {
         var _loc1_:int = 0;
         _progress.gotoAndStop(_gainProgress + 1);
         _loc1_ = 0;
         while(_loc1_ < _gainProgress)
         {
            _giftBtnList[_loc1_].isGain = true;
            _loc1_++;
         }
         if(PlayerManager.Instance.Self.Grade >= gradeList[_gainProgress])
         {
            _giftBtnList[_gainProgress].isShine = true;
         }
      }
      
      private function __onUpdateTimer(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = (WelfareCenterManager.instance.gradeGiftEndTime - TimeManager.Instance.Now().time) / 1000;
         if(_loc2_ > 0)
         {
            _loc3_ = DateUtils.dateTimeRemainArr(_loc2_)[0];
            if(_loc3_ >= 1)
            {
               _timeText.text = LanguageMgr.GetTranslation("newChickenBox.timePlayTxt") + _loc3_ + LanguageMgr.GetTranslation("day");
            }
            else
            {
               _timeText.text = LanguageMgr.GetTranslation("newChickenBox.timePlayTxt") + TimeManager.getHHMMSSArr(_loc2_).join(":");
            }
         }
         else
         {
            _timeText.text = LanguageMgr.GetTranslation("ddt.welfareCenter.gift.activityEnd");
            disposeTimer();
         }
      }
      
      private function isGainAward() : Boolean
      {
         var _loc1_:int = gradeList[_gainProgress];
         if(PlayerManager.Instance.Self.Grade >= _loc1_)
         {
            return true;
         }
         return false;
      }
      
      private function cellBg() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,60,60);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function disposeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onUpdateTimer);
            TimerManager.getInstance().removeTimerJuggler(_timer.id);
            _timer = null;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = null;
         disposeTimer();
         WelfareCenterManager.instance.removeEventListener("change",__onGainComplete);
         while(_giftBtnList.length)
         {
            _loc1_ = _giftBtnList.pop() as BaseButton;
            _loc1_.removeEventListener("click",__onClickGiftBtn);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _progress = null;
         _awardBg = null;
         _awardArrow = null;
         _giftBtnList = null;
         _hBox = null;
         _timeText = null;
      }
   }
}
