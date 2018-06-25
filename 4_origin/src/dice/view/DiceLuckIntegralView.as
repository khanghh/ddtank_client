package dice.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import dice.controller.DiceController;
   import dice.event.DiceEvent;
   import dice.vo.DiceAwardInfo;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class DiceLuckIntegralView extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _level:ScaleFrameImage;
      
      private var _luckBar:Bitmap;
      
      private var _grayBar:Bitmap;
      
      private var _caption:Bitmap;
      
      private var _luckIntegral:FilterFrameText;
      
      private var _shape:Shape;
      
      private var _yellowIris:MovieClip;
      
      private var _starlight:MovieClip;
      
      private var _progressEffect:MovieClip;
      
      private var _container:Sprite;
      
      private var _maxIntegral:int;
      
      private var _currentIntegral:int = 0;
      
      private var _tip:DiceTreasureBoxTip;
      
      public function DiceLuckIntegralView()
      {
         super();
         preInitialize();
         initialize();
         addEvent();
      }
      
      private function preInitialize() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("asset.dice.luckIntegral.BG");
         _yellowIris = ComponentFactory.Instance.creat("asset.dice.yellowIris");
         _starlight = ComponentFactory.Instance.creat("asset.dice.starlight");
         _progressEffect = ComponentFactory.Instance.creat("asset.dice.progressEffect");
         _luckBar = ComponentFactory.Instance.creatBitmap("asset.dice.luckIntegral.luckBar");
         _grayBar = ComponentFactory.Instance.creatBitmap("asset.dice.luckIntegral.grayBar");
         _caption = ComponentFactory.Instance.creatBitmap("asset.dice.luckIntegral.caption");
         _level = ComponentFactory.Instance.creatComponentByStylename("asset.dice.luckIntegral.TreasureBox");
         _luckIntegral = ComponentFactory.Instance.creatComponentByStylename("asset.dice.luckIntegral.number");
         _tip = ComponentFactory.Instance.creatCustomObject("asset.dice.treasureBox.tip");
         _container = new Sprite();
         _container.cacheAsBitmap = true;
         _shape = new Shape();
         _shape.cacheAsBitmap = true;
         with(_shape.graphics)
         {
            
            beginFill(16777215);
            drawRect(0,0,_luckBar.width,_luckBar.height + 8);
            endFill();
         }
      }
      
      private function initialize() : void
      {
         addChild(_grayBar);
         _container.addChild(_luckBar);
         _container.addChild(_progressEffect);
         addChild(_container);
         addChild(_shape);
         addChild(_bg);
         addChild(_caption);
         addChild(_luckIntegral);
         addChild(_yellowIris);
         _yellowIris.mouseChildren = false;
         _yellowIris.mouseEnabled = false;
         PositionUtils.setPos(_yellowIris,"asset.dice.yellowIris.position");
         addChild(_level);
         addChild(_starlight);
         _starlight.mouseChildren = false;
         _starlight.mouseEnabled = false;
         PositionUtils.setPos(_starlight,"asset.dice.starlight.position");
         _shape.x = _grayBar.x - _shape.width + 5;
         _shape.y = _grayBar.y - 4;
         _progressEffect.y = _shape.y + 19;
         _progressEffect.x = _shape.x + _shape.width;
         _container.mask = _shape;
         setIntegralLevel = DiceController.Instance.LuckIntegralLevel;
         setIntegral = DiceController.Instance.LuckIntegral;
      }
      
      private function addEvent() : void
      {
         _level.addEventListener("rollOver",__onLevelRollOver);
         _level.addEventListener("rollOut",__onLevelRollOut);
         DiceController.Instance.addEventListener("dice_level_changed",__onLuckIntegralLevelChanged);
         DiceController.Instance.addEventListener("dice_luckintegral_changed",__onLuckIntegralChanged);
      }
      
      private function removeEvent() : void
      {
         _level.addEventListener("rollOver",__onLevelRollOver);
         _level.addEventListener("rollOut",__onLevelRollOut);
         DiceController.Instance.removeEventListener("dice_level_changed",__onLuckIntegralLevelChanged);
         DiceController.Instance.removeEventListener("dice_luckintegral_changed",__onLuckIntegralChanged);
      }
      
      private function __onLevelRollOver(event:MouseEvent) : void
      {
         if(_tip.parent == null)
         {
            _tip.update();
            addChild(_tip);
         }
      }
      
      private function __onLevelRollOut(event:MouseEvent) : void
      {
         if(_tip.parent)
         {
            removeChild(_tip);
         }
      }
      
      private function __onLuckIntegralChanged(event:DiceEvent) : void
      {
         setIntegral = DiceController.Instance.LuckIntegral;
      }
      
      private function __onLuckIntegralLevelChanged(event:DiceEvent) : void
      {
         setIntegralLevel = DiceController.Instance.LuckIntegralLevel;
      }
      
      public function resetLuckBar(preIntegral:int, maxIntegral:int) : void
      {
         _maxIntegral = maxIntegral;
         setIntegral = preIntegral;
      }
      
      public function set setIntegral(integral:int) : void
      {
         var rate:Number = NaN;
         var current:Number = NaN;
         _currentIntegral = integral;
         current = _currentIntegral - (DiceController.Instance.AwardLevelInfo[DiceController.Instance.LuckIntegralLevel - 1] as DiceAwardInfo != null?(DiceController.Instance.AwardLevelInfo[DiceController.Instance.LuckIntegralLevel - 1] as DiceAwardInfo).integral:0);
         _luckIntegral.text = String(current) + " / " + String(_maxIntegral);
         rate = current / _maxIntegral;
         rate = _luckBar.width * rate;
         TweenLite.killTweensOf(_shape);
         TweenLite.to(_shape,1,{
            "x":_luckBar.x - _luckBar.width + rate,
            "onUpdate":onMoveEffect
         });
         _shape.x = _luckBar.x - _luckBar.width + rate;
      }
      
      private function onMoveEffect() : void
      {
         if(_shape && _progressEffect)
         {
            _progressEffect.x = _shape.x + _shape.width;
         }
      }
      
      public function set setIntegralLevel(level:int) : void
      {
         if(level >= 0 && level < 5)
         {
            _bg.setFrame(level + 1);
            _level.setFrame(level + 1);
            _maxIntegral = (DiceController.Instance.AwardLevelInfo[level] as DiceAwardInfo).integral - (DiceController.Instance.AwardLevelInfo[level - 1] as DiceAwardInfo != null?(DiceController.Instance.AwardLevelInfo[level - 1] as DiceAwardInfo).integral:0);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_yellowIris);
         _yellowIris = null;
         ObjectUtils.disposeObject(_starlight);
         _starlight = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_grayBar);
         _grayBar = null;
         ObjectUtils.disposeObject(_luckBar);
         _luckBar = null;
         ObjectUtils.disposeObject(_caption);
         _caption = null;
         ObjectUtils.disposeObject(_level);
         _level = null;
         ObjectUtils.disposeObject(_luckIntegral);
         _luckIntegral = null;
         ObjectUtils.disposeObject(_shape);
         _shape = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
