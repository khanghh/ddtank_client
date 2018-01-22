package godCardRaise.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import godCardRaise.GodCardRaiseManager;
   import godCardRaise.info.GodCardListGroupInfo;
   
   public class GodCardRaiseExchangeLeftCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedLight:Scale9CornerImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _data:GodCardListGroupInfo;
      
      private var _getExchangeBmp:Bitmap;
      
      public function GodCardRaiseExchangeLeftCell(){super();}
      
      private function initView() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function updateView() : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
