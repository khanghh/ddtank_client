package horseRace.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import horseRace.controller.HorseRaceManager;
   import horseRace.events.HorseRaceEvents;
   
   public class HorseRaceBuffView extends Sprite implements Disposeable
   {
       
      
      public var timeSyn:int = 0;
      
      private var _bg:Bitmap;
      
      private var _buffItemType1:int = 0;
      
      private var _buffItemType2:int = 0;
      
      private var buffItem1:HorseRaceBuffItem;
      
      private var buffItem2:HorseRaceBuffItem;
      
      private var pingzhangBnt:BaseButton;
      
      private var pingzhangTimer:Timer;
      
      private var pingzhangCount:int = 15;
      
      private var pingzhangDaojishi:MovieClip;
      
      public var pingzhangUseSuccess:Boolean = false;
      
      public function HorseRaceBuffView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creat("horseRace.raceView.buffViewBg");
         addChild(_bg);
         buffItem1 = new HorseRaceBuffItem(_buffItemType1,1);
         buffItem2 = new HorseRaceBuffItem(_buffItemType2,2);
         PositionUtils.setPos(buffItem1,"horseRace.raceView.buffView.buffItemPos1");
         PositionUtils.setPos(buffItem2,"horseRace.raceView.buffView.buffItemPos2");
         pingzhangBnt = ComponentFactory.Instance.creatComponentByStylename("horseRace.raceView.buffView.pingzhangBnt");
         pingzhangBnt.tipData = LanguageMgr.GetTranslation("horseRace.raceView.buffView.pingzhangTip");
         addChild(buffItem1);
         addChild(buffItem2);
         addChild(pingzhangBnt);
         pingzhangTimer = new Timer(1000);
         pingzhangTimer.addEventListener("timer",_showDaojishi);
         pingzhangDaojishi = ComponentFactory.Instance.creat("horseRace.raceView.pingzhangDaojishi");
         PositionUtils.setPos(pingzhangDaojishi,"horseRace.raceView.pingzhangDaojishiPos");
         addChild(pingzhangDaojishi);
         pingzhangDaojishi.visible = false;
      }
      
      private function _showDaojishi(e:TimerEvent) : void
      {
         pingzhangDaojishi.gotoAndStop(pingzhangCount);
         pingzhangCount = Number(pingzhangCount) - 1;
         if(pingzhangCount < 0)
         {
            pingzhangDaojishi.gotoAndStop(1);
            pingzhangDaojishi.visible = false;
            pingzhangDaojishi.gotoAndStop(15);
            pingzhangTimer.stop();
            pingzhangCount = 15;
            pingzhangTimer.reset();
            pingzhangBnt.enable = true;
            pingzhangUseSuccess = false;
         }
      }
      
      public function showPingzhangDaojishi() : void
      {
         pingzhangBnt.enable = false;
         pingzhangCount = 15;
         pingzhangDaojishi.visible = true;
         pingzhangDaojishi.gotoAndStop(15);
         pingzhangTimer.start();
         pingzhangCount = Number(pingzhangCount) - 1;
      }
      
      public function set buffItemType1($buffItemType1:int) : void
      {
         _buffItemType1 = $buffItemType1;
         if(_buffItemType1 != 0)
         {
            buffItem1.setShowBuffObj(_buffItemType1);
         }
         else
         {
            buffItem1.showBuffObjByType(0);
         }
      }
      
      public function get buffItemType1() : int
      {
         return _buffItemType1;
      }
      
      public function set buffItemType2($buffItemType2:int) : void
      {
         _buffItemType2 = $buffItemType2;
         if(_buffItemType2 != 0)
         {
            buffItem2.setShowBuffObj(_buffItemType2);
         }
         else
         {
            buffItem2.showBuffObjByType(0);
         }
      }
      
      public function get buffItemType2() : int
      {
         return _buffItemType2;
      }
      
      public function flushBuffItem() : void
      {
         if(_buffItemType1 == 0 && _buffItemType2 == 0)
         {
            buffItem1.setShowBuff(_buffItemType1,timeSyn);
            buffItem2.setShowBuff(_buffItemType2,-1);
         }
         else if(_buffItemType1 == 0 && _buffItemType2 != 0)
         {
            buffItem1.setShowBuff(_buffItemType1,timeSyn);
            buffItem2.setShowBuffObj(_buffItemType2);
         }
         else if(_buffItemType1 != 0 && _buffItemType2 == 0)
         {
            buffItem1.setShowBuffObj(_buffItemType1);
            buffItem2.setShowBuff(_buffItemType2,timeSyn);
         }
         else if(_buffItemType1 != 0 && _buffItemType2 != 0)
         {
            buffItem1.setShowBuffObj(_buffItemType1);
            buffItem2.setShowBuffObj(_buffItemType2);
         }
      }
      
      private function initEvent() : void
      {
         pingzhangBnt.addEventListener("click",_pingzhangUse);
      }
      
      private function _pingzhangUse(e:MouseEvent) : void
      {
         HorseRaceManager.Instance.dispatchEvent(new HorseRaceEvents("HORSERACE_USE_PINGZHANG"));
      }
      
      private function removeEvent() : void
      {
         pingzhangBnt.removeEventListener("click",_pingzhangUse);
      }
      
      public function dispose() : void
      {
         removeEvent();
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
      }
   }
}
