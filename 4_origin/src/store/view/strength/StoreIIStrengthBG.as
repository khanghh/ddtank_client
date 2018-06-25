package store.view.strength
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.ShowSuccessExp;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.data.StoreEquipExperience;
   import store.view.ConsortiaRateManager;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   import vip.VipController;
   
   public class StoreIIStrengthBG extends Sprite implements IStoreViewBG
   {
      
      public static const WEAPONUPGRADESPLAY:String = "weaponUpgradesPlay";
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _strength_btn:BaseButton;
      
      private var _strength_btn_shineEffect:IEffect;
      
      private var _strengHelp:BaseButton;
      
      private var _bg:MutipleImage;
      
      private var _gold_txt:FilterFrameText;
      
      private var _pointArray:Vector.<Point>;
      
      private var _strthShine:MovieImage;
      
      private var _startStrthTip:MutipleImage;
      
      private var _consortiaSmith:MySmithLevel;
      
      private var _strengthStoneCellBg1:Bitmap;
      
      private var _strengthStoneText1:FilterFrameText;
      
      private var _strengthenEquipmentCellBg:Image;
      
      private var _strengthenEquipmentCellText:FilterFrameText;
      
      private var _isInjectSelect:SelectedCheckButton;
      
      private var _progressLevel:StoreStrengthProgress;
      
      private var _lastStrengthTime:int = 0;
      
      private var _showSuccessExp:ShowSuccessExp;
      
      private var _starMovie:MovieClip;
      
      private var _weaponUpgrades:MovieClip;
      
      private var _sBuyStrengthStoneCell:BuyItemButton;
      
      private var _strengthEquipmentTxt:Bitmap;
      
      private var _vipDiscountTxt:FilterFrameText;
      
      private var _vipDiscountBg:Image;
      
      private var _vipDiscountIcon:Image;
      
      private var _aler:StrengthSelectNumAlertFrame;
      
      public function StoreIIStrengthBG()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _vipDiscountBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.VipDiscountBg");
         _vipDiscountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.VipDiscountTxt");
         _vipDiscountTxt.text = LanguageMgr.GetTranslation("store.Strength.VipDiscountDesc");
         _vipDiscountIcon = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBg.VipDiscountIcon");
         addChild(_vipDiscountBg);
         addChild(_vipDiscountIcon);
         addChild(_vipDiscountTxt);
         _strengthEquipmentTxt = ComponentFactory.Instance.creatBitmap("asset.ddtstore.strengthenEquipmentTxt");
         PositionUtils.setPos(_strengthEquipmentTxt,"asset.ddtstore.strengthenEquipmentTxtPos");
         addChild(_strengthEquipmentTxt);
         _strengthStoneCellBg1 = ComponentFactory.Instance.creatBitmap("asset.ddtstore.GoodPanel");
         PositionUtils.setPos(_strengthStoneCellBg1,"ddtstore.StoreIIStrengthBG.StrengthCellBg1Point");
         addChild(_strengthStoneCellBg1);
         _strengthStoneText1 = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.GoodCellText");
         _strengthStoneText1.text = LanguageMgr.GetTranslation("store.Strength.GoodPanelText.StrengthStone");
         PositionUtils.setPos(_strengthStoneText1,"ddtstore.StoreIIStrengthBG.StrengthStoneText1Point");
         addChild(_strengthStoneText1);
         _strengthenEquipmentCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.stoneCellBg");
         PositionUtils.setPos(_strengthenEquipmentCellBg,"ddtstore.StoreIIStrengthBG.EquipmentCellBgPos");
         addChild(_strengthenEquipmentCellBg);
         _strengthenEquipmentCellText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.StrengthenEquipmentCellText");
         _strengthenEquipmentCellText.text = LanguageMgr.GetTranslation("store.Strength.StrengthenCurrentEquipmentCellText");
         PositionUtils.setPos(_strengthenEquipmentCellText,"ddtstore.StoreIIStrengthBG.StrengthenEquipmentCellTextPos");
         addChild(_strengthenEquipmentCellText);
         _items = [];
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         _strength_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.StrengthenBtn");
         addChild(_strength_btn);
         _strength_btn_shineEffect = EffectManager.Instance.creatEffect(4,_strength_btn,{"color":"gold"});
         _startStrthTip = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrengthBG.ArrowHeadTip");
         addChild(_startStrthTip);
         _strengHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.StoreIIStrengthBG.say"),"ddtstore.HelpFrame.StrengthText",404,484);
         _isInjectSelect = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIStrength.isInjectSelect");
         addChild(_isInjectSelect);
         _progressLevel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreStrengthProgress");
         _progressLevel.tipStyle = "ddt.view.tips.OneLineTip";
         _progressLevel.tipDirctions = "3,7,6";
         _progressLevel.tipGapV = 4;
         addChild(_progressLevel);
         _progressLevel.addEventListener("weaponUpgradesPlay",weaponUpgradesPlay);
         getCellsPoint();
         for(i = 0; i < _pointArray.length; )
         {
            switch(int(i))
            {
               case 0:
                  item = new StrengthStone(["2","35"],i);
                  break;
               case 1:
                  item = new StreangthItemCell(i);
            }
            item.addEventListener("change",__itemInfoChange);
            _items[i] = item;
            item.x = _pointArray[i].x;
            item.y = _pointArray[i].y;
            addChild(item);
            i++;
         }
         _consortiaSmith = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.MySmithLevel");
         addChild(_consortiaSmith);
         _sBuyStrengthStoneCell = ComponentFactory.Instance.creat("ddtstore.StoreIIStrengthBG.StoneBuyBtn");
         _sBuyStrengthStoneCell.setup(11025,1,true);
         _sBuyStrengthStoneCell.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _sBuyStrengthStoneCell.tipData = null;
         _sBuyStrengthStoneCell.tipStyle = null;
         addChild(_sBuyStrengthStoneCell);
         hide();
         hideArr();
         _showSuccessExp = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.ShowSuccessExp");
         _showSuccessExp.showVIPRate();
         var strI:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.StrengthenStonStripExp");
         var strIII:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.ConsortiaAddStripExp");
         var strVIP:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.VIPAddStripExp");
         var strIV:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.AllNumStrip");
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            strIII = LanguageMgr.GetTranslation("tank.view.store.consortiaRateI");
         }
         if(!PlayerManager.Instance.Self.IsVIP)
         {
            strVIP = LanguageMgr.GetTranslation("store.StoreIIComposeBG.NoVIPAddStrip");
         }
         _showSuccessExp.showAllTips(strI,strIII,strIV);
         _showSuccessExp.showVIPTip(strVIP);
         addChild(_showSuccessExp);
      }
      
      private function initEvent() : void
      {
         _isInjectSelect.addEventListener("click",__isInjectSelectClick);
         _strength_btn.addEventListener("click",__strengthClick);
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",_consortiaLoadComplete);
      }
      
      private function removeEvents() : void
      {
         _isInjectSelect.removeEventListener("click",__isInjectSelectClick);
         _strength_btn.removeEventListener("click",__strengthClick);
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",_consortiaLoadComplete);
         _items[0].removeEventListener("change",__itemInfoChange);
         _items[1].removeEventListener("change",__itemInfoChange);
         _progressLevel.removeEventListener("weaponUpgradesPlay",weaponUpgradesPlay);
      }
      
      private function userGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(72) && PlayerManager.Instance.Self.Grade >= 5)
         {
            NewHandQueue.Instance.push(new Step(70,exeWeaponTip,preWeaponTip,finWeaponTip));
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(132) && PlayerManager.Instance.Self.Grade >= 10 && TaskManager.instance.isAvailable(TaskManager.instance.getQuestByID(564)))
         {
            NewHandQueue.Instance.push(new Step(132,exeWeaponTip,preClothesTip,finWeaponTip));
         }
      }
      
      private function preClothesTip() : void
      {
         NewHandContainer.Instance.showArrow(11,0,"trainer.strClothesArrowPos","asset.trainer.txtWeaponTip","trainer.strClothesTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function preWeaponTip() : void
      {
         NewHandContainer.Instance.showGuideCoverMultiHoles(2,true,"circle",[240,280,58],"rect",[530,146,372,185]);
         NewHandContainer.Instance.showArrow(11,0,"trainer.strWeaponArrowPos","asset.trainer.txtWeaponTip","trainer.strWeaponTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeWeaponTip() : Boolean
      {
         return _items[1].info;
      }
      
      private function finWeaponTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(680,PathManager.userName(),PathManager.solveRequestPath());
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(11);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(72) && PlayerManager.Instance.Self.Grade >= 5 && !exeStoneTip())
         {
            NewHandQueue.Instance.push(new Step(71,exeStoneTip,preStoneTip,finStoneTip));
         }
      }
      
      private function preStoneTip() : void
      {
         NewHandContainer.Instance.showGuideCoverMultiHoles(2,true,"circle",[442,280,58],"rect",[530,323,366,178]);
         NewHandContainer.Instance.showArrow(11,360,"trainer.strStoneArrowPos","asset.trainer.txtStoneTip","trainer.strStoneTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeStoneTip() : Boolean
      {
         return _items[0].info;
      }
      
      private function finStoneTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(690,PathManager.userName(),PathManager.solveRequestPath());
         disposeUserGuide();
      }
      
      private function disposeUserGuide() : void
      {
         NewHandContainer.Instance.hideGuideCover();
         NewHandContainer.Instance.clearArrowByID(11);
         NewHandQueue.Instance.dispose();
      }
      
      private function getCellsPoint() : void
      {
         _pointArray = new Vector.<Point>();
         var point:Point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.Strengthpoint0");
         _pointArray.push(point);
         var point2:Point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.Strengthpoint1");
         _pointArray.push(point2);
      }
      
      public function get isAutoStrength() : Boolean
      {
         return _isInjectSelect.selected;
      }
      
      private function __onAlertResponse(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         event.currentTarget.addEventListener("response",__onAlertResponse);
         ObjectUtils.disposeObject(event.currentTarget);
      }
      
      public function get area() : Array
      {
         return _items;
      }
      
      private function updateProgress(info:InventoryItemInfo) : void
      {
         if(info)
         {
            if(StoreEquipExperience.expericence)
            {
               _progressLevel.setProgress(info);
            }
         }
      }
      
      private function isAdaptToItem(info:InventoryItemInfo) : Boolean
      {
         if(_items[1].info == null)
         {
            return true;
         }
         if(_items[1].info.RefineryLevel > 0)
         {
            if(info.Property1 == "35")
            {
               return true;
            }
            return false;
         }
         if(info.Property1 == "35")
         {
            return false;
         }
         return true;
      }
      
      private function isAdaptToStone(info:InventoryItemInfo) : Boolean
      {
         if(_items[0].info != null && _items[0].info.Property1 != info.Property1)
         {
            return false;
         }
         return true;
      }
      
      private function itemIsAdaptToStone(info:InventoryItemInfo) : Boolean
      {
         if(info.RefineryLevel > 0)
         {
            if(_items[0].info != null && _items[0].info.Property1 != "35")
            {
               return false;
            }
            return true;
         }
         if(_items[0].info != null && _items[0].info.Property1 == "35")
         {
            return false;
         }
         return true;
      }
      
      private function showNumAlert(info:InventoryItemInfo, index:int) : void
      {
         _aler = ComponentFactory.Instance.creat("ddtstore.StrengthSelectNumAlertFrame");
         _aler.addExeFunction(sellFunction,notSellFunction);
         _aler.goodsinfo = info;
         _aler.index = index;
         _aler.show(info.Count);
      }
      
      private function sellFunction(_nowNum:int, goodsinfo:InventoryItemInfo, index:int) : void
      {
         SocketManager.Instance.out.sendMoveGoods(goodsinfo.BagType,goodsinfo.Place,12,index,_nowNum,true);
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function notSellFunction() : void
      {
         if(_aler)
         {
            _aler.dispose();
         }
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      public function dragDrop(source:BagCell) : void
      {
         var ds:* = null;
         if(source == null)
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(ds in _items)
         {
            if(ds.info == info)
            {
               ds.info = null;
               source.locked = false;
               return;
            }
         }
         var _loc7_:int = 0;
         var _loc6_:* = _items;
         for each(ds in _items)
         {
            if(ds)
            {
               if(ds is StoneCell)
               {
                  if(ds.info == null)
                  {
                     if((ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
                     {
                        if(isAdaptToStone(info))
                        {
                           SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                           return;
                        }
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
                     }
                  }
               }
               else if(ds is StreangthItemCell)
               {
                  if(info.getRemainDate() <= 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
                  }
                  else
                  {
                     if(info.StrengthenLevel >= PathManager.solveStrengthMax())
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.StrengthItemCell.up"));
                        return;
                     }
                     if(source.info.CanStrengthen)
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,1);
                        StreangthItemCell(_items[1]).actionState = true;
                        return;
                     }
                  }
               }
            }
         }
         if(EquipType.isStrengthStone(info))
         {
            var _loc9_:int = 0;
            var _loc8_:* = _items;
            for each(ds in _items)
            {
               if(ds is StoneCell && (ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
               {
                  if(isAdaptToStone(info))
                  {
                     SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                     return;
                  }
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.strength.typeUnpare"));
               }
            }
         }
      }
      
      private function _responseII(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         evt.currentTarget.removeEventListener("response",_responseII);
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function showArr() : void
      {
         _startStrthTip.visible = true;
         _strength_btn_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         _startStrthTip.visible = false;
         _strength_btn_shineEffect.stop();
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(itemPlace in items)
         {
            if(_items.hasOwnProperty(itemPlace))
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
         }
      }
      
      public function updateData() : void
      {
         if(PlayerManager.Instance.Self.StoreBag.items[0] && isAdaptToStone(PlayerManager.Instance.Self.StoreBag.items[0]))
         {
            _items[0].info = PlayerManager.Instance.Self.StoreBag.items[0];
         }
         else
         {
            _items[0].info = null;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[1] && EquipType.isStrengthStone(PlayerManager.Instance.Self.StoreBag.items[1]))
         {
            _items[1].info = PlayerManager.Instance.Self.StoreBag.items[1];
         }
         else
         {
            _items[1].info = null;
         }
      }
      
      public function startShine(cellId:int) : void
      {
         if(cellId < 2)
         {
            _items[cellId].startShine();
         }
      }
      
      public function stopShine() : void
      {
         _items[0].stopShine();
         _items[1].stopShine();
      }
      
      public function show() : void
      {
         if(_items)
         {
            _items[0].addEventListener("change",__itemInfoChange);
            _items[1].addEventListener("change",__itemInfoChange);
         }
         this.visible = true;
         _consortiaLoadComplete(null);
         consortiaRate();
         updateData();
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            userGuide();
         }
      }
      
      public function hide() : void
      {
         this.visible = false;
         disposeUserGuide();
         if(_items)
         {
            _items[0].removeEventListener("change",__itemInfoChange);
            _items[1].removeEventListener("change",__itemInfoChange);
         }
      }
      
      private function __isInjectSelectClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      private function __strengthClick(evt:MouseEvent) : void
      {
         var alert:* = null;
         var alert1:* = null;
         evt.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(_showDontClickTip())
         {
            return;
         }
         if(_items[1].info != null)
         {
            if(_items[1].itemInfo.StrengthenLevel >= PathManager.solveStrengthMax())
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.StrengthItemCell.up"));
               return;
            }
         }
         if(checkTipBindType())
         {
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIStrengthBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert1.moveEnable = false;
            alert1.info.enableHtml = true;
            alert1.info.mutiline = true;
            alert1.addEventListener("response",_bingResponse);
         }
         else if(!_progressLevel.getStarVisible())
         {
            sendSocket();
         }
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _quick:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _quick.itemID = 11233;
         LayerManager.Instance.addToLayer(_quick,2,true,1);
      }
      
      private function _bingResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",_bingResponse);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            sendSocket();
         }
         ObjectUtils.disposeObject(evt.target);
      }
      
      private function sendSocket() : void
      {
         var allBuildInfo:* = null;
         var eachBuildInfo:* = null;
         if(!checkLevel())
         {
            return;
         }
         var consortiaState:Boolean = false;
         var rate:int = ConsortiaRateManager.instance.rate;
         if(PlayerManager.Instance.Self.ConsortiaID != 0 && rate > 0)
         {
            consortiaState = true;
         }
         if(ConsortiaDomainManager.instance.activeState == 1)
         {
            consortiaState = false;
         }
         else if(ConsortiaDomainManager.instance.activeState == 0 || ConsortiaDomainManager.instance.activeState == 100)
         {
            allBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo;
            if(allBuildInfo)
            {
               eachBuildInfo = allBuildInfo[4];
            }
            if(eachBuildInfo && eachBuildInfo.Repair > 0)
            {
               consortiaState = false;
            }
         }
         var time:int = getTimer();
         if(time - _lastStrengthTime > 1200)
         {
            SocketManager.Instance.out.sendItemStrength(consortiaState,_isInjectSelect.selected);
            _lastStrengthTime = time;
            if(!PlayerManager.Instance.Self.IsWeakGuildFinish(72))
            {
               NoviceDataManager.instance.saveNoviceData(700,PathManager.userName(),PathManager.solveRequestPath());
               SocketManager.Instance.out.syncWeakStep(72);
            }
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
         }
      }
      
      private function checkTipBindType() : Boolean
      {
         if(_items[1].itemInfo && _items[1].itemInfo.IsBinds)
         {
            return false;
         }
         if(_items[0].itemInfo && _items[0].itemInfo.IsBinds)
         {
            return true;
         }
         return false;
      }
      
      private function checkLevel() : Boolean
      {
         var item:StreangthItemCell = _items[1] as StreangthItemCell;
         var info:InventoryItemInfo = item.info as InventoryItemInfo;
         if(info && info.StrengthenLevel >= PathManager.solveStrengthMax())
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.StrengthItemCell.up"));
            return false;
         }
         return true;
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         var itemCell:* = null;
         var info:* = null;
         if(evt.currentTarget is StreangthItemCell)
         {
            itemCell = evt.currentTarget as StreangthItemCell;
            info = itemCell.info as InventoryItemInfo;
            if(info)
            {
               if(StreangthItemCell(_items[1]).actionState)
               {
                  _progressLevel.initProgress(info);
                  StreangthItemCell(_items[1]).actionState = false;
                  if(_starMovie)
                  {
                     removeStarMovie();
                  }
                  if(_weaponUpgrades)
                  {
                     removeWeaponUpgradesMovie();
                  }
               }
               else
               {
                  updateProgress(info);
               }
            }
            else
            {
               _progressLevel.resetProgress();
            }
            dispatchEvent(new Event("change"));
         }
         getCountExpI();
         if(_items[0].info == null)
         {
            var _loc4_:String = "";
            _items[1].stoneType = _loc4_;
            _items[0].stoneType = _loc4_;
         }
         if(_items[1].info == null)
         {
            _items[0].itemType = -1;
         }
         else
         {
            _items[0].itemType = _items[1].info.RefineryLevel;
         }
         if(_items[1].info == null || _items[0].info == null || _items[1].itemInfo.StrengthenLevel >= 9)
         {
            hideArr();
            return;
         }
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(72) && PlayerManager.Instance.Self.Grade >= 5)
         {
            showArr();
         }
         else if(_startStrthTip.visible)
         {
            hideArr();
         }
      }
      
      private function _showDontClickTip() : Boolean
      {
         if(_items[1].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.strength.dontStrengthI"));
            return true;
         }
         if(_items[0].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.strength.dontStrengthII"));
            return true;
         }
         return false;
      }
      
      private function getCountExpI() : void
      {
         var tempExpI:* = 0;
         var tempExpIII:* = 0;
         var tempExpIV:* = 0;
         var tempExpVip:* = 0;
         if(_items[0].info != null)
         {
            tempExpI = Number(tempExpI + _items[0].info.Property2);
         }
         if(ConsortiaRateManager.instance.rate > 0)
         {
            tempExpIII = Number(ConsortiaRateManager.instance.getConsortiaStrengthenEx(PlayerManager.Instance.Self.consortiaInfo.SmithLevel) / 100 * tempExpI);
         }
         if(PlayerManager.Instance.Self.IsVIP)
         {
            tempExpVip = Number(VipController.instance.getVIPStrengthenEx(PlayerManager.Instance.Self.VIPLevel) / 100 * tempExpI);
         }
         tempExpIV = Number(tempExpI + tempExpIII + tempExpVip);
         _showSuccessExp.showAllNum(tempExpI,tempExpIII,tempExpVip,tempExpIV);
      }
      
      public function consortiaRate() : void
      {
         ConsortiaRateManager.instance.reset();
      }
      
      private function _consortiaLoadComplete(e:Event) : void
      {
         getCountExpI();
      }
      
      public function getStrengthItemCellInfo() : InventoryItemInfo
      {
         return (_items[1] as StreangthItemCell).itemInfo;
      }
      
      public function starMoviePlay() : void
      {
         if(!_starMovie)
         {
            _starMovie = ClassUtils.CreatInstance("accet.strength.starMovie");
         }
         _starMovie.gotoAndPlay(1);
         _starMovie.addEventListener("enterFrame",__starMovieFrame);
         PositionUtils.setPos(_starMovie,"ddtstore.StoreIIStrengthBG.starMoviePoint");
         addChild(_starMovie);
      }
      
      private function __starMovieFrame(e:Event) : void
      {
         if(_starMovie)
         {
            if(_starMovie.currentFrame == _starMovie.totalFrames)
            {
               removeStarMovie();
            }
         }
      }
      
      private function removeStarMovie() : void
      {
         if(_starMovie.hasEventListener("enterFrame"))
         {
            _starMovie.removeEventListener("enterFrame",__starMovieFrame);
         }
         if(this.contains(_starMovie))
         {
            this.removeChild(_starMovie);
         }
      }
      
      private function weaponUpgradesPlay(e:Event) : void
      {
         if(!_weaponUpgrades)
         {
            _weaponUpgrades = ClassUtils.CreatInstance("asset.strength.weaponUpgrades");
         }
         _weaponUpgrades.gotoAndPlay(1);
         _weaponUpgrades.addEventListener("enterFrame",__weaponUpgradesFrame);
         PositionUtils.setPos(_weaponUpgrades,"ddtstore.StoreIIStrengthBG.weaponUpgradesPoint");
         addChild(_weaponUpgrades);
         this.dispatchEvent(new Event("weaponUpgradesPlay"));
      }
      
      private function __weaponUpgradesFrame(e:Event) : void
      {
         if(_weaponUpgrades)
         {
            if(_weaponUpgrades.currentFrame == _weaponUpgrades.totalFrames)
            {
               removeWeaponUpgradesMovie();
            }
         }
      }
      
      private function removeWeaponUpgradesMovie() : void
      {
         if(_weaponUpgrades.hasEventListener("enterFrame"))
         {
            _weaponUpgrades.removeEventListener("enterFrame",__weaponUpgradesFrame);
         }
         if(this.contains(_weaponUpgrades))
         {
            this.removeChild(_weaponUpgrades);
         }
      }
      
      public function dispose() : void
      {
         removeEvents();
         disposeUserGuide();
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         var _loc3_:int = 0;
         var _loc2_:* = _items;
         for each(var item in _items)
         {
            item.dispose();
         }
         _items = null;
         EffectManager.Instance.removeEffect(_strength_btn_shineEffect);
         ObjectUtils.disposeObject(_strengthStoneCellBg1);
         _strengthStoneCellBg1 = null;
         if(_strengthStoneText1)
         {
            _strengthStoneText1.dispose();
            _strengthStoneText1 = null;
         }
         ObjectUtils.disposeObject(_strengthenEquipmentCellBg);
         _strengthenEquipmentCellBg = null;
         ObjectUtils.disposeObject(_strengthenEquipmentCellText);
         _strengthenEquipmentCellText = null;
         _pointArray = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_strength_btn)
         {
            ObjectUtils.disposeObject(_strength_btn);
         }
         _strength_btn = null;
         if(_strthShine)
         {
            ObjectUtils.disposeObject(_strthShine);
         }
         _strthShine = null;
         if(_startStrthTip)
         {
            ObjectUtils.disposeObject(_startStrthTip);
         }
         _startStrthTip = null;
         if(_strengHelp)
         {
            ObjectUtils.disposeObject(_strengHelp);
         }
         _strengHelp = null;
         if(_showSuccessExp)
         {
            ObjectUtils.disposeObject(_showSuccessExp);
         }
         _showSuccessExp = null;
         if(_consortiaSmith)
         {
            ObjectUtils.disposeObject(_consortiaSmith);
         }
         _consortiaSmith = null;
         if(_gold_txt)
         {
            ObjectUtils.disposeObject(_gold_txt);
         }
         _gold_txt = null;
         if(_progressLevel)
         {
            ObjectUtils.disposeObject(_progressLevel);
         }
         _progressLevel = null;
         if(_isInjectSelect)
         {
            ObjectUtils.disposeObject(_isInjectSelect);
         }
         _isInjectSelect = null;
         if(_aler)
         {
            ObjectUtils.disposeObject(_aler);
         }
         _aler = null;
         ObjectUtils.disposeObject(_vipDiscountBg);
         _vipDiscountBg = null;
         ObjectUtils.disposeObject(_vipDiscountIcon);
         _vipDiscountIcon = null;
         ObjectUtils.disposeObject(_vipDiscountTxt);
         _vipDiscountTxt = null;
         if(_starMovie)
         {
            if(_starMovie.hasEventListener("enterFrame"))
            {
               _starMovie.removeEventListener("enterFrame",__starMovieFrame);
            }
            ObjectUtils.disposeObject(_starMovie);
            _starMovie = null;
         }
         if(_weaponUpgrades)
         {
            if(_weaponUpgrades.hasEventListener("enterFrame"))
            {
               _weaponUpgrades.removeEventListener("enterFrame",__weaponUpgradesFrame);
            }
            ObjectUtils.disposeObject(_weaponUpgrades);
            _weaponUpgrades = null;
         }
         if(_sBuyStrengthStoneCell)
         {
            ObjectUtils.disposeObject(_sBuyStrengthStoneCell);
         }
         _sBuyStrengthStoneCell = null;
         if(_strengthEquipmentTxt)
         {
            ObjectUtils.disposeObject(_strengthEquipmentTxt);
         }
         _strengthEquipmentTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
