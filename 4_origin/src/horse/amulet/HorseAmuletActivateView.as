package horse.amulet
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PkgEvent;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   
   public class HorseAmuletActivateView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _haveDustText:FilterFrameText;
      
      private var _havaDustNumText:FilterFrameText;
      
      private var _dustText:FilterFrameText;
      
      private var _needDustText:FilterFrameText;
      
      private var _extendTypeText:FilterFrameText;
      
      private var _newExtendTypeText:FilterFrameText;
      
      private var _propertyText:FilterFrameText;
      
      private var _newPropertyText:FilterFrameText;
      
      private var _helpText:FilterFrameText;
      
      private var _activateBtn:SimpleBitmapButton;
      
      private var _replaceBtn:BaseButton;
      
      private var _cancelBtn:BaseButton;
      
      private var _hBox:HBox;
      
      private var _activateText:ScaleFrameImage;
      
      private var _property:Bitmap;
      
      private var _minCount:NumberImage;
      
      private var _about:Bitmap;
      
      private var _maxCount:NumberImage;
      
      private var _activateCell:HorseAmuletActivateCell;
      
      private var _resultIcon:ScaleFrameImage;
      
      private var _currentTime:Number;
      
      public function HorseAmuletActivateView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.activateViewBg");
         addChild(_bg);
         _resultIcon = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.result");
         addChild(_resultIcon);
         _haveDustText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.dustText");
         PositionUtils.setPos(_haveDustText,"horseAmulet.activate.haveDustTextPos");
         _haveDustText.text = LanguageMgr.GetTranslation("tank.horseAmulet.haveStive");
         addChild(_haveDustText);
         _havaDustNumText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.needDustText");
         PositionUtils.setPos(_havaDustNumText,"horseAmulet.activate.havaDustNumTextPos");
         _havaDustNumText.text = PlayerManager.Instance.Self.stive.toString();
         addChild(_havaDustNumText);
         _dustText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.dustText");
         PositionUtils.setPos(_dustText,"horseAmulet.activate.dustTextPos");
         _dustText.text = LanguageMgr.GetTranslation("tank.horseAmulet.needStive");
         addChild(_dustText);
         _needDustText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.needDustText");
         PositionUtils.setPos(_needDustText,"horseAmulet.activate.needDustTextPos");
         addChild(_needDustText);
         _extendTypeText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.propertyTitleText");
         PositionUtils.setPos(_extendTypeText,"horseAmulet.activate.extendTypeTextPos");
         addChild(_extendTypeText);
         _newExtendTypeText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.propertyTitleText");
         PositionUtils.setPos(_newExtendTypeText,"horseAmulet.activate.newExtendTypeTextPos");
         addChild(_newExtendTypeText);
         _propertyText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.propertyText");
         PositionUtils.setPos(_propertyText,"horseAmulet.activate.criticalTextPos");
         addChild(_propertyText);
         _newPropertyText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.propertyText");
         PositionUtils.setPos(_newPropertyText,"horseAmulet.activate.newCriticalTextPos");
         addChild(_newPropertyText);
         _helpText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.helpText");
         _helpText.text = LanguageMgr.GetTranslation("tank.horseAmulet.helpText");
         addChild(_helpText);
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.activateBtn");
         addChild(_activateBtn);
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.replaceBtn");
         addChild(_replaceBtn);
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.cancelBtn");
         addChild(_cancelBtn);
         _hBox = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.hBox");
         _activateText = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.activate.text");
         _property = ComponentFactory.Instance.creatBitmap("asset.horseAmulet.activate.property");
         _minCount = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.num");
         _about = ComponentFactory.Instance.creatBitmap("horseAmulet.activate.about");
         _maxCount = ComponentFactory.Instance.creatComponentByStylename("horseAmulet.num");
         _hBox.addChild(_activateText);
         _hBox.addChild(_property);
         _hBox.addChild(_minCount);
         _hBox.addChild(_about);
         _hBox.addChild(_maxCount);
         addChild(_hBox);
         _activateCell = new HorseAmuletActivateCell();
         PositionUtils.setPos(_activateCell,"horseAmulet.activate.activateCellPos");
         addChild(_activateCell);
         __onChangeCell(null);
         updateSatate(false);
      }
      
      private function initEvent() : void
      {
         _activateBtn.addEventListener("click",__onClickActivate);
         _replaceBtn.addEventListener("click",__onClickReplace);
         _cancelBtn.addEventListener("click",__onClickCancel);
         _activateCell.addEventListener("change",__onChangeCell);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,1),__onUpdateActivate);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,7),__onReplaceComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,2),__onSmashComplete);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function removeEvent() : void
      {
         _activateBtn.removeEventListener("click",__onClickActivate);
         _replaceBtn.removeEventListener("click",__onClickReplace);
         _cancelBtn.removeEventListener("click",__onClickCancel);
         _activateCell.removeEventListener("change",__onChangeCell);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,1),__onUpdateActivate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,7),__onReplaceComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,2),__onSmashComplete);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      private function updateSatate(isActivate:Boolean) : void
      {
         HorseAmuletManager.instance.isActivate = isActivate;
         _activateBtn.visible = !isActivate;
         var _loc2_:* = isActivate;
         _cancelBtn.visible = _loc2_;
         _replaceBtn.visible = _loc2_;
      }
      
      private function __propertyChange(evt:PlayerPropertyEvent) : void
      {
         if(evt.changedProperties["stive"])
         {
            _havaDustNumText.text = PlayerManager.Instance.Self.stive.toString();
         }
      }
      
      private function __onChangeCell(e:Event = null) : void
      {
         var amuletVo:* = null;
         _resultIcon.visible = false;
         if(_activateCell.info)
         {
            amuletVo = HorseAmuletManager.instance.getHorseAmuletVo(_activateCell.info.TemplateID);
            _activateText.setFrame(amuletVo.Quality);
            _minCount.count = amuletVo.ExtendType1MinValue;
            _maxCount.count = amuletVo.ExtendType1MaxValue;
            _hBox.arrange();
            _hBox.visible = true;
            _needDustText.text = amuletVo.Consume.toString();
            if(amuletVo.ExtendType1 > 0)
            {
               var _loc3_:* = HorseAmuletManager.instance.getByExtendType(amuletVo.ExtendType1);
               _extendTypeText.text = _loc3_;
               _newExtendTypeText.text = _loc3_;
            }
            _propertyText.text = _activateCell.itemInfo.Hole1.toString();
            _newPropertyText.text = "0";
         }
         else
         {
            _hBox.visible = false;
            _needDustText.text = "0";
            _propertyText.text = "0";
            _newPropertyText.text = "0";
            _extendTypeText.text = "";
            _newExtendTypeText.text = "";
         }
         updateSatate(false);
      }
      
      private function __onUpdateActivate(e:PkgEvent) : void
      {
         var property:int = e.pkg.readInt();
         var stive:int = e.pkg.readInt();
         PlayerManager.Instance.Self.stive = stive;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateComplete"));
         if(property < int(_propertyText.text))
         {
            _resultIcon.setFrame(2);
         }
         else
         {
            _resultIcon.setFrame(1);
         }
         _newPropertyText.text = property.toString();
         _resultIcon.visible = true;
         updateSatate(true);
      }
      
      private function __onReplaceComplete(e:PkgEvent) : void
      {
         var isSuccess:Boolean = e.pkg.readBoolean();
         if(isSuccess)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.replaceComplete"));
            if(int(_newPropertyText.text) > 0)
            {
               _propertyText.text = _newPropertyText.text;
            }
            _activateCell.itemInfo.Hole1 = int(_propertyText.text);
         }
         _newPropertyText.text = "0";
         _resultIcon.visible = false;
         updateSatate(false);
      }
      
      private function __onSmashComplete(e:PkgEvent) : void
      {
         var stive:int = e.pkg.readInt();
         PlayerManager.Instance.Self.stive = stive;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashCompleteTips"));
      }
      
      private function __onClickActivate(e:MouseEvent) : void
      {
         var alertFrame:* = null;
         SoundManager.instance.playButtonSound();
         if(getTimer() - _currentTime < 1500)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_activateCell.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activate.notAmulet"));
            return;
         }
         var vo:HorseAmuletVo = HorseAmuletManager.instance.getHorseAmuletVo(_activateCell.itemInfo.TemplateID);
         if(!vo.IsCanWash)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
            return;
         }
         if(PlayerManager.Instance.Self.stive < vo.Consume)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.stiveTips"));
            return;
         }
         if(HorseAmuletManager.instance.activateAlertFrameShow)
         {
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.activateConfirm",vo.Consume),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            alertFrame.addEventListener("response",__onAlertFrame);
            alertFrame.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            alertFrame.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
         }
         else
         {
            SocketManager.Instance.out.sendAmuletActivate(_activateCell.place);
         }
      }
      
      protected function __onSelectCheckClick(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var btn:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         HorseAmuletManager.instance.activateAlertFrameShow = !btn.selected;
      }
      
      private function __onAlertFrame(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertFrame);
         alertFrame.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendAmuletActivate(_activateCell.place);
         }
         alertFrame.dispose();
      }
      
      private function __onClickReplace(e:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(getTimer() - _currentTime < 1500)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_activateCell.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activate.notAmulet"));
            return;
         }
         if(int(_newPropertyText.text) <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activate.notReplace"));
            return;
         }
         SocketManager.Instance.out.sendAmuletActivateReplace(true);
      }
      
      private function __onClickCancel(e:MouseEvent) : void
      {
         if(getTimer() - _currentTime < 1500)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("carnival.clickTip"));
            return;
         }
         _currentTime = getTimer();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(_activateCell.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activate.notAmulet"));
            return;
         }
         SocketManager.Instance.out.sendAmuletActivateReplace(false);
      }
      
      public function dispose() : void
      {
         SocketManager.Instance.out.sendAmuletActivateReplace(false);
         HorseAmuletManager.instance.isActivate = false;
         removeEvent();
         ObjectUtils.disposeObject(_hBox);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _resultIcon = null;
         _dustText = null;
         _needDustText = null;
         _propertyText = null;
         _newPropertyText = null;
         _helpText = null;
         _replaceBtn = null;
         _cancelBtn = null;
         _activateText = null;
         _minCount = null;
         _maxCount = null;
         _about = null;
         _property = null;
         _extendTypeText = null;
         _newExtendTypeText = null;
         _hBox = null;
         _activateCell = null;
      }
   }
}
