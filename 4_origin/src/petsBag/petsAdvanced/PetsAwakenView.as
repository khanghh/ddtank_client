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
         var temBg:Bitmap = ComponentFactory.Instance.creat("asset.petsBag.awaken.awakenEquipBg");
         _equipCell = new PetsAwakenEquipCell(0,null,true,temBg);
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
         var temCount:int = _stoneCell.itemInfo.Count;
         if(temCount == 0)
         {
            _stoneCell.info = null;
            _stoneCell.itemInfo = null;
         }
         else if(temCount > 1)
         {
            _stoneCell.setCount(temCount);
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
      
      private function getItemCount(temId:int) : int
      {
         var bagInfo:BagInfo = PlayerManager.Instance.Self.getBag(1);
         var count:int = bagInfo.getItemCountByTemplateId(temId);
         return count;
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
      
      private function __removeEquipHandler(evt:InteractiveEvent) : void
      {
         var cell:PetsAwakenEquipCell = evt.target as PetsAwakenEquipCell;
         var info:ItemTemplateInfo = cell.info;
         if(!info)
         {
            return;
         }
         if(info.CategoryID == 50 || info.CategoryID == 51 || info.CategoryID == 52)
         {
            SocketManager.Instance.out.sendMoveGoods(12,1,0,-1);
         }
         else
         {
            SocketManager.Instance.out.sendMoveGoods(12,0,1,-1);
         }
         cell.info = null;
         cell.itemInfo = null;
         checkAwakenBtnEnable();
      }
      
      private function __equipClickDragHandler(evt:InteractiveEvent) : void
      {
         SoundManager.instance.play("008");
         var temCell:PetsAwakenEquipCell = evt.target as PetsAwakenEquipCell;
         if(temCell && temCell.info)
         {
            temCell.dragStart();
         }
      }
      
      private function __equipDataChangeHandler(evt:Event) : void
      {
         if(_equipCell && _equipCell.info == null)
         {
            checkAwakenBtnEnable();
         }
      }
      
      private function _updateEquipHandler(evt:BagEvent) : void
      {
         var itemInfo:* = null;
         var info:BagInfo = PlayerManager.Instance.Self.StoreBag;
         if(info.items.length > 0)
         {
            checkAwakenBtnEnable();
            if(_equipInfoCell.cellInfo)
            {
               _equipInfoCell.iteminfo = null;
            }
            if(info.items[0] is InventoryItemInfo)
            {
               itemInfo = info.items[0] as InventoryItemInfo;
               if(itemInfo.Quality > 5)
               {
                  _equipInfoCell.iteminfo = itemInfo;
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
         var cellInfo:* = null;
         var temInfo:* = null;
         if(_equipInfoCell && _equipInfoCell.cellInfo)
         {
            cellInfo = _equipInfoCell.cellInfo;
            temInfo = PetsBagManager.instance().getAwakenEquipInfo(cellInfo.ItemID.toString());
            if(temInfo != null)
            {
               cellInfo.awakenEquipPro = temInfo;
               _equipInfoCell.iteminfo = cellInfo;
            }
         }
      }
      
      private function __petAwakenResultHandler(evt:PkgEvent) : void
      {
         var itemID:int = 0;
         var skill1:int = 0;
         var skill2:int = 0;
         var petID:int = 0;
         var awakenInfo:* = null;
         if(_equipCell)
         {
            _equipCell.info = null;
         }
         var pkg:PackageIn = evt.pkg;
         var isSuccess:Boolean = pkg.readBoolean();
         if(isSuccess)
         {
            itemID = pkg.readInt();
            skill1 = pkg.readInt();
            skill2 = pkg.readInt();
            petID = pkg.readInt();
            awakenInfo = new AwakenEquipInfo();
            awakenInfo.belongPetId = petID;
            awakenInfo.skillId1 = skill1;
            awakenInfo.skillId2 = skill2;
            awakenInfo.itemID = itemID;
            updateAwakenEquipList(awakenInfo);
         }
         updateAwakenSuccessItemInfo();
         updateCount();
         updateData();
         var result:String = !!isSuccess?"petsBag.petsAwaken.awakenSuccessMsg":"petsBag.petsAwaken.awakenFailMsg";
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation(result));
      }
      
      private function updateAwakenEquipList(info:AwakenEquipInfo) : void
      {
         PetsBagManager.instance().updateAwakenEquipList(info);
      }
      
      private function __sendPetsAwakentHandler(evt:MouseEvent) : void
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
      
      protected function __cellClickHandler(evt:CellEvent) : void
      {
         var info:* = null;
         SoundManager.instance.play("008");
         var temCell:PetsAwakenEquipCell = evt.data as PetsAwakenEquipCell;
         if(temCell && temCell.info)
         {
            info = temCell.info as InventoryItemInfo;
            if(info.getRemainDate() <= 0)
            {
               return;
            }
            temCell.dragStart();
         }
      }
      
      protected function __cellDoubleClickHandler(evt:CellEvent) : void
      {
         var info:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         evt.stopImmediatePropagation();
         var temCell:PetsAwakenEquipCell = evt.data as PetsAwakenEquipCell;
         if(temCell)
         {
            info = temCell.info as InventoryItemInfo;
            if(!info || info.getRemainDate() <= 0)
            {
               return;
            }
            if((info.CategoryID == 50 || info.CategoryID == 51 || info.CategoryID == 52) && info.Quality == 5)
            {
               _equipCell.info = info;
               _equipCell.itemInfo = info;
            }
            else
            {
               _stoneCell.info = info;
               _stoneCell.itemInfo = info;
               _stoneCell.setCountPos(33,39);
            }
         }
      }
      
      protected function __allComplete(event:Event) : void
      {
         _petsBasicInfoView.removeEventListener("all_movie_complete",__allComplete);
         PetsAdvancedControl.Instance.isAllMovieComplete = true;
         PetsAdvancedControl.Instance.frame.enableBtn = true;
      }
      
      protected function updateData() : void
      {
         var petInfo:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(petInfo != null)
         {
            _petsBasicInfoView && _petsBasicInfoView.setInfo(petInfo);
         }
         updateEquipList();
      }
      
      protected function updateEquipList() : void
      {
         _equipCellList.setInfo(PlayerManager.Instance.Self.Bag,PlayerManager.Instance.Self.getBag(1));
      }
      
      private function createTempleteInfo(temID:int) : InventoryItemInfo
      {
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = temID;
         info = ItemManager.fill(info);
         info.IsBinds = true;
         return info;
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
