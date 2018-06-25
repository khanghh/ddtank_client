package uiUtils
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ProgressBarUI extends Component
   {
      
      public static const P_BACK:String = "back";
      
      public static const P_PROGRESS:String = "progress";
      
      public static const P_TEXT:String = "text";
      
      public static const NO_VIEW:String = "noView";
      
      public static const NORMAL_VIEW:String = "normalView";
      
      public static const MAX_VIEW:String = "maxView";
      
      public static const REAL_VIEW:String = "realView";
      
      public static const RATIO_VIEW:String = "ratioView";
      
      public static const NO_ACTION:String = "noAction";
      
      public static const FADE_OUT_ACTION:String = "fadeOutAction";
      
      public static const SLOW_ACTION:String = "slowAction";
       
      
      private var _actionType:String = "noAction";
      
      private var _tipViewType:String = "realView";
      
      private var _textViewType:String = "ratioView";
      
      private var _backStyleName:String;
      
      private var _progressStyleName:String;
      
      private var _textStyleName:String;
      
      private var _ratio:int = 100;
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var _progress:Number = 0;
      
      private var _maxProgress:Number = 0;
      
      private var _lastProgress:Number = 0;
      
      private var _time:Number = 2;
      
      private var _mark:Shape;
      
      private var _backDisplay:DisplayObject;
      
      private var _progressDisplay:DisplayObject;
      
      private var _acitonSprite:Sprite;
      
      private var _textLabel:FilterFrameText;
      
      public function ProgressBarUI()
      {
         super();
      }
      
      public function set progress(value:Number) : void
      {
         if(_progress != value)
         {
            _lastProgress = _progress;
            _progress = value;
            updateAction();
            updateProgressBarMark();
            updateTextTips();
         }
      }
      
      public function set maxProgress(value:Number) : void
      {
         if(_maxProgress != value)
         {
            _maxProgress = value;
            _lastProgress = value;
            updateProgressBarMark();
            updateTextTips();
         }
      }
      
      public function set actionType(value:String) : void
      {
         if(_actionType != value)
         {
            _actionType = value;
         }
      }
      
      public function set tipViewType(value:String) : void
      {
         if(_tipViewType != value)
         {
            _tipViewType = value;
            updateTextTips();
         }
      }
      
      public function set textViewType(value:String) : void
      {
         if(_textViewType != value)
         {
            _textViewType = value;
            updateTextTips();
         }
      }
      
      public function set ratio(value:int) : void
      {
         if(_ratio != value)
         {
            _ratio = value;
            updateTextTips();
         }
      }
      
      public function set offsetX(value:int) : void
      {
         if(_offsetX != value)
         {
            _offsetX = value;
            updateProgressBarOffset();
            updateProgressBarMark();
         }
      }
      
      public function set offsetY(value:int) : void
      {
         if(_offsetY != value)
         {
            _offsetY = value;
            updateProgressBarOffset();
            updateProgressBarMark();
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_backDisplay)
         {
            addChild(_backDisplay);
         }
         if(_progressDisplay)
         {
            addChild(_progressDisplay);
         }
         if(_mark)
         {
            addChild(_mark);
         }
         if(_acitonSprite)
         {
            addChild(_acitonSprite);
         }
         if(_textLabel)
         {
            addChild(_textLabel);
         }
      }
      
      protected function updateProgressBarOffset() : void
      {
         if(_progressDisplay && _offsetX)
         {
            _progressDisplay.x = _offsetX;
         }
         if(_progressDisplay && _offsetY)
         {
            _progressDisplay.y = _offsetY;
         }
      }
      
      protected function updateProgressBarMark() : void
      {
         var w:Number = NaN;
         var h:Number = NaN;
         if(_mark)
         {
            _mark.graphics.clear();
         }
         if(_progressDisplay && _maxProgress > 0)
         {
            if(_mark == null)
            {
               _mark = new Shape();
               _progressDisplay.mask = _mark;
            }
            w = _progress / _maxProgress * _progressDisplay.width;
            h = _progressDisplay.height;
            _mark.graphics.beginFill(0);
            _mark.graphics.drawRect(_offsetX,_offsetY,w,h);
            _mark.graphics.endFill();
            addChild(_mark);
         }
      }
      
      protected function updateTextTips() : void
      {
         var text:* = null;
         if(_maxProgress <= 0)
         {
            return;
         }
         var ratioInt:int = _progress / _maxProgress * _ratio;
         if(ratioInt <= 1 && _progress > 0)
         {
            ratioInt = 1;
         }
         var ratio:String = ratioInt + "%";
         var progress:String = _progress.toString();
         var real:String = _progress + "/" + _maxProgress;
         var max:String = _maxProgress.toString();
         if(_textLabel)
         {
            text = "";
            if(_textViewType == "normalView")
            {
               text = progress;
            }
            else if(_textViewType == "realView")
            {
               text = real;
            }
            else if(_textViewType == "ratioView")
            {
               text = ratio;
            }
            else if(_textViewType == "maxView")
            {
               text = max;
            }
            if(_actionType == "slowAction")
            {
               text = "";
            }
            _textLabel.text = text;
         }
         if(_textLabel)
         {
            if(_tipViewType == "normalView")
            {
               tipData = progress;
            }
            else if(_tipViewType == "realView")
            {
               tipData = real;
            }
            else if(_tipViewType == "ratioView")
            {
               tipData = ratio;
            }
            else if(_tipViewType == "maxView")
            {
               tipData = max;
            }
            else
            {
               tipData = "";
            }
         }
      }
      
      protected function updateAction() : void
      {
         if(_actionType == "noAction" || _maxProgress <= 0 || !_progressDisplay || _lastProgress < _progress)
         {
            return;
         }
         if(_acitonSprite == null)
         {
            _acitonSprite = new Sprite();
         }
         ObjectUtils.disposeAllChildren(_acitonSprite);
         if(_actionType == "fadeOutAction")
         {
            createFadeOutAciton();
         }
         else if(_actionType == "slowAction")
         {
         }
      }
      
      protected function createFadeOutAciton() : void
      {
         var lastPos:Number = _lastProgress / _maxProgress * _progressDisplay.width;
         var currentPos:Number = _progress / _maxProgress * _progressDisplay.width;
         var posX:Number = lastPos < currentPos?lastPos:Number(currentPos);
         var w:Number = Math.abs(lastPos - currentPos);
         if(_progressDisplay as Bitmap)
         {
            var source:BitmapData = (_progressDisplay as Bitmap).bitmapData.clone();
         }
         else
         {
            source = new BitmapData(_progressDisplay.width,_progressDisplay.height,true);
         }
         var btmd:BitmapData = new BitmapData(w,_progressDisplay.height,true);
         btmd.copyPixels(source,new Rectangle(posX,0,w,btmd.height),new Point());
         source.dispose();
         var display:Bitmap = new Bitmap(btmd);
         display.x = posX + _offsetX;
         display.y = _offsetY;
         _acitonSprite.addChild(display);
         _acitonSprite.alpha = 0.7;
         TweenLite.to(_acitonSprite,_time,{
            "alpha":0,
            "onComplete":function():void
            {
               TweenLite.killTweensOf(_acitonSprite);
               ObjectUtils.disposeAllChildren(_acitonSprite);
            }
         });
      }
      
      public function set backStyleName(styleName:String) : void
      {
         _backStyleName = styleName;
         onPropertiesChanged("back");
      }
      
      public function set progressStyleName(styleName:String) : void
      {
         _progressStyleName = styleName;
         onPropertiesChanged("progress");
      }
      
      public function set textStyleName(styleName:String) : void
      {
         _textStyleName = styleName;
         onPropertiesChanged("text");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         if(_changedPropeties["back"])
         {
            ObjectUtils.disposeObject(_backDisplay);
            if(_backStyleName != "")
            {
               _backDisplay = ComponentFactory.Instance.creat(_backStyleName);
            }
         }
         if(_changedPropeties["progress"])
         {
            ObjectUtils.disposeObject(_progressDisplay);
            if(_progressStyleName != "")
            {
               _progressDisplay = ComponentFactory.Instance.creat(_progressStyleName);
               if(_mark)
               {
                  _progressDisplay.mask = _mark;
               }
               updateProgressBarOffset();
               updateProgressBarMark();
            }
         }
         if(_changedPropeties["text"])
         {
            ObjectUtils.disposeObject(_textLabel);
            if(_textStyleName != "")
            {
               _textLabel = ComponentFactory.Instance.creat(_textStyleName);
               updateTextTips();
            }
         }
         super.onProppertiesUpdate();
      }
      
      override public function dispose() : void
      {
         TweenLite.killTweensOf(_acitonSprite);
         ObjectUtils.disposeAllChildren(_acitonSprite);
         ObjectUtils.disposeAllChildren(this);
         _mark = null;
         _backDisplay = null;
         _progressDisplay = null;
         _textLabel = null;
         _acitonSprite = null;
         super.dispose();
      }
   }
}
