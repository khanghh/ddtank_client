package bagAndInfo.info
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Graphics;
   import vip.view.VipLevelProgress;
   
   public class NecklaceLevelProgress extends VipLevelProgress
   {
       
      
      private var _backBG:ScaleLeftRightImage;
      
      public function NecklaceLevelProgress()
      {
         super();
      }
      
      override protected function initView() : void
      {
         _thuck = ComponentFactory.Instance.creatComponentByStylename("NecklacePtetrochemicalView.thunck");
         addChildAt(_thuck,0);
         _backBG = ComponentFactory.Instance.creatComponentByStylename("NecklacePtetrochemicalView.LeveLBG");
         addChildAt(_backBG,0);
         _graphics_thuck = ComponentFactory.Instance.creatComponentByStylename("NecklacePtetrochemicalView.thuckBitData").getBitmapdata();
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("NecklaceProgressTxt");
         addChild(_progressLabel);
      }
      
      override protected function drawProgress() : void
      {
         var _loc2_:Number = _value / _max > 1?1:Number(_value / _max);
         var _loc1_:Graphics = _thuck.graphics;
         _loc1_.clear();
         if(_loc2_ >= 0)
         {
            _progressLabel.text = _value.toString() + "/" + _max.toString();
            _loc1_.beginBitmapFill(_graphics_thuck);
            _loc1_.drawRect(0,0,_width * _loc2_,_height - 8);
            _loc1_.endFill();
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_backBG);
         _backBG = null;
         super.dispose();
      }
   }
}
