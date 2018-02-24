package starling.textures
{
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.utils.cleanMasterString;
   
   public class TextureAtlas
   {
      
      private static var sNames:Vector.<String> = new Vector.<String>(0);
       
      
      private var mAtlasTexture:Texture;
      
      private var mSubTextures:Dictionary;
      
      private var mSubTextureNames:Vector.<String>;
      
      public function TextureAtlas(param1:Texture, param2:XML = null){super();}
      
      private static function parseBool(param1:String) : Boolean{return false;}
      
      public function dispose() : void{}
      
      protected function parseAtlasXml(param1:XML) : void{}
      
      public function getTexture(param1:String) : Texture{return null;}
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>{return null;}
      
      public function getNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>{return null;}
      
      public function getRegion(param1:String) : Rectangle{return null;}
      
      public function getFrame(param1:String) : Rectangle{return null;}
      
      public function getRotation(param1:String) : Boolean{return false;}
      
      public function addRegion(param1:String, param2:Rectangle, param3:Rectangle = null, param4:Boolean = false) : void{}
      
      public function removeRegion(param1:String) : void{}
      
      public function get texture() : Texture{return null;}
   }
}
