package luckStar.view
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarAwardAction extends Sprite implements Disposeable
   {
       
      
      private var _action:MovieClip;
      
      private var _list:Vector.<Bitmap>;
      
      private var _cell:Function;
      
      private var _num:Vector.<ScaleFrameImage>;
      
      private var _count:int = 0;
      
      private var len:int;
      
      private var arr:Array;
      
      private var _isMaxAward:Boolean;
      
      private var _mc:MovieClip;
      
      private var _image:Bitmap;
      
      private var _content:Sprite;
      
      private var _move:Point;
      
      private var _tweenMax:TweenMax;
      
      public function LuckStarAwardAction(){super();}
      
      public function playAction(param1:Function, param2:DisplayObject, param3:Point, param4:Boolean = false) : void{}
      
      private function playNextAction() : void{}
      
      private function __onEnter(param1:Event) : void{}
      
      public function get actionDisplay() : Sprite{return null;}
      
      private function disposeAction() : void{}
      
      public function playMaxAwardAction() : void{}
      
      private function setupCount() : void{}
      
      private function playCount() : void{}
      
      private function updateCoinsView(param1:Array) : void{}
      
      private function __onAction(param1:Event) : void{}
      
      private function coinsDrop() : void{}
      
      private function checkDrop() : void{}
      
      private function createCoinsNum(param1:int = 0) : ScaleFrameImage{return null;}
      
      public function dispose() : void{}
   }
}
