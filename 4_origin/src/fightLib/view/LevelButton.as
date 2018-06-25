package fightLib.view
{
   import com.pickgliss.effect.AddMovieEffect;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   
   public class LevelButton extends BaseButton
   {
       
      
      private var _shineEffect:IEffect;
      
      private var _shine:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _selectedBitmap:Bitmap;
      
      public function LevelButton()
      {
         super();
      }
      
      private static function createShineEffect(target:LevelButton) : IEffect
      {
         var position:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Lessons.LevelShinePosition");
         return EffectManager.Instance.creatEffect(1,target,"fightLib.Lessons.LevelShine",position);
      }
      
      override protected function init() : void
      {
         super.init();
         _shineEffect = createShineEffect(this);
         _selectedBitmap = ComponentFactory.Instance.creatBitmap("fightLib.Lessons.hardness.Selected");
         addChildAt(_selectedBitmap,0);
         this.enable = false;
      }
      
      override public function dispose() : void
      {
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
         super.dispose();
      }
      
      override public function set enable(value:Boolean) : void
      {
         if(_enable != value)
         {
            .super.enable = value;
            if(_enable)
            {
               this.filters = null;
            }
            else
            {
               this.filters = [ComponentFactory.Instance.model.getSet("grayFilter")];
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
               if(_enable)
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
            this.setChildIndex(_selectedBitmap,this.numChildren - 1);
         }
      }
   }
}
