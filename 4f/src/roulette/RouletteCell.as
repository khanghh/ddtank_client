package roulette
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class RouletteCell extends BaseCell
   {
       
      
      private var _selected:Boolean;
      
      private var _count:int;
      
      private var _boolCreep:Boolean;
      
      private var _selectMovie:MovieClip;
      
      public function RouletteCell(param1:DisplayObject){super(null);}
      
      override protected function createChildren() : void{}
      
      protected function initII() : void{}
      
      public function setSparkle() : void{}
      
      public function set count(param1:int) : void{}
      
      public function get count() : int{return 0;}
      
      public function setGreep() : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      override public function dispose() : void{}
   }
}
