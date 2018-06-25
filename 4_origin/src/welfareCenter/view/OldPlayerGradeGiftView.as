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
         var i:int = 0;
         var btn:* = null;
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
         for(i = 0; i < 4; )
         {
            btn = ComponentFactory.Instance.creatComponentByStylename("welfareCenter.gift.btn" + i);
            btn.addEventListener("click",__onClickGiftBtn);
            addChild(btn);
            _giftBtnList.push(btn);
            i++;
         }
         WelfareCenterManager.instance.addEventListener("change",__onGainComplete);
         updateAwardView(_gainProgress + 1);
         updateGiftView();
         __onUpdateTimer(null);
         _timer = TimerManager.getInstance().addTimerJuggler(1000);
         _timer.addEventListener("timer",__onUpdateTimer);
         _timer.start();
      }
      
      private function __onGainComplete(e:Event) : void
      {
         _giftBtnList[_gainProgress].isShine = false;
         _gainProgress = WelfareCenterManager.instance.gradeGiftProgress;
         updateGiftView();
      }
      
      public function updateAwardView($type:int) : void
      {
         var i:int = 0;
         var info:* = null;
         var cell:* = null;
         PositionUtils.setPos(_awardArrow,"welfareCenter.gradeGiftView.arrowPos" + $type);
         _hBox.clearAllChild();
         var idList:Array = goodsIDList[$type - 1];
         var countList:Array = goodsCountList[$type - 1];
         for(i = 0; i < idList.length; )
         {
            info = ItemManager.fillByID(idList[i]);
            info.IsBinds = true;
            info.Count = countList[i];
            cell = new BagCell(0,info);
            cell.width = 70;
            cell.height = 70;
            _hBox.addChild(cell);
            i++;
         }
      }
      
      private function __onClickGiftBtn(e:MouseEvent) : void
      {
         var i:int = 0;
         SoundManager.instance.playButtonSound();
         for(i = 0; i < _giftBtnList.length; )
         {
            if(_giftBtnList[i] == e.currentTarget)
            {
               if(i == _gainProgress && isGainAward())
               {
                  SocketManager.Instance.out.sendGainOldPlayerGift();
               }
               updateAwardView(i + 1);
               return;
            }
            i++;
         }
      }
      
      private function updateGiftView() : void
      {
         var i:int = 0;
         _progress.gotoAndStop(_gainProgress + 1);
         for(i = 0; i < _gainProgress; )
         {
            _giftBtnList[i].isGain = true;
            i++;
         }
         if(PlayerManager.Instance.Self.Grade >= gradeList[_gainProgress])
         {
            _giftBtnList[_gainProgress].isShine = true;
         }
      }
      
      private function __onUpdateTimer(e:Event) : void
      {
         var day:int = 0;
         var time:int = (WelfareCenterManager.instance.gradeGiftEndTime - TimeManager.Instance.Now().time) / 1000;
         if(time > 0)
         {
            day = DateUtils.dateTimeRemainArr(time)[0];
            if(day >= 1)
            {
               _timeText.text = LanguageMgr.GetTranslation("newChickenBox.timePlayTxt") + day + LanguageMgr.GetTranslation("day");
            }
            else
            {
               _timeText.text = LanguageMgr.GetTranslation("newChickenBox.timePlayTxt") + TimeManager.getHHMMSSArr(time).join(":");
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
         var needGrade:int = gradeList[_gainProgress];
         if(PlayerManager.Instance.Self.Grade >= needGrade)
         {
            return true;
         }
         return false;
      }
      
      private function cellBg() : Sprite
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(0,0);
         sp.graphics.drawRect(0,0,60,60);
         sp.graphics.endFill();
         return sp;
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
         var btn:* = null;
         disposeTimer();
         WelfareCenterManager.instance.removeEventListener("change",__onGainComplete);
         while(_giftBtnList.length)
         {
            btn = _giftBtnList.pop() as BaseButton;
            btn.removeEventListener("click",__onClickGiftBtn);
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
