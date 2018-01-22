package bagAndInfo.cell
{
   import beadSystem.beadSystemManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CellEvent;
   import ddt.interfaces.ICell;
   import ddt.interfaces.IDragable;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.DragManager;
   import ddt.manager.ServerConfigManager;
   import ddt.utils.PositionUtils;
   import ddt.view.tips.GoodTipInfo;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import magicStone.MagicStoneManager;
   
   [Event(name="change",type="flash.events.Event")]
   public class BaseCell extends Sprite implements ICell, ITipedDisplay, Disposeable
   {
       
      
      protected var _bg:DisplayObject;
      
      protected var _contentHeight:Number;
      
      protected var _contentWidth:Number;
      
      protected var _info:ItemTemplateInfo;
      
      protected var _loadingasset:MovieClip;
      
      protected var _pic:CellContentCreator;
      
      protected var _effect:CellMCSpecialEffectCreator;
      
      protected var _picPos:Point;
      
      protected var _showLoading:Boolean;
      
      protected var _showTip:Boolean;
      
      protected var _smallPic:Sprite;
      
      protected var _tipData:Object;
      
      protected var _tipDirection:String;
      
      protected var _tipGapH:int;
      
      protected var _tipGapV:int;
      
      protected var _tipStyle:String;
      
      protected var _allowDrag:Boolean;
      
      private var _overBg:DisplayObject;
      
      protected var _locked:Boolean;
      
      private var _grayFlag:Boolean;
      
      protected var _markStarContainer:HBox;
      
      public var showStarContainer:Boolean = true;
      
      public function BaseCell(param1:DisplayObject, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:Boolean = true){super();}
      
      public function set overBg(param1:DisplayObject) : void{}
      
      public function get overBg() : DisplayObject{return null;}
      
      public function set PicPos(param1:Point) : void{}
      
      public function get allowDrag() : Boolean{return false;}
      
      public function set allowDrag(param1:Boolean) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
      
      public function dragDrop(param1:DragEffect) : void{}
      
      public function dragStart() : void{}
      
      public function dragStop(param1:DragEffect) : void{}
      
      public function get editLayer() : int{return 0;}
      
      public function getContent() : Sprite{return null;}
      
      public function getSmallContent() : Sprite{return null;}
      
      public function getSource() : IDragable{return null;}
      
      public function set grayFilters(param1:Boolean) : void{}
      
      public function get grayFlag() : Boolean{return false;}
      
      override public function get height() : Number{return 0;}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function resetLoadIcon() : void{}
      
      protected function setDefaultTipData() : void{}
      
      private function isNotWeddingRing(param1:ItemTemplateInfo) : Boolean{return false;}
      
      public function get locked() : Boolean{return false;}
      
      public function set locked(param1:Boolean) : void{}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function setContentSize(param1:Number, param2:Number) : void{}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function get tipDirctions() : String{return null;}
      
      public function set tipDirctions(param1:String) : void{}
      
      public function get tipGapH() : int{return 0;}
      
      public function set tipGapH(param1:int) : void{}
      
      public function get tipGapV() : int{return 0;}
      
      public function set tipGapV(param1:int) : void{}
      
      public function get tipStyle() : String{return null;}
      
      public function set tipStyle(param1:String) : void{}
      
      override public function get width() : Number{return 0;}
      
      protected function clearCreatingContent() : void{}
      
      protected function createChildren() : void{}
      
      protected function createContentComplete() : void{}
      
      protected function createEffectComplete() : void{}
      
      protected function createDragImg() : DisplayObject{return null;}
      
      protected function createLoading() : void{}
      
      protected function init() : void{}
      
      protected function initTip() : void{}
      
      protected function initEvent() : void{}
      
      protected function onMouseClick(param1:MouseEvent) : void{}
      
      protected function onMouseOut(param1:MouseEvent) : void{}
      
      protected function onMouseOver(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      protected function updateSize(param1:Sprite) : void{}
      
      protected function clearLoading() : void{}
      
      private function updateCellStar() : void{}
      
      private function updateLockState() : void{}
      
      protected function updateSizeII(param1:Sprite) : void{}
   }
}
