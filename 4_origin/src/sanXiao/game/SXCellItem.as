package sanXiao.game
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import sanXiao.model.Pos;
   
   public class SXCellItem extends Sprite implements Disposeable
   {
      
      public static const IMMEDIATELY:String = "immediately";
      
      public static const TWEEN:String = "tween";
      
      public static const BACK:String = "back";
      
      public static var cellWidth:Number = 50;
      
      public static var cellHeight:Number = 49;
      
      public static var stepDistance:Number = 3;
       
      
      private var _curPos:Pos;
      
      protected var _tagPos:Pos;
      
      private var _tagY:Number = 0;
      
      private var _tagX:Number = 0;
      
      private var _icon:ScaleFrameImage;
      
      private var _boomEffect:MovieClip;
      
      private var _testText:FilterFrameText;
      
      private var _lightBorder:Bitmap;
      
      private var _columnDirection:Boolean;
      
      private var _rowDrection:Boolean;
      
      private var _step:Number = 17;
      
      private var _callBack:Function;
      
      public function SXCellItem()
      {
         super();
         _tagPos = new Pos();
         _curPos = new Pos();
         _icon = ComponentFactory.Instance.creat("sanxiao.cell.icons");
         addChild(_icon);
         _boomEffect = ComponentFactory.Instance.creat("ast.sanxiao.effects.boom");
         _boomEffect.x = cellWidth * 0.5;
         _boomEffect.y = cellHeight * 0.5;
         _boomEffect.gotoAndStop(_boomEffect.totalFrames);
         var _loc1_:Boolean = false;
         _boomEffect.mouseEnabled = _loc1_;
         _boomEffect.mouseChildren = _loc1_;
         this.mouseChildren = false;
         _testText = ComponentFactory.Instance.creat("sanxiao.test.Txt");
         _testText.scaleX = 0.6;
         _testText.scaleY = 0.6;
         addChild(_testText);
         _lightBorder = ComponentFactory.Instance.creatBitmap("ast.sanxiao.lightBorder");
         _lightBorder.x = -6;
         _lightBorder.y = -6;
      }
      
      public function get curPos() : Pos
      {
         return _curPos;
      }
      
      public function set curPos(value:Pos) : void
      {
         _curPos.column = value.column;
         _curPos.row = value.row;
         x = _curPos.column * cellWidth;
         y = _curPos.row * cellHeight;
      }
      
      public function get tagPos() : Pos
      {
         return _tagPos;
      }
      
      public function set tagPos(value:Pos) : void
      {
         _tagPos.column = value.column;
         _tagPos.row = value.row;
         _tagX = _tagPos.column * cellWidth;
         _tagY = _tagPos.row * cellHeight;
      }
      
      public function set type(value:int) : void
      {
         _icon.setFrame(value == 0?6:value);
      }
      
      public function get type() : int
      {
         return _icon.getFrame % 6;
      }
      
      public function boom() : void
      {
         addChild(_boomEffect);
         _boomEffect.addEventListener("effect_end",onEffectEnd);
         _boomEffect.gotoAndPlay(1);
         type = 0;
      }
      
      public function killBoom() : void
      {
         if(_boomEffect == null || _boomEffect.parent == null)
         {
            return;
         }
         removeChild(_boomEffect);
         return;
         §§push(_boomEffect.hasEventListener("effect_end") && _boomEffect.removeEventListener("effect_end",onEffectEnd));
      }
      
      protected function onEffectEnd(e:Event) : void
      {
         _boomEffect.removeEventListener("effect_end",onEffectEnd);
      }
      
      public function moveTo(pos:Pos, type:String = "tween", callBack:Function = null) : void
      {
         var __time:Number = NaN;
         var __oX:Number = NaN;
         var __oY:Number = NaN;
         _callBack = callBack;
         selected = false;
         var _loc7_:* = type;
         if("tween" !== _loc7_)
         {
            if("immediately" === _loc7_)
            {
               curPos.column = pos.column;
               curPos.row = pos.row;
               this.x = curPos.column * cellWidth;
               this.y = curPos.row * cellHeight;
               _callBack && _callBack();
               _callBack = null;
            }
         }
         else
         {
            tagPos = pos;
            __oX = Math.abs(tagPos.column - curPos.column);
            __oY = Math.abs(tagPos.row - curPos.row);
            if(__oX > __oY)
            {
               __time = __oX * 0.3;
               _columnDirection = tagPos.column < curPos.column;
               SanXiaoGameMediator.getInstance().addTween(this,TweenX);
            }
            else
            {
               __time = __oY * 0.3;
               _rowDrection = tagPos.row < curPos.row;
               SanXiaoGameMediator.getInstance().addTween(this,TweenY);
            }
         }
      }
      
      private function TweenY() : void
      {
         if(_rowDrection)
         {
            y = y - _step;
            if(y <= _tagY)
            {
               y = _tagY;
               SanXiaoGameMediator.getInstance().removeTween(this);
               onTweenComplete();
            }
         }
         else
         {
            y = y + _step;
            if(y >= _tagY)
            {
               y = _tagY;
               SanXiaoGameMediator.getInstance().removeTween(this);
               onTweenComplete();
            }
         }
      }
      
      private function TweenX() : void
      {
         if(_columnDirection)
         {
            x = x - _step;
            if(x <= _tagX)
            {
               x = _tagX;
               SanXiaoGameMediator.getInstance().removeTween(this);
               onTweenComplete();
            }
         }
         else
         {
            x = x + _step;
            if(x >= _tagX)
            {
               x = _tagX;
               SanXiaoGameMediator.getInstance().removeTween(this);
               onTweenComplete();
            }
         }
      }
      
      private function onTweenComplete() : void
      {
         curPos.row = tagPos.row;
         curPos.column = tagPos.column;
         _callBack && _callBack();
         _callBack = null;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(value)
         {
            addChild(_lightBorder);
         }
         else
         {
            _lightBorder.parent && removeChild(_lightBorder);
         }
      }
      
      public function dispose() : void
      {
         if(_boomEffect != null)
         {
            _boomEffect.removeEventListener("effect_end",onEffectEnd);
            ObjectUtils.disposeObject(_boomEffect);
            _boomEffect = null;
         }
         if(_icon != null)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_lightBorder != null)
         {
            ObjectUtils.disposeObject(_lightBorder);
            _lightBorder = null;
         }
      }
   }
}
