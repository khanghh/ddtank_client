package consortion.view.boss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import consortion.data.ConsortiaBossDataVo;
   import consortion.guard.ConsortiaGuardControl;
   import consortion.guard.ConsortiaGuardEvent;
   import ddt.manager.ConsortiaDutyManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import road7th.data.DictionaryData;
   
   public class ConsortiaGuardBossView extends Sprite implements Disposeable
   {
       
      
      private var _frame:ConsortiaBossFrame;
      
      private var _enterGuardSceneBtn:SimpleBitmapButton;
      
      private var _openGuardBossBtn:SimpleBitmapButton;
      
      private var _helpBtn:SimpleBitmapButton;
      
      public function ConsortiaGuardBossView(param1:ConsortiaBossFrame)
      {
         super();
         _frame = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _enterGuardSceneBtn = ComponentFactory.Instance.creatComponentByStylename("consortionBossFrame.enterBtn");
         addChild(_enterGuardSceneBtn);
         _openGuardBossBtn = ComponentFactory.Instance.creatComponentByStylename("consortionBossFrame.openFightBtn");
         addChild(_openGuardBossBtn);
         _helpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"core.helpButtonSmall","consort.bossFrame.helpPos",LanguageMgr.GetTranslation("ddt.consortia.bossFrame.helpTitle"),"asset.consortionBossFrame.guardHelpContentTxt",406,483) as SimpleBitmapButton;
         update();
      }
      
      private function update() : void
      {
         if(_frame.levelView)
         {
            _enterGuardSceneBtn.enable = false;
            _openGuardBossBtn.enable = false;
            if(ConsortiaGuardControl.Instance.model.isOpen)
            {
               _frame.levelView.selectedLevel = ConsortiaGuardControl.Instance.model.openLevel;
               _frame.levelView.mouseChildren = false;
               _frame.levelView.mouseEnabled = false;
               if(ConsortiaGuardControl.Instance.model.isOpen)
               {
                  _enterGuardSceneBtn.enable = true;
               }
            }
            else
            {
               _frame.levelView.mouseChildren = true;
               _frame.levelView.mouseEnabled = true;
               if(ConsortiaDutyManager.GetRight(PlayerManager.Instance.Self.Right,512))
               {
                  _openGuardBossBtn.enable = true;
               }
            }
         }
         updateRank();
      }
      
      private function updateRank() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(_frame.cellList == null || _frame.currentPage != 1)
         {
            return;
         }
         var _loc1_:DictionaryData = ConsortiaGuardControl.Instance.model.rankList;
         _loc3_ = 0;
         while(_loc3_ < 11)
         {
            _loc2_ = _loc1_[_loc3_] as ConsortiaBossDataVo;
            if(_loc2_)
            {
               _frame.cellList[_loc3_].info = _loc2_;
               _frame.cellList[_loc3_].visible = true;
            }
            else
            {
               _frame.cellList[_loc3_].visible = false;
            }
            _loc3_++;
         }
      }
      
      private function __onClickEnterGuard(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(ConsortiaGuardControl.Instance.model.isOpen)
         {
            ConsortiaGuardControl.Instance.enterGuradScene();
         }
      }
      
      private function __onOpenGurad(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:int = ServerConfigManager.instance.consortiaGuardOpenRiches * _frame.levelView.selectedLevel;
         var _loc3_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.consortiaGurad.openConfirmTxt",_loc2_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1);
         _loc3_.moveEnable = false;
         _loc3_.addEventListener("response",__confirmOpenGuard,false,0,true);
      }
      
      private function __confirmOpenGuard(param1:FrameEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         var _loc3_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc3_.removeEventListener("response",__confirmOpenGuard);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _loc2_ = ServerConfigManager.instance.consortiaGuardOpenRiches * _frame.levelView.selectedLevel;
            if(PlayerManager.Instance.Self.consortiaInfo.Riches < _loc2_)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.consortia.bossFrame.unenoughRiches"));
               return;
            }
            SocketManager.Instance.out.sendConsortiaGuradOpenGuard(_frame.levelView.selectedLevel);
         }
      }
      
      public function show() : void
      {
         this.visible = true;
         ConsortiaGuardControl.Instance.addEventListener("updateActivity",__onUpdateActivity);
         ConsortiaGuardControl.Instance.addEventListener("updateRank",__onUpdateRank);
         update();
         SocketManager.Instance.out.sendConsortiaGuradRank();
      }
      
      public function hied() : void
      {
         this.visible = false;
         ConsortiaGuardControl.Instance.removeEventListener("updateActivity",__onUpdateActivity);
         ConsortiaGuardControl.Instance.removeEventListener("updateRank",__onUpdateRank);
      }
      
      private function __onUpdateActivity(param1:ConsortiaGuardEvent) : void
      {
         if(ConsortiaGuardControl.Instance.model.isOpen)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.consortiaGurad.activityOpen"));
         }
         update();
      }
      
      private function __onUpdateRank(param1:ConsortiaGuardEvent) : void
      {
         updateRank();
      }
      
      private function initEvent() : void
      {
         _enterGuardSceneBtn.addEventListener("click",__onClickEnterGuard);
         _openGuardBossBtn.addEventListener("click",__onOpenGurad);
      }
      
      private function removeEvent() : void
      {
         _enterGuardSceneBtn.removeEventListener("click",__onClickEnterGuard);
         _openGuardBossBtn.removeEventListener("click",__onOpenGurad);
         ConsortiaGuardControl.Instance.removeEventListener("updateActivity",__onUpdateActivity);
         ConsortiaGuardControl.Instance.removeEventListener("updateRank",__onUpdateRank);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
         _enterGuardSceneBtn = null;
         _openGuardBossBtn = null;
         _frame = null;
      }
   }
}
