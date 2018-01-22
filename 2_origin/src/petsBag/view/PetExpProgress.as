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
      
      private function creatMask(param1:DisplayObject) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,1);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         param1.mask = _loc2_;
         return _loc2_;
      }
      
      public function setProgress(param1:Number, param2:Number) : void
      {
         _gp = param1;
         _maxGp = param2;
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
         var _loc3_:int = PetExperience.getLevelByGP(_gp);
         var _loc6_:int = _gp - PetExperience.expericence[_loc3_ - 1];
         var _loc5_:int = PetExperience.expericence[_loc3_ >= PetExperience.MAX_LEVEL?PetExperience.MAX_LEVEL - 1:_loc3_] - PetExperience.expericence[_loc3_ - 1];
         var _loc4_:int = _maxGp - _gp;
         var _loc2_:Number = _loc5_ == 0?0:Number(_loc6_ / _loc5_);
         var _loc1_:Number = _loc5_ == 0?0:Number((_loc6_ + _loc4_) / _loc5_);
         _gpMask.width = _gpItem.width * _loc1_;
         _maxGpMask.width = _maxGpItem.width * _loc2_;
         _tipData = [_loc6_,_loc5_].join("/") + LanguageMgr.GetTranslation("ddt.petbag.petExpProgressTip",_loc4_);
         _progressLabel.text = [_loc6_,_loc5_].join("/");
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
