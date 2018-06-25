package store.view.shortcutBuy
{
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class ShortcutBuyList extends Sprite implements Disposeable
   {
       
      
      private var _list:SimpleTileList;
      
      private var _cells:Vector.<ShortcutBuyCell>;
      
      private var _cow:int;
      
      public function ShortcutBuyList()
      {
         super();
      }
      
      public function setup(itemIDs:Array) : void
      {
         _cow = Math.ceil(itemIDs.length / 4);
         init();
         createCells(itemIDs);
      }
      
      private function init() : void
      {
         _cells = new Vector.<ShortcutBuyCell>();
         _list = new SimpleTileList(4);
         _list.hSpace = 30;
         _list.vSpace = 40;
         addChild(_list);
      }
      
      override public function get height() : Number
      {
         return _list.height;
      }
      
      private function createCells(itemIDs:Array) : void
      {
         var i:int = 0;
         var info:* = null;
         var cell:* = null;
         _list.beginChanges();
         for(i = 0; i < itemIDs.length; )
         {
            info = ItemManager.Instance.getTemplateById(itemIDs[i]);
            cell = new ShortcutBuyCell(info);
            cell.info = info;
            cell.addEventListener("click",cellClickHandler);
            cell.buttonMode = true;
            cell.showBg();
            _list.addChild(cell);
            _cells.push(cell);
            i++;
         }
         _list.commitChanges();
      }
      
      public function shine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.hideBg();
            cell.startShine();
         }
      }
      
      public function noShine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.stopShine();
            cell.showBg();
         }
      }
      
      private function cellClickHandler(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var cell in _cells)
         {
            cell.selected = false;
            noShine();
         }
         ShortcutBuyCell(evt.currentTarget).selected = true;
         dispatchEvent(new Event("select"));
      }
      
      public function get selectedItemID() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            if(cell.selected)
            {
               return cell.info.TemplateID;
            }
         }
         return -1;
      }
      
      public function set selectedItemID(value:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var cell in _cells)
         {
            if(cell.info.TemplateID == value)
            {
               cell.selected = true;
               return;
            }
         }
      }
      
      public function set selectedIndex(value:int) : void
      {
         var i:int = 0;
         var tmpLength:int = _cells.length;
         if(value >= 0 && value < tmpLength)
         {
            for(i = 0; i < tmpLength; )
            {
               if(i == value)
               {
                  _cells[i].selected = true;
               }
               else
               {
                  _cells[i].selected = false;
               }
               i++;
            }
         }
      }
      
      public function get list() : SimpleTileList
      {
         return _list;
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var cell in _cells)
         {
            cell.removeEventListener("click",cellClickHandler);
            ObjectUtils.disposeObject(cell);
         }
         _cells = null;
         _list.disposeAllChildren();
         _list = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
