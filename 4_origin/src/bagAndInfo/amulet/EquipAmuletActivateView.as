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
         var i:int = 0;
         var currentItem:* = null;
         var newItem:* = null;
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
         for(i = 0; i < 4; )
         {
            currentItem = new EquipAmuletActivateItem();
            currentItem.addEventListener("change",__onItemChange);
            PositionUtils.setPos(currentItem,"equipAmulet.currentItemPos" + i);
            _currentEffect.push(currentItem);
            addChild(currentItem);
            newItem = new EquipAmuletActivateItem(false);
            PositionUtils.setPos(newItem,"equipAmulet.newItemPos" + i);
            _newEffect.push(newItem);
            addChild(newItem);
            i++;
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
      
      private function __onItemChange(e:Event) : void
      {
         var phaseVo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         EquipAmuletManager.Instance.lockNum = lockProperty.length;
         var price:int = EquipAmuletManager.Instance.lockNum * phaseVo.LockPrice;
         _consumeMoneyText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeMoney",price);
      }
      
      private function __onClickGetStive(event:MouseEvent) : void
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
      
      private function __onClickActivate(event:MouseEvent) : void
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
         var phaseVo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         var price:int = lockProperty.length * phaseVo.LockPrice;
         var alertFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.activateTip",phaseVo.Expend,price),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
         alertFrame.isBand = false;
         alertFrame.addEventListener("response",__onAlertActivate);
      }
      
      private function __onAlertActivate(e:FrameEvent) : void
      {
         e = e;
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
      
      private function __onAlertNotStiveFrame(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertNotStiveFrame);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            buyStive();
         }
         alertFrame.dispose();
      }
      
      private function buyStive() : void
      {
         var tips:* = null;
         var coin:int = 0;
         var stive:int = 0;
         var canBuyNum:int = 0;
         var alertFrame:* = null;
         var buyNum:int = EquipAmuletManager.Instance.buyStiveNum;
         var maxBuyNum:int = ServerConfigManager.instance.equipAmuletBuyDustMax;
         if(buyNum < maxBuyNum)
         {
            if(buyNum == 0)
            {
               tips = LanguageMgr.GetTranslation("tank.equipAmulet.buyFreeStive");
            }
            else
            {
               coin = (buyNum - 1) * int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[2]) + int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[2]);
               stive = (buyNum - 1) * int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[0]) + int(ServerConfigManager.instance.AmuletBuyDustCountAndNeedMoney[1]);
               canBuyNum = maxBuyNum - buyNum;
               tips = LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveTip",coin,stive,canBuyNum);
            }
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),tips,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            alertFrame.isBand = false;
            alertFrame.addEventListener("response",__onAlertBuyStiveFrame);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveCount"));
         }
      }
      
      private function __onAlertBuyStiveFrame(e:FrameEvent) : void
      {
         e = e;
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
         var buyNum:int = EquipAmuletManager.Instance.buyStiveNum;
         var maxBuyNum:int = ServerConfigManager.instance.equipAmuletBuyDustMax;
         return buyNum == 0?0:Number((buyNum - 1) * 150 + 150);
      }
      
      private function __onReplace(event:MouseEvent) : void
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
         if(_newEffect[0].propertyType == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.notReplace"));
            return;
         }
         if(_power < 0)
         {
            alertFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tips"),LanguageMgr.GetTranslation("tank.equipAmulet.powerReplaceTip"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2,null,"SimpleAlert",60,false);
            alertFrame.addEventListener("response",__onAlertPowerFrame);
            return;
         }
         SocketManager.Instance.out.sendEquipAmuletReplace(true);
      }
      
      private function __onAlertPowerFrame(e:FrameEvent) : void
      {
         var alertFrame:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alertFrame.removeEventListener("response",__onAlertBuyStiveFrame);
         if(e.responseCode == 2 || e.responseCode == 3)
         {
            SocketManager.Instance.out.sendEquipAmuletReplace(true);
         }
         alertFrame.dispose();
      }
      
      private function __onActivateComplete(e:PkgEvent) : void
      {
         var i:int = 0;
         var type:int = 0;
         var value:int = 0;
         var property:int = 0;
         var count:int = e.pkg.readInt();
         _power = e.pkg.readInt();
         var stive:int = e.pkg.readInt();
         PlayerManager.Instance.Self.stive = stive;
         _info.StrengthenExp = count;
         var vo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         for(i = 0; i < 4; )
         {
            type = e.pkg.readInt();
            value = e.pkg.readInt();
            _activateProperty[i] = value;
            property = Math.round(value / 10000 * vo["property" + type]);
            _newEffect[i].update(type,property || 1,value);
            i++;
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
      
      private function __onReplaceComplete(e:PkgEvent) : void
      {
         var bool:Boolean = e.pkg.readBoolean();
         if(bool)
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
         var vo:EquipAmuletVo = EquipAmuletManager.Instance.getAmuletVo(_info.StrengthenLevel);
         _phaseText.text = LanguageMgr.GetTranslation("tank.equipAmulet.phase",vo.phase);
         _gradeText.text = LanguageMgr.GetTranslation("tank.equipAmulet.grade",EquipAmuletManager.Instance.getAmuletPhaseGradeByCount(_info.StrengthenExp));
         var phaseVo:EquipAmuletPhaseVo = EquipAmuletManager.Instance.getAmuletPhaseVoByGrade(_info.StrengthenLevel);
         _consumeStiveText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeStive",phaseVo.Expend,PlayerManager.Instance.Self.stive);
         var price:int = lockProperty.length * phaseVo.LockPrice;
         _consumeMoneyText.htmlText = LanguageMgr.GetTranslation("tank.equipAmulet.consumeMoney",price);
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
      
      private function __onBuyStiveComplete(e:PkgEvent) : void
      {
         EquipAmuletManager.Instance.buyStiveNum = e.pkg.readInt();
         PlayerManager.Instance.Self.stive = e.pkg.readInt();
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.equipAmulet.buyStiveComplete"));
         update();
      }
      
      private function get lockProperty() : Array
      {
         var i:int = 0;
         var list:Array = [];
         for(i = 0; i < _currentEffect.length; )
         {
            if(_currentEffect[i].lockBool)
            {
               list.push(_currentEffect[i].propertyType);
            }
            i++;
         }
         return list;
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
         for each(var item in _currentEffect)
         {
            item.addEventListener("change",__onItemChange);
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
