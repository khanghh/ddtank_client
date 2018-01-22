package setting.view
{
   import bagAndInfo.cell.DragEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.data.PropInfo;
   import ddt.interfaces.IAcceptDrag;
   import ddt.manager.DragManager;
   import ddt.manager.ItemManager;
   import ddt.view.tips.ToolPropInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import gameCommon.view.ItemCellView;
   
   public class KeySetItem extends ItemCellView implements IAcceptDrag, ITipedDisplay
   {
       
      
      private var _propIndex:int;
      
      private var _propID:int;
      
      private var _isGlow:Boolean = false;
      
      private var glow_mc:Bitmap;
      
      private var lightingFilter:ColorMatrixFilter;
      
      private const CONST1:int = 40;
      
      private const CONST2:int = 35;
      
      public function KeySetItem(param1:uint = 0, param2:int = 0, param3:int = 0, param4:DisplayObject = null, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _propIndex = param2;
         _propID = param3;
         glow_mc = ComponentFactory.Instance.creatBitmap("ddtsetting.keyset.glowAsset");
         addChild(glow_mc);
         glow_mc.visible = false;
         addEventListener("rollOver",__over);
         addEventListener("rollOut",__out);
         ShowTipManager.Instance.addTip(this);
      }
      
      override protected function initItemBg() : void
      {
         _asset = ComponentFactory.Instance.creatBitmap("ddtsetting.keyset.quickKeyItemBg");
         var _loc1_:int = 40;
         _asset.height = _loc1_;
         _asset.width = _loc1_;
      }
      
      override protected function setItemWidthAndHeight() : void
      {
         var _loc1_:int = 35;
         _item.height = _loc1_;
         _item.width = _loc1_;
         _item.x = 2;
         _item.y = 3;
      }
      
      public function dragDrop(param1:DragEffect) : void
      {
         DragManager.acceptDrag(this,"none");
      }
      
      private function __over(param1:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function __out(param1:MouseEvent) : void
      {
         filters = null;
      }
      
      public function set glow(param1:Boolean) : void
      {
         _isGlow = param1;
         glow_mc.visible = _isGlow;
      }
      
      public function get glow() : Boolean
      {
         return _isGlow;
      }
      
      public function set propID(param1:int) : void
      {
         _propID = param1;
      }
      
      public function get tipData() : Object
      {
         var _loc2_:PropInfo = new PropInfo(ItemManager.Instance.getTemplateById(_propID));
         var _loc1_:ToolPropInfo = new ToolPropInfo();
         _loc1_.showThew = true;
         _loc1_.info = _loc2_.Template;
         if(_propIndex)
         {
            _loc1_.shortcutKey = _propIndex.toString();
         }
         return _loc1_;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(param1:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return -15;
      }
      
      public function set tipGapH(param1:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 5;
      }
      
      public function set tipGapV(param1:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "core.ToolPropTips";
      }
      
      public function set tipStyle(param1:String) : void
      {
      }
      
      override public function dispose() : void
      {
         ShowTipManager.Instance.removeTip(this);
         removeEventListener("rollOver",__over);
         removeEventListener("rollOut",__out);
         if(glow_mc && glow_mc.parent)
         {
            glow_mc.parent.removeChild(glow_mc);
         }
         glow_mc = null;
         lightingFilter = null;
         filters = null;
         super.dispose();
      }
   }
}
