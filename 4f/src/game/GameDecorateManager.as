package game{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.Sprite;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.filters.BlurFilter;      public class GameDecorateManager extends EventDispatcher   {            private static var _instance:GameDecorateManager;                   public var isOpen:Boolean = false;            private var _bitmaps:Array;            public function GameDecorateManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : GameDecorateManager { return null; }
            public function createBitmapUI(parent:Sprite, classname:String) : * { return null; }
            private function getBitmapUI(parent:Sprite, classname:String) : * { return null; }
            public function createBlurSprite(parent:Sprite, w:Number, h:Number, color:int = 8070436, alpha:Number = 0.5, blurX:Number = 20, blurY:Number = 20) : Sprite { return null; }
            public function disposeBitmapUI() : void { }
            public function get isGameBattle() : Boolean { return false; }
   }}