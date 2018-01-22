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
         var _loc2_:int = 0;
         var _loc1_:* = null;
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
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = new TransferItemCell(_loc2_);
            _loc1_.addEventListener("change",__itemInfoChange);
            _loc1_.x = _pointArray[_loc2_].x;
            _loc1_.y = _pointArray[_loc2_].y;
            addChild(_loc1_);
            _items.push(_loc1_);
            _loc2_++;
         }
         _area = new TransferDragInArea(_items);
         addChildAt(_area,0);
         hideArr();
         hide();
      }
      
      private function getCellsPoint() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _pointArray = new Vector.<Point>();
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ddtstore.StoreIITransferBG.Transferpoint" + _loc2_);
            _pointArray.push(_loc1_);
            _loc2_++;
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
      
      public function startShine(param1:int) : void
      {
         _items[param1].startShine();
      }
      
      public function stopShine() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _items[_loc1_].stopShine();
            _loc1_++;
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
      
      public function dragDrop(param1:BagCell) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:InventoryItemInfo = param1.info as InventoryItemInfo;
         var _loc5_:int = 0;
         var _loc4_:* = _items;
         for each(var _loc2_ in _items)
         {
            if(_loc2_.info == null)
            {
               if(_items[0].info && _items[0].info.CategoryID != _loc3_.CategoryID || _items[1].info && _items[1].info.CategoryID != _loc3_.CategoryID)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.fusion.TransferItemCell.put"));
                  return;
               }
               SocketManager.Instance.out.sendMoveGoods(_loc3_.BagType,_loc3_.Place,12,_loc2_.index,1);
               return;
            }
         }
      }
      
      private function __transferHandler(param1:MouseEvent) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         SoundManager.instance.play("008");
         param1.stopImmediatePropagation();
         var _loc3_:TransferItemCell = _items[0] as TransferItemCell;
         var _loc2_:TransferItemCell = _items[1] as TransferItemCell;
         if(_showDontClickTip())
         {
            return;
         }
         if(_loc3_.info && _loc2_.info)
         {
            if(PlayerManager.Instance.Self.Gold < Number(gold_txt.text))
            {
               _loc5_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("tank.room.RoomIIView2.notenoughmoney.title"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,2);
               _loc5_.moveEnable = false;
               _loc5_.addEventListener("response",_responseV);
               return;
            }
            hideArr();
            _transferAfter = false;
            _transferBefore = false;
            _loc4_ = "";
            if(EquipType.isArm(_loc3_.info) || EquipType.isCloth(_loc3_.info) || EquipType.isHead(_loc3_.info) || EquipType.isArm(_loc2_.info) || EquipType.isCloth(_loc2_.info) || EquipType.isHead(_loc2_.info))
            {
               _loc4_ = LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.sure2");
            }
            else
            {
               _loc4_ = LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.sure");
            }
            _loc6_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),_loc4_,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,true,2);
            _loc6_.addEventListener("response",_responseII);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.EmptyItem"));
         }
      }
      
      private function _responseV(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseV);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            okFastPurchaseGold();
         }
         ObjectUtils.disposeObject(param1.currentTarget);
      }
      
      private function okFastPurchaseGold() : void
      {
         var _loc1_:QuickBuyFrame = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
         _loc1_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
         _loc1_.itemID = 11233;
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      private function _response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 3)
         {
            depositAction();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function _responseII(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = BaseAlerFrame(param1.currentTarget);
         _loc2_.removeEventListener("response",_responseII);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            _transferAfter = true;
            _transferBefore = true;
            sendSocket();
         }
         else
         {
            cannel();
         }
         ObjectUtils.disposeObject(param1.target);
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
      
      private function isComposeStrengthen(param1:BagCell) : Boolean
      {
         if(param1.itemInfo.StrengthenLevel > 0)
         {
            return true;
         }
         if(param1.itemInfo.AttackCompose > 0)
         {
            return true;
         }
         if(param1.itemInfo.DefendCompose > 0)
         {
            return true;
         }
         if(param1.itemInfo.LuckCompose > 0)
         {
            return true;
         }
         if(param1.itemInfo.AgilityCompose > 0)
         {
            return true;
         }
         if(param1.itemInfo.MagicLevel > 0)
         {
            return true;
         }
         return false;
      }
      
      private function sendSocket() : void
      {
         SocketManager.Instance.out.sendItemTransfer(_transferBefore,_transferAfter);
      }
      
      private function __itemInfoChange(param1:Event) : void
      {
         gold_txt.text = "0";
         var _loc3_:TransferItemCell = _items[0];
         var _loc2_:TransferItemCell = _items[1];
         if(_loc3_.info)
         {
            _loc3_.categoryId = -1;
            if(_loc2_.info)
            {
               _loc3_.categoryId = _loc3_.info.CategoryID;
            }
            _loc2_.categoryId = _loc3_.info.CategoryID;
         }
         else
         {
            _loc2_.categoryId = -1;
            if(_loc2_.info)
            {
               _loc3_.categoryId = _loc2_.info.CategoryID;
            }
            else
            {
               _loc3_.categoryId = -1;
            }
         }
         if(_loc3_.info)
         {
            var _loc4_:* = _loc3_.info.RefineryLevel;
            _loc2_.Refinery = _loc4_;
            _loc3_.Refinery = _loc4_;
         }
         else if(_loc2_.info)
         {
            _loc4_ = _loc2_.info.RefineryLevel;
            _loc2_.Refinery = _loc4_;
            _loc3_.Refinery = _loc4_;
         }
         else
         {
            _loc4_ = -1;
            _loc2_.Refinery = _loc4_;
            _loc3_.Refinery = _loc4_;
         }
         if(_loc3_.info && _loc2_.info)
         {
            if(_loc3_.info.CategoryID != _loc2_.info.CategoryID)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.StoreIITransferBG.put"));
               return;
            }
            if(isComposeStrengthen(_loc3_) || isOpenHole(_loc3_) || isHasBead(_loc3_) || isComposeStrengthen(_loc2_) || isOpenHole(_loc2_) || isHasBead(_loc2_) || _loc3_.itemInfo.isHasLatentEnergy || _loc2_.itemInfo.isHasLatentEnergy)
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
         if(_loc3_.info && !_loc2_.info)
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(_loc3_.info,true);
         }
         else if(_loc2_.info && !_loc3_.info)
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(_loc2_.info,true);
         }
         else
         {
            ConsortiaRateManager.instance.sendTransferShowLightEvent(null,false);
         }
      }
      
      private function _showDontClickTip() : Boolean
      {
         var _loc2_:TransferItemCell = _items[0];
         var _loc1_:TransferItemCell = _items[1];
         if(_loc2_.info == null && _loc1_.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.NoItem"));
            return true;
         }
         if(_loc2_.info == null || _loc1_.info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.view.transfer.EmptyItem"));
            return true;
         }
         if(!isComposeStrengthen(_loc2_) && !isOpenHole(_loc2_) && !isHasBead(_loc2_) && !isComposeStrengthen(_loc1_) && !isOpenHole(_loc1_) && !isHasBead(_loc1_) && !_loc2_.itemInfo.isHasLatentEnergy && !_loc1_.itemInfo.isHasLatentEnergy)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("store.showTips.transfer.dontTransferII"));
            return true;
         }
         return false;
      }
      
      private function isHasBead(param1:BagCell) : Boolean
      {
         var _loc2_:InventoryItemInfo = param1.itemInfo;
         return _loc2_.Hole1 + _loc2_.Hole2 + _loc2_.Hole3 + _loc2_.Hole4 + _loc2_.Hole5 + _loc2_.Hole6 > 0;
      }
      
      private function isOpenHole(param1:BagCell) : Boolean
      {
         if(param1.itemInfo.Hole5Level > 0 || param1.itemInfo.Hole6Level > 0 || param1.itemInfo.Hole5Exp > 0 || param1.itemInfo.Hole6Exp > 0)
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
      
      public function refreshData(param1:Dictionary) : void
      {
         var _loc2_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(_loc2_ in param1)
         {
            if(_loc2_ < _items.length)
            {
               _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            }
         }
      }
      
      public function updateData() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _items[_loc1_].info = PlayerManager.Instance.Self.StoreBag.items[_loc1_];
            _loc1_++;
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
         var _loc2_:TransferItemCell = _items[0];
         var _loc1_:TransferItemCell = _items[1];
         if(_loc2_.info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,_loc2_.index,_loc2_.itemBagType,-1);
         }
         if(_loc1_.info != null)
         {
            SocketManager.Instance.out.sendMoveGoods(12,_loc1_.index,_loc1_.itemBagType,-1);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         _loc1_ = 0;
         while(_loc1_ < _items.length)
         {
            _items[_loc1_].removeEventListener("change",__itemInfoChange);
            _items[_loc1_].dispose();
            _loc1_++;
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
