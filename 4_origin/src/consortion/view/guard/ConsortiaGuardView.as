package consortion.view.guard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import road7th.utils.MovieClipWrapper;
   
   public class ConsortiaGuardView extends Sprite implements Disposeable
   {
       
      
      private var _movie:MovieClipWrapper;
      
      private var _clickBuyBuff:SimpleBitmapButton;
      
      private var _bossRank:ConsortiaGuardSubBossRank;
      
      private var _barUIList:Vector.<ConsortiaGuardBossBar>;
      
      private var _currentType:int;
      
      public function ConsortiaGuardView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var barUI:* = null;
         _barUIList = new Vector.<ConsortiaGuardBossBar>();
         for(i = 0; i < 4; )
         {
            barUI = new ConsortiaGuardBossBar(i);
            _barUIList.push(barUI);
            PositionUtils.setPos(barUI,"consortiaGuard.bossUI.BarPos" + i);
            addChild(barUI);
            i++;
         }
         _clickBuyBuff = ComponentFactory.Instance.creatComponentByStylename("consortiaGurad.buyBuffBtn");
         _clickBuyBuff.addEventListener("click",__onClickBuyBuff);
         addChild(_clickBuyBuff);
         if(ConsortiaGuardControl.Instance.model.isFight)
         {
            ConsortiaGuardControl.Instance.addEventListener("updateGameState",__onUpdateGameState);
         }
         else
         {
            updateGame();
         }
         _bossRank = new ConsortiaGuardSubBossRank();
         addChild(_bossRank);
         _bossRank.visible = false;
         ConsortiaGuardControl.Instance.addEventListener("showBossRank",__onShowBossRank);
         ConsortiaGuardControl.Instance.addEventListener("hideBossRank",__onHideBossRank);
      }
      
      protected function __onHideBossRank(event:Event) : void
      {
         hideBossRank();
      }
      
      private function __onShowBossRank(e:ConsortiaGuardEvent) : void
      {
         _currentType = int(e.data) - 1;
         _bossRank.visible = true;
         this.addEventListener("click",removeBossRank);
         PositionUtils.setPos(_bossRank,"consortiaGuard.bossRankPos" + _currentType);
         _bossRank.uptaView();
         _barUIList[_currentType].isShowRank = true;
         ConsortiaGuardControl.Instance.bossRankShow = true;
      }
      
      protected function removeBossRank(event:MouseEvent) : void
      {
         if(!(event.target as ConsortiaGuardSubBossRank) && !(event.target.parent as ConsortiaGuardSubBossRank) && !(event.target.parent.parent as ConsortiaGuardSubBossRank))
         {
            hideBossRank();
            this.removeEventListener("click",removeBossRank);
         }
      }
      
      private function hideBossRank() : void
      {
         _bossRank.visible = false;
         _barUIList[_currentType].isShowRank = false;
         ConsortiaGuardControl.Instance.bossRankShow = false;
      }
      
      private function __onClickBuyBuff(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var count:int = ServerConfigManager.instance.consortiaGuardBuyCost;
         var maxLevel:int = ServerConfigManager.instance.consortiaGuardBuyBuffMaxLevel;
         var current:int = ConsortiaGuardControl.Instance.model.buffLevel;
         if(current >= maxLevel)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.buffExist"));
            return;
         }
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.consortiaGurad.buyBuff",count,current,maxLevel),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         alertFrame.addEventListener("response",__onAlertFrame);
      }
      
      private function __onAlertFrame(e:FrameEvent) : void
      {
         var count:int = 0;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertFrame);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            count = ServerConfigManager.instance.consortiaGuardBuyCost;
            if(PlayerManager.Instance.Self.Riches < count)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.buyBuffFail"));
            }
            else
            {
               SocketManager.Instance.out.sendConsortiaGuradBuyBuff(1);
            }
         }
         ObjectUtils.disposeObject(alertFrame);
      }
      
      private function __onUpdateGameState(e:ConsortiaGuardEvent) : void
      {
         ConsortiaGuardControl.Instance.removeEventListener("updateGameState",__onUpdateGameState);
         updateGame();
      }
      
      private function updateGame() : void
      {
         if(!ConsortiaGuardControl.Instance.model.isFight)
         {
            if(ConsortiaGuardControl.Instance.model.isWin)
            {
               _movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.consortiaGurad.win")),true);
               _movie.movie.x = 359;
               _movie.movie.y = 217;
            }
            else
            {
               _movie = new MovieClipWrapper(MovieClip(ClassUtils.CreatInstance("asset.consortiaGurad.fail")),true);
               _movie.movie.x = 438;
               _movie.movie.y = 244;
            }
            addChild(_movie.movie);
         }
      }
      
      public function dispose() : void
      {
         _clickBuyBuff.removeEventListener("click",__onClickBuyBuff);
         ConsortiaGuardControl.Instance.removeEventListener("showBossRank",__onShowBossRank);
         ConsortiaGuardControl.Instance.removeEventListener("updateGameState",__onUpdateGameState);
         ConsortiaGuardControl.Instance.removeEventListener("hideBossRank",__onHideBossRank);
         this.removeEventListener("click",removeBossRank);
         while(_barUIList.length)
         {
            ObjectUtils.disposeObject(_barUIList.pop());
         }
         if(_movie)
         {
            ObjectUtils.disposeObject(_movie);
         }
         _movie = null;
         if(_bossRank)
         {
            ObjectUtils.disposeObject(_bossRank);
         }
         _bossRank = null;
         ObjectUtils.disposeAllChildren(this);
         _clickBuyBuff = null;
      }
   }
}
