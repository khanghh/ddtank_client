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
      
      public function setup(param1:Array) : void
      {
         _cow = Math.ceil(param1.length / 4);
         init();
         createCells(param1);
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
      
      private function createCells(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         _list.beginChanges();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(param1[_loc4_]);
            _loc2_ = new ShortcutBuyCell(_loc3_);
            _loc2_.info = _loc3_;
            _loc2_.addEventListener("click",cellClickHandler);
            _loc2_.buttonMode = true;
            _loc2_.showBg();
            _list.addChild(_loc2_);
            _cells.push(_loc2_);
            _loc4_++;
         }
         _list.commitChanges();
      }
      
      public function shine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.hideBg();
            _loc1_.startShine();
         }
      }
      
      public function noShine() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            _loc1_.stopShine();
            _loc1_.showBg();
         }
      }
      
      private function cellClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            _loc2_.selected = false;
            noShine();
         }
         ShortcutBuyCell(param1.currentTarget).selected = true;
         dispatchEvent(new Event("select"));
      }
      
      public function get selectedItemID() : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = _cells;
         for each(var _loc1_ in _cells)
         {
            if(_loc1_.selected)
            {
               return _loc1_.info.TemplateID;
            }
         }
         return -1;
      }
      
      public function set selectedItemID(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _cells;
         for each(var _loc2_ in _cells)
         {
            if(_loc2_.info.TemplateID == param1)
            {
               _loc2_.selected = true;
               return;
            }
         }
      }
      
      public function set selectedIndex(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _cells.length;
         if(param1 >= 0 && param1 < _loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ == param1)
               {
                  _cells[_loc3_].selected = true;
               }
               else
               {
                  _cells[_loc3_].selected = false;
               }
               _loc3_++;
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
         for each(var _loc1_ in _cells)
         {
            _loc1_.removeEventListener("click",cellClickHandler);
            ObjectUtils.disposeObject(_loc1_);
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
