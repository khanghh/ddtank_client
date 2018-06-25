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
      
      public function GameDecorateManager(target:IEventDispatcher = null)
      {
         _bitmaps = [];
         super(target);
      }
      
      public static function get Instance() : GameDecorateManager
      {
         if(_instance == null)
         {
            _instance = new GameDecorateManager();
         }
         return _instance;
      }
      
      public function createBitmapUI(parent:Sprite, classname:String) : *
      {
         if(isOpen && !isGameBattle)
         {
            return getBitmapUI(parent,classname);
         }
         if(isGameBattle)
         {
            return getBitmapUI(parent,classname.replace("asset.gameDecorate","asset.battle.gameDecorate"));
         }
         return null;
      }
      
      private function getBitmapUI(parent:Sprite, classname:String) : *
      {
         var bitmap:* = null;
         if(ClassUtils.uiSourceDomain.hasDefinition(classname))
         {
            bitmap = ComponentFactory.Instance.creatBitmap(classname);
            if(parent != null)
            {
               parent.addChild(bitmap);
            }
            _bitmaps.push(bitmap);
            return bitmap;
         }
         trace("GameDecorateManager:createBitmapUI-创建UI失败：" + classname);
         return null;
      }
      
      public function createBlurSprite(parent:Sprite, w:Number, h:Number, color:int = 8070436, alpha:Number = 0.5, blurX:Number = 20, blurY:Number = 20) : Sprite
      {
         var sp:Sprite = new Sprite();
         sp.alpha = alpha;
         sp.graphics.beginFill(color);
         sp.graphics.drawRoundRect(0,0,w,h,blurX,blurY);
         sp.graphics.endFill();
         var blur:BlurFilter = new BlurFilter();
         blur.blurX = blurX;
         blur.blurY = blurY;
         blur.quality = 2;
         sp.filters = [blur];
         _bitmaps.push(sp);
         if(parent != null)
         {
            parent.addChild(sp);
         }
         return sp;
      }
      
      public function disposeBitmapUI() : void
      {
         var obj:* = undefined;
         if(_bitmaps.length > 0)
         {
            obj = _bitmaps.shift();
            ObjectUtils.disposeObject(obj);
            disposeBitmapUI();
         }
      }
      
      public function get isGameBattle() : Boolean
      {
         return false;
      }
   }
}
