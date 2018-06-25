package store.fineStore.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.events.CellEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.HelpFrameUtils;
   import ddt.utils.PositionUtils;
   import ddt.view.common.BuyItemButton;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import road7th.utils.MathUtils;
   import store.StoreCell;
   import store.StoreController;
   import store.StoreDragInArea;
   import store.data.StoreModel;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.EquipGhostData;
   import store.events.StoreDargEvent;
   import store.view.StoneCellFrame;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagController;
   import store.view.storeBag.StoreBagView;
   
   public final class FineGhostView extends Sprite implements Disposeable
   {
       
      
      private var _area:StoreDragInArea;
      
      private var _items:Array;
      
      private var _luckyStoneCell:StoneCellFrame;
      
      private var _ghostStoneCell:StoneCellFrame;
      
      private var _equipmentCell:StoneCellFrame;
      
      private var _ghostBtn:SimpleBitmapButton;
      
      private var _ghostHelpBtn:BaseButton;
      
      private var _cBuyluckyBtn:BuyItemButton;
      
      private var _buyStoneBtn:BuyItemButton;
      
      private var _ratioTxt:FilterFrameText;
      
      private var _continuesBtn:SelectedCheckButton;
      
      private var _controller:StoreBagController;
      
      private var _view:DisplayObject;
      
      private var _moveSprite:Sprite;
      
      private var _successBit:Bitmap;
      
      private var _failBit:Bitmap;
      
      public function FineGhostView(controller:StoreController)
      {
         super();
         _controller = new StoreBagController(controller.Model);
         _controller.model.currentPanel = 7;
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         PlayerManager.Instance.Self.StoreBag.addEventListener("update",refreshData);
         PlayerManager.Instance.Self.StoreBag.addEventListener("clearStoreBag",updateData);
         EquipGhostManager.getInstance().addEventListener("equip_ghost_result",onEquipGhostResult);
         EquipGhostManager.getInstance().addEventListener("equip_ghost_ratio",onEquipGhostRatio);
         EquipGhostManager.getInstance().addEventListener("equip_ghost_state",onEquipGhostState);
         _ghostBtn.addEventListener("click",equipGhost);
         addEventListener("startDarg",startShine);
         addEventListener("stopDarg",stopShine);
         _view.addEventListener("doubleclick",__cellDoubleClick,false,0,true);
      }
      
      protected function __cellDoubleClick(evt:CellEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",refreshData);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("clearStoreBag",updateData);
         if(_items)
         {
            for(i = 0; i < _items.length; )
            {
               _items[i].dispose();
               _items[i] = null;
               i++;
            }
         }
         _ghostBtn.removeEventListener("click",equipGhost);
         EquipGhostManager.getInstance().removeEventListener("equip_ghost_result",onEquipGhostResult);
         EquipGhostManager.getInstance().removeEventListener("equip_ghost_ratio",onEquipGhostRatio);
         EquipGhostManager.getInstance().removeEventListener("equip_ghost_state",onEquipGhostState);
         removeEventListener("startDarg",startShine);
         removeEventListener("stopDarg",stopShine);
         _view.removeEventListener("doubleclick",__cellDoubleClick);
      }
      
      private function startShine(evt:StoreDargEvent) : void
      {
         var cell:* = null;
         var item:ItemTemplateInfo = evt.sourceInfo;
         if(item == null)
         {
            return;
         }
         var dsIndex:int = 1;
         if(item.CategoryID == 11)
         {
            if(item.Property1 == "117")
            {
               dsIndex = 0;
            }
            else if(item.Property1 == "118")
            {
               dsIndex = 2;
            }
            else
            {
               return;
            }
         }
         if(_items != null && _items.length > dsIndex)
         {
            cell = _items[dsIndex];
            if(cell)
            {
               cell.startShine();
            }
         }
      }
      
      private function stopShine(evt:StoreDargEvent) : void
      {
         var i:int = 0;
         i = 0;
         while(_items && i < _items.length)
         {
            _items[i].stopShine();
            i++;
         }
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var item:* = null;
         var bg:Bitmap = ComponentFactory.Instance.creatBitmap("equipGhost.leftBg");
         PositionUtils.setPos(bg,"equipGhost.leftBgPos");
         addChild(bg);
         _luckyStoneCell = ComponentFactory.Instance.creatCustomObject("equipGhost.LuckySymbolCell");
         _luckyStoneCell.label = LanguageMgr.GetTranslation("equipGhost.luck");
         addChild(_luckyStoneCell);
         _ghostStoneCell = ComponentFactory.Instance.creatCustomObject("equipGhost.StrengthenStoneCell");
         _ghostStoneCell.label = LanguageMgr.GetTranslation("equipGhost.stone");
         addChild(_ghostStoneCell);
         _equipmentCell = ComponentFactory.Instance.creatCustomObject("equipGhost.EquipmentCell");
         _equipmentCell.label = LanguageMgr.GetTranslation("store.Strength.StrengthenEquipmentCellText");
         addChild(_equipmentCell);
         _ghostBtn = ComponentFactory.Instance.creatComponentByStylename("equipGhost.ghostButton");
         addChild(_ghostBtn);
         _ghostHelpBtn = HelpFrameUtils.Instance.simpleHelpButton(this,"ddtstore.HelpButton",null,LanguageMgr.GetTranslation("store.StoreIIGhost.say"),"ddtstore.HelpFrame.GhostText",404,484);
         PositionUtils.setPos(_ghostHelpBtn,"equipGhost.helpBtnPos");
         _cBuyluckyBtn = ComponentFactory.Instance.creatComponentByStylename("equipGhost.buyLock");
         _cBuyluckyBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _cBuyluckyBtn.setup(11185,2,true);
         addChild(_cBuyluckyBtn);
         _buyStoneBtn = ComponentFactory.Instance.creatComponentByStylename("equipGhost.buyStone");
         _buyStoneBtn.text = LanguageMgr.GetTranslation("store.Strength.BuyButtonText");
         _buyStoneBtn.setup(11186,2,true);
         addChild(_buyStoneBtn);
         var pos:Point = null;
         _items = [];
         for(i = 0; i < 3; )
         {
            if(i == 0)
            {
               item = new GhostStoneCell(["117"],i);
            }
            else if(i == 1)
            {
               item = new GhostItemCell(i);
            }
            else if(i == 2)
            {
               item = new GhostStoneCell(["118"],i);
            }
            pos = ComponentFactory.Instance.creatCustomObject("equipGhost.ghostPos" + i);
            item.x = pos.x;
            item.y = pos.y;
            addChild(item);
            _items.push(item);
            i++;
         }
         _ratioTxt = ComponentFactory.Instance.creatComponentByStylename("equipGhost.successRatioTxt");
         _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioLowTxt");
         addChild(_ratioTxt);
         _continuesBtn = ComponentFactory.Instance.creatComponentByStylename("equipGhost.continuousBtn");
         addChild(_continuesBtn);
         _view = _controller.getView(StoreModel.STORE_BAG);
         _view.visible = true;
         (_view as StoreBagView).EquipList.setData(_controller.model.canGhostEquipList);
         (_view as StoreBagView).PropList.setData(_controller.model.canGhostPropList);
         (_view as StoreBagView).enableCellDoubleClick(true,dragDrop);
         PositionUtils.setPos(_view,"equipGhost.rightViewPos");
         addChild(_view);
      }
      
      public function dragDrop(evt:CellEvent) : void
      {
         var ds:* = null;
         var ghost:* = null;
         var isUp:* = false;
         var source:BagCell = evt.data as StoreBagCell;
         if(source == null)
         {
            return;
         }
         var info:InventoryItemInfo = source.info as InventoryItemInfo;
         if(info == null)
         {
            return;
         }
         var _loc9_:int = 0;
         var _loc8_:* = _items;
         for each(ds in _items)
         {
            if(ds.info == info)
            {
               ds.info = null;
               source.locked = false;
               return;
            }
         }
         var dsIndex:int = 1;
         if(info.CategoryID == 11)
         {
            if(info.Property1 == "117")
            {
               dsIndex = 0;
            }
            else if(info.Property1 == "118")
            {
               dsIndex = 2;
            }
            else
            {
               return;
            }
         }
         if(dsIndex == 1)
         {
            ghost = PlayerManager.Instance.Self.getGhostDataByCategoryID(info.CategoryID);
            if(ghost)
            {
               isUp = ghost.level >= EquipGhostManager.getInstance().model.topLvDic[info.CategoryID];
               if(isUp)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
                  return;
               }
            }
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,dsIndex,info.Count,true);
            EquipGhostManager.getInstance().chooseEquip(info);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(info.BagType,info.Place,12,dsIndex,info.Count,true);
            if(dsIndex == 0)
            {
               EquipGhostManager.getInstance().chooseLuckyMaterial(info);
            }
            else
            {
               EquipGhostManager.getInstance().chooseStoneMaterial(info);
            }
         }
      }
      
      public function refreshData(evt:BagEvent) : void
      {
         var itemPlace:* = 0;
         var items:Dictionary = evt.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = items;
         for(itemPlace in items)
         {
            if(itemPlace < _items.length)
            {
               _items[itemPlace].info = PlayerManager.Instance.Self.StoreBag.items[itemPlace];
               if(itemPlace == 0)
               {
                  EquipGhostManager.getInstance().chooseLuckyMaterial(_items[itemPlace].info);
               }
               else if(itemPlace == 2)
               {
                  EquipGhostManager.getInstance().chooseStoneMaterial(_items[itemPlace].info);
               }
            }
         }
      }
      
      public function updateData(evt:CEvent = null) : void
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            _items[i].info = PlayerManager.Instance.Self.StoreBag.items[i];
            i++;
         }
         _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioLowTxt");
      }
      
      private function equipGhost(evt:MouseEvent) : void
      {
         evt.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(checkMaterial())
         {
            EquipGhostManager.getInstance().requestEquipGhost();
         }
      }
      
      private function checkMaterial() : Boolean
      {
         var enough:Boolean = true;
         if(_items[1].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.material1"));
            enough = false;
         }
         else if(_items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.material2"));
            enough = false;
         }
         return enough;
      }
      
      public function show() : void
      {
         this.visible = true;
         updateData();
      }
      
      public function dispose() : void
      {
         TweenMax.killTweensOf(_moveSprite);
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
         removeEvent();
         EquipGhostManager.getInstance().clearEquip();
         EquipGhostManager.getInstance().chooseStoneMaterial(null);
         EquipGhostManager.getInstance().chooseLuckyMaterial(null);
         _items = null;
         if(_area)
         {
            _area.dispose();
         }
         _area = null;
         if(_luckyStoneCell)
         {
            ObjectUtils.disposeObject(_luckyStoneCell);
         }
         _luckyStoneCell = null;
         if(_ghostStoneCell)
         {
            ObjectUtils.disposeObject(_ghostStoneCell);
         }
         _ghostStoneCell = null;
         if(_ghostBtn)
         {
            ObjectUtils.disposeObject(_ghostBtn);
         }
         _ghostBtn = null;
         if(_ghostHelpBtn)
         {
            ObjectUtils.disposeObject(_ghostHelpBtn);
         }
         _ghostHelpBtn = null;
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
         if(_equipmentCell)
         {
            ObjectUtils.disposeObject(_equipmentCell);
         }
         _equipmentCell = null;
         (_view as StoreBagView).enableCellDoubleClick(false,dragDrop);
         if(_view)
         {
            ObjectUtils.disposeObject(_view);
         }
         _view = null;
         if(_ratioTxt)
         {
            ObjectUtils.disposeObject(_ratioTxt);
         }
         _ratioTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function onEquipGhostResult(evt:CEvent) : void
      {
         var result:Boolean = evt.data;
         if(!result)
         {
            showResultEffect(false);
         }
         else
         {
            showResultEffect();
         }
      }
      
      private function showResultEffect(success:Boolean = true) : void
      {
         _ghostBtn.enable = true;
         if(!_moveSprite)
         {
            _moveSprite = new Sprite();
            var _loc2_:Boolean = false;
            _moveSprite.mouseEnabled = _loc2_;
            _moveSprite.mouseChildren = _loc2_;
            addChild(_moveSprite);
         }
         if(success)
         {
            _successBit = _successBit || ComponentFactory.Instance.creatBitmap("asset.ddtstore.StoreIISuccessBitAsset");
            _successBit.visible = true;
            if(_failBit)
            {
               _failBit.visible = false;
            }
            _moveSprite.addChild(_successBit);
            SoundManager.instance.pauseMusic();
            SoundManager.instance.play("063",false,false);
         }
         else
         {
            _failBit = _failBit || ComponentFactory.Instance.creatBitmap("asset.ddtstore.StoreIIFailBitAsset");
            _failBit.visible = true;
            if(_successBit)
            {
               _successBit.visible = false;
            }
            _moveSprite.addChild(_failBit);
            SoundManager.instance.pauseMusic();
            SoundManager.instance.play("064",false,false);
         }
         TweenMax.killTweensOf(_moveSprite);
         _moveSprite.y = 170;
         _moveSprite.alpha = 1;
         TweenMax.to(_moveSprite,0.4,{
            "delay":1.4,
            "y":54,
            "alpha":0,
            "onComplete":continueGhost,
            "onCompleteParams":[success]
         });
      }
      
      private function continueGhost(success:Boolean) : void
      {
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
         var materialEnough:Boolean = _items && _items.length > 2 && _items[2].info != null;
         if(!success && _continuesBtn.selected && materialEnough)
         {
            EquipGhostManager.getInstance().requestEquipGhost();
         }
      }
      
      private function onEquipGhostRatio(evt:CEvent) : void
      {
         var ratio:Number = MathUtils.getValueInRange(Number(evt.data),1,99);
         if(ratio < 5)
         {
            _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioLowTxt");
         }
         else
         {
            _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioTxt",ratio);
         }
      }
      
      private function onEquipGhostState(evt:CEvent) : void
      {
         var state:Boolean = evt.data as Boolean;
         if(_ghostBtn)
         {
            _ghostBtn.enable = state;
         }
      }
   }
}
