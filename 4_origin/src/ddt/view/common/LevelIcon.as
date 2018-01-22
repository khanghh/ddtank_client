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
      
      private function __click(param1:MouseEvent) : void
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
         var _loc1_:* = null;
         _bmContainer.removeEventListener("click",__click);
         ShowTipManager.Instance.removeTip(this);
         clearnDisplay();
         var _loc4_:int = 0;
         var _loc3_:* = _levelBitmaps;
         for(var _loc2_ in _levelBitmaps)
         {
            _loc1_ = _levelBitmaps[_loc2_];
            _loc1_.bitmapData.dispose();
            delete _levelBitmaps[_loc2_];
         }
         _levelBitmaps = null;
         _levelEffects = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function setInfo(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:Boolean = true, param9:Boolean = true, param10:int = 1) : void
      {
         var _loc11_:* = _level != param1;
         _level = MathUtils.getValueInRange(param1,1,70);
         _isBitmap = param9;
         _levelTipInfo.Level = _level;
         _levelTipInfo.Battle = param6;
         _levelTipInfo.Win = param4;
         _levelTipInfo.Repute = param3;
         _levelTipInfo.Total = param5;
         _levelTipInfo.exploit = param7;
         _levelTipInfo.enableTip = param8;
         _levelTipInfo.team = param10;
         _levelTipInfo.ddtKingGraed = param2;
         if(_loc11_)
         {
            updateView();
         }
      }
      
      public function setSize(param1:int) : void
      {
         _size = param1;
         updateSize();
      }
      
      public function get tipData() : Object
      {
         return _levelTipInfo;
      }
      
      public function set tipData(param1:Object) : void
      {
         _levelTipInfo = param1 as LevelTipInfo;
      }
      
      public function get tipDirctions() : String
      {
         return _tipDirctions;
      }
      
      public function set tipDirctions(param1:String) : void
      {
         _tipDirctions = param1;
      }
      
      public function get tipGapH() : int
      {
         return _tipGapH;
      }
      
      public function set tipGapH(param1:int) : void
      {
         _tipGapH = param1;
      }
      
      public function get tipGapV() : int
      {
         return _tipGapV;
      }
      
      public function set tipGapV(param1:int) : void
      {
         _tipGapV = param1;
      }
      
      public function get tipStyle() : String
      {
         return _tipStyle;
      }
      
      public function set tipStyle(param1:String) : void
      {
         _tipStyle = param1;
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
         var _loc1_:MovieClip = creatLevelEffect(_level);
         if(_loc1_)
         {
            var _loc2_:Boolean = false;
            _loc1_.mouseEnabled = _loc2_;
            _loc1_.mouseChildren = _loc2_;
            _loc1_.play();
            if(_level > 40)
            {
               _loc1_.blendMode = "add";
            }
            addChild(_loc1_);
         }
      }
      
      private function clearnDisplay() : void
      {
         var _loc1_:* = null;
         while(_bmContainer.numChildren > 0)
         {
            _bmContainer.removeChildAt(0);
         }
         while(numChildren > 0)
         {
            _loc1_ = getChildAt(0) as MovieClip;
            if(_loc1_)
            {
               _loc1_.stop();
            }
            removeChildAt(0);
         }
      }
      
      private function creatLevelBitmap(param1:int) : Bitmap
      {
         if(_levelBitmaps[param1])
         {
            return _levelBitmaps[param1];
         }
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.LevelIcon.Level_" + param1.toString());
         _loc2_.smoothing = true;
         _levelBitmaps[param1] = _loc2_;
         return _loc2_;
      }
      
      private function creatLevelEffect(param1:int) : MovieClip
      {
         var _loc3_:int = 0;
         if(MathUtils.isInRange(param1,11,20))
         {
            _loc3_ = 1;
         }
         else if(MathUtils.isInRange(param1,21,30))
         {
            _loc3_ = 2;
         }
         else if(MathUtils.isInRange(param1,31,40))
         {
            _loc3_ = 3;
         }
         else if(MathUtils.isInRange(param1,41,50))
         {
            _loc3_ = 4;
         }
         else if(MathUtils.isInRange(param1,51,60))
         {
            _loc3_ = 5;
         }
         else if(MathUtils.isInRange(param1,61,70))
         {
            _loc3_ = 6;
         }
         if(_loc3_ == 0)
         {
            return null;
         }
         if(_levelEffects[_loc3_])
         {
            return _levelEffects[_loc3_];
         }
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.LevelIcon.LevelEffect_" + _loc3_.toString());
         _loc2_.stop();
         _levelEffects[_loc3_] = _loc2_;
         return _loc2_;
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
