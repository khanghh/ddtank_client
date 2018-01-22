package happyLittleGame.cubesGame
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.NumberImage;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import funnyGames.cubeGame.CubeGameManager;
   import funnyGames.cubeGame.event.CubeGameEvent;
   
   public class Cube extends Sprite implements Disposeable
   {
      
      public static const WIDTH_SPACE:uint = 41;
      
      public static const HEIGH_SPACE:uint = 42;
      
      private static const _TWEEN_TIME:Number = 0.3;
      
      private static const _DELAY_TIME:Number = 0.6;
       
      
      private var _id:int;
      
      private var _type:uint;
      
      public var yPos:int;
      
      private var _score:uint;
      
      private var _hitEffect:MovieClip;
      
      private var _exploreEffect:MovieClip;
      
      private var _numsImg:NumberImage;
      
      private var _bg:Bitmap;
      
      public function Cube(param1:int, param2:uint){super();}
      
      private function initListener() : void{}
      
      private function removeListener() : void{}
      
      private function __onClick(param1:MouseEvent) : void{}
      
      private function __onCollide(param1:CubeGameEvent) : void{}
      
      private function initView() : void{}
      
      public function get povit() : Point{return null;}
      
      public function set score(param1:uint) : void{}
      
      public function die() : void{}
      
      private function __onExplore(param1:Event) : void{}
      
      public function fall() : void{}
      
      public function dispose() : void{}
      
      public function get id() : int{return 0;}
   }
}
