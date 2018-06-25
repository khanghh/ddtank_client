package morn.core.ex
{
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.utils.ObjectUtils;
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
         return _level;
      }
      
      public function set level(value:int) : void
      {
         var l:int = getValueInRange(value,1,70);
         if(_level != l)
         {
            _level = l;
            updateView();
         }
      }
      
      override protected function createChildren() : void
      {
         _bmContainer = new Sprite();
         addChild(new Sprite());
         _levelImage = new Image();
         _bmContainer.addChild(new Image());
         _levelEffect = new FrameClip();
         _bmContainer.addChild(new FrameClip());
      }
      
      override protected function initialize() : void
      {
         _levelEffect.blendMode = "add";
         _bmContainer.buttonMode = true;
         _levelImage.smoothing = true;
         _tipStyle = "core.LevelTips";
         _tipGapV = 5;
         _tipGapH = 5;
         _tipDirctions = "7,6,5";
         _size = "small";
         _levelTipInfo = {};
         ShowTipManager.Instance.addTip(this);
      }
      
      public function setInfo(lev:int, ddtKingGraed:int, reputeCount:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, isBitmap:Boolean = true, team:int = 1) : void
      {
         var l:int = getValueInRange(lev,1,70);
         _isBitmap = isBitmap;
         _levelTipInfo.Level = l;
         _levelTipInfo.Battle = battle;
         _levelTipInfo.Win = win;
         _levelTipInfo.Repute = reputeCount;
         _levelTipInfo.Total = total;
         _levelTipInfo.exploit = exploit;
         _levelTipInfo.enableTip = enableTip;
         _levelTipInfo.team = team;
         _levelTipInfo.ddtKingGraed = ddtKingGraed;
         level = l;
      }
      
      private function updateView() : void
      {
         addCurrentLevelBitmap();
         addCurrentLevelEffect();
         updateSize();
      }
      
      private function addCurrentLevelBitmap() : void
      {
         _levelImage.skin = "asset.LevelIcon.Level_" + _level.toString();
      }
      
      private function addCurrentLevelEffect() : void
      {
         var effectLevel:int = 0;
         if(isInRange(_level,10,20))
         {
            effectLevel = 1;
         }
         else if(isInRange(_level,20,30))
         {
            effectLevel = 2;
         }
         else if(isInRange(_level,30,40))
         {
            effectLevel = 3;
         }
         else if(isInRange(_level,40,50))
         {
            effectLevel = 4;
         }
         else if(isInRange(_level,50,60))
         {
            effectLevel = 5;
         }
         else if(isInRange(_level,60,70))
         {
            effectLevel = 6;
         }
         if(effectLevel && !_isBitmap)
         {
            _levelEffect.skin = "asset.LevelIcon.LevelEffect_" + effectLevel.toString();
            _levelEffect.play();
         }
         else
         {
            _levelEffect.skin = null;
         }
      }
      
      private function getValueInRange(value:Number, min:Number, max:Number) : Number
      {
         if(value <= min)
         {
            return min;
         }
         if(value >= max)
         {
            return max;
         }
         return value;
      }
      
      private function isInRange(value:Number, min:Number, max:Number, equalMin:Boolean = false, equleMax:Boolean = true) : Boolean
      {
         if(value < min || value > max)
         {
            return false;
         }
         if(value == min)
         {
            return equalMin;
         }
         if(value == max)
         {
            return equleMax;
         }
         return true;
      }
      
      override public function get tipData() : Object
      {
         return _levelTipInfo;
      }
      
      public function set size(value:String) : void
      {
         if(_size == value)
         {
            return;
         }
         _size = value;
         updateSize();
      }
      
      public function get size() : String
      {
         return _size;
      }
      
      private function updateSize() : void
      {
         if(_size == "small")
         {
            scaleY = 0.6;
            scaleX = 0.6;
         }
         else if(_size == "big")
         {
            scaleY = 0.75;
            scaleX = 0.75;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(_bmContainer);
         ObjectUtils.disposeObject(_bmContainer);
         super.dispose();
      }
   }
}
