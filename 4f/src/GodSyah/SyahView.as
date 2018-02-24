package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import wonderfulActivity.views.IRightView;
   
   public class SyahView extends Sprite implements IRightView
   {
       
      
      private var _bg:Bitmap;
      
      private var _valid:FilterFrameText;
      
      private var _description:FilterFrameText;
      
      private var _content:SyahItemContent;
      
      private var _vbox:VBox;
      
      private var _scrollpanel:ScrollPanel;
      
      public function SyahView(){super();}
      
      private function _buildUI() : void{}
      
      private function _createItem() : void{}
      
      public function init() : void{}
      
      public function content() : Sprite{return null;}
      
      public function setState(param1:int, param2:int) : void{}
      
      public function dispose() : void{}
   }
}
