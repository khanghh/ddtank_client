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
      
      public function DiceAwardCell($info:ItemTemplateInfo = null, count:int = 1, showLoading:Boolean = true, showTip:Boolean = true)
      {
         $info = $info;
         count = count;
         showLoading = showLoading;
         showTip = showTip;
         _background = new Shape();
         with(_background.graphics)
         {
            
            lineStyle(1,16777215,0.6);
            beginFill(0,0.5);
            drawRoundRect(0,0,38,38,8,8);
            endFill();
         }
         _count = count;
         super(_background,$info,showLoading,showTip);
         initialize();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(value:int) : void
      {
         _count = value;
      }
      
      private function initialize() : void
      {
         _bg.visible = false;
         _counttext = ComponentFactory.Instance.creatComponentByStylename("asset.dice.awardcell.count");
         _counttext.text = String(_count);
         _caption = ComponentFactory.Instance.creatComponentByStylename("asset.dice.awardcell.caption");
         _caption.text = _info.Name;
         if(_caption.numLines > 1)
         {
            _caption.y = 2;
         }
         else
         {
            _caption.y = 10;
         }
         if(_count > 1)
         {
            addChild(_counttext);
         }
         addChild(_caption);
      }
      
      override public function setContentSize(cWidth:Number, cHeight:Number) : void
      {
         PicPos = new Point(-21,-21);
         updateSize(_pic);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_counttext);
         _counttext = null;
         ObjectUtils.disposeObject(_caption);
         _caption = null;
         super.dispose();
      }
   }
}
