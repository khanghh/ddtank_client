package newTitle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class NewTitleListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _index:int;
      
      private var _info;
      
      private var _titleBg:ScaleFrameImage;
      
      private var _titleName:FilterFrameText;
      
      private var _shine:Bitmap;
      
      public function NewTitleListCell(){super();}
      
      private function initEvent() : void{}
      
      private function initView() : void{}
      
      public function dispose() : void{}
      
      private function removeEvent() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
   }
}
