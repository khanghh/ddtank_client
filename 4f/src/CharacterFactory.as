package
{
   import character.CharacterType;
   import character.ComplexBitmapCharacter;
   import character.ICharacter;
   import character.MovieClipCharacter;
   import character.SimpleBitmapCharacter;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class CharacterFactory
   {
      
      private static var _instance:CharacterFactory;
       
      
      private var _filse:Dictionary;
      
      private var _loadedResource:Array;
      
      private var _bitmapdatas:Dictionary;
      
      private var _characterDefines:Dictionary;
      
      private var _movieClips:Dictionary;
      
      private var _loader:URLLoader;
      
      public function CharacterFactory(){super();}
      
      public static function get Instance() : CharacterFactory{return null;}
      
      public function addResource(param1:String) : URLLoader{return null;}
      
      public function hasResource(param1:String) : Boolean{return false;}
      
      public function hasChactater(param1:String) : Boolean{return false;}
      
      public function creatChacrater(param1:String) : ICharacter{return null;}
      
      public function releaseResource() : void{}
      
      public function hasFile(param1:String) : Boolean{return false;}
      
      public function addFile(param1:String, param2:ByteArray) : void{}
      
      public function readFile(param1:ByteArray) : void{}
   }
}
