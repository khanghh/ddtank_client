package store.view.Compose
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.manager.NoviceDataManager;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.quest.QuestInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.ShowSuccessRate;
   import store.StoneCell;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.view.ConsortiaRateManager;
   import store.view.StoneCellFrame;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   import store.view.strength.MySmithLevel;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class StoreIIComposeBG extends Sprite implements IStoreViewBG
   {
      
      private static const ITEMS:Array = [11004,11008,11012,11016];
      
      public static const COMPOSE_TOP:int = 50;
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _bg:MutipleImage;
      
      private var _luckyStoneCell:StoneCellFrame;
      
      private var _strengthStoneCell:StoneCellFrame;
      
      private var _equipmentCell:StoneCellFrame;
      
      private var _compose_btn:BaseButton;
      
      private var _compose_btn_shineEffect:IEffect;
      
      private var _composeHelp:BaseButton;
      
      private var cpsArr:MutipleImage;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _buyStoneBtn:TextButton;
      
      private var _composeTitle:Bitmap;
      
      private var _pointArray:Vector.<Point>;
      
      private var _showSuccessRate:ShowSuccessRate;
      
      private var _consortiaSmith:MySmithLevel;
      
      public var composeRate:Array;
      
      public function StoreIIComposeBG()
      {
         composeRate = [0.8,0.5,0.3,0.1,0.05];
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _items = [];
         _composeTitle = ComponentFactory.Instance.creatBitmap("asset.ddtstore.ComposeTitle");
         addChild(_composeTitle);
         _luckyStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.LuckySymbolCell");
         _luckyStoneCell.label = LanguageMgr.GetTranslation("store.Strength.GoodPanelText.LuckySymbol");
         addChild(_luckyStoneCell);
         _strengthStoneCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.StrengthenStoneCell");
         _strengthStoneCell.label = LanguageMgr.GetTranslation("store.Compose.ComposeStone");
         addChild(_strengthStoneCell);
         _equipmentCell = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.EquipmentCell");
         _equipmentCell.label = LanguageMgr.GetTranslation("store.Strength.StrengthenEquipmentCellText");
         addChild(_equipmentCell);
         _compose_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.ComposeBtn");
         _compose_btn_shineEffect = EffectManager.Instance.creatEffect(4,_compose_btn,{"color":"gold"});
         addChild(_compose_btn);
         _composeHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.StoreIIComposeBG.say"),"ddtstore.HelpFrame.ComposeText",404,484);
         cpsArr = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ArrowHeadComposeTip");
         addChild(cpsArr);
         _cBuyluckyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.BuyLuckyComposeBtn");
         _cBuyluckyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _cBuyluckyBtn.setup(11018,2,true);
         addChild(_cBuyluckyBtn);
         _buyStoneBtn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIComposeBG.BuyComposeStoneBtn");
         _buyStoneBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         addChild(_buyStoneBtn);
         _consortiaSmith = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.MySmithLevel");
         addChild(_consortiaSmith);
         getCellsPoint();
         for(i = 0; i < 3; )
         {
            if(i == 0)
            {
               item = new ComposeStoneCell(["3"],i);
            }
            else if(i == 1)
            {
               item = new ComposeItemCell(i);
            }
            else if(i == 2)
            {
               item = new ComposeStoneCell(["1"],i);
            }
            item.x = _pointArray[i].x;
            item.y = _pointArray[i].y;
            item.addEventListener("change",__itemInfoChange);
            addChild(item);
            _items.push(item);
            i++;
         }
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         hide();
         hideArr();
         _showSuccessRate = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIStrengthBG.ShowSuccessRate");
         var strI:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.ComposeStonStrip");
         var strII:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.LuckSignStrip");
         var strIII:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.ConsortiaAddStrip");
         var strIV:String = LanguageMgr.GetTranslation("store.StoreIIComposeBG.noVIPAllNumStrip");
         if(PlayerManager.Instance.Self.ConsortiaID == 0)
         {
            strIII = LanguageMgr.GetTranslation("tank.view.store.consortiaRateI");
         }
         _showSuccessRate.showAllTips(strI,strII,strIII,strIV);
         addChild(_showSuccessRate);
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 3; )
         {
            point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIComposeBG.Composepoint" + i);
            _pointArray.push(point);
            i++;
         }
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
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                        return;
                     }
                  }
               }
               else if(ds is ComposeItemCell)
               {
                  if(info.getRemainDate() <= 0)
                  {
                     MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
                  }
                  else
                  {
                     if(info.AgilityCompose == 50 && info.DefendCompose == 50 && info.AttackCompose == 50 && info.LuckCompose == 50)
                     {
                        MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.ComposeItemCell.up"));
                        return;
                     }
                     if(source.info.CanCompose)
                     {
                        SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                        return;
                     }
                  }
               }
            }
         }
         if(EquipType.isComposeStone(info) || info.CategoryID == 11 && info.Property1 == "7" || info.CategoryID == 11 && info.Property1 == "3")
         {
            var _loc9_:int = 0;
            var _loc8_:* = _items;
            for each(ds in _items)
            {
               if(ds is StoneCell && (ds as StoneCell).types.indexOf(info.Property1) > -1 && info.CategoryID == 11)
               {
                  SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,ds.index,info.Count,true);
                  return;
               }
            }
         }
      }
      
      public function startShine(cellId:int) : void
      {
         if(cellId != 3)
         {
            _items[cellId].startShine();
         }
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = items;
         for(itemPlace in items)
         {
            if(itemPlace < _items.length)
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
         }
      }
      
      public function updateData() : void
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            _items[i].info = PlayerManager.Instance.Self.StoreBag.items[i];
            i++;
         }
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _compose_btn.addEventListener("click",__composeClick);
         _buyStoneBtn.addEventListener("click",__buyStone);
         ConsortiaRateManager.instance.addEventListener("loadComplete_consortia",_consortiaLoadComplete);
      }
      
      private function userGuide() : void
      {
         var tmpInfo:* = null;
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(75))
         {
            tmpInfo = TaskManager.instance.getQuestByID(566);
            if(TaskManager.instance.isAvailableQuest(tmpInfo,true) && !tmpInfo.isCompleted)
            {
               NewHandQueue.Instance.push(new Step(72,exeWeaponTip,preWeaponTip,finWeaponTip));
               NewHandQueue.Instance.push(new Step(73,exeStoneTip,preStoneTip,finStoneTip));
            }
            TaskManager.instance.checkSendRequestAddQuestDic();
         }
      }
      
      private function preWeaponTip() : void
      {
         NewHandContainer.Instance.showArrow(13,0,"trainer.comWeaponArrowPos","asset.trainer.txtWeaponTip","trainer.comWeaponTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeWeaponTip() : Boolean
      {
         return _items[1].info;
      }
      
      private function finWeaponTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(870,PathManager.userName(),PathManager.solveRequestPath());
         NewHandContainer.Instance.clearArrowByID(13);
      }
      
      private function preStoneTip() : void
      {
         NewHandContainer.Instance.showArrow(13,360,"trainer.comStoneArrowPos","asset.trainer.txtComStoneTip","trainer.comStoneTipPos",LayerManager.Instance.getLayerByType(2));
      }
      
      private function exeStoneTip() : Boolean
      {
         return _items[2].info;
      }
      
      private function finStoneTip() : void
      {
         NoviceDataManager.instance.saveNoviceData(880,PathManager.userName(),PathManager.solveRequestPath());
         disposeUserGuide();
         showArr();
      }
      
      private function disposeUserGuide() : void
      {
         if(NewHandContainer.Instance.hasArrow(13))
         {
            NewHandContainer.Instance.clearArrowByID(13);
            NewHandQueue.Instance.dispose();
         }
      }
      
      private function __buyStone(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuy:ShortcutBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ShortcutBuyFrame");
         quickBuy.show(ITEMS,false,LanguageMgr.GetTranslation("store.view.Compose.buyCompose"),2);
      }
      
      private function showArr() : void
      {
         NewHandContainer.Instance.clearArrowByID(13);
         cpsArr.visible = true;
         _compose_btn_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         cpsArr.visible = false;
         _compose_btn_shineEffect.stop();
      }
      
      public function get area() : Array
      {
         return this._items;
      }
      
      private function __composeClick(evt:MouseEvent) : void
      {
         var alert:* = null;
         evt.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(_showDontClickTip())
         {
            return;
         }
         if(checkTipBindType())
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.StoreIIComposeBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert.addEventListener("response",_responseI);
         }
         else
         {
            hideArr();
            sendSocket();
         }
      }
      
      private function _responseV(evt:FrameEvent) : void
      {
         var _quick:* = null;
         SoundManager.instance.play("008");
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            _quick = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _quick.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            _quick.itemID = 11233;
            LayerManager.Instance.addToLayer(_quick,2,true,1);
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = BaseAlerFrame(e.currentTarget);
         alert.removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            sendSocket();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function sendSocket() : void
      {
         var consortiaState:Boolean = false;
         if(PlayerManager.Instance.Self.ConsortiaID != 0 && ConsortiaRateManager.instance.rate > 0)
         {
            consortiaState = true;
         }
         SocketManager.Instance.out.sendItemCompose(consortiaState);
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(75))
         {
            NoviceDataManager.instance.saveNoviceData(890,PathManager.userName(),PathManager.solveRequestPath());
            SocketManager.Instance.out.syncWeakStep(75);
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
         if(_items[2].itemInfo && _items[2].itemInfo.IsBinds)
         {
            return true;
         }
         return false;
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         if(getCountRate() <= 0)
         {
         }
         getCountRateI();
      }
      
      private function _showDontClickTip() : Boolean
      {
         if(_items[1].info == null && _items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontCompose"));
            return true;
         }
         if(_items[1].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontComposeI"));
            return true;
         }
         if(_items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.compose.dontComposeII"));
            return true;
         }
         return false;
      }
      
      private function getCountRate() : Number
      {
         var rate:* = 0;
         if(_items[1] == null || _items[1].info == null)
         {
            return rate;
         }
         if(_items[2] != null && _items[2].info != null)
         {
            rate = Number(composeRate[_items[2].info.Quality - 1] * 100);
         }
         if(rate > 0 && _items[0] != null && _items[0].info != null)
         {
            rate = Number((1 + _items[0].info.Property2 / 100) * rate);
         }
         rate = Number(rate * (1 + 0.1 * ConsortiaRateManager.instance.rate));
         rate = Number(Math.floor(rate * 10) / 10);
         rate = Number(rate > 100?100:Number(rate));
         return rate;
      }
      
      private function getCountRateI() : void
      {
         var tempRateI:* = 0;
         var tempRateII:* = 0;
         var tempRateIII:* = 0;
         var tempRateIV:* = 0;
         if(_items[1] == null || _items[1].info == null)
         {
            _showSuccessRate.showAllNum(tempRateI,tempRateII,tempRateIII,tempRateIV);
            return;
         }
         if(_items[2] != null && _items[2].info != null)
         {
            tempRateI = Number(composeRate[_items[2].info.Quality - 1] * 100);
         }
         if(tempRateI > 0 && _items[0] != null && _items[0].info != null)
         {
            tempRateII = Number(_items[0].info.Property2 / 100 * tempRateI);
         }
         tempRateIII = Number(tempRateI * (0.1 * ConsortiaRateManager.instance.rate));
         tempRateIV = Number(tempRateI + tempRateII + tempRateIII);
         tempRateI = Number(Math.floor(tempRateI * 10) / 10);
         tempRateII = Number(Math.floor(tempRateII * 10) / 10);
         tempRateIII = Number(Math.floor(tempRateIII * 10) / 10);
         tempRateIV = Number(Math.floor(tempRateIV * 10) / 10);
         tempRateI = Number(tempRateI > 100?100:Number(tempRateI));
         tempRateII = Number(tempRateII > 100?100:Number(tempRateII));
         tempRateIII = Number(tempRateIII > 100?100:Number(tempRateIII));
         tempRateIV = Number(tempRateIV > 100?100:Number(tempRateIV));
         _showSuccessRate.showAllNum(tempRateI,tempRateII,tempRateIII,tempRateIV);
      }
      
      public function consortiaRate() : void
      {
         ConsortiaRateManager.instance.reset();
      }
      
      private function _consortiaLoadComplete(e:Event) : void
      {
         __itemInfoChange(null);
      }
      
      public function show() : void
      {
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
         if(NewHandContainer.Instance.hasArrow(13))
         {
            NoviceDataManager.instance.saveNoviceData(860,PathManager.userName(),PathManager.solveRequestPath());
         }
         hideArr();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         disposeUserGuide();
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("change",__itemInfoChange);
            _items[i].dispose();
            _items[i] = null;
            i++;
         }
         _items = null;
         _compose_btn.removeEventListener("click",__composeClick);
         ConsortiaRateManager.instance.removeEventListener("loadComplete_consortia",_consortiaLoadComplete);
         EffectManager.Instance.removeEffect(_compose_btn_shineEffect);
         if(_area)
         {
            _area.dispose();
         }
         _area = null;
         _pointArray = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_luckyStoneCell)
         {
            ObjectUtils.disposeObject(_luckyStoneCell);
         }
         _luckyStoneCell = null;
         if(_strengthStoneCell)
         {
            ObjectUtils.disposeObject(_strengthStoneCell);
         }
         _strengthStoneCell = null;
         if(_compose_btn)
         {
            ObjectUtils.disposeObject(_compose_btn);
         }
         _compose_btn = null;
         if(_composeHelp)
         {
            ObjectUtils.disposeObject(_composeHelp);
         }
         _composeHelp = null;
         if(cpsArr)
         {
            ObjectUtils.disposeObject(cpsArr);
         }
         cpsArr = null;
         if(_cBuyluckyBtn)
         {
            ObjectUtils.disposeObject(_cBuyluckyBtn);
         }
         _cBuyluckyBtn = null;
         if(_buyStoneBtn)
         {
            ObjectUtils.disposeObject(_buyStoneBtn);
         }
         _buyStoneBtn = null;
         if(_consortiaSmith)
         {
            ObjectUtils.disposeObject(_consortiaSmith);
         }
         _consortiaSmith = null;
         if(_consortiaSmith)
         {
            ObjectUtils.disposeObject(_consortiaSmith);
         }
         _consortiaSmith = null;
         if(_showSuccessRate)
         {
            ObjectUtils.disposeObject(_showSuccessRate);
         }
         _showSuccessRate = null;
         if(_equipmentCell)
         {
            ObjectUtils.disposeObject(_equipmentCell);
         }
         _equipmentCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
