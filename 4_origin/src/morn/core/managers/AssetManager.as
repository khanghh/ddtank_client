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
         this._bmdMap = {};
         this._clipsMap = {};
         super();
      }
      
      public function setDomain(param1:ApplicationDomain) : void
      {
         this._domain = param1 || ApplicationDomain.currentDomain;
      }
      
      public function hasClass(param1:String) : Boolean
      {
         return this._domain.hasDefinition(param1);
      }
      
      public function getClass(param1:String) : Class
      {
         if(this.hasClass(param1))
         {
            return this._domain.getDefinition(param1) as Class;
         }
         App.log.error("Miss Asset:",param1);
         return null;
      }
      
      public function getAsset(param1:String) : *
      {
         var _loc2_:Class = this.getClass(param1);
         if(_loc2_ != null)
         {
            return new _loc2_();
         }
         return null;
      }
      
      public function getBitmapData(param1:String, param2:Boolean = false) : BitmapData
      {
         var _loc4_:Class = null;
         var _loc3_:BitmapData = this._bmdMap[param1];
         if(_loc3_ == null)
         {
            _loc4_ = this.getClass(param1);
            if(_loc4_ != null)
            {
               _loc3_ = new _loc4_(1,1);
               if(param2)
               {
                  this._bmdMap[param1] = _loc3_;
               }
            }
         }
         return _loc3_;
      }
      
      public function getClips(param1:String, param2:int, param3:int, param4:Boolean = false, param5:BitmapData = null) : Vector.<BitmapData>
      {
         var _loc7_:BitmapData = null;
         var _loc6_:Vector.<BitmapData> = this._clipsMap[param1];
         if(_loc6_ == null)
         {
            _loc7_ = param5 || this.getBitmapData(param1,false);
            if(_loc7_)
            {
               _loc6_ = BitmapUtils.createClips(_loc7_,param2,param3);
               if(param4)
               {
                  this._clipsMap[param1] = _loc6_;
               }
            }
         }
         if(_loc7_)
         {
            _loc7_.dispose();
         }
         return _loc6_;
      }
      
      public function cacheBitmapData(param1:String, param2:BitmapData) : void
      {
         if(param2)
         {
            this._bmdMap[param1] = param2;
         }
      }
      
      public function disposeBitmapData(param1:String) : void
      {
         var _loc2_:BitmapData = this._bmdMap[param1];
         if(_loc2_)
         {
            delete this._bmdMap[param1];
            _loc2_.dispose();
         }
      }
      
      public function cacheClips(param1:String, param2:Vector.<BitmapData>) : void
      {
         if(param2)
         {
            this._clipsMap[param1] = param2;
         }
      }
      
      public function destroyClips(param1:String) : void
      {
         var _loc3_:BitmapData = null;
         var _loc2_:Vector.<BitmapData> = this._clipsMap[param1];
         if(_loc2_)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc3_.dispose();
            }
            _loc2_.length = 0;
            delete this._clipsMap[param1];
         }
      }
   }
}
