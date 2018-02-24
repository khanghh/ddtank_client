package dice.vo
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class DiceAwardCell extends BaseCell
   {
       
      
      private var _count:int;
      
      private var _background:Shape;
      
      private var _counttext:FilterFrameText;
      
      private var _caption:FilterFrameText;
      
      public function DiceAwardCell(param1:ItemTemplateInfo = null, param2:int = 1, param3:Boolean = true, param4:Boolean = true){super(null,null,null,null);}
      
      public function get count() : int{return 0;}
      
      public function set count(param1:int) : void{}
      
      private function initialize() : void{}
      
      override public function setContentSize(param1:Number, param2:Number) : void{}
      
      override public function dispose() : void{}
   }
}
