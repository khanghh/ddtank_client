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
      
      public function showForVipAward(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(!param1 || param1.length < 1)
         {
            return;
         }
         _goodsList = param1;
         _cells = new Vector.<BoxVipTipsInfoCell>();
         _list.dispose();
         _list = new SimpleTileList(_goodsList.length);
         _list.vSpace = 12;
         _list.hSpace = 120;
         _list.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _goodsList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("bossbox.BoxVipTipsInfoCell");
            if(_goodsList[_loc3_])
            {
               _loc2_.info = _goodsList[_loc3_] as ItemTemplateInfo;
               _loc2_.itemName = (_goodsList[_loc3_] as ItemTemplateInfo).Name;
               _loc2_.isSelect = isCanSelect(_loc3_);
               if(isCanSelect(_loc3_))
               {
                  _currentCell = _loc2_;
               }
               _list.addChild(_loc2_);
               _cells.push(_loc2_);
            }
            _loc3_++;
         }
         _list.commitChanges();
         addChild(_list);
      }
      
      private function isCanSelect(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = PlayerManager.Instance.Self.VIPLevel;
         switch(int(param1))
         {
            case 0:
               _loc3_ = true && _loc2_ < 12;
               break;
            case 1:
               _loc3_ = false || _loc2_ == 12;
         }
         return _loc3_;
      }
      
      private function __cellClick(param1:CellEvent) : void
      {
         _currentCell = param1.data as BoxVipTipsInfoCell;
      }
      
      private function getTemplateInfo(param1:int) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.TemplateID = param1;
         ItemManager.fill(_loc2_);
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.dispose();
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
