package cardSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.geom.Matrix;
   
   public class CardPropress extends Component
   {
       
      
      private var _thuck:Component;
      
      private var _graphics_thuck:BitmapData;
      
      private var _propgressLabel:FilterFrameText;
      
      private var _value:Number = 0;
      
      private var _max:Number = 100;
      
      public function CardPropress()
      {
         super();
         _height = 10;
         _width = 10;
         initView();
         drawProgress();
      }
      
      private function initView() : void
      {
         _thuck = ComponentFactory.Instance.creatComponentByStylename("cardSystem.info.thunck");
         addChild(_thuck);
         _graphics_thuck = ComponentFactory.Instance.creatBitmapData("card.info.Bitmap_thuck1");
         _propgressLabel = ComponentFactory.Instance.creatComponentByStylename("CardSystem.info.LevelProgressText");
         addChild(_propgressLabel);
      }
      
      public function setProgress(param1:Number, param2:Number) : void
      {
         if(_value != param1 || _max != param2)
         {
            _value = param1;
            _max = param2;
            drawProgress();
         }
      }
      
      private function drawProgress() : void
      {
         var _loc2_:Number = _value / _max > 1?1:Number(_value / _max);
         var _loc1_:Graphics = _thuck.graphics;
         _loc1_.clear();
         if(_loc2_ >= 0)
         {
            _propgressLabel.text = Math.floor(_loc2_ * 10000) / 100 + "%";
            _loc1_.beginBitmapFill(_graphics_thuck,new Matrix(1.04065040650407));
            _loc1_.drawRect(0,0,(_width + 20) * _loc2_,_height - 4);
            _loc1_.endFill();
         }
      }
      
      public function set labelText(param1:String) : void
      {
         _propgressLabel.text = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_graphics_thuck);
         _graphics_thuck = null;
         ObjectUtils.disposeObject(_thuck);
         _thuck = null;
         ObjectUtils.disposeObject(_propgressLabel);
         _propgressLabel = null;
         super.dispose();
      }
   }
}
