package ddt.interfaces
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   
   public interface ICellFactory
   {
       
      
      function createBagCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null) : ICell;
      
      function createPersonalInfoCell(param1:int, param2:ItemTemplateInfo = null, param3:Boolean = true) : ICell;
   }
}
