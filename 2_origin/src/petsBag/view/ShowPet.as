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
   import ddt.utils.PositionUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import pet.data.PetInfo;
   import pet.sprite.PetSpriteManager;
   import petsBag.PetsBagManager;
   import petsBag.view.item.PetBigItem;
   import petsBag.view.item.PetEquipItem;
   import petsBag.view.item.PetWashBoneGrade;
   import petsBag.view.item.StarBar;
   
   public class ShowPet extends Sprite implements Disposeable
   {
      
      public static var isPetEquip:Boolean;
       
      
      private var _starBar:StarBar;
      
      private var _petGrade:PetWashBoneGrade;
      
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
         var i:int = 0;
         var item:* = null;
         _dragDropArea = new PersonalInfoDragInArea();
         _equipList = [];
         _vbox = ComponentFactory.Instance.creatCustomObject("petsBag.showPet.vbox");
         for(i = 0; i < 3; )
         {
            item = new PetEquipItem(i);
            item.id = i;
            item.addEventListener("doubleclick",doubleClickHander);
            item.addEventListener("itemclick",onClickHander);
            _vbox.addChild(item);
            _equipList.push(item);
            i++;
         }
         _starBar = new StarBar();
         _starBar.x = _vbox.x + _vbox.width;
         addChild(_starBar);
         _petBigItem = ComponentFactory.Instance.creat("petsBag.petBigItem");
         _petBigItem.initTips();
         _petGrade = new PetWashBoneGrade();
         addChild(_petGrade);
         PositionUtils.setPos(_petGrade,"petsBag.petGradePos");
         addChild(_dragDropArea);
         addChild(_petBigItem);
         addChild(_vbox);
      }
      
      private function initEvent() : void
      {
         PetSpriteManager.Instance.addEventListener("showPetTip",__showPetTip);
      }
      
      private function __showPetTip(e:Event) : void
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
      
      private function onClickHander(e:CellEvent) : void
      {
         var cell:* = null;
         if(PlayerInfoViewControl.isOpenFromBag)
         {
            cell = e.data as BagCell;
            PetsBagManager.instance().isEquip = true;
            cell.dragStart();
         }
      }
      
      private function doubleClickHander(e:CellEvent) : void
      {
         if(PlayerInfoViewControl.isOpenFromBag)
         {
            SocketManager.Instance.out.delPetEquip(PetsBagManager.instance().petModel.currentPetInfo.Place,e.currentTarget.id);
         }
      }
      
      public function addPetEquip(date:InventoryItemInfo) : void
      {
         getBagCell(date.Place).initBagCell(date);
      }
      
      public function getBagCell(type:int) : PetEquipItem
      {
         return _equipList[type] as PetEquipItem;
      }
      
      public function delPetEquip(id:int) : void
      {
         if(getBagCell(id))
         {
            getBagCell(id).clearBagCell();
         }
      }
      
      public function update() : void
      {
         var i:int = 0;
         var data:* = null;
         var newInfo:* = null;
         clearCell();
         var currentPet:PetInfo = PetsBagManager.instance().petModel.currentPetInfo;
         _petGrade.visible = currentPet != null;
         if(!currentPet)
         {
            _starBar.starNum(!!currentPet?currentPet.StarLevel:0);
            _petBigItem.info = currentPet;
            return;
         }
         _starBar.starNum(!!currentPet?currentPet.StarLevel:0);
         _petBigItem.info = currentPet;
         for(i = 0; i < 3; )
         {
            data = currentPet.equipList[i];
            if(data)
            {
               newInfo = ItemManager.fill(data) as InventoryItemInfo;
               addPetEquip(data);
            }
            i++;
         }
         _petGrade.info = currentPet;
      }
      
      public function update2(currentPet2:PetInfo) : void
      {
         var i:int = 0;
         var data:* = null;
         var newInfo:* = null;
         clearCell();
         var currentPet:* = currentPet2;
         _petGrade.visible = currentPet != null;
         if(!currentPet)
         {
            _starBar.starNum(!!currentPet?currentPet.StarLevel:0);
            _petBigItem.info = currentPet;
            return;
         }
         _starBar.starNum(!!currentPet?currentPet.StarLevel:0);
         _petBigItem.info = currentPet;
         for(i = 0; i < 3; )
         {
            data = currentPet.equipList[i];
            if(data)
            {
               newInfo = ItemManager.fill(data) as InventoryItemInfo;
               addPetEquip(data);
            }
            i++;
         }
         _petGrade.info = currentPet;
      }
      
      private function removeEvent() : void
      {
         var i:int = 0;
         var len:int = _equipList.length;
         for(i = 0; i < len; )
         {
            getBagCell(_equipList[i]).removeEventListener("doubleclick",doubleClickHander);
            i++;
         }
         PetSpriteManager.Instance.removeEventListener("showPetTip",__showPetTip);
      }
      
      private function clearCell() : void
      {
         var i:int = 0;
         for(i = 0; i < 3; )
         {
            delPetEquip(i);
            i++;
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
         ObjectUtils.disposeObject(_petGrade);
         _petGrade = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}
