package wasteRecycle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import flash.display.Sprite;
   import wasteRecycle.WasteRecycleController;
   
   public class WasteRecycleHelperFrame extends Frame
   {
       
      
      private var _helptext:FilterFrameText;
      
      private var _bg:Scale9CornerImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _helptext2:FilterFrameText;
      
      private var _infoList:Array;
      
      private var _sprite:Sprite;
      
      private var _helptext3:FilterFrameText;
      
      public function WasteRecycleHelperFrame(){super();}
      
      public function show() : void{}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function onFrameClose() : void{}
      
      private function updataView() : void{}
      
      override public function dispose() : void{}
   }
}
