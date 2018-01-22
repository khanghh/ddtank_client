package magicStone.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class MagicStoneProgress extends Component
   {
       
      
      private var _progressBg:Bitmap;
      
      private var _progress:Bitmap;
      
      private var _progressMask:Bitmap;
      
      private var _progressTxt:FilterFrameText;
      
      public function MagicStoneProgress()
      {
         super();
         initView();
         setData(0,0);
      }
      
      private function initView() : void
      {
         _progress = ComponentFactory.Instance.creat("magicStone.colorStrip");
         addChild(_progress);
         _progressBg = ComponentFactory.Instance.creat("magicStone.spaceProgress");
         addChild(_progressBg);
         _progressMask = ComponentFactory.Instance.creat("magicStone.spaceProgress");
         addChild(_progressMask);
         _progress.mask = _progressMask;
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("magicStone.progressTxt");
         addChild(_progressTxt);
         tipStyle = "ddt.view.tips.OneLineTip";
         tipDirctions = "7";
         tipGapV = 20;
      }
      
      public function setData(param1:int, param2:int) : void
      {
         _progressMask.scaleX = param1 / param2;
         tipData = param1 + "/" + param2;
         _progressTxt.text = int(param1 / param2 * 100) + "%";
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeObject(_progressMask);
         _progressMask = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         super.dispose();
      }
   }
}
