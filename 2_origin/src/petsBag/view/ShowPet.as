package petsBag.view
{
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.info.PersonalInfoDragInArea;
   import bagAndInfo.info.PlayerInfoViewControl;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.PetEquipItem;
   import petsBag.view.item.StarBar;
   
   public class ShowPet extends Sprite implements Disposeable
   {
      
      public static var isPetEquip:Boolean;
       
      
      private var _starBar:StarBar;
      
      private var _petBigItem:PetBigItem;
      
      private var _equipLockBitmapData:BitmapData;
      
      private var _vbox:VBox;
      
      private var _equipList:Array;
      
      private var _currentPetIndex:int;
      
      private var _dragDropArea:PersonalInfoDragInArea;
      
      public function ShowPet()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _dragDropArea = new PersonalInfoDragInArea();
         _equipList = [];
         _vbox = ComponentFactory.Instance.creatCustomObject("petsBag.showPet.vbox");
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new PetEquipItem(_loc2_);
            _loc1_.id = _loc2_;
            _loc1_.addEventListener("doubleclick",doubleClickHander);
            _loc1_.addEventListener("itemclick",onClickHander);
            _vbox.addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc2_++;
         }
         _starBar = new StarBar();
         _starBar.x = _vbox.x + _vbox.width;
         addChild(_starBar);
         _petBigItem = ComponentFactory.Instance.creat("petsBag.petBigItem");
         _petBigItem.initTips();
         addChild(_dragDropArea);
         addChild(_petBigItem);
         addChild(_vbox);
      }
      
      private function initEvent() : void
      {
         PetSpriteManager.Instance.addEventListener("showPetTip",__showPetTip);
      }
      
      private function __showPetTip(param1:Event) : void
      {
         if(isPetEquip == true)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ShowPet.Tip"));
         }
      }
      
      public function addDragInfoArea() : void
      {
         _dragDropArea.visible = true;
      }
      
      public function removeDragInfoArea() : void
      {
         _dragDropArea.visible = false;
      }
      
      private function onClickHander(param1:CellEvent) : void
      {
         var _loc2_:* = null;
         if(PlayerInfoViewControl.isOpenFromBag)
         {
            _loc2_ = param1.data as BagCell;
            PetsBagManager.instance().isEquip = true;
            _loc2_.dragStart();
         }
      }
      
      private function doubleClickHander(param1:CellEvent) : void
      {
         if(PlayerInfoViewControl.isOpenFromBag)
         {
            SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,param1.currentTarget.id);
         }
      }
      
      public function addPetEquip(param1:InventoryItemInfo) : void
      {
         getBagCell(param1.Place).initBagCell(param1);
      }
      
      public function getBagCell(param1:int) : PetEquipItem
      {
         return _equipList[param1] as PetEquipItem;
      }
      
      public function delPetEquip(param1:int) : void
      {
         if(getBagCell(param1))
         {
            getBagCell(param1).clearBagCell();
         }
      }
      
      public function update() : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         clearCell();
         var _loc3_:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         if(!_loc3_)
         {
            _starBar.starNum(!!_loc3_?_loc3_.StarLevel:0);
            _petBigItem.info = _loc3_;
            return;
         }
         _starBar.starNum(!!_loc3_?_loc3_.StarLevel:0);
         _petBigItem.info = _loc3_;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc2_ = _loc3_.equipList[_loc4_];
            if(_loc2_)
            {
               _loc1_ = ItemManager.fill(_loc2_) as InventoryItemInfo;
               addPetEquip(_loc2_);
            }
            _loc4_++;
         }
      }
      
      public function update2(param1:PetInfo) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         clearCell();
         var _loc4_:* = param1;
         if(!_loc4_)
         {
            _starBar.starNum(!!_loc4_?_loc4_.StarLevel:0);
            _petBigItem.info = _loc4_;
            return;
         }
         _starBar.starNum(!!_loc4_?_loc4_.StarLevel:0);
         _petBigItem.info = _loc4_;
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc3_ = _loc4_.equipList[_loc5_];
            if(_loc3_)
            {
               _loc2_ = ItemManager.fill(_loc3_) as InventoryItemInfo;
               addPetEquip(_loc3_);
            }
            _loc5_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = _equipList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            getBagCell(_equipList[_loc2_]).removeEventListener("doubleclick",doubleClickHander);
            _loc2_++;
         }
         PetSpriteManager.Instance.removeEventListener("showPetTip",__showPetTip);
      }
      
      private function clearCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 3)
         {
            delPetEquip(_loc1_);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_petBigItem)
         {
            ObjectUtils.disposeObject(_petBigItem);
            _petBigItem = null;
         }
         if(_equipLockBitmapData)
         {
            ObjectUtils.disposeObject(_equipLockBitmapData);
            _equipLockBitmapData = null;
         }
         if(_vbox)
         {
            ObjectUtils.disposeAllChildren(_vbox);
            ObjectUtils.disposeObject(_vbox);
            _vbox = null;
         }
         if(_starBar)
         {
            ObjectUtils.disposeObject(_starBar);
            _starBar = null;
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
