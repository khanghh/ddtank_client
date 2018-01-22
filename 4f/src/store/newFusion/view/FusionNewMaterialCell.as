package store.newFusion.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import store.newFusion.data.FusionNewVo;
   
   public class FusionNewMaterialCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _tipTxt:FilterFrameText;
      
      private var _itemCell:BagCell;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _data:FusionNewVo;
      
      private var _needCount:int;
      
      public function FusionNewMaterialCell(param1:int){super();}
      
      private function initView() : void{}
      
      public function refreshView(param1:FusionNewVo) : void{}
      
      public function refreshCount() : void{}
      
      public function dispose() : void{}
   }
}
