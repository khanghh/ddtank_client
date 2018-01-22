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
      
      public function FineGhostView(param1:StoreController)
      {
         super();
         _controller = new StoreBagController(param1.Model);
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
      
      protected function __cellDoubleClick(param1:CellEvent) : void
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
         var _loc1_:int = 0;
         PlayerManager.Instance.Self.StoreBag.removeEventListener("update",refreshData);
         PlayerManager.Instance.Self.StoreBag.removeEventListener("clearStoreBag",updateData);
         if(_items)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               _items[_loc1_].dispose();
               _items[_loc1_] = null;
               _loc1_++;
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
      
      private function startShine(param1:StoreDargEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:ItemTemplateInfo = param1.sourceInfo;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:int = 1;
         if(_loc3_.CategoryID == 11)
         {
            if(_loc3_.Property1 == "117")
            {
               _loc4_ = 0;
            }
            else if(_loc3_.Property1 == "118")
            {
               _loc4_ = 2;
            }
            else
            {
               return;
            }
         }
         if(_items != null && _items.length > _loc4_)
         {
            _loc2_ = _items[_loc4_];
            if(_loc2_)
            {
               _loc2_.startShine();
            }
         }
      }
      
      private function stopShine(param1:StoreDargEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_items && _loc2_ < _items.length)
         {
            _items[_loc2_].stopShine();
            _loc2_++;
         }
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("equipGhost.leftBg");
         PositionUtils.setPos(_loc2_,"equipGhost.leftBgPos");
         addChild(_loc2_);
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
         var _loc4_:Point = null;
         _items = [];
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            if(_loc3_ == 0)
            {
               _loc1_ = new GhostStoneCell(["117"],_loc3_);
            }
            else if(_loc3_ == 1)
            {
               _loc1_ = new GhostItemCell(_loc3_);
            }
            else if(_loc3_ == 2)
            {
               _loc1_ = new GhostStoneCell(["118"],_loc3_);
            }
            _loc4_ = ComponentFactory.Instance.creatCustomObject("equipGhost.ghostPos" + _loc3_);
            _loc1_.x = _loc4_.x;
            _loc1_.y = _loc4_.y;
            addChild(_loc1_);
            _items.push(_loc1_);
            _loc3_++;
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
      
      public function dragDrop(param1:CellEvent) : void
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = false;
         var _loc2_:BagCell = param1.data as StoreBagCell;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc7_:InventoryItemInfo = _loc2_.info as InventoryItemInfo;
         if(_loc7_ == null)
         {
            return;
         }
         var _loc9_:int = 0;
         var _loc8_:* = _items;
         for each(_loc6_ in _items)
         {
            if(_loc6_.info == _loc7_)
            {
               _loc6_.info = null;
               _loc2_.locked = false;
               return;
            }
         }
         var _loc3_:int = 1;
         if(_loc7_.CategoryID == 11)
         {
            if(_loc7_.Property1 == "117")
            {
               _loc3_ = 0;
            }
            else if(_loc7_.Property1 == "118")
            {
               _loc3_ = 2;
            }
            else
            {
               return;
            }
         }
         if(_loc3_ == 1)
         {
            _loc5_ = PlayerManager.Instance.Self.getGhostDataByCategoryID(_loc7_.CategoryID);
            if(_loc5_)
            {
               _loc4_ = _loc5_.level >= EquipGhostManager.getInstance().model.topLvDic[_loc7_.CategoryID];
               if(_loc4_)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
                  return;
               }
            }
            SocketManager.Instance.out.sendMoveGoods(_loc7_.BagType,_loc7_.Place,12,_loc3_,_loc7_.Count,true);
            EquipGhostManager.getInstance().chooseEquip(_loc7_);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(_loc7_.BagType,_loc7_.Place,12,_loc3_,_loc7_.Count,true);
            if(_loc3_ == 0)
            {
               EquipGhostManager.getInstance().chooseLuckyMaterial(_loc7_);
            }
            else
            {
               EquipGhostManager.getInstance().chooseStoneMaterial(_loc7_);
            }
         }
      }
      
      public function refreshData(param1:BagEvent) : void
      {
         var _loc3_:* = 0;
         var _loc2_:Dictionary = param1.changedSlots;
         var _loc6_:int = 0;
         var _loc5_:* = _loc2_;
         for(_loc3_ in _loc2_)
         {
            if(_loc3_ < _items.length)
            {
               _items[_loc3_].info = PlayerManager.Instance.Self.StoreBag.items[_loc3_];
               if(_loc3_ == 0)
               {
                  EquipGhostManager.getInstance().chooseLuckyMaterial(_items[_loc3_].info);
               }
               else if(_loc3_ == 2)
               {
                  EquipGhostManager.getInstance().chooseStoneMaterial(_items[_loc3_].info);
               }
            }
         }
      }
      
      public function updateData(param1:CEvent = null) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _items[_loc2_].info = PlayerManager.Instance.Self.StoreBag.items[_loc2_];
            _loc2_++;
         }
         _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioLowTxt");
      }
      
      private function equipGhost(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         SoundManager.instance.play("008");
         if(checkMaterial())
         {
            EquipGhostManager.getInstance().requestEquipGhost();
         }
      }
      
      private function checkMaterial() : Boolean
      {
         var _loc1_:Boolean = true;
         if(_items[1].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.material1"));
            _loc1_ = false;
         }
         else if(_items[2].info == null)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.material2"));
            _loc1_ = false;
         }
         return _loc1_;
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
      
      private function onEquipGhostResult(param1:CEvent) : void
      {
         var _loc2_:Boolean = param1.data;
         if(!_loc2_)
         {
            showResultEffect(false);
         }
         else
         {
            showResultEffect();
         }
      }
      
      private function showResultEffect(param1:Boolean = true) : void
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
         if(param1)
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
            "onCompleteParams":[param1]
         });
      }
      
      private function continueGhost(param1:Boolean) : void
      {
         SoundManager.instance.resumeMusic();
         SoundManager.instance.stop("063");
         SoundManager.instance.stop("064");
         var _loc2_:Boolean = _items && _items.length > 2 && _items[2].info != null;
         if(!param1 && _continuesBtn.selected && _loc2_)
         {
            EquipGhostManager.getInstance().requestEquipGhost();
         }
      }
      
      private function onEquipGhostRatio(param1:CEvent) : void
      {
         var _loc2_:Number = MathUtils.getValueInRange(Number(param1.data),1,99);
         if(_loc2_ < 5)
         {
            _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioLowTxt");
         }
         else
         {
            _ratioTxt.htmlText = LanguageMgr.GetTranslation("equipGhost.ratioTxt",_loc2_);
         }
      }
      
      private function onEquipGhostState(param1:CEvent) : void
      {
         var _loc2_:Boolean = param1.data as Boolean;
         if(_ghostBtn)
         {
            _ghostBtn.enable = _loc2_;
         }
      }
   }
}
