package wasteRecycle.view
{
   import com.greensock.TweenLite;
   import com.greensock.easing.Back;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class WasteRecycleTurnItem extends Sprite implements Disposeable
   {
      
      public static const PLAY_COMPLETE:String = "playComplete";
      
      public static const SHINE_COMPLETE:String = "shineComplete";
       
      
      private var _turn:Sprite;
      
      private var _waggleBg:Bitmap;
      
      private var _shine:MovieClip;
      
      private var _result:int;
      
      private var _origin:int;
      
      private var _isPlay:Boolean;
      
      private var _isShine:Boolean;
      
      public function WasteRecycleTurnItem(){super();}
      
      private function init() : void{}
      
      private function createTurn(param1:int) : void{}
      
      public function turn(param1:int) : void{}
      
      public function shine() : void{}
      
      private function __onEnterFrame(param1:Event) : void{}
      
      private function turnStart() : void{}
      
      public function get isPlay() : Boolean{return false;}
      
      public function get isShine() : Boolean{return false;}
      
      public function dispose() : void{}
   }
}
