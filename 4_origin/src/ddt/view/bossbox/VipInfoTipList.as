package ddt.view.bossbox
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import flash.display.Sprite;
   
   public class VipInfoTipList extends Sprite implements Disposeable
   {
       
      
      private var _goodsList:Array;
      
      private var _list:SimpleTileList;
      
      private var _cells:Vector.<BoxVipTipsInfoCell>;
      
      private var _currentCell:BoxVipTipsInfoCell;
      
      public function VipInfoTipList()
      {
         super();
         initList();
      }
      
      public function get currentCell() : BoxVipTipsInfoCell
      {
         return _currentCell;
      }
      
      protected function initList() : void
      {
         _list = new SimpleTileList(2);
      }
      
      public function showForVipAward(infoList:Array) : void
      {
         var i:int = 0;
         var cell:* = null;
         if(!infoList || infoList.length < 1)
         {
            return;
         }
         _goodsList = infoList;
         _cells = new Vector.<BoxVipTipsInfoCell>();
         _list.dispose();
         _list = new SimpleTileList(_goodsList.length);
         _list.vSpace = 12;
         _list.hSpace = 120;
         _list.beginChanges();
         for(i = 0; i < _goodsList.length; )
         {
            cell = ComponentFactory.Instance.creatCustomObject("bossbox.BoxVipTipsInfoCell");
            if(_goodsList[i])
            {
               cell.info = _goodsList[i] as ItemTemplateInfo;
               cell.itemName = (_goodsList[i] as ItemTemplateInfo).Name;
               cell.isSelect = isCanSelect(i);
               if(isCanSelect(i))
               {
                  _currentCell = cell;
               }
               _list.addChild(cell);
               _cells.push(cell);
            }
            i++;
         }
         _list.commitChanges();
         addChild(_list);
      }
      
      private function isCanSelect(index:int) : Boolean
      {
         var resultBool:Boolean = false;
         var level:int = PlayerManager.Instance.Self.VIPLevel;
         switch(int(index))
         {
            case 0:
               resultBool = true && level < 12;
               break;
            case 1:
               resultBool = false || level == 12;
         }
         return resultBool;
      }
      
      private function __cellClick(e:CellEvent) : void
      {
         _currentCell = e.data as BoxVipTipsInfoCell;
      }
      
      private function getTemplateInfo(id:int) : InventoryItemInfo
      {
         var itemInfo:InventoryItemInfo = new InventoryItemInfo();
         itemInfo.TemplateID = id;
         ItemManager.fill(itemInfo);
         return itemInfo;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.dispose();
         }
         _cells.splice(0,_cells.length);
         _cells = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
