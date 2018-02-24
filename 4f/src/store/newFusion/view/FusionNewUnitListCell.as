package store.newFusion.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import horse.HorseControl;
   import petsBag.petsAdvanced.PetsAdvancedManager;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewUnitListCell extends Sprite implements Disposeable, IListCell
   {
       
      
      private var _isActivatedText:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _countTxt:FilterFrameText;
      
      private var _selectedCover:Bitmap;
      
      private var _data:FusionNewVo;
      
      public function FusionNewUnitListCell(){super();}
      
      private function updateViewData() : void{}
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
