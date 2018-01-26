package starling.loader
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.QueueLoader;
   import com.pickgliss.loader.TextLoader;
   import dragonBones.textures.NativeTextureAtlas;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.system.System;
   import road7th.DDTAssetManager;
   import starling.core.Starling;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   
   public class StarlingQueueLoader
   {
      
      public static const NAME_REGEX:RegExp = /([^\?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
       
      
      private var _assetArr:Array;
      
      private var _module:String;
      
      private var _queueLoader:QueueLoader;
      
      private var _onComplete:Function;
      
      public function StarlingQueueLoader(){super();}
      
      public function load(param1:Array, param2:Function, param3:String = "none") : void{}
      
      private function onQueueLoaderComplete(param1:Event) : void{}
      
      private function addTexture(param1:Object, param2:Texture) : void{}
      
      private function addAtfTexture(param1:Object, param2:Texture) : void{}
      
      public function getCompletePrecent() : Number{return 0;}
      
      public function dispose() : void{}
   }
}
