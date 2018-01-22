package game
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.filters.BlurFilter;
   
   public class GameDecorateManager extends EventDispatcher
   {
      
      private static var _instance:GameDecorateManager;
       
      
      public var isOpen:Boolean = false;
      
      private var _bitmaps:Array;
      
      public function GameDecorateManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : GameDecorateManager{return null;}
      
      public function createBitmapUI(param1:Sprite, param2:String) : *{return null;}
      
      private function getBitmapUI(param1:Sprite, param2:String) : *{return null;}
      
      public function createBlurSprite(param1:Sprite, param2:Number, param3:Number, param4:int = 8070436, param5:Number = 0.5, param6:Number = 20, param7:Number = 20) : Sprite{return null;}
      
      public function disposeBitmapUI() : void{}
      
      public function get isGameBattle() : Boolean{return false;}
   }
}
