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
      
      public function TextureAtlas(texture:Texture, atlasXml:XML = null)
      {
         super();
         mSubTextures = new Dictionary();
         mAtlasTexture = texture;
         if(atlasXml)
         {
            parseAtlasXml(atlasXml);
         }
      }
      
      private static function parseBool(value:String) : Boolean
      {
         return value.toLowerCase() == "true";
      }
      
      public function dispose() : void
      {
         mAtlasTexture.dispose();
      }
      
      protected function parseAtlasXml(atlasXml:XML) : void
      {
         var name:* = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var width:Number = NaN;
         var height:Number = NaN;
         var frameX:Number = NaN;
         var frameY:Number = NaN;
         var frameWidth:Number = NaN;
         var frameHeight:Number = NaN;
         var rotated:Boolean = false;
         var scale:Number = mAtlasTexture.scale;
         var region:Rectangle = new Rectangle();
         var frame:Rectangle = new Rectangle();
         var _loc17_:int = 0;
         var _loc16_:* = atlasXml.SubTexture;
         for each(var subTexture in atlasXml.SubTexture)
         {
            name = cleanMasterString(subTexture.@name);
            x = parseFloat(subTexture.@x) / scale;
            y = parseFloat(subTexture.@y) / scale;
            width = parseFloat(subTexture.@width) / scale;
            height = parseFloat(subTexture.@height) / scale;
            frameX = parseFloat(subTexture.@frameX) / scale;
            frameY = parseFloat(subTexture.@frameY) / scale;
            frameWidth = parseFloat(subTexture.@frameWidth) / scale;
            frameHeight = parseFloat(subTexture.@frameHeight) / scale;
            rotated = parseBool(subTexture.@rotated);
            region.setTo(x,y,width,height);
            frame.setTo(frameX,frameY,frameWidth,frameHeight);
            if(frameWidth > 0 && frameHeight > 0)
            {
               addRegion(name,region,frame,rotated);
            }
            else
            {
               addRegion(name,region,null,rotated);
            }
         }
      }
      
      public function getTexture(name:String) : Texture
      {
         return mSubTextures[name];
      }
      
      public function getTextures(prefix:String = "", result:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(result == null)
         {
            result = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getNames(prefix,sNames);
         for each(var name in getNames(prefix,sNames))
         {
            result[result.length] = getTexture(name);
         }
         sNames.length = 0;
         return result;
      }
      
      public function getNames(prefix:String = "", result:Vector.<String> = null) : Vector.<String>
      {
         var name:* = null;
         if(result == null)
         {
            result = new Vector.<String>(0);
         }
         if(mSubTextureNames == null)
         {
            mSubTextureNames = new Vector.<String>(0);
            var _loc5_:int = 0;
            var _loc4_:* = mSubTextures;
            for(mSubTextureNames[mSubTextureNames.length] in mSubTextures)
            {
            }
            mSubTextureNames.sort(1);
         }
         var _loc7_:int = 0;
         var _loc6_:* = mSubTextureNames;
         for each(name in mSubTextureNames)
         {
            if(name.indexOf(prefix) == 0)
            {
               result[result.length] = name;
            }
         }
         return result;
      }
      
      public function getRegion(name:String) : Rectangle
      {
         var subTexture:SubTexture = mSubTextures[name];
         return !!subTexture?subTexture.region:null;
      }
      
      public function getFrame(name:String) : Rectangle
      {
         var subTexture:SubTexture = mSubTextures[name];
         return !!subTexture?subTexture.frame:null;
      }
      
      public function getRotation(name:String) : Boolean
      {
         var subTexture:SubTexture = mSubTextures[name];
         return !!subTexture?subTexture.rotated:false;
      }
      
      public function addRegion(name:String, region:Rectangle, frame:Rectangle = null, rotated:Boolean = false) : void
      {
         mSubTextures[name] = new SubTexture(mAtlasTexture,region,false,frame,rotated);
         mSubTextureNames = null;
      }
      
      public function removeRegion(name:String) : void
      {
         var subTexture:SubTexture = mSubTextures[name];
         if(subTexture)
         {
            subTexture.dispose();
         }
         delete mSubTextures[name];
         mSubTextureNames = null;
      }
      
      public function get texture() : Texture
      {
         return mAtlasTexture;
      }
   }
}
