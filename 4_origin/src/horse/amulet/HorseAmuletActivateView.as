package horse.amulet
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
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
      }
      
      private function initEvent() : void
      {
         _activateBtn.addEventListener("click",__onClickActivate);
         _activateCell.addEventListener("change",__onChangeCell);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,1),__onUpdateActivate);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,7),__onReplaceComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(375,2),__onSmashComplete);
         PlayerManager.Instance.Self.addEventListener("propertychange",__propertyChange);
      }
      
      private function removeEvent() : void
      {
         _activateBtn.removeEventListener("click",__onClickActivate);
         _activateCell.removeEventListener("change",__onChangeCell);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,1),__onUpdateActivate);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,7),__onReplaceComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(375,2),__onSmashComplete);
         PlayerManager.Instance.Self.removeEventListener("propertychange",__propertyChange);
      }
      
      private function __propertyChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["stive"])
         {
            _havaDustNumText.text = PlayerManager.Instance.Self.stive.toString();
         }
      }
      
      private function __onChangeCell(param1:Event = null) : void
      {
         var _loc2_:* = null;
         _resultIcon.visible = false;
         if(_activateCell.info)
         {
            _loc2_ = HorseAmuletManager.instance.getHorseAmuletVo(_activateCell.info.TemplateID);
            _activateText.setFrame(_loc2_.Quality);
            _minCount.count = _loc2_.ExtendType1MinValue;
            _maxCount.count = _loc2_.ExtendType1MaxValue;
            _hBox.arrange();
            _hBox.visible = true;
            _needDustText.text = _loc2_.Consume.toString();
            if(_loc2_.ExtendType1 > 0)
            {
               var _loc3_:* = HorseAmuletManager.instance.getByExtendType(_loc2_.ExtendType1);
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
      }
      
      private function __onUpdateActivate(param1:PkgEvent) : void
      {
         var _loc3_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.stive = _loc2_;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateComplete"));
         if(int(_newPropertyText.text) > 0)
         {
            _propertyText.text = _newPropertyText.text;
         }
         _newPropertyText.text = _loc3_.toString();
         if(_loc3_ < int(_propertyText.text))
         {
            _resultIcon.setFrame(2);
         }
         else
         {
            _resultIcon.setFrame(1);
         }
         _resultIcon.visible = true;
         _activateCell.tipData = _activateCell.info;
      }
      
      private function __onReplaceComplete(param1:PkgEvent) : void
      {
         _newPropertyText.text = "0";
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.replaceComplete"));
      }
      
      private function __onSmashComplete(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.stive = _loc2_;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.smashCompleteTips"));
      }
      
      private function __onClickActivate(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
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
         var _loc3_:HorseAmuletVo = HorseAmuletManager.instance.getHorseAmuletVo(_activateCell.itemInfo.TemplateID);
         if(!_loc3_.IsCanWash)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.activateFail"));
            return;
         }
         if(PlayerManager.Instance.Self.stive < _loc3_.Consume)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.horseAmulet.stiveTips"));
            return;
         }
         if(HorseAmuletManager.instance.activateAlertFrameShow)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.horseAmulet.activateConfirm",_loc3_.Consume),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _loc2_.addEventListener("response",__onAlertFrame);
            _loc2_.setIsShowTheLog(true,LanguageMgr.GetTranslation("notAlertAgain"));
            _loc2_.selectedCheckButton.addEventListener("click",__onSelectCheckClick);
         }
         else
         {
            SocketManager.Instance.out.sendAmuletActivate(_activateCell.place);
         }
      }
      
      protected function __onSelectCheckClick(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var _loc2_:SelectedCheckButton = param1.currentTarget as SelectedCheckButton;
         HorseAmuletManager.instance.activateAlertFrameShow = !_loc2_.selected;
      }
      
      private function __onAlertFrame(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertFrame);
         _loc2_.selectedCheckButton.removeEventListener("click",__onSelectCheckClick);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendAmuletActivate(_activateCell.place);
         }
         _loc2_.dispose();
      }
      
      private function __onClickReplace(param1:MouseEvent) : void
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
         SocketManager.Instance.out.sendAmuletActivateReplace(_activateCell.place);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _activateCell.clearCell();
         ObjectUtils.disposeObject(_hBox);
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _resultIcon = null;
         _dustText = null;
         _needDustText = null;
         _propertyText = null;
         _newPropertyText = null;
         _helpText = null;
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
