package demonChiYou.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import demonChiYou.DemonChiYouManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class WorldBossRoomTotalInfoView extends Sprite implements Disposeable
   {
       
      
      private var _totalInfoBg:ScaleBitmapImage;
      
      private var _totalInfo_time:FilterFrameText;
      
      private var _totalInfo_yourSelf:FilterFrameText;
      
      private var _totalInfo_timeTxt:FilterFrameText;
      
      private var _totalInfo_yourSelfTxt:FilterFrameText;
      
      private var _txtArr:Array;
      
      private var _show_totalInfoBtnIMG:ScaleFrameImage;
      
      private var _open_show:Boolean = true;
      
      private var _show_totalInfoBtn:SimpleBitmapButton;
      
      private var _mgr:DemonChiYouManager;
      
      private var _getRankTimer:Timer;
      
      private var _leftTimeTimer:Timer;
      
      private var _leftSec:int;
      
      public function WorldBossRoomTotalInfoView()
      {
         super();
         initView();
         addEvent();
         _getRankTimer = new Timer(5000,2147483647);
         _getRankTimer.addEventListener("timer",onGetRankTimer);
         _getRankTimer.start();
         onGetRankTimer(null);
         _leftTimeTimer = new Timer(1000,2147483647);
         _leftTimeTimer.addEventListener("timer",onUpdateLeftTime);
         _leftTimeTimer.start();
      }
      
      private function initView() : void
      {
         _mgr = DemonChiYouManager.instance;
         _txtArr = [];
         var _loc2_:Date = _mgr.model.endDate;
         var _loc1_:Date = TimeManager.Instance.Now();
         _leftSec = _loc2_.hours * 3600 + _loc2_.minutes * 60 + _loc2_.seconds - _loc1_.hours * 3600 - _loc1_.minutes * 60 - _loc1_.seconds;
         _leftSec = _leftSec > 0?_leftSec:0;
         _totalInfoBg = ComponentFactory.Instance.creat("demonChiYou.totalInfoBg");
         addChild(_totalInfoBg);
         creatTxtInfo();
         _show_totalInfoBtn = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.showTotalBtn");
         addChild(_show_totalInfoBtn);
         _open_show = true;
         _show_totalInfoBtnIMG = ComponentFactory.Instance.creatComponentByStylename("demonChiYou.showTotalBtnIMG");
         _show_totalInfoBtnIMG.setFrame(1);
         _show_totalInfoBtn.addChild(_show_totalInfoBtnIMG);
      }
      
      private function onGetRankTimer(param1:TimerEvent) : void
      {
         SocketManager.Instance.out.getDemonChiYouRankInfo();
      }
      
      private function onUpdateLeftTime(param1:TimerEvent) : void
      {
         if(_leftSec <= 0)
         {
            _leftSec = 0;
            _leftTimeTimer.removeEventListener("timer",onUpdateLeftTime);
            _leftTimeTimer.stop();
         }
         _totalInfo_time.text = setFormat(int(_leftSec / 3600)) + ":" + setFormat(int(_leftSec / 60 % 60)) + ":" + setFormat(int(_leftSec % 60));
         _leftSec = Number(_leftSec) - 1;
      }
      
      private function creatTxtInfo() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _totalInfo_time = ComponentFactory.Instance.creat("demonChiYou.totalInfo.time");
         _totalInfo_yourSelf = ComponentFactory.Instance.creat("demonChiYou.totalInfo.yourself");
         _totalInfo_timeTxt = ComponentFactory.Instance.creat("demonChiYou.totalInfo.timeTxt");
         _totalInfo_yourSelfTxt = ComponentFactory.Instance.creat("demonChiYou.totalInfo.yourselfTxt");
         addChild(_totalInfo_time);
         addChild(_totalInfo_yourSelf);
         addChild(_totalInfo_timeTxt);
         addChild(_totalInfo_yourSelfTxt);
         _totalInfo_yourSelf.text = "0";
         _totalInfo_timeTxt.text = LanguageMgr.GetTranslation("worldboss.totalInfo.time");
         _totalInfo_yourSelfTxt.text = LanguageMgr.GetTranslation("demonChiYou.totalInfo.yourself");
         _loc2_ = 0;
         while(_loc2_ < 20)
         {
            if(_loc2_ < 3)
            {
               _loc1_ = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.No" + (_loc2_ + 1));
            }
            else if(_loc2_ < 10)
            {
               _loc1_ = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.NoOtherLeft");
            }
            else if(_loc2_ < 13)
            {
               _loc1_ = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.No" + (_loc2_ + 1));
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.NoOtherRight");
            }
            _loc1_.y = _loc1_.y + (int(_loc2_ % 10) * 24 - 30 + 17);
            addChild(_loc1_);
            _txtArr.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _show_totalInfoBtn.addEventListener("click",__showTotalInfo);
         _mgr.addEventListener("event_get_rankinfo_back",onGetRankInfoBack);
         _mgr.addEventListener("event_boss_end",onBossEnd);
      }
      
      private function removeEvent() : void
      {
         if(_show_totalInfoBtn)
         {
            _show_totalInfoBtn.removeEventListener("click",__showTotalInfo);
         }
         _getRankTimer.removeEventListener("timer",onGetRankTimer);
         _leftTimeTimer.removeEventListener("timer",onUpdateLeftTime);
         _mgr.removeEventListener("event_get_rankinfo_back",onGetRankInfoBack);
         _mgr.removeEventListener("event_boss_end",onBossEnd);
      }
      
      private function onBossEnd(param1:Event) : void
      {
         if(_mgr.model.bossState >= 3)
         {
            _leftSec = 0;
         }
      }
      
      private function onGetRankInfoBack(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         if(_mgr.model.rankInfo.hasMyConsortiaData)
         {
            _totalInfo_yourSelf.text = _mgr.model.rankInfo.myConsortiaDamage.toString();
         }
         var _loc3_:Array = _mgr.model.rankInfo.rankArr;
         var _loc2_:int = _loc3_.length > 10?10:_loc3_.length;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = _loc3_[_loc6_];
            _txtArr[_loc6_].text = _loc6_ + 1 + "." + formatName(_loc4_["Name"]);
            _loc5_ = (_loc4_["Damage"] * 100 / _mgr.model.bossMaxBlood).toFixed(3) + "%";
            _txtArr[_loc6_ + 10].text = _loc4_["Damage"] + "(" + _loc5_ + ")";
            _loc6_++;
         }
      }
      
      private function formatName(param1:String) : String
      {
         if(param1.length > 4)
         {
            return param1.slice(0,4) + "...";
         }
         return param1;
      }
      
      private function __showTotalInfo(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _show_totalInfoBtnIMG.setFrame(!!_open_show?2:1);
         addEventListener("enterFrame",__totalViewShowOrHide);
      }
      
      private function __totalViewShowOrHide(param1:Event) : void
      {
         if(_open_show)
         {
            this.x = this.x + 20;
            if(this.x >= StageReferance.stageWidth - 25)
            {
               removeEventListener("enterFrame",__totalViewShowOrHide);
               this.x = StageReferance.stageWidth - 46;
               _open_show = !_open_show;
            }
         }
         else
         {
            this.x = this.x - 20;
            if(this.x <= StageReferance.stageWidth - this.width)
            {
               removeEventListener("enterFrame",__totalViewShowOrHide);
               this.x = StageReferance.stageWidth - this.width - 6;
               _open_show = !_open_show;
            }
         }
      }
      
      public function setRightDown() : void
      {
         this.x = StageReferance.stageWidth - this.width - 6;
         this.y = StageReferance.stageHeight - this.height - 94;
      }
      
      private function setFormat(param1:int) : String
      {
         var _loc2_:String = param1.toString();
         if(param1 < 10)
         {
            _loc2_ = "0" + _loc2_;
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         _totalInfoBg = null;
         _totalInfo_time = null;
         _totalInfo_yourSelf = null;
         _totalInfo_timeTxt = null;
         _totalInfo_yourSelfTxt = null;
         _txtArr = null;
         _show_totalInfoBtnIMG = null;
         _show_totalInfoBtn = null;
         _mgr = null;
         _getRankTimer.stop();
         _getRankTimer = null;
         _leftTimeTimer.stop();
         _leftTimeTimer = null;
      }
   }
}
