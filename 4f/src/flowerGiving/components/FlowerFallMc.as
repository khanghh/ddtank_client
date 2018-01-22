package flowerGiving.components
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class FlowerFallMc extends Sprite implements Disposeable
   {
       
      
      private var _flowerMc:MovieClip;
      
      private var _frequency:Number = 0.5;
      
      private var _flag:Number = 0;
      
      private var _flowerArr:Array;
      
      private var _num:int;
      
      private var _loadingSpriteWidth:int = 1010;
      
      private var _loadingSpriteHeight:int = 610;
      
      private var _fsr:Number = 0.5235988333333332;
      
      private var _tempv:Number;
      
      private var _tempr:Number;
      
      public var isOver:Boolean = false;
      
      public function FlowerFallMc(){super();}
      
      private function __update(param1:Event) : void{}
      
      private function initFlower(param1:MovieClip) : void{}
      
      private function __flowerUpdate(param1:Event) : void{}
      
      public function dispose() : void{}
   }
}
