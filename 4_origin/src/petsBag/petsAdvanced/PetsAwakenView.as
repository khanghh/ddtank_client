package petsBag.petsAdvanced
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.BagInfo;
   import ddt.data.goods.AwakenEquipInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.BagEvent;
   import ddt.events.CellEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import pet.data.PetInfo;
   import petsBag.PetsBagManager;
   import road7th.comm.PackageIn;
   
   public class PetsAwakenView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _petsBasicInfoView:PetsBasicInfoView;
      
      private var _prbabilityTxt:FilterFrameText;
      
      private var _awakenBtn:BaseButton;
      
      private var _stoneCell:PetsAwakenEquipCell;
      
      private var _equipCell:PetsAwakenEquipCell;
      
      private var _equipInfoCell:PetsAwakenInfoCell;
      
      private var _equipCellList:PetsAwakenEquipList;
      
      private var _clickDate:Number = 0;
      
      public function PetsAwakenView()
      {
         super();
         initView();
         initEvent();
         updateData();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.petsBag.awaken.bg");
         addChild(_bg);
         _prbabilityTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.awaken.awakenProbabilityTxt");
         addChild(_prbabilityTxt);
         _awakenBtn = ComponentFactory.Instance.creatComponentByStylename("petsBag.awaken.awakenButton");
         _awakenBtn.enable = false;
         addChild(_awakenBtn);
         _petsBasicInfoView = new PetsBasicInfoView();
         addChild(_petsBasicInfoView);
         _stoneCell = new PetsAwakenEquipCell(0);
         _stoneCell.x = 499;
         _stoneCell.y = 233;
         _stoneCell.setBgVisible(false);
         _stoneCell.isReceiveDrag = true;
         _stoneCell.isSendToHideBag = true;
         _stoneCell.setContentSize(57,57);
         _stoneCell.setCountPos(33,39);
         _stoneCell.type = 2;
         addChild(_stoneCell);
         var _loc1_:Bitmap = ComponentFactory.Instance.creat("asset.petsBag.awaken.awakenEquipBg");
         _equipCell = new PetsAwakenEquipCell(0,null,true,_loc1_);
         _equipCell.x = 306;
         _equipCell.y = 106;
         _equipCell.PicPos = new Point(14,13);
         _equipCell.setContentSize(53,53);
         _equipCell.isReceiveDrag = true;
         _equipCell.isSendToHideBag = true;
         _equipCell.type = 1;
         addChild(_equipCell);
         _equipInfoCell = new PetsAwakenInfoCell();
         _equipInfoCell.x = 469;
         _equipInfoCell.y = 96;
         addChild(_equipInfoCell);
         _equipCellList = new PetsAwakenEquipList();
         _equipCellList.x = 42;
         _equipCellList.y = 348;
         _equipCellList.bagType = 5;
         addChild(_equipCellList);
      }
      
      private function updateCount() : void
      {
         _stoneCell.itemInfo.Count = _stoneCell.itemInfo.Count - 1;
         var _loc1_:int = _stoneCell.itemInfo.Count;
         if(_loc1_ == 0)
         {
            _stoneCell.info = null;
            _stoneCell.itemInfo = null;
         }
         else if(_loc1_ > 1)
         {
            _stoneCell.setCount(_loc1_);
            _stoneCell.setCountPos(33,39);
         }
         else
         {
            _stoneCell.setCountNotVisible();
         }
         checkAwakenBtnEnable();
      }
      
      private function checkAwakenBtnEnable() : void
      {
         if(_stoneCell != null && _equipCell != null)
         {
            if(_stoneCell.itemInfo && _stoneCell.itemInfo.Count > 0 && _equipCell.info != null)
            {
               _awakenBtn.enable = true;
               return;
            }
         }
         _awakenBtn.enable = false;
      }
      
      private function getItemCount(param1:int) : int
      {
         var _loc2_:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var _loc3_:int = _loc2_.getItemCountByTemplateId(param1);
         return _loc3_;
      }
      
      protected function initEvent() : void
      {
         if(_petsBasicInfoView)
         {
            _petsBasicInfoView.addEventListener("all_movie_complete",__allComplete);
         }
         if(_equipCellList)
         {
            _equipCellList.addEventListener("itemclick",__cellClickHandler);
            _equipCellList.addEventListener("doubleclick",__cellDoubleClickHandler);
         }
         if(_equipCell)
         {
            _equipCell.addEventListener("interactive_click",__equipClickDragHandler);
            _equipCell.addEventListener("interactive_double_click",__removeEquipHandler);
            _equipCell.addEventListener("dataChange",__equipDataChangeHandler);
            DoubleClickManager.Instance.enableDoubleClick(_equipCell);
         }
         if(_stoneCell)
         {
            _stoneCell.addEventListener("interactive_click",__equipClickDragHandler);
            _stoneCell.addEventListener("interactive_double_click",__removeEquipHandler);
            _stoneCell.addEventListener("dataChange",__equipDataChangeHandler);
            DoubleClickManager.Instance.enableDoubleClick(_stoneCell);
         }
         if(_awakenBtn)
         {
            _awakenBtn.addEventListener("click",__sendPetsAwakentHandler);
         }
         SocketManager.Instance.addEventListener(PkgEvent.format(68,37),__petAwakenResultHandler);
         PlayerManager.Instance.Self.Bag.addEventListener("update",_updateEquipHandler);
         PlayerManager.Instance.Self.getBag(1).addEventListener("update",_updateEquipHandler);
      }
      
      protected function removeEvent() : void
      {
         if(_petsBasicInfoView)
         {
            _petsBasicInfoView.removeEventListener("all_movie_complete",__allComplete);
         }
         if(_equipCellList)
         {
            _equipCellList.removeEventListener("itemclick",__cellClickHandler);
            _equipCellList.removeEventListener("doubleclick",__cellDoubleClickHandler);
         }
         if(_equipCell)
         {
            _equipCell.removeEventListener("interactive_click",__equipClickDragHandler);
            _equipCell.removeEventListener("interactive_double_click",__removeEquipHandler);
            _equipCell.removeEventListener("dataChange",__equipDataChangeHandler);
            DoubleClickManager.Instance.disableDoubleClick(_equipCell);
         }
         if(_stoneCell)
         {
            _stoneCell.addEventListener("interactive_click",__equipClickDragHandler);
            _stoneCell.addEventListener("interactive_double_click",__removeEquipHandler);
            _stoneCell.addEventListener("dataChange",__equipDataChangeHandler);
            DoubleClickManager.Instance.enableDoubleClick(_stoneCell);
         }
         if(_awakenBtn)
         {
            _awakenBtn.removeEventListener("click",__sendPetsAwakentHandler);
         }
         SocketManager.Instance.removeEventListener(PkgEvent.format(68,37),__petAwakenResultHandler);
         PlayerManager.Instance.Self.Bag.removeEventListener("update",_updateEquipHandler);
         PlayerManager.Instance.Self.getBag(1).removeEventListener("update",_updateEquipHandler);
      }
      
      private function __removeEquipHandler(param1:InteractiveEvent) : void
      {
         var _loc2_:PetsAwakenEquipCell = param1.target as PetsAwakenEquipCell;
         var _loc3_:ItemTemplateInfo = _loc2_.info;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.CategoryID == 50 || _loc3_.CategoryID == 51 || _loc3_.CategoryID == 52)
         {
            SocketManager.Instance.out.sendMoveGoods(12,1,0,-1);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(12,0,1,-1);
         }
         _loc2_.info = null;
         _loc2_.itemInfo = null;
         checkAwakenBtnEnable();
      }
      
      private function __equipClickDragHandler(param1:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:PetsAwakenEquipCell = param1.target as PetsAwakenEquipCell;
         if(_loc2_ && _loc2_.info)
         {
            _loc2_.dragStart();
         }
      }
      
      private function __equipDataChangeHandler(param1:Event) : void
      {
         if(_equipCell && _equipCell.info == null)
         {
            checkAwakenBtnEnable();
         }
      }
      
      private function _updateEquipHandler(param1:BagEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:BagInfo = PlayerManager.Instance.Self.StoreBag;
         if(_loc3_.items.length > 0)
         {
            checkAwakenBtnEnable();
            if(_equipInfoCell.cellInfo)
            {
               _equipInfoCell.iteminfo = null;
            }
            if(_loc3_.items[0] is InventoryItemInfo)
            {
               _loc2_ = _loc3_.items[0] as InventoryItemInfo;
               if(_loc2_.Quality > 5)
               {
                  _equipInfoCell.iteminfo = _loc2_;
               }
            }
         }
         updateData();
         if(_equipCell.info)
         {
            _prbabilityTxt.text = LanguageMgr.GetTranslation("petsBag.petsAwaken.awakenSuccessRateTxt",int(_equipCell.info.Property4) / 10);
         }
         else
         {
            _prbabilityTxt.text = "";
         }
      }
      
      private function updateAwakenSuccessItemInfo() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_equipInfoCell && _equipInfoCell.cellInfo)
         {
            _loc2_ = _equipInfoCell.cellInfo;
            _loc1_ = PetsBagManager.instance().getAwakenEquipInfo(_loc2_.ItemID.toString());
            if(_loc1_ != null)
            {
               _loc2_.awakenEquipPro = _loc1_;
               _equipInfoCell.iteminfo = _loc2_;
            }
         }
      }
      
      private function __petAwakenResultHandler(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:* = null;
         if(_equipCell)
         {
            _equipCell.info = null;
         }
         var _loc7_:PackageIn = param1.pkg;
         var _loc8_:Boolean = _loc7_.readBoolean();
         if(_loc8_)
         {
            _loc4_ = _loc7_.readInt();
            _loc5_ = _loc7_.readInt();
            _loc6_ = _loc7_.readInt();
            _loc9_ = _loc7_.readInt();
            _loc3_ = new AwakenEquipInfo();
            _loc3_.belongPetId = _loc9_;
            _loc3_.skillId1 = _loc5_;
            _loc3_.skillId2 = _loc6_;
            _loc3_.itemID = _loc4_;
            updateAwakenEquipList(_loc3_);
         }
         updateAwakenSuccessItemInfo();
         updateCount();
         updateData();
         var _loc2_:String = !!_loc8_?"petsBag.petsAwaken.awakenSuccessMsg":"petsBag.petsAwaken.awakenFailMsg";
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(_loc2_));
      }
      
      private function updateAwakenEquipList(param1:AwakenEquipInfo) : void
      {
         PetsBagManager.instance().updateAwakenEquipList(param1);
      }
      
      private function __sendPetsAwakentHandler(param1:MouseEvent) : void
      {
         if(new Date().time - _clickDate <= 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
            return;
         }
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         _clickDate = new Date().time;
         SoundManager.instance.playButtonSound();
         if(_equipCell && _equipCell.info)
         {
            SocketManager.Instance.out.sendPetsAwaken();
            return;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("petsBag.petsAwaken.sendAwakenFailMsg"));
      }
      
      protected function __cellClickHandler(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:PetsAwakenEquipCell = param1.data as PetsAwakenEquipCell;
         if(_loc2_ && _loc2_.info)
         {
            _loc3_ = _loc2_.info as InventoryItemInfo;
            if(_loc3_.getRemainDate() <= 0)
            {
               return;
            }
            _loc2_.dragStart();
         }
      }
      
      protected function __cellDoubleClickHandler(param1:CellEvent) : void
      {
         var _loc3_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         param1.stopImmediatePropagation();
         var _loc2_:PetsAwakenEquipCell = param1.data as PetsAwakenEquipCell;
         if(_loc2_)
         {
            _loc3_ = _loc2_.info as InventoryItemInfo;
            if(!_loc3_ || _loc3_.getRemainDate() <= 0)
            {
               return;
            }
            if((_loc3_.CategoryID == 50 || _loc3_.CategoryID == 51 || _loc3_.CategoryID == 52) && _loc3_.Quality == 5)
            {
               _equipCell.info = _loc3_;
               _equipCell.itemInfo = _loc3_;
            }
            else
            {
               _stoneCell.info = _loc3_;
               _stoneCell.itemInfo = _loc3_;
               _stoneCell.setCountPos(33,39);
            }
         }
      }
      
      protected function __allComplete(param1:Event) : void
      {
         _petsBasicInfoView.removeEventListener("all_movie_complete",__allComplete);
         PetsAdvancedControl.Instance.isAllMovieComplete = true;
         PetsAdvancedControl.Instance.frame.enableBtn = true;
      }
      
      protected function updateData() : void
      {
         var _loc1_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(_loc1_ != null)
         {
            _petsBasicInfoView && _petsBasicInfoView.setInfo(_loc1_);
         }
         updateEquipList();
      }
      
      protected function updateEquipList() : void
      {
         _equipCellList.setInfo(PlayerManager.Instance.Self.Bag,PlayerManager.Instance.Self.getBag(1));
      }
      
      private function createTempleteInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         _loc2_ = ItemManager.fill(_loc2_);
         _loc2_.IsBinds = true;
         return _loc2_;
      }
      
      private function clearHideBagItem() : void
      {
         if(PlayerManager.Instance.Self.StoreBag.items.length > 0)
         {
            SocketManager.Instance.out.sendClearStoreBag();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearHideBagItem();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_prbabilityTxt)
         {
            ObjectUtils.disposeObject(_prbabilityTxt);
         }
         _prbabilityTxt = null;
         if(_awakenBtn)
         {
            ObjectUtils.disposeObject(_awakenBtn);
         }
         _awakenBtn = null;
         if(_petsBasicInfoView)
         {
            ObjectUtils.disposeObject(_petsBasicInfoView);
         }
         _petsBasicInfoView = null;
         if(_equipCell)
         {
            ObjectUtils.disposeObject(_equipCell);
         }
         _equipCell = null;
         if(_equipInfoCell)
         {
            ObjectUtils.disposeObject(_equipInfoCell);
         }
         _equipInfoCell = null;
         if(_stoneCell)
         {
            ObjectUtils.disposeObject(_stoneCell);
         }
         _stoneCell = null;
         if(_equipCellList)
         {
            ObjectUtils.disposeObject(_equipCellList);
         }
         _equipCellList = null;
      }
   }
}
