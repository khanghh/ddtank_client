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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _barUIList = new Vector.<ConsortiaGuardBossBar>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new ConsortiaGuardBossBar(_loc2_);
            _barUIList.push(_loc1_);
            PositionUtils.setPos(_loc1_,"consortiaGuard.bossUI.BarPos" + _loc2_);
            addChild(_loc1_);
            _loc2_++;
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
      
      protected function __onHideBossRank(param1:Event) : void
      {
         hideBossRank();
      }
      
      private function __onShowBossRank(param1:ConsortiaGuardEvent) : void
      {
         _currentType = int(param1.data) - 1;
         _bossRank.visible = true;
         this.addEventListener("click",removeBossRank);
         PositionUtils.setPos(_bossRank,"consortiaGuard.bossRankPos" + _currentType);
         _bossRank.uptaView();
         _barUIList[_currentType].isShowRank = true;
         ConsortiaGuardControl.Instance.bossRankShow = true;
      }
      
      protected function removeBossRank(param1:MouseEvent) : void
      {
         if(!(param1.target as ConsortiaGuardSubBossRank) && !(param1.target.parent as ConsortiaGuardSubBossRank) && !(param1.target.parent.parent as ConsortiaGuardSubBossRank))
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
      
      private function __onClickBuyBuff(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc4_:int = ServerConfigManager.instance.consortiaGuardBuyCost;
         var _loc3_:int = ServerConfigManager.instance.consortiaGuardBuyBuffMaxLevel;
         var _loc5_:int = ConsortiaGuardControl.Instance.model.buffLevel;
         if(_loc5_ >= _loc3_)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.buffExist"));
            return;
         }
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.consortiaGurad.buyBuff",_loc4_,_loc5_,_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         _loc2_.addEventListener("response",__onAlertFrame);
      }
      
      private function __onAlertFrame(param1:FrameEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertFrame);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            _loc3_ = ServerConfigManager.instance.consortiaGuardBuyCost;
            if(PlayerManager.Instance.Self.Riches < _loc3_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.buyBuffFail"));
            }
            else
            {
               SocketManager.Instance.out.sendConsortiaGuradBuyBuff(1);
            }
         }
         ObjectUtils.disposeObject(_loc2_);
      }
      
      private function __onUpdateGameState(param1:ConsortiaGuardEvent) : void
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
