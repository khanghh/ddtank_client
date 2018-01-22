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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 20)
         {
            if(_loc2_ < 3)
            {
               _loc1_ = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.No" + (_loc2_ + 1));
            }
            else if(_loc2_ < 10)
            {
               _loc1_ = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.NoOtherLeft");
            }
            else if(_loc2_ < 13)
            {
               _loc1_ = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.No" + (_loc2_ + 1));
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat("worldBossRoom.rankingTxt.NoOtherRight");
            }
            _loc1_.y = _loc1_.y + int(_loc2_ % 10) * 24;
            addChild(_loc1_);
            _txtArr.push(_loc1_);
            _loc2_++;
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
      
      protected function __onUpdata(param1:Event) : void
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
      
      public function setTimeCount(param1:int) : void
      {
         _totalInfo_time.text = setFormat(int(param1 / 3600)) + ":" + setFormat(int(param1 / 60 % 60)) + ":" + setFormat(int(param1 % 60));
      }
      
      public function updataRanking(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_] as RankingPersonInfo;
            _txtArr[_loc3_].text = _loc3_ + 1 + "." + _loc2_.name;
            _txtArr[_loc3_ + 10].text = _loc2_.damage + "(" + _loc2_.getPercentage(WorldBossManager.Instance.bossInfo.total_Blood) + ")";
            _loc3_++;
         }
      }
      
      private function testshowRanking() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _txtArr[_loc1_].text = _loc1_ + 1 + ".哈王00" + _loc1_;
            _txtArr[_loc1_ + 10].text = (9 - _loc1_) * 3 * 10000 + "(2.152%)";
            _loc1_++;
         }
      }
      
      public function restTimeInfo() : void
      {
         _totalInfo_time.text = "00:00:00";
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
