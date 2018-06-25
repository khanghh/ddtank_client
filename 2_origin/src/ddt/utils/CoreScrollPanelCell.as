package ddt.utils
{
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class CoreScrollPanelCell extends Sprite implements Disposeable, IListCell
   {
      
      public static var content:Sprite;
       
      
      private var _data:Object;
      
      public function CoreScrollPanelCell()
      {
         super();
         mouseEnabled = false;
      }
      
      public function getCellValue() : *
      {
         return {};
      }
      
      public function setCellValue(value:*) : void
      {
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
         addChild(content);
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(content);
         content = null;
      }
   }
}
