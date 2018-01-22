package boguAdventure.view
{
   import baglocked.BaglockedManager;
   import boguAdventure.BoguAdventureControl;
   import boguAdventure.cell.BoguAdventureCell;
   import boguAdventure.event.BoguAdventureEvent;
   import boguAdventure.model.BoguAdventureCellInfo;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Mouse;
   import org.aswing.KeyStroke;
   import org.aswing.KeyboardManager;
   
   public class BoguAdventureGameView extends Sprite
   {
       
      
      private var _reviveBtn:SimpleBitmapButton;
      
      private var _awardBtn:SimpleBitmapButton;
      
      private var _arardBtnEffect:IEffect;
      
      private var _resetBtn:SimpleBitmapButton;
      
      private var _freeResetBtn:SimpleBitmapButton;
      
      private var _signBtn:SimpleBitmapButton;
      
      private var _findMineBtn:SimpleBitmapButton;
      
      private var _helpView:BoguAdventureHelpFrame;
      
      private var _mouseStyle:Bitmap;
      
      private var _control:BoguAdventureControl;
      
      private var _map:BoguAdventureMap;
      
      private var _changeView:BoguAdventureChangeView;
      
      private var _hpBox:HBox;
      
      private var _openCountBg:Bitmap;
      
      private var _openCountText:FilterFrameText;
      
      private var _limitResetText:FilterFrameText;
      
      private var _resetNumText:FilterFrameText;
      
      public function BoguAdventureGameView(param1:BoguAdventureControl)
      {
         super();
         _control = param1;
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _map = new BoguAdventureMap(_control);
         PositionUtils.setPos(_map,"boguAdventure.view.mapContainerPos");
         _map.mouseClickClose();
         addChild(_map);
         _changeView = new BoguAdventureChangeView(_control);
         addChild(_changeView);
         _reviveBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolRevive",this);
         _reviveBtn.tipData = LanguageMgr.GetTranslation("boguAdventure.view.reviveBtnTip");
         _reviveBtn.enable = false;
         _awardBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolGetAwardBtn",this);
         _resetBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolReset",this);
         _resetBtn.tipData = LanguageMgr.GetTranslation("boguAdventure.view.resetBtnTip");
         _freeResetBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolFreeReset",this);
         _freeResetBtn.tipData = LanguageMgr.GetTranslation("boguAdventure.view.resetBtnTip");
         _signBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolSign",this);
         _signBtn.tipData = LanguageMgr.GetTranslation("boguAdventure.view.signBtnTip");
         _findMineBtn = UICreatShortcut.creatAndAdd("boguAdventure.toolFindMine",this);
         _findMineBtn.tipData = LanguageMgr.GetTranslation("boguAdventure.view.findMineBtnTip");
         _helpView = UICreatShortcut.creatAndAdd("boguAdventure.view.helpFrame",this);
         _mouseStyle = UICreatShortcut.creatAndAdd("boguAdventure.view.mouseStyle",this);
         _mouseStyle.visible = false;
         _hpBox = UICreatShortcut.creatAndAdd("boguAdventure.view.hpBox",this);
         _openCountBg = UICreatShortcut.creatAndAdd("boguAdventure.stateView.openCountBg",this);
         _openCountText = UICreatShortcut.creatAndAdd("boguAdventure.view.openCountText",this);
         _limitResetText = UICreatShortcut.creatTextAndAdd("boguAdventure.view.limitResetText",LanguageMgr.GetTranslation("boguAdventure.view.limitRevive"),this);
         _resetNumText = UICreatShortcut.creatAndAdd("boguAdventure.view.openCountText",this);
         PositionUtils.setPos(_resetNumText,"boguAdventure.view.resetNumPos");
      }
      
      public function updateView() : void
      {
         if(_control.changeMouse)
         {
            _mouseStyle.x = stage.mouseX - _mouseStyle.width / 2;
            _mouseStyle.y = stage.mouseY - _mouseStyle.height / 2;
         }
         _changeView.update();
      }
      
      private function __onAllEvent(param1:BoguAdventureEvent) : void
      {
         var _loc2_:* = param1.eventType;
         if("boguadventureeventwalk" !== _loc2_)
         {
            if("boguadventureeventstop" !== _loc2_)
            {
               if("boguadventureeventupdatecell" !== _loc2_)
               {
                  if("boguadventureeventactioncomplete" !== _loc2_)
                  {
                     if("boguadventureeventchangehp" !== _loc2_)
                     {
                        if("boguadventureeventupdatemap" !== _loc2_)
                        {
                           if("boguadventureeventupdatereset" === _loc2_)
                           {
                              updateReset();
                           }
                        }
                        else
                        {
                           updateMap();
                        }
                     }
                     else
                     {
                        updateHp();
                     }
                  }
                  else
                  {
                     playActionComplete(param1.data);
                  }
               }
               else
               {
                  updateCell(param1.data["index"],param1.data["type"],param1.data["result"],true);
               }
            }
            else
            {
               SocketManager.Instance.out.sendBoguAdventureWalkInfo(4,_control.currentIndex);
            }
         }
         else
         {
            _changeView.boguWalk(param1.data as Array);
         }
      }
      
      private function updateCell(param1:int, param2:int, param3:int, param4:Boolean = false) : void
      {
         var _loc5_:BoguAdventureCell = _map.getCellByIndex(param1);
         _loc5_.info.result = param3;
         switch(int(param2) - 1)
         {
            case 0:
               _loc5_.info.state = 1;
               _changeView.placeGoods("sign",_loc5_.info.index,_map.getCellPosIndex(_loc5_.info.index,_control.signFocus));
               break;
            case 1:
               _loc5_.info.state = 3;
               _changeView.celarGoods(_loc5_.info.index);
               break;
            case 2:
               if(_loc5_.info.state != 2)
               {
                  _loc5_.info.state = 2;
                  _changeView.celarGoods(param1);
                  _map.playFineMineAction(param1);
               }
               break;
            case 3:
               openCell(_loc5_,param4);
         }
      }
      
      private function openCell(param1:BoguAdventureCell, param2:Boolean) : void
      {
         if(param1.info.result == -1)
         {
            _changeView.placeGoods("mine",param1.info.index,_map.getCellPosIndex(param1.info.index,_control.mineFocus));
            if(param2)
            {
               _changeView.playExplodAciton();
            }
         }
         else if(param2)
         {
            _changeView.playWarnAction(param1.info.aroundMineCount,_map.getCellPosIndex(param1.info.index,_control.mineNumFocus));
            if(param1.info.state != 2 && param1.info.result != -2)
            {
               _changeView.playAwardAction(param1.info.result);
               param1.changeCellBg();
            }
            else
            {
               _map.mouseClickOpen();
               _control.isMove = false;
            }
         }
         else
         {
            param1.changeCellBg();
         }
         param1.info.state = 2;
         param1.open();
         updateOpenCount();
      }
      
      private function updateMap() : void
      {
         var _loc1_:int = 0;
         _changeView.clearChangeView();
         _changeView.clearWarnAction();
         if(_control.model.mapInfoList != null)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _control.model.mapInfoList;
            for each(var _loc2_ in _control.model.mapInfoList)
            {
               _map.getCellByIndex(_loc2_.index).info = _loc2_;
               _loc1_ = 0;
               if(_loc2_.state == 2)
               {
                  _loc1_ = 4;
               }
               else if(_loc2_.state == 1)
               {
                  _loc1_ = 1;
               }
               if(_loc1_ != 0)
               {
                  updateCell(_loc2_.index,_loc1_,_loc2_.result);
               }
            }
         }
         _changeView.resetBogu(_map.getCellPosIndex(_control.currentIndex,_control.bogu.focusPos));
         if(_control.currentIndex && _map.getCellByIndex(_control.currentIndex).info.result != -1)
         {
            _changeView.playWarnAction(_map.getCellByIndex(_control.currentIndex).info.aroundMineCount,_map.getCellPosIndex(_control.currentIndex,_control.mineNumFocus));
         }
         updateHp();
         _changeView.boguState(_control.hp > 0);
         updateOpenCount();
         _map.mouseClickOpen();
         updateReset();
         _control.isMove = false;
      }
      
      private function updateReset() : void
      {
         _resetBtn.visible = !_control.model.isFreeReset;
         _limitResetText.visible = !_control.model.isFreeReset;
         _resetNumText.visible = !_control.model.isFreeReset;
         _freeResetBtn.visible = _control.model.isFreeReset;
         _resetNumText.text = _control.model.resetCount.toString();
      }
      
      private function __onReviveClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.reviveText",_control.model.revivePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
         _loc2_.addEventListener("response",__onReviveAffirmRevive);
      }
      
      private function __onReviveAffirmRevive(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
            }
            else if(_control.model.isAcquireAward1 && _control.model.isAcquireAward2 && _control.model.isAcquireAward3)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.acquireAward"));
            }
            else
            {
               CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_control.model.revivePrice,onCheckReviveComplete);
            }
         }
         _loc2_.removeEventListener("response",__onReviveAffirmRevive);
         _loc2_.dispose();
      }
      
      protected function onCheckReviveComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureUpdateGame(1,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onAwardClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         clearEffect();
         var _loc2_:BoguAdventureAwardFrame = ComponentFactory.Instance.creatCustomObject("boguAdventure.awardFrame");
         _loc2_.control = _control;
         _loc2_.show();
      }
      
      private function __onResetClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(_control.currentIndex == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notReset"));
            return;
         }
         if(_control.model.resetCount == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.resetCountOver"));
            return;
         }
         if(_control.isMove)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.move"));
            return;
         }
         if(_control.checkGetAward())
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_.addEventListener("response",__onResetTip);
         }
         else if(_control.model.isFreeReset)
         {
            SocketManager.Instance.out.sendBoguAdventureUpdateGame(2);
         }
         else
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetAffirmText",_control.model.resetPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            _loc2_.addEventListener("response",__onResetAffirmRevive);
         }
      }
      
      private function __onResetTip(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         param1.currentTarget.removeEventListener("response",__onResetTip);
         ObjectUtils.disposeObject(param1.currentTarget);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(_control.model.isFreeReset)
            {
               SocketManager.Instance.out.sendBoguAdventureUpdateGame(2);
            }
            else
            {
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetAffirmText",_control.model.resetPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
               _loc2_.addEventListener("response",__onResetAffirmRevive);
            }
         }
      }
      
      private function __onResetAffirmRevive(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
            }
            else if(_control.model.resetCount <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notRevive"));
            }
            else
            {
               CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_control.model.resetPrice,onCheckResetComplete);
            }
         }
         _loc2_.removeEventListener("response",__onResetAffirmRevive);
         _loc2_.dispose();
      }
      
      protected function onCheckResetComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureUpdateGame(2,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onFindMineClick(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         SoundManager.instance.playButtonSound();
         if(!_control.checkGameOver())
         {
            if(_control.currentIndex == 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notStart"));
               return;
            }
            if(_map.getCellByIndex(_control.currentIndex).info.aroundMineCount <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notFineMine"));
               return;
            }
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.findMineText",_control.model.findMinePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            _loc2_.addEventListener("response",__onFindAffirmRevive);
         }
      }
      
      private function __onFindAffirmRevive(param1:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               _loc2_.removeEventListener("response",__onFindAffirmRevive);
               _loc2_.dispose();
               return;
            }
            CheckMoneyUtils.instance.checkMoney(_loc2_.isBand,_control.model.findMinePrice,onCheckComplete);
         }
         _loc2_.removeEventListener("response",__onFindAffirmRevive);
         _loc2_.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureWalkInfo(3,0,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onSignClick(param1:MouseEvent) : void
      {
         if(!_control.checkGameOver())
         {
            SoundManager.instance.playButtonSound();
            if(!_control.changeMouse)
            {
               changeMouseStyle(true);
               param1.stopImmediatePropagation();
               StageReferance.stage.addEventListener("click",__onStageClick,true);
            }
         }
      }
      
      private function __onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == KeyStroke.VK_F.getCode())
         {
            if(!_control.checkGameOver())
            {
               SoundManager.instance.playButtonSound();
               if(!_control.changeMouse)
               {
                  changeMouseStyle(true);
                  param1.stopImmediatePropagation();
                  StageReferance.stage.addEventListener("click",__onStageClick,true);
               }
               else
               {
                  changeMouseStyle(false);
                  StageReferance.stage.removeEventListener("click",__onStageClick,true);
               }
            }
         }
      }
      
      private function __onStageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StageReferance.stage.removeEventListener("click",__onStageClick,true);
         if(_control.changeMouse)
         {
            if(param1.target is BoguAdventureCell)
            {
               signCell(param1.target as BoguAdventureCell);
            }
            changeMouseStyle(false);
            param1.stopImmediatePropagation();
         }
      }
      
      private function changeMouseStyle(param1:Boolean) : void
      {
         if(_control.changeMouse == param1)
         {
            return;
         }
         _control.changeMouse = param1;
         !!_control.changeMouse?Mouse.hide():Mouse.show();
         _mouseStyle.visible = _control.changeMouse;
      }
      
      private function signCell(param1:BoguAdventureCell) : void
      {
         var _loc2_:* = param1;
         if(_control.currentIndex == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notStart"));
            return;
         }
         if(_loc2_.info.state == 1)
         {
            SocketManager.Instance.out.sendBoguAdventureWalkInfo(2,_loc2_.info.index);
            return;
         }
         if(_loc2_.info.state == 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notSignOpenCell"));
            return;
         }
         SocketManager.Instance.out.sendBoguAdventureWalkInfo(1,_loc2_.info.index);
      }
      
      private function updateHp() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         ObjectUtils.disposeAllChildren(_hpBox);
         if(_control.hp > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < _control.hp)
            {
               _hpBox.addChild(ComponentFactory.Instance.creat("boguAdventure.stateView.hp"));
               _loc2_++;
            }
         }
         if(_reviveBtn.enable && _control.hp > 0)
         {
            _changeView.boguState(true);
         }
         _reviveBtn.enable = _control.hp <= 0;
         if(_control.hp <= 0)
         {
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.reviveText",_control.model.revivePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            _loc1_.addEventListener("response",__onReviveAffirmRevive);
         }
      }
      
      private function playActionComplete(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = String(param1["type"]);
         if(_loc3_ == "actionexplode")
         {
            _changeView.boguState(_control.hp > 0);
         }
         else if(_loc3_ == "actionfintmine")
         {
            _loc2_ = param1["index"];
            _map.getCellByIndex(_loc2_).open();
            _changeView.placeGoods("mine",_loc2_,_map.getCellPosIndex(_loc2_,_control.mineFocus));
         }
         _map.mouseClickOpen();
         _control.isMove = false;
      }
      
      private function updateOpenCount() : void
      {
         _openCountText.text = _control.model.openCount.toString();
         if(_control.checkGetAward())
         {
            createEffect();
         }
         else
         {
            clearEffect();
         }
      }
      
      private function createEffect() : void
      {
         if(_arardBtnEffect)
         {
            return;
         }
         var _loc1_:Object = {};
         _loc1_["color"] = "gold";
         _arardBtnEffect = EffectManager.Instance.creatEffect(3,_awardBtn,_loc1_);
         _arardBtnEffect.play();
      }
      
      private function clearEffect() : void
      {
         if(_arardBtnEffect == null)
         {
            return;
         }
         _arardBtnEffect.stop();
         ObjectUtils.disposeObject(_arardBtnEffect);
         _arardBtnEffect = null;
      }
      
      private function initEvent() : void
      {
         KeyboardManager.getInstance().addEventListener("keyDown",__onKeyDown);
         _reviveBtn.addEventListener("click",__onReviveClick);
         _awardBtn.addEventListener("click",__onAwardClick);
         _resetBtn.addEventListener("click",__onResetClick);
         _freeResetBtn.addEventListener("click",__onResetClick);
         _signBtn.addEventListener("click",__onSignClick);
         _findMineBtn.addEventListener("click",__onFindMineClick);
         _control.addEventListener("boguadventureeventevent",__onAllEvent);
      }
      
      private function removeEvent() : void
      {
         KeyboardManager.getInstance().removeEventListener("keyDown",__onKeyDown);
         _reviveBtn.removeEventListener("click",__onReviveClick);
         _awardBtn.removeEventListener("click",__onAwardClick);
         _resetBtn.removeEventListener("click",__onResetClick);
         _freeResetBtn.removeEventListener("click",__onResetClick);
         _signBtn.removeEventListener("click",__onSignClick);
         _findMineBtn.removeEventListener("click",__onFindMineClick);
         _control.removeEventListener("boguadventureeventevent",__onAllEvent);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_changeView);
         _changeView = null;
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeObject(_reviveBtn);
         _reviveBtn = null;
         ObjectUtils.disposeObject(_awardBtn);
         _awardBtn = null;
         clearEffect();
         ObjectUtils.disposeObject(_resetBtn);
         _resetBtn = null;
         ObjectUtils.disposeObject(_freeResetBtn);
         _freeResetBtn = null;
         ObjectUtils.disposeObject(_signBtn);
         _signBtn = null;
         ObjectUtils.disposeObject(_findMineBtn);
         _findMineBtn = null;
         ObjectUtils.disposeObject(_helpView);
         _helpView = null;
         ObjectUtils.disposeObject(_mouseStyle);
         _mouseStyle = null;
         if(_hpBox)
         {
            ObjectUtils.disposeAllChildren(_hpBox);
            ObjectUtils.disposeObject(_hpBox);
         }
         _hpBox = null;
         ObjectUtils.disposeObject(_openCountBg);
         _openCountBg = null;
         ObjectUtils.disposeObject(_openCountText);
         _openCountText = null;
         ObjectUtils.disposeObject(_limitResetText);
         _limitResetText = null;
         ObjectUtils.disposeObject(_resetNumText);
         _resetNumText = null;
         _control = null;
         this.parent.removeChild(this);
      }
   }
}
