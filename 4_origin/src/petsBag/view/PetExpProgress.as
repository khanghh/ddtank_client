package petsBag.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PetExperience;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   
   public class PetExpProgress extends Component
   {
       
      
      private var _backGround:Bitmap;
      
      private var _gpItem:ScaleLeftRightImage;
      
      private var _maxGpItem:ScaleLeftRightImage;
      
      private var _gpMask:Shape;
      
      private var _maxGpMask:Shape;
      
      private var _gp:Number = 0;
      
      private var _maxGp:Number = 100;
      
      private var _progressLabel:FilterFrameText;
      
      public function PetExpProgress()
      {
         super();
         _height = 10;
         _width = 10;
         initView();
      }
      
      override public function get tipData() : Object
      {
         return _tipData;
      }
      
      private function initView() : void
      {
         _backGround = ComponentFactory.Instance.creatBitmap("assets.petsBag.Background_Progress1");
         addChild(_backGround);
         _gpItem = ComponentFactory.Instance.creatComponentByStylename("petsBag.thuck.Graphic");
         addChild(_gpItem);
         _gpMask = creatMask(_gpItem);
         addChild(_gpMask);
         _maxGpItem = ComponentFactory.Instance.creatComponentByStylename("petsBag.thuck.maxGraphic");
         addChild(_maxGpItem);
         _maxGpMask = creatMask(_maxGpItem);
         addChild(_maxGpMask);
         _progressLabel = ComponentFactory.Instance.creatComponentByStylename("petsBag.info.LevelProgressText");
         addChild(_progressLabel);
      }
      
      private function creatMask(source:DisplayObject) : Shape
      {
         var result:Shape = new Shape();
         result.graphics.beginFill(16711680,1);
         result.graphics.drawRect(0,0,source.width,source.height);
         result.graphics.endFill();
         result.x = source.x;
         result.y = source.y;
         source.mask = result;
         return result;
      }
      
      public function setProgress(value:Number, max:Number) : void
      {
         _gp = value;
         _maxGp = max;
         drawProgress();
      }
      
      public function noPet() : void
      {
         _maxGpItem.visible = false;
         _gpItem.visible = false;
         _progressLabel.visible = false;
      }
      
      private function drawProgress() : void
      {
         var lv:int = PetExperience.getLevelByGP(_gp);
         var x:int = _gp - PetExperience.expericence[lv - 1];
         var y:int = PetExperience.expericence[lv >= PetExperience.MAX_LEVEL?PetExperience.MAX_LEVEL - 1:lv] - PetExperience.expericence[lv - 1];
         var z:int = _maxGp - _gp;
         var max_width:Number = y == 0?0:Number(x / y);
         var gp_width:Number = y == 0?0:Number((x + z) / y);
         _gpMask.width = _gpItem.width * gp_width;
         _maxGpMask.width = _maxGpItem.width * max_width;
         _tipData = [x,y].join("/") + LanguageMgr.GetTranslation("ddt.petbag.petExpProgressTip",z);
         _progressLabel.text = [x,y].join("/");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_gpItem);
         _gpItem = null;
         ObjectUtils.disposeObject(_backGround);
         _backGround = null;
         ObjectUtils.disposeObject(_progressLabel);
         _progressLabel = null;
         ObjectUtils.disposeObject(_gpItem);
         _gpItem = null;
         ObjectUtils.disposeObject(_maxGpItem);
         _maxGpItem = null;
         ObjectUtils.disposeObject(_gpMask);
         _gpMask = null;
         ObjectUtils.disposeObject(_maxGpMask);
         _maxGpMask = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}
