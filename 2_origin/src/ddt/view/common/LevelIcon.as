package ddt.view.common
{
   import bagAndInfo.ddtKingGrade.DDTKingGradeManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.core.ITipedDisplay;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.tips.LevelTipInfo;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import road7th.utils.MathUtils;
   import trainer.view.NewHandContainer;
   
   public class LevelIcon extends Sprite implements ITipedDisplay, Disposeable
   {
      
      public static const MAX_LEVEL:int = 70;
      
      public static const MIN_LEVEL:int = 1;
      
      public static const SIZE_BIG:int = 0;
      
      public static const SIZE_SMALL:int = 1;
      
      private static const LEVEL_EFFECT_CLASSPATH:String = "asset.LevelIcon.LevelEffect_";
      
      private static const LEVEL_ICON_CLASSPATH:String = "asset.LevelIcon.Level_";
       
      
      private var _isBitmap:Boolean;
      
      private var _level:int;
      
      private var _levelBitmaps:Dictionary;
      
      private var _levelEffects:Dictionary;
      
      private var _levelTipInfo:LevelTipInfo;
      
      private var _tipDirctions:String;
      
      private var _tipGapH:int;
      
      private var _tipGapV:int;
      
      private var _tipStyle:String;
      
      private var _size:int;
      
      private var _bmContainer:Sprite;
      
      public function LevelIcon()
      {
         super();
         _levelBitmaps = new Dictionary();
         _levelEffects = new Dictionary();
         _levelTipInfo = new LevelTipInfo();
         _tipStyle = "core.LevelTips";
         _tipGapV = 5;
         _tipGapH = 5;
         _tipDirctions = "7,6,5";
         _size = 0;
         mouseChildren = true;
         mouseEnabled = false;
         _bmContainer = new Sprite();
         _bmContainer.buttonMode = true;
         addChild(_bmContainer);
         ShowTipManager.Instance.addTip(this);
      }
      
      private function __click(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_level >= 70)
         {
            DDTKingGradeManager.Instance.show();
            if(NewHandContainer.Instance.hasArrow(151))
            {
               NewHandContainer.Instance.clearArrowByID(151);
               SocketManager.Instance.out.syncWeakStep(160);
            }
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function dispose() : void
      {
         var bm:* = null;
         _bmContainer.removeEventListener("click",__click);
         ShowTipManager.Instance.removeTip(this);
         clearnDisplay();
         var _loc4_:int = 0;
         var _loc3_:* = _levelBitmaps;
         for(var key in _levelBitmaps)
         {
            bm = _levelBitmaps[key];
            bm.bitmapData.dispose();
            delete _levelBitmaps[key];
         }
         _levelBitmaps = null;
         _levelEffects = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function setInfo(level:int, ddtKingGraed:int, reputeCount:int, win:int, total:int, battle:int, exploit:int, enableTip:Boolean = true, isBitmap:Boolean = true, team:int = 1) : void
      {
         var changeLevel:* = _level != level;
         _level = MathUtils.getValueInRange(level,1,70);
         _isBitmap = isBitmap;
         _levelTipInfo.Level = _level;
         _levelTipInfo.Battle = battle;
         _levelTipInfo.Win = win;
         _levelTipInfo.Repute = reputeCount;
         _levelTipInfo.Total = total;
         _levelTipInfo.exploit = exploit;
         _levelTipInfo.enableTip = enableTip;
         _levelTipInfo.team = team;
         _levelTipInfo.ddtKingGraed = ddtKingGraed;
         if(changeLevel)
         {
            updateView();
         }
      }
      
      public function setSize(size:int) : void
      {
         _size = size;
         updateSize();
      }
      
      public function get tipData() : Object
      {
         return _levelTipInfo;
      }
      
      public function set tipData(value:Object) : void
      {
         _levelTipInfo = value as LevelTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(value:String) : void
      {
         _tipDirctions = value;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(value:int) : void
      {
         _tipGapH = value;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(value:int) : void
      {
         _tipGapV = value;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(value:String) : void
      {
         _tipStyle = value;
      }
      
      public function allowClick() : void
      {
         _bmContainer.addEventListener("click",__click);
      }
      
      private function addCurrentLevelBitmap() : void
      {
         addChild(_bmContainer);
         _bmContainer.addChild(creatLevelBitmap(_level));
      }
      
      private function addCurrentLevelEffect() : void
      {
         if(_isBitmap)
         {
            return;
         }
         var effect:MovieClip = creatLevelEffect(_level);
         if(effect)
         {
            var _loc2_:Boolean = false;
            effect.mouseEnabled = _loc2_;
            effect.mouseChildren = _loc2_;
            effect.play();
            if(_level > 40)
            {
               effect.blendMode = "add";
            }
            addChild(effect);
         }
      }
      
      private function clearnDisplay() : void
      {
         var mc:* = null;
         while(_bmContainer.numChildren > 0)
         {
            _bmContainer.removeChildAt(0);
         }
         while(numChildren > 0)
         {
            mc = getChildAt(0) as MovieClip;
            if(mc)
            {
               mc.stop();
            }
            removeChildAt(0);
         }
      }
      
      private function creatLevelBitmap(level:int) : Bitmap
      {
         if(_levelBitmaps[level])
         {
            return _levelBitmaps[level];
         }
         var iconBitmap:Bitmap = ComponentFactory.Instance.creatBitmap("asset.LevelIcon.Level_" + level.toString());
         iconBitmap.smoothing = true;
         _levelBitmaps[level] = iconBitmap;
         return iconBitmap;
      }
      
      private function creatLevelEffect(level:int) : MovieClip
      {
         var effectLevel:int = 0;
         if(MathUtils.isInRange(level,11,20))
         {
            effectLevel = 1;
         }
         else if(MathUtils.isInRange(level,21,30))
         {
            effectLevel = 2;
         }
         else if(MathUtils.isInRange(level,31,40))
         {
            effectLevel = 3;
         }
         else if(MathUtils.isInRange(level,41,50))
         {
            effectLevel = 4;
         }
         else if(MathUtils.isInRange(level,51,60))
         {
            effectLevel = 5;
         }
         else if(MathUtils.isInRange(level,61,70))
         {
            effectLevel = 6;
         }
         if(effectLevel == 0)
         {
            return null;
         }
         if(_levelEffects[effectLevel])
         {
            return _levelEffects[effectLevel];
         }
         var levelEffect:MovieClip = ComponentFactory.Instance.creat("asset.LevelIcon.LevelEffect_" + effectLevel.toString());
         levelEffect.stop();
         _levelEffects[effectLevel] = levelEffect;
         return levelEffect;
      }
      
      private function updateView() : void
      {
         clearnDisplay();
         addCurrentLevelBitmap();
         addCurrentLevelEffect();
         updateSize();
      }
      
      private function updateSize() : void
      {
         if(_size == 1)
         {
            scaleY = 0.6;
            scaleX = 0.6;
         }
         else if(_size == 0)
         {
            scaleY = 0.75;
            scaleX = 0.75;
         }
      }
   }
}
