package bagAndInfo.amulet
{
   import bagAndInfo.amulet.vo.EquipAmuletPhaseVo;
   import bagAndInfo.amulet.vo.EquipAmuletVo;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class EquipAmuletActivateView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _gradeTips:Component;
      
      private var _phaseTips:Component;
      
      private var _phaseText:FilterFrameText;
      
      private var _phaseTipText:FilterFrameText;
      
      private var _gradeText:FilterFrameText;
      
      private var _gradeTipText:FilterFrameText;
      
      private var _powerText:FilterFrameText;
      
      private var _power:int;
      
      private var _powerArrow:ScaleFrameImage;
      
      private var _currentEffect:Vector.<EquipAmuletActivateItem>;
      
      private var _newEffect:Vector.<EquipAmuletActivateItem>;
      
      private var _getStiveBtn:SimpleBitmapButton;
      
      private var _consumeStiveText:FilterFrameText;
      
      private var _consumeMoneyText:FilterFrameText;
      
      private var _activateBtn:SimpleBitmapButton;
      
      private var _replaceBtn:SimpleBitmapButton;
      
      private var _info:InventoryItemInfo;
      
      private var _currentTime:Number;
      
      private var _moneyText:FilterFrameText;
      
      private var _moneyBg:ScaleBitmapImage;
      
      private var _moneyIcon:Bitmap;
      
      private var _bindMoneyText:FilterFrameText;
      
      private var _bindMoneyBg:ScaleBitmapImage;
      
      private var _bindMoneyIcon:Bitmap;
      
      private var _activateProperty:Array;
      
      public function EquipAmuletActivateView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         _info = PlayerManager.Instance.Self.Bag.items[18];
         _activateProperty = [];
         _bg = ComponentFactory.Instance.creatBitmap("asset.equipAmulet.activateView");
         addChild(_bg);
         _phaseTips = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.phaseTips");
         _phaseText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.phaseText");
         _phaseTips.addChild(_phaseText);
         addChild(_phaseTips);
         _phaseTipText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.phaseTipText");
         _phaseTipText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.phaseTip");
         addChild(_phaseTipText);
         _gradeTips = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateTips.gradeTips");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.gradeText");
         _gradeTips.addChild(_gradeText);
         addChild(_gradeTips);
         _gradeTipText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.gradeTipText");
         _gradeTipText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.gradeTip");
         addChild(_gradeTipText);
         _gradeTips.tipData = _info;
         _phaseTips.tipData = _info;
         _currentEffect = new Vector.<EquipAmuletActivateItem>();
         _newEffect = new Vector.<EquipAmuletActivateItem>();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = new EquipAmuletActivateItem();
            _loc2_.addEventListener("change",__onItemChange);
            PositionUtils.setPos(_loc2_,"equipAmulet.currentItemPos" + _loc3_);
            _currentEffect.push(_loc2_);
            addChild(_loc2_);
            _loc1_ = new EquipAmuletActivateItem(false);
            PositionUtils.setPos(_loc1_,"equipAmulet.newItemPos" + _loc3_);
            _newEffect.push(_loc1_);
            addChild(_loc1_);
            _loc3_++;
         }
         updateProperty();
         _powerText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.powerText");
         addChild(_powerText);
         _powerArrow = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.arrow");
         _powerArrow.setFrame(1);
         addChild(_powerArrow);
         var _loc4_:Boolean = false;
         _powerArrow.visible = _loc4_;
         _powerText.visible = _loc4_;
         _getStiveBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.getStiveBtn");
         addChild(_getStiveBtn);
         _consumeStiveText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.consumeText");
         PositionUtils.setPos(_consumeStiveText,"equipAmulet.consumeStiveTextPos");
         addChild(_consumeStiveText);
         _consumeMoneyText = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.consumeText");
         PositionUtils.setPos(_consumeMoneyText,"equipAmulet.consumeMoneyTextPos");
         addChild(_consumeMoneyText);
         _moneyBg = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBG");
         PositionUtils.setPos(_moneyBg,"equipAmulet.activate.moneyBgPos");
         addChild(_moneyBg);
         _moneyIcon = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.PointCoupon");
         PositionUtils.setPos(_moneyIcon,"equipAmulet.activate.moneyIconPos");
         addChild(_moneyIcon);
         _moneyText = ComponentFactory.Instance.creatComponentByStylename("BagMoneyInfoText");
         PositionUtils.setPos(_moneyText,"equipAmulet.activate.moneyTextPos");
         addChild(_moneyText);
         _bindMoneyBg = ComponentFactory.Instance.creatComponentByStylename("bagAndInfo.moneyViewBG");
         PositionUtils.setPos(_bindMoneyBg,"equipAmulet.activate.bindMoneyBgPos");
         addChild(_bindMoneyBg);
         _bindMoneyIcon = ComponentFactory.Instance.creatBitmap("bagAndInfo.info.xunzhang");
         PositionUtils.setPos(_bindMoneyIcon,"equipAmulet.activate.bindMoneyIconPos");
         addChild(_bindMoneyIcon);
         _bindMoneyText = ComponentFactory.Instance.creatComponentByStylename("BagGiftInfoText");
         PositionUtils.setPos(_bindMoneyText,"equipAmulet.activate.bindMoneyTextPos");
         addChild(_bindMoneyText);
         _activateBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.activateBtn");
         addChild(_activateBtn);
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("equipAmulet.replaceBtn");
         addChild(_replaceBtn);
         update();
      }
      
      private function __onItemChange(param1:Event) : void
      {
         var _loc3_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         EquipAmuletManager.Instance.lockNum = lockProperty.length;
         var _loc2_:int = EquipAmuletManager.Instance.lockNum * _loc3_.LockPrice;
         _consumeMoneyText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeMoney",_loc2_);
      }
      
      private function __onClickGetStive(param1:MouseEvent) : void
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
         buyStive();
      }
      
      private function __onClickActivate(param1:MouseEvent) : void
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
         var _loc4_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         var _loc3_:int = lockProperty.length * _loc4_.LockPrice;
         var _loc2_:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.activateTip",_loc4_.Expend,_loc3_),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         _loc2_.isBand = false;
         _loc2_.addEventListener("response",__onAlertActivate);
      }
      
      private function __onAlertActivate(param1:FrameEvent) : void
      {
         e = param1;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertActivate);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            var phaseVo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
            if(PlayerManager.Instance.Self.stive < phaseVo.Expend)
            {
               var stiveFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.notStive"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
               stiveFrame.addEventListener("response",__onAlertNotStiveFrame);
            }
            else
            {
               var list:Array = lockProperty;
               var price:int = list.length * phaseVo.LockPrice;
               CheckMoneyUtils.instance.checkMoney(alertFrame.isBand,price,function():void
               {
                  SocketManager.Instance.out.sendEquipAmuletActivate(CheckMoneyUtils.instance.isBind,list);
               });
            }
         }
         alertFrame.dispose();
      }
      
      private function __onAlertNotStiveFrame(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertNotStiveFrame);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            buyStive();
         }
         _loc2_.dispose();
      }
      
      private function buyStive() : void
      {
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = EquipAmuletManager.Instance.buyStiveNum;
         var _loc4_:int = ServerConfigManager.instance.equipAmuletBuyDustMax;
         if(_loc5_ < _loc4_)
         {
            if(_loc5_ == 0)
            {
               _loc7_ = LanguageMgr.GetTranslation("tank.equipAmulet.buyFreeStive");
            }
            else
            {
               _loc3_ = (_loc5_ - 1) * int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[2]) + int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[2]);
               _loc2_ = (_loc5_ - 1) * int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[0]) + int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[1]);
               _loc6_ = _loc4_ - _loc5_;
               _loc7_ = LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveTip",_loc3_,_loc2_,_loc6_);
            }
            _loc1_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),_loc7_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _loc1_.isBand = false;
            _loc1_.addEventListener("response",__onAlertBuyStiveFrame);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveCount"));
         }
      }
      
      private function __onAlertBuyStiveFrame(param1:FrameEvent) : void
      {
         e = param1;
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertBuyStiveFrame);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            CheckMoneyUtils.instance.checkMoney(alertFrame.isBand,buyStiveCoin,function():void
            {
               SocketManager.Instance.out.sendEquipAmuletBuyStive(CheckMoneyUtils.instance.isBind);
            });
         }
         alertFrame.dispose();
      }
      
      private function get buyStiveCoin() : int
      {
         var _loc2_:int = EquipAmuletManager.Instance.buyStiveNum;
         var _loc1_:int = ServerConfigManager.instance.equipAmuletBuyDustMax;
         return _loc2_ == 0?0:Number((_loc2_ - 1) * 150 + 150);
      }
      
      private function __onReplace(param1:MouseEvent) : void
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
         if(_newEffect[0].propertyType == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.notReplace"));
            return;
         }
         if(_power < 0)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.powerReplaceTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            _loc2_.addEventListener("response",__onAlertPowerFrame);
            return;
         }
         SocketManager.Instance.out.sendEquipAmuletReplace(true);
      }
      
      private function __onAlertPowerFrame(param1:FrameEvent) : void
      {
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onAlertBuyStiveFrame);
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendEquipAmuletReplace(true);
         }
         _loc2_.dispose();
      }
      
      private function __onActivateComplete(param1:PkgEvent) : void
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = param1.pkg.readInt();
         _power = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readInt();
         PlayerManager.Instance.Self.stive = _loc2_;
         _info.StrengthenExp = _loc3_;
         var _loc8_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         _loc7_ = 0;
         while(_loc7_ < 4)
         {
            _loc6_ = param1.pkg.readInt();
            _loc4_ = param1.pkg.readInt();
            _activateProperty[_loc7_] = _loc4_;
            _loc5_ = Math.round(_loc4_ / 10000 * _loc8_["property" + _loc6_]);
            _newEffect[_loc7_].update(_loc6_,_loc5_ || 1,_loc4_);
            _loc7_++;
         }
         var _loc9_:Boolean = true;
         _powerArrow.visible = _loc9_;
         _powerText.visible = _loc9_;
         _powerText.text = LanguageMgr.GetTranslation("tank.equipAmulet.power",_power);
         _powerArrow.visible = _power != 0;
         _powerArrow.setFrame(_power > 0?1:2);
         update();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.activateComplete"));
      }
      
      private function __onReplaceComplete(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         if(_loc2_)
         {
            _info.Hole1 = _newEffect[0].propertyType;
            _info.Hole5 = _activateProperty[0];
            _info.Hole2 = _newEffect[1].propertyType;
            _info.Hole6 = _activateProperty[1];
            _info.Hole3 = _newEffect[2].propertyType;
            _info.Hole5Exp = _activateProperty[2];
            _info.Hole4 = _newEffect[3].propertyType;
            _info.Hole6Exp = _activateProperty[3];
            var _loc3_:Boolean = false;
            _powerArrow.visible = _loc3_;
            _powerText.visible = _loc3_;
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.replaceComplete"));
         }
         updateProperty();
         update();
      }
      
      private function updateProperty() : void
      {
         _newEffect[0].update(0,0);
         _newEffect[1].update(0,0);
         _newEffect[2].update(0,0);
         _newEffect[3].update(0,0);
      }
      
      public function update() : void
      {
         var _loc3_:EquipAmuletVo = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel);
         _phaseText.text = LanguageMgr.GetTranslation("tank.equipAmulet.phase",_loc3_.phase);
         _gradeText.text = LanguageMgr.GetTranslation("tank.equipAmulet.grade",EquipAmuletManager.Instance.getAmuletPhaseGradeByCount(_info.StrengthenExp));
         var _loc2_:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         _consumeStiveText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeStive",_loc2_.Expend,PlayerManager.Instance.Self.stive);
         var _loc1_:int = lockProperty.length * _loc2_.LockPrice;
         _consumeMoneyText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeMoney",_loc1_);
         _currentEffect[0].update(_info.Hole1,_info.equipAmuletProperty1,_info.Hole5);
         _currentEffect[1].update(_info.Hole2,_info.equipAmuletProperty2,_info.Hole6);
         _currentEffect[2].update(_info.Hole3,_info.equipAmuletProperty3,_info.Hole5Exp);
         _currentEffect[3].update(_info.Hole4,_info.equipAmuletProperty4,_info.Hole6Exp);
         updateMoney();
      }
      
      public function updateMoney() : void
      {
         _moneyText.text = PlayerManager.Instance.Self.Money.toString();
         _bindMoneyText.text = PlayerManager.Instance.Self.BandMoney.toString();
      }
      
      private function __onBuyStiveComplete(param1:PkgEvent) : void
      {
         EquipAmuletManager.Instance.buyStiveNum = param1.pkg.readInt();
         PlayerManager.Instance.Self.stive = param1.pkg.readInt();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveComplete"));
         update();
      }
      
      private function get lockProperty() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _currentEffect.length)
         {
            if(_currentEffect[_loc2_].lockBool)
            {
               _loc1_.push(_currentEffect[_loc2_].propertyType);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get isActivate() : Boolean
      {
         return _newEffect[0].propertyType > 0;
      }
      
      private function addEvent() : void
      {
         _getStiveBtn.addEventListener("click",__onClickGetStive);
         _activateBtn.addEventListener("click",__onClickActivate);
         _replaceBtn.addEventListener("click",__onReplace);
         SocketManager.Instance.addEventListener(PkgEvent.format(386,3),__onActivateComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(386,6),__onReplaceComplete);
         SocketManager.Instance.addEventListener(PkgEvent.format(386,4),__onBuyStiveComplete);
      }
      
      private function removeEvent() : void
      {
         _getStiveBtn.removeEventListener("click",__onClickGetStive);
         _activateBtn.removeEventListener("click",__onClickActivate);
         _replaceBtn.removeEventListener("click",__onReplace);
         SocketManager.Instance.removeEventListener(PkgEvent.format(386,3),__onActivateComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(386,6),__onReplaceComplete);
         SocketManager.Instance.removeEventListener(PkgEvent.format(386,4),__onBuyStiveComplete);
      }
      
      public function dispose() : void
      {
         removeEvent();
         _activateProperty = null;
         SocketManager.Instance.out.sendEquipAmuletReplace(false);
         ObjectUtils.disposeObject(_phaseText);
         _phaseText = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         var _loc3_:int = 0;
         var _loc2_:* = _currentEffect;
         for each(var _loc1_ in _currentEffect)
         {
            _loc1_.addEventListener("change",__onItemChange);
         }
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _phaseTips = null;
         _phaseTipText = null;
         _gradeTips = null;
         _gradeTipText = null;
         _powerText = null;
         _powerArrow = null;
         _currentEffect.splice(0,_currentEffect.length);
         _currentEffect = null;
         _newEffect.splice(0,_newEffect.length);
         _newEffect = null;
         _getStiveBtn = null;
         _consumeStiveText = null;
         _consumeMoneyText = null;
         _activateBtn = null;
         _replaceBtn = null;
         _info = null;
         _moneyText = null;
         _moneyBg = null;
         _moneyIcon = null;
         _bindMoneyText = null;
         _bindMoneyBg = null;
         _bindMoneyIcon = null;
      }
   }
}
