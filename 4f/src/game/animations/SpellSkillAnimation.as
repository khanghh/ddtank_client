package game.animations
{
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import game.objects.GamePlayer;
   import game.view.GameViewBase;
   import game.view.map.MapView;
   import road7th.math.interpolateNumber;
   
   public class SpellSkillAnimation extends EventDispatcher implements IAnimate
   {
       
      
      private var _begin:Point;
      
      private var _end:Point;
      
      private var _scale:Number;
      
      private var _life:int;
      
      private var _backlist:Array;
      
      private var _finished:Boolean;
      
      private var _player:GamePlayer;
      
      private var _characterCopy:Bitmap;
      
      private var _gameView:GameViewBase;
      
      private var _skill:Sprite;
      
      private var _skillAsset:MovieClip;
      
      private var _effect:ScaleEffect;
      
      private var _skillType:int;
      
      private var map:MapView;
      
      public function SpellSkillAnimation(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:GamePlayer, param8:GameViewBase){super();}
      
      public function get level() : int{return 0;}
      
      public function canAct() : Boolean{return false;}
      
      public function prepare(param1:AnimationSet) : void{}
      
      public function canReplace(param1:IAnimate) : Boolean{return false;}
      
      public function cancel() : void{}
      
      public function update(param1:MapView) : Boolean{return false;}
      
      private function createSkillCartoon(param1:int) : Sprite{return null;}
      
      public function get finish() : Boolean{return false;}
   }
}
