package store.view.transfer
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   import store.IStoreViewBG;
   import store.view.ConsortiaRateManager;
   import store.view.StoneCellFrame;
   
   public class StoreIITransferBG extends Sprite implements IStoreViewBG
   {
       
      
      private var _bg:MutipleImage;
      
      private var _area:TransferDragInArea;
      
      private var _items:Vector.<TransferItemCell>;
      
      private var _transferBtnAsset:BaseButton;
      
      private var _transferHelpAsset:BaseButton;
      
      private var transShine:MovieImage;
      
      private var transArr:MutipleImage;
      
      private var _pointArray:Vector.<Point>;
      
      private var gold_txt:FilterFrameText;
      
      private var _goldIcon:Image;
      
      private var _transferBefore:Boolean = false;
      
      private var _transferAfter:Boolean = false;
      
      private var _equipmentCell1:StoneCellFrame;
      
      private var _equipmentCell2:StoneCellFrame;
      
      private var _transferArrow:Bitmap;
      
      private var _transferTitleSmall:Bitmap;
      
      private var _transferTitleLarge:Bitmap;
      
      private var _neededGoldTipText:FilterFrameText;
      
      private var _transferBtnAsset_shineEffect:IEffect;
      
      public function StoreIITransferBG()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         var i:int = 0;
         var item:* = null;
         _transferTitleSmall = ComponentFactory.Instance.creatBitmap("asset.ddtstore.TransferTitleSmall");
         _transferTitleLarge = ComponentFactory.Instance.creatBitmap("asset.ddtstore.TransferTitleLarge");
         addChild(_transferTitleSmall);
         addChild(_transferTitleLarge);
         _equipmentCell1 = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIITransferBG.EquipmentCell1");
         _equipmentCell2 = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIITransferBG.EquipmentCell2");
         var _loc3_:* = LanguageMgr.GetTranslation("store.Strength.StrengthenEquipmentCellText");
         _equipmentCell2.label = _loc3_;
         _equipmentCell1.label = _loc3_;
         addChild(_equipmentCell1);
         addChild(_equipmentCell2);
         _transferArrow = ComponentFactory.Instance.creatBitmap("asset.ddtstore.TransferArrow");
         addChild(_transferArrow);
         _transferBtnAsset = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIITransferBG.TransferBtn");
         addChild(_transferBtnAsset);
         _transferBtnAsset_shineEffect = EffectManager.Instance.creatEffect(4,_transferBtnAsset,{"color":"gold"});
         _transferHelpAsset = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.move"),"ddtstore.HelpFrame.TransferText",404,484);
         transArr = ComponentFactory.Instance.creatComponentByStylename("ddtstore.ArrowHeadTransferTip");
         addChild(transArr);
         _neededGoldTipText = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIITransferBG.NeededGoldTipText");
         _neededGoldTipText.text = LanguageMgr.GetTranslation("store.Transfer.NeededGoldTipText");
         addChild(_neededGoldTipText);
         gold_txt = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIITarnsferBG.NeedMoneyText");
         addChild(gold_txt);
         _goldIcon = ComponentFactory.Instance.creatComponentByStylename("ddtstore.StoreIITransferBG.GoldIcon");
         addChild(_goldIcon);
         getCellsPoint();
         _items = new Vector.<TransferItemCell>();
         for(i = 0; i < 2; )
         {
            item = new TransferItemCell(i);
            item.addEventListener("change",__itemInfoChange);
            item.x = _pointArray[i].x;
            item.y = _pointArray[i].y;
            addChild(item);
            _items.push(item);
            i++;
         }
         _area = new TransferDragInArea(_items);
         addChildAt(_area,0);
         hideArr();
         hide();
      }
      
      private function getCellsPoint() : void
      {
         var i:int = 0;
         var point:* = null;
         _pointArray = new Vector.<Point>();
         for(i = 0; i < 2; )
         {
            point = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIITransferBG.Transferpoint" + i);
            _pointArray.push(point);
            i++;
         }
      }
      
      private function initEvent() : void
      {
         _transferBtnAsset.addEventListener("click",__transferHandler);
      }
      
      private function removeEvent() : void
      {
         _transferBtnAsset.removeEventListener("click",__transferHandler);
      }
      
      public function startShine(cellId:int) : void
      {
         _items[cellId].startShine();
      }
      
      public function stopShine() : void
      {
         var i:int = 0;
         for(i = 0; i < 2; )
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      private function showArr() : void
      {
         transArr.visible = true;
         _transferBtnAsset_shineEffect.play();
      }
      
      private function hideArr() : void
      {
         transArr.visible = false;
         _transferBtnAsset_shineEffect.stop();
      }
      
      public function get area() : Vector.<TransferItemCell>
      {
         return _items;
      }
      
      public function dragDrop(source:BagCell) : void
      {
         if(source == null)
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var item in _items)
         {
            if(item.info == null)
            {
               if(_items[0].info && _items[0].info.CategoryID != info.CategoryID || _items[1].info && _items[1].info.CategoryID != info.CategoryID)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.put"));
                  return;
               }
               SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,item.index,1);
               return;
            }
         }
      }
      
      private function __transferHandler(evt:MouseEvent) : void
      {
         var alert:* = null;
         var infoText:* = null;
         var alert2:* = null;
         SoundManager.instance.play("008");
         evt.stopImmediatePropagation();
         var item1:TransferItemCell = _items[0] as TransferItemCell;
         var item2:TransferItemCell = _items[1] as TransferItemCell;
         if(_showDontClickTip())
         {
            return;
         }
         if(item1.info && item2.info)
         {
            if(PlayerManager.Instance.Self.Gold < Number(gold_txt.text))
            {
               alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               alert.moveEnable = false;
               alert.addEventListener("response",_responseV);
               return;
            }
            hideArr();
            _transferAfter = false;
            _transferBefore = false;
            infoText = "";
            if(EquipType.isArm(item1.info) || EquipType.isCloth(item1.info) || EquipType.isHead(item1.info) || EquipType.isArm(item2.info) || EquipType.isCloth(item2.info) || EquipType.isHead(item2.info))
            {
               infoText = LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.sure2");
            }
            else
            {
               infoText = LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.sure");
            }
            alert2 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),infoText,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            alert2.addEventListener("response",_responseII);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.EmptyItem"));
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
      
      private function _response(e:FrameEvent) : void
      {
         if(e.responseCode == 3)
         {
            depositAction();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function _responseII(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = BaseAlerFrame(e.currentTarget);
         alert.removeEventListener("response",_responseII);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            _transferAfter = true;
            _transferBefore = true;
            sendSocket();
         }
         else
         {
            cannel();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function cannel() : void
      {
         showArr();
      }
      
      private function depositAction() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("setFlashCall");
         }
      }
      
      private function isComposeStrengthen(info:BagCell) : Boolean
      {
         if(info.itemInfo.StrengthenLevel > 0)
         {
            return true;
         }
         if(info.itemInfo.AttackCompose > 0)
         {
            return true;
         }
         if(info.itemInfo.DefendCompose > 0)
         {
            return true;
         }
         if(info.itemInfo.LuckCompose > 0)
         {
            return true;
         }
         if(info.itemInfo.AgilityCompose > 0)
         {
            return true;
         }
         if(info.itemInfo.MagicLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      private function sendSocket() : void
      {
         SocketManager.Instance.out.sendItemTransfer(_transferBefore,_transferAfter);
      }
      
      private function __itemInfoChange(evt:Event) : void
      {
         gold_txt.text = "0";
         var item1:TransferItemCell = _items[0];
         var item2:TransferItemCell = _items[1];
         if(item1.info)
         {
            item1.categoryId = -1;
            if(item2.info)
            {
               item1.categoryId = item1.info.CategoryID;
            }
            item2.categoryId = item1.info.CategoryID;
         }
         else
         {
            item2.categoryId = -1;
            if(item2.info)
            {
               item1.categoryId = item2.info.CategoryID;
            }
            else
            {
               item1.categoryId = -1;
            }
         }
         if(item1.info)
         {
            var _loc4_:* = item1.info.RefineryLevel;
            item2.Refinery = _loc4_;
            item1.Refinery = _loc4_;
         }
         else if(item2.info)
         {
            _loc4_ = item2.info.RefineryLevel;
            item2.Refinery = _loc4_;
            item1.Refinery = _loc4_;
         }
         else
         {
            _loc4_ = -1;
            item2.Refinery = _loc4_;
            item1.Refinery = _loc4_;
         }
         if(item1.info && item2.info)
         {
            if(item1.info.CategoryID != item2.info.CategoryID)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.put"));
               return;
            }
            if(isComposeStrengthen(item1) || isOpenHole(item1) || isHasBead(item1) || isComposeStrengthen(item2) || isOpenHole(item2) || isHasBead(item2) || item1.itemInfo.isHasLatentEnergy || item2.itemInfo.isHasLatentEnergy)
            {
               showArr();
               goldMoney();
            }
            else
            {
               hideArr();
            }
         }
         else
         {
            hideArr();
         }
         if(item1.info && !item2.info)
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(item1.info,true);
         }
         else if(item2.info && !item1.info)
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(item2.info,true);
         }
         else
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(null,false);
         }
      }
      
      private function _showDontClickTip() : Boolean
      {
         var item1:TransferItemCell = _items[0];
         var item2:TransferItemCell = _items[1];
         if(item1.info == null && item2.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.NoItem"));
            return true;
         }
         if(item1.info == null || item2.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.EmptyItem"));
            return true;
         }
         if(!isComposeStrengthen(item1) && !isOpenHole(item1) && !isHasBead(item1) && !isComposeStrengthen(item2) && !isOpenHole(item2) && !isHasBead(item2) && !item1.itemInfo.isHasLatentEnergy && !item2.itemInfo.isHasLatentEnergy)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.transfer.dontTransferII"));
            return true;
         }
         return false;
      }
      
      private function isHasBead(info:BagCell) : Boolean
      {
         var item:InventoryItemInfo = info.itemInfo;
         return item.Hole1 + item.Hole2 + item.Hole3 + item.Hole4 + item.Hole5 + item.Hole6 > 0;
      }
      
      private function isOpenHole(info:BagCell) : Boolean
      {
         if(info.itemInfo.Hole5Level > 0 || info.itemInfo.Hole6Level > 0 || info.itemInfo.Hole5Exp > 0 || info.itemInfo.Hole6Exp > 0)
         {
            return true;
         }
         return false;
      }
      
      private function goldMoney() : void
      {
         gold_txt.text = "40000";
      }
      
      public function show() : void
      {
         initEvent();
         this.visible = true;
         updateData();
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
         for(i = 0; i < 2; )
         {
            _items[i].info = PlayerManager.Instance.Self.StoreBag.items[i];
            i++;
         }
      }
      
      public function hide() : void
      {
         removeEvent();
         this.visible = false;
         hideArr();
      }
      
      public function clearTransferItemCell() : void
      {
         var item1:TransferItemCell = _items[0];
         var item2:TransferItemCell = _items[1];
         if(item1.info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,item1.index,item1.itemBagType,-1);
         }
         if(item2.info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,item2.index,item2.itemBagType,-1);
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         removeEvent();
         for(i = 0; i < _items.length; )
         {
            _items[i].removeEventListener("change",__itemInfoChange);
            _items[i].dispose();
            i++;
         }
         _items = null;
         EffectManager.Instance.removeEffect(_transferBtnAsset_shineEffect);
         _pointArray = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_neededGoldTipText)
         {
            ObjectUtils.disposeObject(_neededGoldTipText);
         }
         _neededGoldTipText = null;
         if(_goldIcon)
         {
            ObjectUtils.disposeObject(_goldIcon);
         }
         _goldIcon = null;
         if(_transferTitleLarge)
         {
            ObjectUtils.disposeObject(_transferTitleLarge);
         }
         _transferTitleLarge = null;
         if(_transferTitleSmall)
         {
            ObjectUtils.disposeObject(_transferTitleSmall);
         }
         _transferTitleSmall = null;
         if(_transferArrow)
         {
            ObjectUtils.disposeObject(_transferArrow);
         }
         _transferArrow = null;
         if(_equipmentCell1)
         {
            ObjectUtils.disposeObject(_equipmentCell1);
         }
         _equipmentCell1 = null;
         if(_equipmentCell2)
         {
            ObjectUtils.disposeObject(_equipmentCell2);
         }
         _equipmentCell2 = null;
         if(_area)
         {
            ObjectUtils.disposeObject(_area);
         }
         _area = null;
         if(_transferBtnAsset)
         {
            ObjectUtils.disposeObject(_transferBtnAsset);
         }
         _transferBtnAsset = null;
         if(_transferHelpAsset)
         {
            ObjectUtils.disposeObject(_transferHelpAsset);
         }
         _transferHelpAsset = null;
         if(transShine)
         {
            ObjectUtils.disposeObject(transShine);
         }
         transShine = null;
         if(transArr)
         {
            ObjectUtils.disposeObject(transArr);
         }
         transArr = null;
         if(gold_txt)
         {
            ObjectUtils.disposeObject(gold_txt);
         }
         gold_txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
