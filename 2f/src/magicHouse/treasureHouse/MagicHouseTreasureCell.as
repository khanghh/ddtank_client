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
      
      public function MagicHouseTreasureCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null, param5:Boolean = true){super(null,null,null,null);}
      
      override public function set grayFilters(param1:Boolean) : void{}
   }
}
