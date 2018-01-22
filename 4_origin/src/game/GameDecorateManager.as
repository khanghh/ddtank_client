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
      
      public function GameDecorateManager(param1:IEventDispatcher = null)
      {
         _bitmaps = [];
         super(param1);
      }
      
      public static function get Instance() : GameDecorateManager
      {
         if(_instance == null)
         {
            _instance = new GameDecorateManager();
         }
         return _instance;
      }
      
      public function createBitmapUI(param1:Sprite, param2:String) : *
      {
         if(isOpen && !isGameBattle)
         {
            return getBitmapUI(param1,param2);
         }
         if(isGameBattle)
         {
            return getBitmapUI(param1,param2.replace("asset.gameDecorate","asset.battle.gameDecorate"));
         }
         return null;
      }
      
      private function getBitmapUI(param1:Sprite, param2:String) : *
      {
         var _loc3_:* = null;
         if(ClassUtils.uiSourceDomain.hasDefinition(param2))
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap(param2);
            if(param1 != null)
            {
               param1.addChild(_loc3_);
            }
            _bitmaps.push(_loc3_);
            return _loc3_;
         }
         trace("GameDecorateManager:createBitmapUI-创建UI失败：" + param2);
         return null;
      }
      
      public function createBlurSprite(param1:Sprite, param2:Number, param3:Number, param4:int = 8070436, param5:Number = 0.5, param6:Number = 20, param7:Number = 20) : Sprite
      {
         var _loc8_:Sprite = new Sprite();
         _loc8_.alpha = param5;
         _loc8_.graphics.beginFill(param4);
         _loc8_.graphics.drawRoundRect(0,0,param2,param3,param6,param7);
         _loc8_.graphics.endFill();
         var _loc9_:BlurFilter = new BlurFilter();
         _loc9_.blurX = param6;
         _loc9_.blurY = param7;
         _loc9_.quality = 2;
         _loc8_.filters = [_loc9_];
         _bitmaps.push(_loc8_);
         if(param1 != null)
         {
            param1.addChild(_loc8_);
         }
         return _loc8_;
      }
      
      public function disposeBitmapUI() : void
      {
         var _loc1_:* = undefined;
         if(_bitmaps.length > 0)
         {
            _loc1_ = _bitmaps.shift();
            ObjectUtils.disposeObject(_loc1_);
            disposeBitmapUI();
         }
      }
      
      public function get isGameBattle() : Boolean
      {
         return false;
      }
   }
}
