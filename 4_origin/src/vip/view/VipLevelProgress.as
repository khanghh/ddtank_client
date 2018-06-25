package vip.view
{
   import bagAndInfo.info.LevelProgress;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Graphics;
   
   public class VipLevelProgress extends LevelProgress
   {
       
      
      private var _backBG:ScaleLeftRightImage;
      
      public function VipLevelProgress()
      {
         super();
      }
      
      public function set progressLabelTextFormatStyle(value:String) : void
      {
         _progressLabel.textFormatStyle = value;
      }
      
      public function set progressLabelFilterString(value:String) : void
      {
         _progressLabel.filterString = value;
      }
      
      override protected function initView() : void
      {
         _thuck = ComponentFactory.Instance.creatComponentByStylename("VIP.thunck");
         addChildAt(_thuck,0);
         _backBG = ComponentFactory.Instance.creatComponentByStylename("VIP.LeveLBG");
         addChildAt(_backBG,0);
         _graphics_thuck = ComponentFactory.Instance.creatComponentByStylename("VIP.thuckBitData").getBitmapdata();
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("vipLevelProgressTxt");
         addChild(_progressLabel);
      }
      
      override protected function drawProgress() : void
      {
         var rate:Number = _value / _max > 1?1:Number(_value / _max);
         var pen:Graphics = _thuck.graphics;
         pen.clear();
         if(rate >= 0)
         {
            _progressLabel.text = Math.floor(rate * 10000) / 100 + "%";
            pen.beginBitmapFill(_graphics_thuck);
            pen.drawRect(0,0,_width * rate,_height - 8);
            pen.endFill();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_backBG);
         _backBG = null;
      }
   }
}
