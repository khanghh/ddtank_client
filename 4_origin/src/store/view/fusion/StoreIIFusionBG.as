package store.view.fusion
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import quest.TaskManager;
   import store.IStoreViewBG;
   import store.StoreCell;
   import store.StoreDragInArea;
   import store.StrengthDataManager;
   import store.data.PreviewInfoII;
   import store.events.StoreIIEvent;
   import store.view.shortcutBuy.ShortcutBuyFrame;
   import trainer.controller.NewHandQueue;
   import trainer.controller.WeakGuildManager;
   import trainer.data.Step;
   import trainer.view.NewHandContainer;
   
   public class StoreIIFusionBG extends Sprite implements IStoreViewBG
   {
      
      private static const ITEMS:Array = [11301,11302,11303,11304,11201,11202,11203,11204];
      
      private static const ZOMM:Number = 0.75;
      
      public static var lastIndexFusion:int = -1;
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _accessoryFrameII:AccessoryFrameII;
      
      private var _fusion_btn:BaseButton;
      
      private var _fusion_btn_shineEffect:IEffect;
      
      private var _fusionHelp:BaseButton;
      
      private var fusionArr:MutipleImage;
      
      private var gold_txt:FilterFrameText;
      
      private var _goldIcon:Image;
      
      private var _goodName:FilterFrameText;
      
      private var _goodRate:FilterFrameText;
      
      private var _autoFusion:Boolean;
      
      private var _autoSelect:Boolean;
      
      private var _autoCheck:SelectedCheckButton;
      
      private var _pointArray:Vector.<Point>;
      
      private var _gold:int = 400;
      
      private var _maxCell:int = 0;
      
      private var _ckAutoSplit:SelectedCheckButton;
      
      private var _isAutoSplit:Boolean = false;
      
      private var _bg:Image;
      
      private var _fusionTitle:Bitmap;
      
      private var _goldTipText:FilterFrameText;
      
      private var _previewPanelBg:Image;
      
      private var _previewNameLabel:FilterFrameText;
      
      private var _previewRateLabel:FilterFrameText;
      
      private var _windowTime:int;
      
      private var _itemsPreview:Array;
      
      private var _alertBand:Boolean = false;
      
      public function StoreIIFusionBG()
      {
         super();
         init();
         initEvent();
      }
      
      public static function autoSplitSend(bagtype:int, place:int, tobagType:int, position:String, countNum:int, allMove:Boolean = false, cellParent:IStoreViewBG = null) : void
      {
         var sendParam:Array = getAutoSplitSendParam(position,countNum);
         var index:int = 0;
         var positionEmptyArray:Array = position.split(",");
         if(positionEmptyArray.length == 4)
         {
            if(sendParam)
            {
               clearFusion(cellParent);
               for(index = 0; index < sendParam.length; )
               {
                  if(sendParam[index] > 0)
                  {
                     SocketManager.Instance.out.sendMoveGoods(bagtype,place,tobagType,index + 1,sendParam[index],allMove);
                  }
                  index++;
               }
            }
         }
         else if(sendParam)
         {
            clearFusion(cellParent,positionEmptyArray);
            for(index = 0; index < sendParam.length; )
            {
               if(sendParam[index] > 0)
               {
                  SocketManager.Instance.out.sendMoveGoods(bagtype,place,tobagType,positionEmptyArray[index],sendParam[index],allMove);
               }
               index++;
            }
         }
         lastIndexFusion = -1;
      }
      
      public static function getRemainIndexByEmpty(fusionCount:int, cellParent:IStoreViewBG) : String
      {
         var ds:* = null;
         var i:int = 0;
         if(fusionCount >= 4)
         {
            return "1,2,3,4";
         }
         var resultStr:String = "";
         var emptyPostion:Array = [];
         if(cellParent is StoreIIFusionBG)
         {
            for(i = 1; i < 5; )
            {
               ds = (cellParent as StoreIIFusionBG).area[i];
               if(!ds.info)
               {
                  emptyPostion.push(ds.index);
               }
               i++;
            }
            switch(int(fusionCount) - 2)
            {
               case 0:
                  resultStr = emptyPostion.concat(findDiff(emptyPostion)).slice(0,fusionCount).splice(",");
                  break;
               case 1:
                  resultStr = emptyPostion.concat(findDiff(emptyPostion)).slice(0,fusionCount).splice(",");
            }
         }
         return resultStr;
      }
      
      private static function findDiff(searchArray:Array) : Array
      {
         var index:int = 0;
         var flag:Boolean = false;
         var value:int = 0;
         var resultArray:Array = [];
         for(index = 1; index < 5; )
         {
            flag = false;
            for(value = 0; value < searchArray.length; )
            {
               if(index == int(searchArray[value]))
               {
                  flag = true;
               }
               value++;
            }
            if(!flag)
            {
               resultArray.push(index);
            }
            index++;
         }
         return resultArray;
      }
      
      private static function getAutoSplitSendParam(position:String, countNum:int) : Array
      {
         var remainNum:int = 0;
         var perNum:int = 0;
         var i:int = 0;
         var resultSend:Array = [];
         var posArray:Array = position.split(",");
         if(posArray && countNum >= 1)
         {
            remainNum = countNum % posArray.length;
            perNum = countNum / posArray.length;
            for(i = 0; i < posArray.length; )
            {
               remainNum--;
               resultSend.push(perNum + getRemainCellNumber(remainNum));
               i++;
            }
         }
         return resultSend;
      }
      
      private static function getRemainCellNumber(remainNum:int) : int
      {
         return remainNum > 0?1:0;
      }
      
      private static function clearFusion(cellParent:IStoreViewBG, removePosition:Array = null) : void
      {
         var ds:* = null;
         var j:int = 0;
         var i:int = 0;
         if(!removePosition)
         {
            for(i = 1; i < 5; )
            {
               ds = (cellParent as StoreIIFusionBG).area[i];
               if(ds.info)
               {
                  SocketManager.Instance.out.sendMoveGoods(12,ds.index,ds.itemBagType,-1);
               }
               i++;
            }
            return;
         }
         for(j = 0; j < removePosition.length; )
         {
            for(i = 1; i < 5; )
            {
               ds = (cellParent as StoreIIFusionBG).area[i];
               if(ds.info && ds.index == int(removePosition[j]))
               {
                  SocketManager.Instance.out.sendMoveGoods(12,ds.index,ds.itemBagType,-1);
                  break;
               }
               i++;
            }
            j++;
         }
      }
      
      public function get isAutoSplit() : Boolean
      {
         return _isAutoSplit;
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.FusionBg");
         addChild(_bg);
         _fusionTitle = ComponentFactory.Instance.creatBitmap("asset.ddtstore.FusionTitle");
         addChild(_fusionTitle);
         _previewPanelBg = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelBg");
         addChild(_previewPanelBg);
         _previewNameLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelNameLabel");
         _previewNameLabel.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.PreviewNameLabelText");
         addChild(_previewNameLabel);
         _previewRateLabel = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewPanelRateLabel");
         _previewRateLabel.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.PreviewRateLabelText");
         addChild(_previewRateLabel);
         _items = [];
         getCellsPoint();
         for(i = 0; i < 6; )
         {
            if(i == 0)
            {
               item = new FusionItemCellII(i);
            }
            else if(i == 5)
            {
               item = new FusionItemCell(i);
               var _loc3_:* = 0.75;
               item.scaleY = _loc3_;
               item.scaleX = _loc3_;
               FusionItemCell(item).mouseEvt = false;
               FusionItemCell(item).bgVisible = false;
            }
            else
            {
               item = new FusionItemCell(i);
            }
            item.x = _pointArray[i].x;
            item.y = _pointArray[i].y;
            addChild(item);
            if(i != 5)
            {
               item.addEventListener("change",__itemInfoChange);
            }
            _items.push(item);
            i++;
         }
         _accessoryFrameII = new AccessoryFrameII();
         _area = new StoreDragInArea(_items);
         addChildAt(_area,0);
         _fusion_btn = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.FusionBtn");
         _fusion_btn_shineEffect = EffectManager.Instance.creatEffect(4,_fusion_btn,{"color":"gold"});
         addChild(_fusion_btn);
         _fusionHelp = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.say"),"ddtstore.HelpFrame.FusionText",404,484);
         fusionArr = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.ArrowHeadFusionTip");
         addChild(fusionArr);
         _goldTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.NeedMoneyTipText");
         _goldTipText.text = LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.NeedMoneyTipText");
         addChild(_goldTipText);
         gold_txt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.NeedMoneyText");
         addChild(gold_txt);
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.GoldIcon");
         addChild(_goldIcon);
         _goodName = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewNameText");
         addChild(_goodName);
         _goodRate = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.PreviewSucessRateText");
         addChild(_goodRate);
         _autoCheck = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIIFusionBG.ContinuousFusionCheckButton");
         addChild(_autoCheck);
         _ckAutoSplit = ComponentFactory.Instance.creat("ddtstore.StoreIIFusionBG.SellLeftAlerAutoSplitCk");
         _ckAutoSplit.text = LanguageMgr.GetTranslation("store.fusion.autoSplit");
         addChild(_ckAutoSplit);
         _ckAutoSplit.selected = _isAutoSplit;
         hideArr();
         hide();
      }
      
      private function initEvent() : void
      {
         _fusion_btn.addEventListener("click",__fusionClick);
         _accessoryFrameII.addEventListener("itemclick",__accessoryItemClick);
         _autoCheck.addEventListener("select",__selectedChanged);
         _ckAutoSplit.addEventListener("select",__autoSplit);
         SocketManager.Instance.addEventListener(PkgEvent.format(76),__upPreview);
         StrengthDataManager.instance.addEventListener("fusionFinish",__fusionFinish);
      }
      
      private function removeEvents() : void
      {
         var i:int = 0;
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("change",__itemInfoChange);
            _items[i].dispose();
            i++;
         }
         _fusion_btn.removeEventListener("click",__fusionClick);
         _accessoryFrameII.removeEventListener("itemclick",__accessoryItemClick);
         _autoCheck.removeEventListener("select",__selectedChanged);
         SocketManager.Instance.removeEventListener(PkgEvent.format(76),__upPreview);
         StrengthDataManager.instance.removeEventListener("fusionFinish",__fusionFinish);
         if(_ckAutoSplit)
         {
            _ckAutoSplit.removeEventListener("select",__autoSplit);
         }
      }
      
      private function userGuide() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(88) && TaskManager.instance.isAchieved(TaskManager.instance.getQuestByID(351)))
         {
            NewHandQueue.Instance.push(new Step(74,exeItemTip,preItemTip,finItemTip));
         }
      }
      
      private function preItemTip() : void
      {
         NewHandContainer.Instance.showArrow(15,0,"trainer.fusItemArrowPos","asset.trainer.txtFusItemTip","trainer.fusItemTipPos");
      }
      
      private function exeItemTip() : Boolean
      {
         var fusionType:int = 0;
         var i:int = 0;
         if(checkItemEmpty() >= 4)
         {
            fusionType = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            for(i = 2; i <= 4; )
            {
               if(fusionType != PlayerManager.Instance.Self.StoreBag.items[i].FusionType)
               {
                  return false;
               }
               i++;
            }
            return true;
         }
         return false;
      }
      
      private function finItemTip() : void
      {
         disposeUserGuide();
      }
      
      private function disposeUserGuide() : void
      {
         NewHandContainer.Instance.clearArrowByID(15);
         NewHandQueue.Instance.dispose();
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 6; )
         {
            point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIIFusionBG.Fusionpoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function __buyBtnClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuy:ShortcutBuyFrame = ComponentFactory.Instance.creatCustomObject("ddtstore.ShortcutBuyFrame");
         quickBuy.show(ITEMS,true,LanguageMgr.GetTranslation("store.view.fusion.buyFormula"),4);
      }
      
      public function dragDrop(source:BagCell) : void
      {
         var ds:* = null;
         var i:int = 0;
         if(source == null)
         {
            return;
         }
         if(_accessoryFrameII.containsItem(source.itemInfo))
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         var _loc6_:int = 0;
         var _loc5_:* = _items;
         for each(ds in _items)
         {
            if(ds.info == info)
            {
               ds.info = null;
               source.locked = false;
               return;
            }
         }
         for(i = 1; i < 5; )
         {
            ds = _items[i];
            if(ds is FusionItemCell)
            {
               if(info.getRemainDate() <= 0)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryDragInArea.overdue"));
               }
               else if(info.FusionType != 0 && info.FusionRate != 0)
               {
                  if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
                  {
                     __moveGoods(info,1);
                     return;
                  }
                  if(ds.info == null)
                  {
                     __moveGoods(info,ds.index);
                     return;
                  }
               }
               else
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.AccessoryItemCell.fusion"));
                  return;
               }
            }
            i++;
         }
      }
      
      private function __moveGoods(info:InventoryItemInfo, index:int) : void
      {
         var _aler:* = null;
         if(StrengthDataManager.instance.autoFusion)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.fusion.donMoveGoods"));
            return;
         }
         if(info.Count > 1 && !_isAutoSplit)
         {
            _aler = ComponentFactory.Instance.creat("ddtstore.FusionSelectNumAlertFrame");
            _aler.goodsinfo = info;
            _aler.index = index;
            _aler.show(info.Count);
            _aler.addEventListener("sell",_alerSell);
            _aler.addEventListener("notsell",_alerNotSell);
         }
         else if(info.Count > 1 && _isAutoSplit)
         {
            autoSplitSend(info.BagType,info.Place,12,getRemainIndexByEmpty(info.Count,this),info.Count,true,this);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,index,info.Count,true);
         }
      }
      
      private function _alerSell(e:FusionSelectEvent) : void
      {
         var _aler:FusionSelectNumAlertFrame = e.currentTarget as FusionSelectNumAlertFrame;
         SocketManager.Instance.out.sendMoveGoods(e.info.BagType,e.info.Place,12,e.index,e.sellCount,true);
         _aler.removeEventListener("sell",_alerSell);
         _aler.removeEventListener("notsell",_alerNotSell);
         _aler.dispose();
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function _alerNotSell(e:FusionSelectEvent) : void
      {
         var _aler:FusionSelectNumAlertFrame = e.currentTarget as FusionSelectNumAlertFrame;
         _aler.removeEventListener("sell",_alerSell);
         _aler.removeEventListener("notsell",_alerNotSell);
         _aler.dispose();
         if(_aler && _aler.parent)
         {
            removeChild(_aler);
         }
         _aler = null;
      }
      
      private function _showDontClickTip() : Boolean
      {
         var fusionType:int = 0;
         var len:int = 0;
         var i:int = 0;
         var j:int = 0;
         var stones:int = checkItemEmpty();
         if(stones == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.noEquip"));
            return true;
         }
         if(stones < 4)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notEnoughStone"));
            return true;
         }
         if(stones == 4)
         {
            fusionType = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            len = 5;
            for(i = 2; i < len; )
            {
               if(fusionType != PlayerManager.Instance.Self.StoreBag.items[i].FusionType)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notSameStone"));
                  return true;
               }
               i++;
            }
            for(j = 2; j < len; )
            {
               if(_items[1].info.TemplateID != _items[j].info.TemplateID)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.fusion.notSameLevelStone"));
                  return true;
               }
               j++;
            }
         }
         return false;
      }
      
      private function showIt() : void
      {
         showArr();
      }
      
      public function get area() : Array
      {
         return this._items;
      }
      
      public function refreshData(items:Dictionary) : void
      {
         var itemPlace:* = 0;
         var fusionType:int = 0;
         var len:int = 0;
         var i:int = 0;
         var _loc8_:int = 0;
         var _loc7_:* = items;
         for(itemPlace in items)
         {
            if(itemPlace < 5)
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
            }
            else
            {
               _accessoryFrameII.setItemInfo(itemPlace,PlayerManager.Instance.Self.StoreBag.items[itemPlace]);
            }
         }
         if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
         {
            if(_items[0].info != null)
            {
               SocketManager.Instance.out.sendMoveGoods(12,FusionItemCellII(_items[0]).index,FusionItemCellII(_items[0]).itemBagType,-1);
            }
            __previewRequest();
            fusionType = PlayerManager.Instance.Self.StoreBag.items[1].FusionType;
            len = 5;
            for(i = 2; i < len; )
            {
               if(fusionType != PlayerManager.Instance.Self.StoreBag.items[i].FusionType)
               {
                  _clearPreview();
               }
               i++;
            }
         }
         else
         {
            _clearPreview();
            autoFusion = false;
         }
      }
      
      private function __fusionFinish(e:Event) : void
      {
         if(_items[1].info != null && _items[2].info != null && _items[3].info != null && _items[4].info != null)
         {
            __checkAuto();
         }
         else
         {
            _clearPreview();
            autoFusion = false;
         }
      }
      
      private function __checkAuto() : void
      {
         if(autoFusion)
         {
            auto = function():void
            {
               checkfunsion();
            };
            _windowTime = setTimeout(auto,1000);
         }
      }
      
      public function updateData() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < 5; )
         {
            _items[i].info = PlayerManager.Instance.Self.StoreBag.items[i];
            i++;
         }
         for(j = 5; j < 11; )
         {
            _accessoryFrameII.setItemInfo(j,PlayerManager.Instance.Self.StoreBag.items[j + 5]);
            j++;
         }
      }
      
      public function startShine(cellId:int) : void
      {
         _items[cellId].startShine();
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 0; i < 5; )
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      private function showArr() : void
      {
         if(autoFusion)
         {
            return;
         }
         fusionArr.visible = true;
         _fusion_btn_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         fusionArr.visible = false;
         _fusion_btn_shineEffect.stop();
      }
      
      public function show() : void
      {
         this.visible = true;
         updateData();
         if(WeakGuildManager.Instance.switchUserGuide)
         {
            userGuide();
         }
      }
      
      public function hide() : void
      {
         autoFusion = false;
         this.visible = false;
         _accessoryFrameII.hide();
         disposeUserGuide();
      }
      
      private function __upPreview(evt:PkgEvent) : void
      {
         var isBin:Boolean = false;
         var i:int = 0;
         var info:* = null;
         var j:int = 0;
         var info1:* = null;
         hideArr();
         var count:int = evt.pkg.readInt();
         _itemsPreview = [];
         for(i = 0; i < count; )
         {
            info = new PreviewInfoII();
            info.data(evt.pkg.readInt(),evt.pkg.readInt());
            info.rate = evt.pkg.readInt();
            _itemsPreview.push(info);
            i++;
         }
         isBin = evt.pkg.readBoolean();
         for(j = 0; j < _itemsPreview.length; )
         {
            info1 = _itemsPreview[j] as PreviewInfoII;
            info1.info.IsBinds = isBin;
            j++;
         }
         _showPreview();
         showArr();
      }
      
      private function _showPreview() : void
      {
         _items[5].info = _itemsPreview[0].info;
         _goodName.text = String(_itemsPreview[0].info.Name);
         _goodRate.text = _itemsPreview[0].rate <= 5?LanguageMgr.GetTranslation("store.fusion.preview.LowRate"):String(_itemsPreview[0].rate) + "%";
      }
      
      private function _clearPreview() : void
      {
         _items[5].info = null;
         _goodName.text = "";
         _goodRate.text = "0%";
      }
      
      private function __accessoryItemClick(evt:StoreIIEvent) : void
      {
         gold_txt.text = String((checkItemEmpty() + _accessoryFrameII.getCount()) * _gold);
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         var stones:int = 0;
         stones = checkItemEmpty();
         gold_txt.text = String((stones + _accessoryFrameII.getCount()) * _gold);
         _clearPreview();
         hideArr();
      }
      
      private function checkItemEmpty() : int
      {
         var stones:int = 0;
         if(PlayerManager.Instance.Self.StoreBag.items[1] != null)
         {
            stones++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[2] != null)
         {
            stones++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[3] != null)
         {
            stones++;
         }
         if(PlayerManager.Instance.Self.StoreBag.items[4] != null)
         {
            stones++;
         }
         return stones;
      }
      
      private function isAllBinds() : int
      {
         var stones:int = 0;
         if(_items[1].info != null && _items[1].info.IsBinds)
         {
            stones++;
         }
         if(_items[2].info != null && _items[2].info.IsBinds)
         {
            stones++;
         }
         if(_items[3].info != null && _items[3].info.IsBinds)
         {
            stones++;
         }
         if(_items[4].info != null && _items[4].info.IsBinds)
         {
            stones++;
         }
         return stones;
      }
      
      private function __fusionClick(evt:MouseEvent) : void
      {
         if(evt != null)
         {
            evt.stopImmediatePropagation();
         }
         SoundManager.instance.play("008");
         _alertBand = false;
         checkfunsion();
      }
      
      private function checkfunsion() : void
      {
         var alert:* = null;
         var alert1:* = null;
         var alert2:* = null;
         if(_showDontClickTip())
         {
            return;
         }
         if(PlayerManager.Instance.Self.Gold < (_accessoryFrameII.getCount() + 4) * _gold)
         {
            autoFusion = false;
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
            alert.moveEnable = false;
            alert.addEventListener("response",_responseV);
            return;
         }
         if(isAllBinds() != 0 && isAllBinds() != 4 && !_alertBand)
         {
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert1.addEventListener("response",_response);
            _alertBand = true;
            return;
         }
         if(this._accessoryFrameII.isBinds && isAllBinds() != 4)
         {
            alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.view.fusion.StoreIIFusionBG.use"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert2.addEventListener("response",_response);
            return;
         }
         sendFusionRequest();
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
      
      private function _response(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = BaseAlerFrame(e.currentTarget);
         alert.removeEventListener("response",_response);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            sendFusionRequest();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function testingSXJ() : Boolean
      {
         var i:int = 0;
         var b:Boolean = false;
         for(i = 0; i < _items.length; )
         {
            if(EquipType.isRongLing(_items[i].info))
            {
               b = true;
               break;
            }
            i++;
         }
         return b;
      }
      
      private function sendFusionRequest() : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(88))
         {
            SocketManager.Instance.out.syncWeakStep(88);
         }
         if(autoSelect)
         {
            autoFusion = true;
            _fusion_btn.enable = true;
            hideArr();
         }
      }
      
      private function __previewRequest() : void
      {
      }
      
      private function __selectedChanged(event:Event) : void
      {
         SoundManager.instance.play("008");
         autoSelect = _autoCheck.selected;
         if(autoSelect == false)
         {
            autoFusion = false;
         }
      }
      
      private function __autoSplit(e:Event) : void
      {
         SoundManager.instance.play("008");
         _isAutoSplit = _ckAutoSplit.selected;
         StoreIIFusionBG.lastIndexFusion = -1;
      }
      
      public function set autoSelect(value:Boolean) : void
      {
         _autoSelect = value;
      }
      
      public function get autoSelect() : Boolean
      {
         return _autoSelect;
      }
      
      public function set autoFusion(value:Boolean) : void
      {
         _autoFusion = value;
         StrengthDataManager.instance.autoFusion = _autoFusion;
         if(!_autoFusion)
         {
            _fusion_btn.enable = true;
            clearTimeout(_windowTime);
            if(_items[5].info != null)
            {
               showArr();
            }
         }
      }
      
      public function get autoFusion() : Boolean
      {
         return _autoFusion;
      }
      
      public function dispose() : void
      {
         EffectManager.Instance.removeEffect(_fusion_btn_shineEffect);
         StoreIIFusionBG.lastIndexFusion = -1;
         removeEvents();
         disposeUserGuide();
         clearTimeout(_windowTime);
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_fusionTitle)
         {
            ObjectUtils.disposeObject(_fusionTitle);
         }
         _fusionTitle = null;
         if(_previewPanelBg)
         {
            ObjectUtils.disposeObject(_previewPanelBg);
         }
         _previewPanelBg = null;
         if(_previewNameLabel)
         {
            ObjectUtils.disposeObject(_previewNameLabel);
         }
         _previewNameLabel = null;
         if(_previewRateLabel)
         {
            ObjectUtils.disposeObject(_previewRateLabel);
         }
         _previewRateLabel = null;
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_accessoryFrameII)
         {
            ObjectUtils.disposeObject(_accessoryFrameII);
         }
         _accessoryFrameII = null;
         if(_fusion_btn)
         {
            ObjectUtils.disposeObject(_fusion_btn);
         }
         _fusion_btn = null;
         if(_fusionHelp)
         {
            ObjectUtils.disposeObject(_fusionHelp);
         }
         _fusionHelp = null;
         if(fusionArr)
         {
            ObjectUtils.disposeObject(fusionArr);
         }
         fusionArr = null;
         if(_goldTipText)
         {
            ObjectUtils.disposeObject(_goldTipText);
         }
         _goldTipText = null;
         if(gold_txt)
         {
            ObjectUtils.disposeObject(gold_txt);
         }
         gold_txt = null;
         if(_goldIcon)
         {
            ObjectUtils.disposeObject(_goldIcon);
         }
         _goldIcon = null;
         if(_goodName)
         {
            ObjectUtils.disposeObject(_goodName);
         }
         _goodName = null;
         if(_goodRate)
         {
            ObjectUtils.disposeObject(_goodRate);
         }
         _goodRate = null;
         if(_autoCheck)
         {
            ObjectUtils.disposeObject(_autoCheck);
         }
         _autoCheck = null;
         if(_ckAutoSplit)
         {
            ObjectUtils.disposeObject(_ckAutoSplit);
            _ckAutoSplit = null;
         }
         _pointArray = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
