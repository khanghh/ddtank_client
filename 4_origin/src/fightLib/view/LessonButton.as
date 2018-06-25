package fightLib.view
{
   import com.pickgliss.effect.AddMovieEffect;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class LessonButton extends Sprite implements Disposeable
   {
      
      public static const hitCommands:Vector.<int> = Vector.<int>([1,2,2,2,2,2]);
      
      public static const hitCoords:Vector.<Number> = Vector.<Number>([52,1,115,3,117,21,91,94,24,88,20,67]);
      
      public static const SelectedLesson:String = "SelectedLesson";
       
      
      private var _type:int = -1;
      
      private var _enabled:Boolean = true;
      
      private var _background:DisplayObject;
      
      private var _icon:DisplayObject;
      
      private var _label:DisplayObject;
      
      private var _hitShape:Sprite;
      
      private var _lastIcon:DisplayObject;
      
      private var _lastLabel:DisplayObject;
      
      private var _labelString:String;
      
      private var _iconString:String;
      
      private var _shine:Boolean;
      
      private var _selected:Boolean = false;
      
      private var _shineEffect:IEffect;
      
      private var _selectedBitmap:Bitmap;
      
      private var _mesIdx:String;
      
      public function LessonButton()
      {
         super();
         configUI();
         addEvent();
      }
      
      private static function createShineEffect(target:LessonButton) : IEffect
      {
         var position:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Lessons.LessonShinePosition");
         return EffectManager.Instance.creatEffect(1,target,"fightLib.Lessons.LessonShine",position);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_background)
         {
            ObjectUtils.disposeObject(_background);
            _background = null;
         }
         if(_hitShape)
         {
            ObjectUtils.disposeObject(_hitShape);
            _hitShape = null;
         }
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
            _icon = null;
         }
         if(_label)
         {
            ObjectUtils.disposeObject(_label);
            _label = null;
         }
         if(_lastIcon)
         {
            ObjectUtils.disposeObject(_lastIcon);
            _lastIcon = null;
         }
         if(_selectedBitmap)
         {
            ObjectUtils.disposeObject(_selectedBitmap);
            _selectedBitmap = null;
         }
         if(_shineEffect)
         {
            EffectManager.Instance.removeEffect(_shineEffect);
            _shineEffect = null;
         }
      }
      
      public function set mesIdx(val:String) : void
      {
         _mesIdx = val;
      }
      
      public function get mesIdx() : String
      {
         return _mesIdx;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(val:Boolean) : void
      {
         if(_enabled != val)
         {
            _enabled = val;
            if(_enabled)
            {
               setIcon(ComponentFactory.Instance.creatBitmap(_iconString));
               setLabel(ComponentFactory.Instance.creatBitmap(_labelString));
               filters = null;
            }
            else
            {
               filters = ComponentFactory.Instance.creatFilters("grayFilter");
               if(!_iconString)
               {
                  setIcon(ComponentFactory.Instance.creatBitmap("fightLib.Lessons.icon.Disenable"));
                  setLabel(ComponentFactory.Instance.creatBitmap("fightLib.Lessons.label.Disenable"));
               }
               if(_shine)
               {
                  shine = false;
               }
               if(_selected)
               {
                  selected = false;
               }
            }
            drawHit();
         }
      }
      
      public function set icon(val:String) : void
      {
         _iconString = val;
         setIcon(ComponentFactory.Instance.creatBitmap(val));
      }
      
      public function get icon() : String
      {
         return _iconString;
      }
      
      public function set label(val:String) : void
      {
         _labelString = val;
         setLabel(ComponentFactory.Instance.creatBitmap(val));
      }
      
      public function get label() : String
      {
         return _labelString;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(val:int) : void
      {
         _type = val;
         drawHit();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(val:Boolean) : void
      {
         if(_selected != val)
         {
            _selected = val;
            _selectedBitmap.visible = _selected;
         }
      }
      
      public function get shine() : Boolean
      {
         return _shine;
      }
      
      public function set shine(val:Boolean) : void
      {
         if(_shine != val)
         {
            _shine = val;
            if(_shine)
            {
               if(_enabled)
               {
                  _shineEffect.play();
               }
            }
            else
            {
               _shineEffect.stop();
               var _loc4_:int = 0;
               var _loc3_:* = AddMovieEffect(_shineEffect).movie;
               for each(var movie in AddMovieEffect(_shineEffect).movie)
               {
                  if(movie is MovieClip)
                  {
                     MovieClip(movie).gotoAndStop(1);
                  }
               }
            }
         }
      }
      
      public function setIcon(newIcon:DisplayObject) : void
      {
         var icon:DisplayObject = _icon;
         _icon = newIcon;
         if(_icon)
         {
            _icon.x = 3;
            _icon.y = 2;
            addChildAt(_icon,0);
         }
         if(icon && icon != _icon)
         {
            ObjectUtils.disposeObject(icon);
         }
      }
      
      public function setLabel(newLabel:DisplayObject) : void
      {
         var label:DisplayObject = _label;
         _label = newLabel;
         if(_label)
         {
            addChild(_label);
         }
         if(_icon)
         {
            _label.x = _icon.x + 20;
            _label.y = _icon.y + _icon.height - _label.height - 2;
         }
         if(label && label != _label)
         {
            ObjectUtils.disposeObject(label);
         }
      }
      
      private function configUI() : void
      {
         _hitShape = new Sprite();
         _hitShape.buttonMode = true;
         _hitShape.y = -5;
         addChild(_hitShape);
         _shineEffect = createShineEffect(this);
         _selectedBitmap = ComponentFactory.Instance.creatBitmap("fightLib.Lessons.lesson.Selected");
         _selectedBitmap.y = -4;
         addChildAt(_selectedBitmap,0);
         drawHit();
      }
      
      private function __mouseOver(evt:MouseEvent) : void
      {
         if(!_selected && _type > 0)
         {
            _selectedBitmap.visible = true;
         }
      }
      
      private function __mouseOut(evt:MouseEvent) : void
      {
         if(_selectedBitmap.visible && !_selected)
         {
            _selectedBitmap.visible = false;
         }
      }
      
      private function addEvent() : void
      {
         _hitShape.addEventListener("mouseOver",__mouseOver);
         _hitShape.addEventListener("mouseOut",__mouseOut);
         _hitShape.addEventListener("click",__clicked);
      }
      
      private function removeEvent() : void
      {
         _hitShape.removeEventListener("mouseOver",__mouseOver);
         _hitShape.removeEventListener("mouseOut",__mouseOut);
         _hitShape.removeEventListener("click",__clicked);
      }
      
      private function drawHit() : void
      {
         var pen:Graphics = _hitShape.graphics;
         pen.clear();
         if(_type > 0)
         {
            pen.beginFill(16777215 * Math.random(),0);
            pen.drawPath(hitCommands,hitCoords);
            pen.endFill();
         }
      }
      
      private function __clicked(evt:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(_enabled)
         {
            dispatchEvent(new Event("SelectedLesson"));
         }
         else if(_mesIdx)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.fightLib.Lesson.Message" + _mesIdx));
         }
      }
   }
}
