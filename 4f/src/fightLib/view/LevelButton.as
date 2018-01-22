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
      
      public function LevelButton(){super();}
      
      private static function createShineEffect(param1:LevelButton) : IEffect{return null;}
      
      override protected function init() : void{}
      
      override public function dispose() : void{}
      
      override public function set enable(param1:Boolean) : void{}
      
      public function get shine() : Boolean{return false;}
      
      public function set shine(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
   }
}
