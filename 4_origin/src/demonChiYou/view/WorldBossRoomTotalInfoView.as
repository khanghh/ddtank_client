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
         var endDate:Date = _mgr.model.endDate;
         var nowDate:Date = TimeManager.Instance.Now();
         _leftSec = endDate.hours * 3600 + endDate.minutes * 60 + endDate.seconds - nowDate.hours * 3600 - nowDate.minutes * 60 - nowDate.seconds;
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
      
      private function onGetRankTimer(evt:TimerEvent) : void
      {
         SocketManager.Instance.out.getDemonChiYouRankInfo();
      }
      
      private function onUpdateLeftTime(evt:TimerEvent) : void
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
         var i:int = 0;
         var txt:* = null;
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
         for(i = 0; i < 20; )
         {
            if(i < 3)
            {
               txt = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.No" + (i + 1));
            }
            else if(i < 10)
            {
               txt = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.NoOtherLeft");
            }
            else if(i < 13)
            {
               txt = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.No" + (i + 1));
            }
            else
            {
               txt = ComponentFactory.Instance.creat("demonChiYou.rankingTxt.NoOtherRight");
            }
            txt.y = txt.y + (int(i % 10) * 24 - 30 + 17);
            addChild(txt);
            _txtArr.push(txt);
            i++;
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
      
      private function onBossEnd(evt:Event) : void
      {
         if(_mgr.model.bossState >= 3)
         {
            _leftSec = 0;
         }
      }
      
      private function onGetRankInfoBack(evt:Event) : void
      {
         var i:int = 0;
         var item:* = null;
         var prect:* = null;
         if(_mgr.model.rankInfo.hasMyConsortiaData)
         {
            _totalInfo_yourSelf.text = _mgr.model.rankInfo.myConsortiaDamage.toString();
         }
         var arr:Array = _mgr.model.rankInfo.rankArr;
         var num:int = arr.length > 10?10:arr.length;
         for(i = 0; i < num; )
         {
            item = arr[i];
            _txtArr[i].text = i + 1 + "." + formatName(item["Name"]);
            prect = (item["Damage"] * 100 / _mgr.model.bossMaxBlood).toFixed(3) + "%";
            _txtArr[i + 10].text = item["Damage"] + "(" + prect + ")";
            i++;
         }
      }
      
      private function formatName(name:String) : String
      {
         if(name.length > 4)
         {
            return name.slice(0,4) + "...";
         }
         return name;
      }
      
      private function __showTotalInfo(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _show_totalInfoBtnIMG.setFrame(!!_open_show?2:1);
         addEventListener("enterFrame",__totalViewShowOrHide);
      }
      
      private function __totalViewShowOrHide(evt:Event) : void
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
      
      private function setFormat(value:int) : String
      {
         var str:String = value.toString();
         if(value < 10)
         {
            str = "0" + str;
         }
         return str;
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
