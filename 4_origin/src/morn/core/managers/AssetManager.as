package morn.core.managers
{
   import flash.display.BitmapData;
   import flash.system.ApplicationDomain;
   import morn.core.utils.BitmapUtils;
   
   public class AssetManager
   {
       
      
      private var _bmdMap:Object;
      
      private var _clipsMap:Object;
      
      private var _domain:ApplicationDomain;
      
      public function AssetManager()
      {
         _bmdMap = {};
         _clipsMap = {};
         super();
      }
      
      public function setDomain(domain:ApplicationDomain) : void
      {
         _domain = domain || ApplicationDomain.currentDomain;
      }
      
      public function hasClass(name:String) : Boolean
      {
         return _domain.hasDefinition(name);
      }
      
      public function getClass(name:String) : Class
      {
         if(hasClass(name))
         {
            return _domain.getDefinition(name) as Class;
         }
         App.log.error("Miss Asset:",name);
         return null;
      }
      
      public function getAsset(name:String) : *
      {
         var assetClass:Class = getClass(name);
         if(assetClass != null)
         {
            return new assetClass();
         }
         return null;
      }
      
      public function getBitmapData(name:String, cache:Boolean = false) : BitmapData
      {
         var bmdClass:* = null;
         var bmd:BitmapData = _bmdMap[name];
         if(bmd == null)
         {
            bmdClass = getClass(name);
            if(bmdClass != null)
            {
               bmd = new bmdClass(1,1);
               if(cache)
               {
                  _bmdMap[name] = bmd;
               }
            }
         }
         return bmd;
      }
      
      public function getClips(name:String, xNum:int, yNum:int, cache:Boolean = false, source:BitmapData = null) : Vector.<BitmapData>
      {
         var bmd:* = null;
         var clips:Vector.<BitmapData> = _clipsMap[name];
         if(clips == null)
         {
            bmd = source || getBitmapData(name,false);
            if(bmd)
            {
               clips = BitmapUtils.createClips(bmd,xNum,yNum);
               if(cache)
               {
                  _clipsMap[name] = clips;
               }
            }
         }
         if(bmd)
         {
            bmd.dispose();
         }
         return clips;
      }
      
      public function cacheBitmapData(name:String, bmd:BitmapData) : void
      {
         if(bmd)
         {
            _bmdMap[name] = bmd;
         }
      }
      
      public function disposeBitmapData(name:String) : void
      {
         var bmd:BitmapData = _bmdMap[name];
         if(bmd)
         {
            delete _bmdMap[name];
            bmd.dispose();
         }
      }
      
      public function cacheClips(name:String, clips:Vector.<BitmapData>) : void
      {
         if(clips)
         {
            _clipsMap[name] = clips;
         }
      }
      
      public function destroyClips(name:String) : void
      {
         var clips:Vector.<BitmapData> = _clipsMap[name];
         if(clips)
         {
            var _loc5_:int = 0;
            var _loc4_:* = clips;
            for each(var item in clips)
            {
               item.dispose();
            }
            clips.length = 0;
            delete _clipsMap[name];
         }
      }
   }
}
