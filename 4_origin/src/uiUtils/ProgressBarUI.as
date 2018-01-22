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
      
      public function set progress(param1:Number) : void
      {
         if(_progress != param1)
         {
            _lastProgress = _progress;
            _progress = param1;
            updateAction();
            updateProgressBarMark();
            updateTextTips();
         }
      }
      
      public function set maxProgress(param1:Number) : void
      {
         if(_maxProgress != param1)
         {
            _maxProgress = param1;
            _lastProgress = param1;
            updateProgressBarMark();
            updateTextTips();
         }
      }
      
      public function set actionType(param1:String) : void
      {
         if(_actionType != param1)
         {
            _actionType = param1;
         }
      }
      
      public function set tipViewType(param1:String) : void
      {
         if(_tipViewType != param1)
         {
            _tipViewType = param1;
            updateTextTips();
         }
      }
      
      public function set textViewType(param1:String) : void
      {
         if(_textViewType != param1)
         {
            _textViewType = param1;
            updateTextTips();
         }
      }
      
      public function set ratio(param1:int) : void
      {
         if(_ratio != param1)
         {
            _ratio = param1;
            updateTextTips();
         }
      }
      
      public function set offsetX(param1:int) : void
      {
         if(_offsetX != param1)
         {
            _offsetX = param1;
            updateProgressBarOffset();
            updateProgressBarMark();
         }
      }
      
      public function set offsetY(param1:int) : void
      {
         if(_offsetY != param1)
         {
            _offsetY = param1;
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
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
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
            _loc1_ = _progress / _maxProgress * _progressDisplay.width;
            _loc2_ = _progressDisplay.height;
            _mark.graphics.beginFill(0);
            _mark.graphics.drawRect(_offsetX,_offsetY,_loc1_,_loc2_);
            _mark.graphics.endFill();
            addChild(_mark);
         }
      }
      
      protected function updateTextTips() : void
      {
         var _loc3_:* = null;
         if(_maxProgress <= 0)
         {
            return;
         }
         var _loc6_:int = _progress / _maxProgress * _ratio;
         if(_loc6_ <= 1 && _progress > 0)
         {
            _loc6_ = 1;
         }
         var _loc5_:String = _loc6_ + "%";
         var _loc1_:String = _progress.toString();
         var _loc2_:String = _progress + "/" + _maxProgress;
         var _loc4_:String = _maxProgress.toString();
         if(_textLabel)
         {
            _loc3_ = "";
            if(_textViewType == "normalView")
            {
               _loc3_ = _loc1_;
            }
            else if(_textViewType == "realView")
            {
               _loc3_ = _loc2_;
            }
            else if(_textViewType == "ratioView")
            {
               _loc3_ = _loc5_;
            }
            else if(_textViewType == "maxView")
            {
               _loc3_ = _loc4_;
            }
            if(_actionType == "slowAction")
            {
               _loc3_ = "";
            }
            _textLabel.text = _loc3_;
         }
         if(_textLabel)
         {
            if(_tipViewType == "normalView")
            {
               tipData = _loc1_;
            }
            else if(_tipViewType == "realView")
            {
               tipData = _loc2_;
            }
            else if(_tipViewType == "ratioView")
            {
               tipData = _loc5_;
            }
            else if(_tipViewType == "maxView")
            {
               tipData = _loc4_;
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
      
      public function set backStyleName(param1:String) : void
      {
         _backStyleName = param1;
         onPropertiesChanged("back");
      }
      
      public function set progressStyleName(param1:String) : void
      {
         _progressStyleName = param1;
         onPropertiesChanged("progress");
      }
      
      public function set textStyleName(param1:String) : void
      {
         _textStyleName = param1;
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
