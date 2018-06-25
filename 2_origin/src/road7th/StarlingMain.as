package road7th
{
   import com.demonsters.debugger.MonsterDebugger;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.ResizeEvent;
   import starling.scene.Scene;
   import starling.textures.Texture;
   
   public class StarlingMain extends Sprite
   {
      
      private static var _instance:StarlingMain;
       
      
      public var currentScene:Scene;
      
      public function StarlingMain()
      {
         super();
         _instance = this;
         initAsset();
         MonsterDebugger.initialize(this);
      }
      
      public static function get instance() : StarlingMain
      {
         if(!_instance)
         {
            _instance = new StarlingMain();
         }
         return _instance;
      }
      
      private function initAsset() : void
      {
         DDTAssetManager.instance.addTexture("default",Texture.fromBitmapData(new BitmapData(2,2,false,0),false));
      }
      
      public function onStarlingCreate() : void
      {
         Starling.current.stage.addEventListener("resize",onStageResize);
      }
      
      private function onStageResize(evt:ResizeEvent) : void
      {
         var stageWidth:int = evt.width;
         var stageHeight:int = evt.height;
         Starling.current.viewPort = new Rectangle(0,0,stageWidth,stageHeight);
         if(StarlingPre.stageWidth == 0)
         {
            StarlingPre.originalWidth = stageWidth;
            StarlingPre.originalHeight = stageHeight;
         }
         else
         {
            StarlingPre.originalWidth = StarlingPre.stageWidth;
            StarlingPre.originalHeight = StarlingPre.stageHeight;
         }
         StarlingPre.stageWidth = stageWidth;
         StarlingPre.stageHeight = stageHeight;
         Starling.current.stage.stageWidth = stageWidth;
         Starling.current.stage.stageHeight = stageHeight;
      }
      
      public function leaveCurrentScene() : void
      {
         currentScene && currentScene.leaving();
         currentScene = null;
      }
      
      public function enterScene(scene:Scene) : void
      {
         currentScene && currentScene.leaving();
         currentScene = scene;
         if(currentScene)
         {
            currentScene.enter();
            addChild(currentScene);
         }
      }
      
      public function createImage(styleName:String = "default", posObject:* = null) : Image
      {
         var image:* = null;
         var btmd:* = null;
         var pos:* = null;
         var texture:Texture = DDTAssetManager.instance.getTexture(styleName);
         if(texture)
         {
            image = new Image(texture);
         }
         else
         {
            btmd = null;
            try
            {
               btmd = ComponentFactory.Instance.creatBitmapData(styleName);
            }
            catch(e:Error)
            {
               btmd = null;
            }
            if(btmd == null)
            {
               trace("create starling Image Error: styleName : " + styleName);
               image = new Image(DDTAssetManager.instance.getTexture("default"));
            }
            else
            {
               texture = Texture.fromBitmapData(btmd);
               DDTAssetManager.instance.addTexture(styleName,texture,"default");
               image = new Image(texture);
               trace("create starling Image by ComponentFactiory : " + styleName);
            }
         }
         if(posObject != null)
         {
            if(posObject is String)
            {
               pos = ComponentFactory.Instance.creatCustomObject(posObject);
               image.x = pos.x;
               image.y = pos.y;
            }
            else if(posObject is Object)
            {
               image.x = posObject.x;
               image.y = posObject.y;
            }
         }
         image.touchable = false;
         return image;
      }
   }
}
