package morn.core.ex
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BlendMode;
   import flash.display.Sprite;
   import morn.core.components.Component;
   import morn.core.components.FrameClip;
   import morn.core.components.Image;
   
   public class LevelIconEx extends Component
   {
      
      private static const BIG:String = "big";
      
      private static const SMALL:String = "small";
      
      private static const MAX:int = 70;
      
      private static const MIN:int = 1;
      
      private static const LEVEL_EFFECT_CLASSPATH:String = "asset.LevelIcon.LevelEffect_";
      
      private static const LEVEL_ICON_CLASSPATH:String = "asset.LevelIcon.Level_";
       
      
      private var _level:int;
      
      private var _size:String;
      
      private var _levelTipInfo:Object;
      
      private var _isBitmap:Boolean;
      
      private var _bmContainer:Sprite;
      
      private var _levelImage:Image;
      
      private var _levelEffect:FrameClip;
      
      public function LevelIconEx()
      {
         super();
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         var _loc2_:int = this.getValueInRange(param1,MIN,MAX);
         if(this._level != _loc2_)
         {
            this._level = _loc2_;
            this.updateView();
         }
      }
      
      override protected function createChildren() : void
      {
         addChild(this._bmContainer = new Sprite());
         this._bmContainer.addChild(this._levelImage = new Image());
         this._bmContainer.addChild(this._levelEffect = new FrameClip());
      }
      
      override protected function initialize() : void
      {
         this._levelEffect.blendMode = BlendMode.ADD;
         this._bmContainer.buttonMode = true;
         this._levelImage.smoothing = true;
         _tipStyle = "core.LevelTips";
         _tipGapV = 5;
         _tipGapH = 5;
         _tipDirctions = "7,6,5";
         this._size = SMALL;
         this._levelTipInfo = {};
         ShowTipManager.Instance.addTip(this);
      }
      
      public function setInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = true, param9:Boolean = true, param10:int = 1) : void
      {
         var _loc11_:int = this.getValueInRange(param1,MIN,MAX);
         this._isBitmap = param9;
         this._levelTipInfo.Level = _loc11_;
         this._levelTipInfo.Battle = param6;
         this._levelTipInfo.Win = param4;
         this._levelTipInfo.Repute = param3;
         this._levelTipInfo.Total = param5;
         this._levelTipInfo.exploit = param7;
         this._levelTipInfo.enableTip = param8;
         this._levelTipInfo.team = param10;
         this._levelTipInfo.ddtKingGraed = param2;
         this.level = _loc11_;
      }
      
      private function updateView() : void
      {
         this.addCurrentLevelBitmap();
         this.addCurrentLevelEffect();
         this.updateSize();
      }
      
      private function addCurrentLevelBitmap() : void
      {
         this._levelImage.skin = LEVEL_ICON_CLASSPATH + this._level.toString();
      }
      
      private function addCurrentLevelEffect() : void
      {
         var _loc1_:int = 0;
         if(this.isInRange(this._level,10,20))
         {
            _loc1_ = 1;
         }
         else if(this.isInRange(this._level,20,30))
         {
            _loc1_ = 2;
         }
         else if(this.isInRange(this._level,30,40))
         {
            _loc1_ = 3;
         }
         else if(this.isInRange(this._level,40,50))
         {
            _loc1_ = 4;
         }
         else if(this.isInRange(this._level,50,60))
         {
            _loc1_ = 5;
         }
         else if(this.isInRange(this._level,60,70))
         {
            _loc1_ = 6;
         }
         if(_loc1_ && !this._isBitmap)
         {
            this._levelEffect.skin = LEVEL_EFFECT_CLASSPATH + _loc1_.toString();
            this._levelEffect.play();
         }
         else
         {
            this._levelEffect.skin = null;
         }
      }
      
      private function getValueInRange(param1:Number, param2:Number, param3:Number) : Number
      {
         if(param1 <= param2)
         {
            return param2;
         }
         if(param1 >= param3)
         {
            return param3;
         }
         return param1;
      }
      
      private function isInRange(param1:Number, param2:Number, param3:Number, param4:Boolean = false, param5:Boolean = true) : Boolean
      {
         if(param1 < param2 || param1 > param3)
         {
            return false;
         }
         if(param1 == param2)
         {
            return param4;
         }
         if(param1 == param3)
         {
            return param5;
         }
         return true;
      }
      
      override public function get tipData() : Object
      {
         return this._levelTipInfo;
      }
      
      public function set size(param1:String) : void
      {
         if(this._size == param1)
         {
            return;
         }
         this._size = param1;
         this.updateSize();
      }
      
      public function get size() : String
      {
         return this._size;
      }
      
      private function updateSize() : void
      {
         if(this._size == SMALL)
         {
            scaleX = scaleY = 0.6;
         }
         else if(this._size == BIG)
         {
            scaleX = scaleY = 0.75;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this._bmContainer);
         ObjectUtils.disposeObject(this._bmContainer);
         super.dispose();
      }
   }
}
