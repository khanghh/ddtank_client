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
      
      private static function createShineEffect(param1:LevelButton) : IEffect
      {
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("fightLib.Lessons.LevelShinePosition");
         return EffectManager.Instance.creatEffect(1,param1,"fightLib.Lessons.LevelShine",_loc2_);
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
      
      override public function set enable(param1:Boolean) : void
      {
         if(_enable != param1)
         {
            .super.enable = param1;
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
      
      public function set shine(param1:Boolean) : void
      {
         if(_shine != param1)
         {
            _shine = param1;
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
               for each(var _loc2_ in AddMovieEffect(_shineEffect).movie)
               {
                  if(_loc2_ is MovieClip)
                  {
                     MovieClip(_loc2_).gotoAndStop(1);
                  }
               }
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(_selected != param1)
         {
            _selected = param1;
            _selectedBitmap.visible = _selected;
            this.setChildIndex(_selectedBitmap,this.numChildren - 1);
         }
      }
   }
}
