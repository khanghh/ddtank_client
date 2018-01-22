package redPackage.view
{
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class RedPackageHelpCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _data:Object;
      
      private var redPkgHelpContent:Sprite;
      
      public function RedPackageHelpCell(){super();}
      
      public function dispose() : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
