package worldboss.view
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
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   import worldboss.player.RankingPersonInfo;
   
   public class WorldBossRoomTotalInfoView extends Sprite implements Disposeable
   {
       
      
      private var _totalInfoBg:ScaleBitmapImage;
      
      private var _totalInfo_time:FilterFrameText;
      
      private var _totalInfo_yourSelf:FilterFrameText;
      
      private var _totalInfo_timeTxt:FilterFrameText;
      
      private var _totalInfo_yourSelfTxt:FilterFrameText;
      
      private var _selfHonor:FilterFrameText;
      
      private var _selfHonorText:FilterFrameText;
      
      private var _txtArr:Array;
      
      private var _show_totalInfoBtnIMG:ScaleFrameImage;
      
      private var _open_show:Boolean = true;
      
      private var _show_totalInfoBtn:SimpleBitmapButton;
      
      public function WorldBossRoomTotalInfoView()
      {
         super();
         _txtArr = [];
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _totalInfoBg = ComponentFactory.Instance.creat("worldBossRoom.totalInfoBg");
         addChild(_totalInfoBg);
         creatTxtInfo();
         _show_totalInfoBtn = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.showTotalBtn");
         addChild(_show_totalInfoBtn);
         _open_show = true;
         _show_totalInfoBtnIMG = ComponentFactory.Instance.creatComponentByStylename("asset.worldBossRoom.showTotalBtnIMG");
         _show_totalInfoBtnIMG.setFrame(1);
         _show_totalInfoBtn.addChild(_show_totalInfoBtnIMG);
      }
      
      private function creatTxtInfo() : void
      {
         var i:int = 0;
         var txt:* = null;
         _totalInfo_time = ComponentFactory.Instance.creat("worldBossRoom.totalInfo.time");
         _totalInfo_yourSelf = ComponentFactory.Instance.creat("worldBossRoom.totalInfo.yourself");
         _totalInfo_timeTxt = ComponentFactory.Instance.creat("worldBossRoom.totalInfo.timeTxt");
         _totalInfo_yourSelfTxt = ComponentFactory.Instance.creat("worldBossRoom.totalInfo.yourselfTxt");
         _selfHonorText = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.totalInfo.selfHonorText");
         _selfHonor = ComponentFactory.Instance.creatComponentByStylename("worldBossRoom.totalInfo.selfHonor");
         addChild(_totalInfo_time);
         addChild(_totalInfo_yourSelf);
         addChild(_totalInfo_timeTxt);
         addChild(_totalInfo_yourSelfTxt);
         addChild(_selfHonor);
         addChild(_selfHonorText);
         _totalInfo_timeTxt.text = LanguageMgr.GetTranslation("worldboss.totalInfo.time");
         _totalInfo_yourSelfTxt.text = LanguageMgr.GetTranslation("worldboss.totalInfo.yourself");
         _selfHonorText.text = LanguageMgr.GetTranslation("worldboss.totalInfo.selfHonor");
         for(i = 0; i < 20; )
         {
            if(i < 3)
            {
               txt = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.No" + (i + 1));
            }
            else if(i < 10)
            {
               txt = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.NoOtherLeft");
            }
            else if(i < 13)
            {
               txt = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.No" + (i + 1));
            }
            else
            {
               txt = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.NoOtherRight");
            }
            txt.y = txt.y + int(i % 10) * 24;
            addChild(txt);
            _txtArr.push(txt);
            i++;
         }
         if(WorldBossManager.Instance.bossInfo.fightOver)
         {
            _txtArr[0].text = LanguageMgr.GetTranslation("worldboss.ranking.over");
         }
         else
         {
            _txtArr[0].text = LanguageMgr.GetTranslation("worldbossRoom.ranking.proploading");
         }
      }
      
      private function addEvent() : void
      {
         _show_totalInfoBtn.addEventListener("click",__showTotalInfo);
         WorldBossManager.Instance.addEventListener("change",__onUpdata);
      }
      
      protected function __onUpdata(event:Event) : void
      {
         updata_yourSelf_damage();
      }
      
      private function removeEvent() : void
      {
         if(_show_totalInfoBtn)
         {
            _show_totalInfoBtn.removeEventListener("click",__showTotalInfo);
         }
         WorldBossManager.Instance.removeEventListener("change",__onUpdata);
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
      
      public function updata_yourSelf_damage() : void
      {
         if(_totalInfo_yourSelf)
         {
            _totalInfo_yourSelf.text = WorldBossManager.Instance.bossInfo.myPlayerVO.myDamage.toString();
         }
         if(_selfHonor)
         {
            _selfHonor.text = WorldBossManager.Instance.bossInfo.myPlayerVO.myHonor.toString();
         }
      }
      
      public function setTimeCount(num:int) : void
      {
         _totalInfo_time.text = setFormat(int(num / 3600)) + ":" + setFormat(int(num / 60 % 60)) + ":" + setFormat(int(num % 60));
      }
      
      public function updataRanking(arr:Array) : void
      {
         var i:int = 0;
         var personInfo:* = null;
         for(i = 0; i < arr.length; )
         {
            personInfo = arr[i] as RankingPersonInfo;
            _txtArr[i].text = i + 1 + "." + personInfo.name;
            _txtArr[i + 10].text = personInfo.damage + "(" + personInfo.getPercentage(WorldBossManager.Instance.bossInfo.total_Blood) + ")";
            i++;
         }
      }
      
      private function testshowRanking() : void
      {
         var i:int = 0;
         for(i = 0; i < 10; )
         {
            _txtArr[i].text = i + 1 + ".哈王00" + i;
            _txtArr[i + 10].text = (9 - i) * 3 * 10000 + "(2.152%)";
            i++;
         }
      }
      
      public function restTimeInfo() : void
      {
         _totalInfo_time.text = "00:00:00";
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
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            this.parent.removeChild(this);
         }
         removeEvent();
         _totalInfoBg = null;
         _totalInfo_time = null;
         _totalInfo_yourSelf = null;
         _totalInfoBg = null;
         _totalInfoBg = null;
         _show_totalInfoBtn = null;
         _show_totalInfoBtnIMG = null;
         _selfHonorText = null;
         _selfHonor = null;
         _txtArr = null;
      }
   }
}
