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
      
      public function KeySetItem(index:uint = 0, propIndex:int = 0, propID:int = 0, item:DisplayObject = null, isCount:Boolean = false)
      {
         super(index,item,isCount);
         _propIndex = propIndex;
         _propID = propID;
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
      
      public function dragDrop(effect:DragEffect) : void
      {
         DragManager.acceptDrag(this,"none");
      }
      
      private function __over(e:MouseEvent) : void
      {
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      private function __out(e:MouseEvent) : void
      {
         filters = null;
      }
      
      public function set glow(b:Boolean) : void
      {
         _isGlow = b;
         glow_mc.visible = _isGlow;
      }
      
      public function get glow() : Boolean
      {
         return _isGlow;
      }
      
      public function set propID(value:int) : void
      {
         _propID = value;
      }
      
      public function get tipData() : Object
      {
         var info:PropInfo = new PropInfo(ItemManager.Instance.getTemplateById(_propID));
         var tipInfo:ToolPropInfo = new ToolPropInfo();
         tipInfo.showThew = true;
         tipInfo.info = info.Template;
         if(_propIndex)
         {
            tipInfo.shortcutKey = _propIndex.toString();
         }
         return tipInfo;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set tipData(value:Object) : void
      {
      }
      
      public function get tipDirctions() : String
      {
         return "5,2,7,1,6,4";
      }
      
      public function set tipDirctions(value:String) : void
      {
      }
      
      public function get tipGapH() : int
      {
         return -15;
      }
      
      public function set tipGapH(value:int) : void
      {
      }
      
      public function get tipGapV() : int
      {
         return 5;
      }
      
      public function set tipGapV(value:int) : void
      {
      }
      
      public function get tipStyle() : String
      {
         return "core.ToolPropTips";
      }
      
      public function set tipStyle(value:String) : void
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
