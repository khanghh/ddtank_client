package magicHouse.treasureHouse
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public class MagicHouseTreasureCell extends BagCell
   {
       
      
      public var isOpen:Boolean;
      
      public var pos:int;
      
      public function MagicHouseTreasureCell(index:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null, mouseOverEffBoolean:Boolean = true)
      {
         super(index,null,true,ComponentFactory.Instance.creatBitmap("magichouse.treasure.bag.bankCellBg"),true);
         pos = index;
      }
      
      override public function set grayFilters(b:Boolean) : void
      {
         if(b)
         {
            removeChild(_bg);
            _bg = null;
            _bg = ComponentFactory.Instance.creatBitmap("magichouse.treasure.bag.bankCellBg.lock");
            addChildAt(_bg,0);
            this.buttonMode = true;
         }
         else
         {
            removeChild(_bg);
            _bg = null;
            _bg = ComponentFactory.Instance.creatBitmap("magichouse.treasure.bag.bankCellBg");
            addChildAt(_bg,0);
            this.buttonMode = false;
         }
      }
   }
}
