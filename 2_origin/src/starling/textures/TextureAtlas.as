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
      
      public function TextureAtlas(param1:Texture, param2:XML = null)
      {
         super();
         mSubTextures = new Dictionary();
         mAtlasTexture = param1;
         if(param2)
         {
            parseAtlasXml(param2);
         }
      }
      
      private static function parseBool(param1:String) : Boolean
      {
         return param1.toLowerCase() == "true";
      }
      
      public function dispose() : void
      {
         mAtlasTexture.dispose();
      }
      
      protected function parseAtlasXml(param1:XML) : void
      {
         var _loc7_:* = null;
         var _loc15_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc12_:Boolean = false;
         var _loc3_:Number = mAtlasTexture.scale;
         var _loc2_:Rectangle = new Rectangle();
         var _loc5_:Rectangle = new Rectangle();
         var _loc17_:int = 0;
         var _loc16_:* = param1.SubTexture;
         for each(var _loc14_ in param1.SubTexture)
         {
            _loc7_ = cleanMasterString(_loc14_.@name);
            _loc15_ = parseFloat(_loc14_.@x) / _loc3_;
            _loc11_ = parseFloat(_loc14_.@y) / _loc3_;
            _loc4_ = parseFloat(_loc14_.@width) / _loc3_;
            _loc6_ = parseFloat(_loc14_.@height) / _loc3_;
            _loc9_ = parseFloat(_loc14_.@frameX) / _loc3_;
            _loc10_ = parseFloat(_loc14_.@frameY) / _loc3_;
            _loc8_ = parseFloat(_loc14_.@frameWidth) / _loc3_;
            _loc13_ = parseFloat(_loc14_.@frameHeight) / _loc3_;
            _loc12_ = parseBool(_loc14_.@rotated);
            _loc2_.setTo(_loc15_,_loc11_,_loc4_,_loc6_);
            _loc5_.setTo(_loc9_,_loc10_,_loc8_,_loc13_);
            if(_loc8_ > 0 && _loc13_ > 0)
            {
               addRegion(_loc7_,_loc2_,_loc5_,_loc12_);
            }
            else
            {
               addRegion(_loc7_,_loc2_,null,_loc12_);
            }
         }
      }
      
      public function getTexture(param1:String) : Texture
      {
         return mSubTextures[param1];
      }
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(param2 == null)
         {
            param2 = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getNames(param1,sNames);
         for each(var _loc3_ in getNames(param1,sNames))
         {
            param2[param2.length] = getTexture(_loc3_);
         }
         sNames.length = 0;
         return param2;
      }
      
      public function getNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         var _loc3_:* = null;
         if(param2 == null)
         {
            param2 = new Vector.<String>(0);
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
         for each(_loc3_ in mSubTextureNames)
         {
            if(_loc3_.indexOf(param1) == 0)
            {
               param2[param2.length] = _loc3_;
            }
         }
         return param2;
      }
      
      public function getRegion(param1:String) : Rectangle
      {
         var _loc2_:SubTexture = mSubTextures[param1];
         return !!_loc2_?_loc2_.region:null;
      }
      
      public function getFrame(param1:String) : Rectangle
      {
         var _loc2_:SubTexture = mSubTextures[param1];
         return !!_loc2_?_loc2_.frame:null;
      }
      
      public function getRotation(param1:String) : Boolean
      {
         var _loc2_:SubTexture = mSubTextures[param1];
         return !!_loc2_?_loc2_.rotated:false;
      }
      
      public function addRegion(param1:String, param2:Rectangle, param3:Rectangle = null, param4:Boolean = false) : void
      {
         mSubTextures[param1] = new SubTexture(mAtlasTexture,param2,false,param3,param4);
         mSubTextureNames = null;
      }
      
      public function removeRegion(param1:String) : void
      {
         var _loc2_:SubTexture = mSubTextures[param1];
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         delete mSubTextures[param1];
         mSubTextureNames = null;
      }
      
      public function get texture() : Texture
      {
         return mAtlasTexture;
      }
   }
}
