package petsBag.view.item
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.ShineObject;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CellEvent;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import petsBag.view.ShowPet;
   
   public class PetEquipItem extends Sprite
   {
       
      
      private var _back:Bitmap;
      
      private var _cell:BagCell;
      
      public var id:int;
      
      private var _shiner:ShineObject;
      
      public function PetEquipItem(type:int)
      {
         super();
         initView(type);
      }
      
      private function initView(type:int) : void
      {
         _back = ComponentFactory.Instance.creat("assets.petsBag.equip" + String(type));
         addChild(_back);
         addEventListener("interactive_double_click",onDoubleClick);
         addEventListener("interactive_click",onClick);
         DoubleClickManager.Instance.enableDoubleClick(this);
         _shiner = new ShineObject(ComponentFactory.Instance.creat("asset.petBagSystem.cellShine"));
         _shiner.x = -5;
         _shiner.y = -4;
         _shiner.width = 48;
         _shiner.height = 48;
         addChild(_shiner);
         var _loc2_:Boolean = false;
         _shiner.mouseEnabled = _loc2_;
         _shiner.mouseChildren = _loc2_;
      }
      
      public function shinePlay() : void
      {
         _shiner.shine();
      }
      
      public function shineStop() : void
      {
         _shiner.stopShine();
      }
      
      private function onClick(e:InteractiveEvent) : void
      {
         if(_cell)
         {
            dispatchEvent(new CellEvent("itemclick",_cell));
         }
      }
      
      protected function onDoubleClick(event:InteractiveEvent) : void
      {
         SoundManager.instance.playButtonSound();
         if(_cell)
         {
            dispatchEvent(new CellEvent("doubleclick",this));
         }
      }
      
      public function initBagCell(data:InventoryItemInfo) : void
      {
         clearBagCell();
         ShowPet.isPetEquip = true;
         _cell = new BagCell(0,data);
         _cell.allowDrag = true;
         addChild(_cell);
      }
      
      public function clearBagCell() : void
      {
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
            _cell = null;
         }
      }
      
      public function dispose() : void
      {
         removeEventListener("interactive_double_click",onDoubleClick);
         clearBagCell();
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
      }
   }
}
