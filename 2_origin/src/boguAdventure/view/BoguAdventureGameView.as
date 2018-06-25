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
      
      public function BoguAdventureGameView(control:BoguAdventureControl)
      {
         super();
         _control = control;
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
      
      private function __onAllEvent(e:BoguAdventureEvent) : void
      {
         var _loc2_:* = e.eventType;
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
                     playActionComplete(e.data);
                  }
               }
               else
               {
                  updateCell(e.data["index"],e.data["type"],e.data["result"],true);
               }
            }
            else
            {
               SocketManager.Instance.out.sendBoguAdventureWalkInfo(4,_control.currentIndex);
            }
         }
         else
         {
            _changeView.boguWalk(e.data as Array);
         }
      }
      
      private function updateCell(index:int, type:int, result:int, playAction:Boolean = false) : void
      {
         var cell:BoguAdventureCell = _map.getCellByIndex(index);
         cell.info.result = result;
         switch(int(type) - 1)
         {
            case 0:
               cell.info.state = 1;
               _changeView.placeGoods("sign",cell.info.index,_map.getCellPosIndex(cell.info.index,_control.signFocus));
               break;
            case 1:
               cell.info.state = 3;
               _changeView.celarGoods(cell.info.index);
               break;
            case 2:
               if(cell.info.state != 2)
               {
                  cell.info.state = 2;
                  _changeView.celarGoods(index);
                  _map.playFineMineAction(index);
               }
               break;
            case 3:
               openCell(cell,playAction);
         }
      }
      
      private function openCell(cell:BoguAdventureCell, playAction:Boolean) : void
      {
         if(cell.info.result == -1)
         {
            _changeView.placeGoods("mine",cell.info.index,_map.getCellPosIndex(cell.info.index,_control.mineFocus));
            if(playAction)
            {
               _changeView.playExplodAciton();
            }
         }
         else if(playAction)
         {
            _changeView.playWarnAction(cell.info.aroundMineCount,_map.getCellPosIndex(cell.info.index,_control.mineNumFocus));
            if(cell.info.state != 2 && cell.info.result != -2)
            {
               _changeView.playAwardAction(cell.info.result);
               cell.changeCellBg();
            }
            else
            {
               _map.mouseClickOpen();
               _control.isMove = false;
            }
         }
         else
         {
            cell.changeCellBg();
         }
         cell.info.state = 2;
         cell.open();
         updateOpenCount();
      }
      
      private function updateMap() : void
      {
         var type:int = 0;
         _changeView.clearChangeView();
         _changeView.clearWarnAction();
         if(_control.model.mapInfoList != null)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _control.model.mapInfoList;
            for each(var info in _control.model.mapInfoList)
            {
               _map.getCellByIndex(info.index).info = info;
               type = 0;
               if(info.state == 2)
               {
                  type = 4;
               }
               else if(info.state == 1)
               {
                  type = 1;
               }
               if(type != 0)
               {
                  updateCell(info.index,type,info.result);
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
      
      private function __onReviveClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.reviveText",_control.model.revivePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
         alert.addEventListener("response",__onReviveAffirmRevive);
      }
      
      private function __onReviveAffirmRevive(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         if(e.responseCode == 3 || e.responseCode == 2)
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
               CheckMoneyUtils.instance.checkMoney(alert.isBand,_control.model.revivePrice,onCheckReviveComplete);
            }
         }
         alert.removeEventListener("response",__onReviveAffirmRevive);
         alert.dispose();
      }
      
      protected function onCheckReviveComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureUpdateGame(1,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onAwardClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         clearEffect();
         var frame:BoguAdventureAwardFrame = ComponentFactory.Instance.creatCustomObject("boguAdventure.awardFrame");
         frame.control = _control;
         frame.show();
      }
      
      private function __onResetClick(e:MouseEvent) : void
      {
         var alert:* = null;
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
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetText"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert.addEventListener("response",__onResetTip);
         }
         else if(_control.model.isFreeReset)
         {
            SocketManager.Instance.out.sendBoguAdventureUpdateGame(2);
         }
         else
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetAffirmText",_control.model.resetPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            alert.addEventListener("response",__onResetAffirmRevive);
         }
      }
      
      private function __onResetTip(e:FrameEvent) : void
      {
         var alert:* = null;
         SoundManager.instance.playButtonSound();
         e.currentTarget.removeEventListener("response",__onResetTip);
         ObjectUtils.disposeObject(e.currentTarget);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(_control.model.isFreeReset)
            {
               SocketManager.Instance.out.sendBoguAdventureUpdateGame(2);
            }
            else
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.resetAffirmText",_control.model.resetPrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
               alert.addEventListener("response",__onResetAffirmRevive);
            }
         }
      }
      
      private function __onResetAffirmRevive(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         if(e.responseCode == 3 || e.responseCode == 2)
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
               CheckMoneyUtils.instance.checkMoney(alert.isBand,_control.model.resetPrice,onCheckResetComplete);
            }
         }
         alert.removeEventListener("response",__onResetAffirmRevive);
         alert.dispose();
      }
      
      protected function onCheckResetComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureUpdateGame(2,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onFindMineClick(e:MouseEvent) : void
      {
         var alert:* = null;
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
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.findMineText",_control.model.findMinePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            alert.addEventListener("response",__onFindAffirmRevive);
         }
      }
      
      private function __onFindAffirmRevive(e:FrameEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               alert.removeEventListener("response",__onFindAffirmRevive);
               alert.dispose();
               return;
            }
            CheckMoneyUtils.instance.checkMoney(alert.isBand,_control.model.findMinePrice,onCheckComplete);
         }
         alert.removeEventListener("response",__onFindAffirmRevive);
         alert.dispose();
      }
      
      protected function onCheckComplete() : void
      {
         SocketManager.Instance.out.sendBoguAdventureWalkInfo(3,0,CheckMoneyUtils.instance.isBind);
      }
      
      private function __onSignClick(e:MouseEvent) : void
      {
         if(!_control.checkGameOver())
         {
            SoundManager.instance.playButtonSound();
            if(!_control.changeMouse)
            {
               changeMouseStyle(true);
               e.stopImmediatePropagation();
               StageReferance.stage.addEventListener("click",__onStageClick,true);
            }
         }
      }
      
      private function __onKeyDown(e:KeyboardEvent) : void
      {
         if(e.keyCode == KeyStroke.VK_F.getCode())
         {
            if(!_control.checkGameOver())
            {
               SoundManager.instance.playButtonSound();
               if(!_control.changeMouse)
               {
                  changeMouseStyle(true);
                  e.stopImmediatePropagation();
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
      
      private function __onStageClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         StageReferance.stage.removeEventListener("click",__onStageClick,true);
         if(_control.changeMouse)
         {
            if(e.target is BoguAdventureCell)
            {
               signCell(e.target as BoguAdventureCell);
            }
            changeMouseStyle(false);
            e.stopImmediatePropagation();
         }
      }
      
      private function changeMouseStyle(value:Boolean) : void
      {
         if(_control.changeMouse == value)
         {
            return;
         }
         _control.changeMouse = value;
         !!_control.changeMouse?Mouse.hide():Mouse.show();
         _mouseStyle.visible = _control.changeMouse;
      }
      
      private function signCell(value:BoguAdventureCell) : void
      {
         var cell:* = value;
         if(_control.currentIndex == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notStart"));
            return;
         }
         if(cell.info.state == 1)
         {
            SocketManager.Instance.out.sendBoguAdventureWalkInfo(2,cell.info.index);
            return;
         }
         if(cell.info.state == 2)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("boguAdventure.view.notSignOpenCell"));
            return;
         }
         SocketManager.Instance.out.sendBoguAdventureWalkInfo(1,cell.info.index);
      }
      
      private function updateHp() : void
      {
         var i:int = 0;
         var alert:* = null;
         ObjectUtils.disposeAllChildren(_hpBox);
         if(_control.hp > 0)
         {
            for(i = 0; i < _control.hp; )
            {
               _hpBox.addChild(ComponentFactory.Instance.creat("boguAdventure.stateView.hp"));
               i++;
            }
         }
         if(_reviveBtn.enable && _control.hp > 0)
         {
            _changeView.boguState(true);
         }
         _reviveBtn.enable = _control.hp <= 0;
         if(_control.hp <= 0)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("boguAdventure.view.reviveText",_control.model.revivePrice),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",30,true,1);
            alert.addEventListener("response",__onReviveAffirmRevive);
         }
      }
      
      private function playActionComplete(data:Object) : void
      {
         var index:int = 0;
         var type:String = String(data["type"]);
         if(type == "actionexplode")
         {
            _changeView.boguState(_control.hp > 0);
         }
         else if(type == "actionfintmine")
         {
            index = data["index"];
            _map.getCellByIndex(index).open();
            _changeView.placeGoods("mine",index,_map.getCellPosIndex(index,_control.mineFocus));
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
         var shineData:Object = {};
         shineData["color"] = "gold";
         _arardBtnEffect = EffectManager.Instance.creatEffect(3,_awardBtn,shineData);
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
