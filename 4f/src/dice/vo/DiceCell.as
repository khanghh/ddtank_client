package dice.vo
{
   import bagAndInfo.cell.BaseCell;
   import bagAndInfo.cell.CellContentCreator;
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class DiceCell extends BaseCell
   {
       
      
      private var _txtCount:FilterFrameText;
      
      private var _count:int;
      
      private var _position:int;
      
      private var _strengthLevel:int;
      
      private var _validate:int;
      
      private var _isBind:Boolean = false;
      
      private var _isDestination:Boolean = false;
      
      private var _vertices:Vector.<Number>;
      
      private var _indices:Vector.<int>;
      
      private var _uvtData:Vector.<Number>;
      
      private var _cellInfo:DiceCellInfo;
      
      private var _mask:DisplayObject;
      
      private var _lightByMask:DisplayObject;
      
      private var _Deform:Shape;
      
      public function DiceCell(param1:DisplayObject, param2:DiceCellInfo, param3:ItemTemplateInfo = null, param4:DisplayObject = null, param5:Boolean = true, param6:Boolean = true){super(null,null,null,null);}
      
      private function preInitialize() : void{}
      
      public function get isDestination() : Boolean{return false;}
      
      public function set isDestination(param1:Boolean) : void{}
      
      public function get isBind() : Boolean{return false;}
      
      public function set isBind(param1:Boolean) : void{}
      
      public function get validate() : int{return 0;}
      
      public function set validate(param1:int) : void{}
      
      public function get strengthLevel() : int{return 0;}
      
      public function set strengthLevel(param1:int) : void{}
      
      public function get position() : int{return 0;}
      
      public function set position(param1:int) : void{}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      private function initialize() : void{}
      
      override public function setContentSize(param1:Number, param2:Number) : void{}
      
      override protected function createChildren() : void{}
      
      override protected function createContentComplete() : void{}
      
      override public function dispose() : void{}
   }
}
