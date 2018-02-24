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
      
      public function KeySetItem(param1:uint = 0, param2:int = 0, param3:int = 0, param4:DisplayObject = null, param5:Boolean = false){super(null,null,null);}
      
      override protected function initItemBg() : void{}
      
      override protected function setItemWidthAndHeight() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      private function __over(param1:MouseEvent) : void{}
      
      private function __out(param1:MouseEvent) : void{}
      
      public function set glow(param1:Boolean) : void{}
      
      public function get glow() : Boolean{return false;}
      
      public function set propID(param1:int) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      override public function dispose() : void{}
   }
}
