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
      
      public function MagicHouseTreasureCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true)
      {
         super(param1,null,true,ComponentFactory.Instance.creatBitmap("magichouse.treasure.bag.bankCellBg"),true);
         pos = param1;
      }
      
      override public function set grayFilters(param1:Boolean) : void
      {
         if(param1)
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
