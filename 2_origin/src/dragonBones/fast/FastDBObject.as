package dragonBones.fast
{
   import dragonBones.cache.FrameCache;
   import dragonBones.core.DBObject;
   import dragonBones.§core:dragonBones_internal§._frameCache;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalBackup;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrixBackup;
   import dragonBones.§core:dragonBones_internal§._parent;
   import dragonBones.§core:dragonBones_internal§._tempParentGlobalTransform;
   import dragonBones.objects.DBTransform;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Matrix;
   
   public class FastDBObject
   {
      
      static var _tempParentGlobalTransform:DBTransform = new DBTransform();
      
      private static var tempOutputObj:Object = {};
       
      
      private var _name:String;
      
      public var userData:Object;
      
      public var inheritRotation:Boolean;
      
      public var inheritScale:Boolean;
      
      public var inheritTranslation:Boolean;
      
      var _global:DBTransform;
      
      var _globalTransformMatrix:Matrix;
      
      var _globalBackup:DBTransform;
      
      var _globalTransformMatrixBackup:Matrix;
      
      var _frameCache:FrameCache;
      
      public var armature:FastArmature;
      
      protected var _origin:DBTransform;
      
      protected var _visible:Boolean;
      
      var _parent:FastBone;
      
      public function FastDBObject()
      {
         super();
         _globalTransformMatrix = new Matrix();
         _global = new DBTransform();
         _origin = new DBTransform();
         _visible = true;
         armature = null;
         _parent = null;
         userData = null;
         this.inheritRotation = true;
         this.inheritScale = true;
         this.inheritTranslation = true;
      }
      
      function updateByCache() : void
      {
         _global = _frameCache.globalTransform;
         _globalTransformMatrix = _frameCache.globalTransformMatrix;
      }
      
      function switchTransformToBackup() : void
      {
         if(!_globalBackup)
         {
            _globalBackup = new DBTransform();
            _globalTransformMatrixBackup = new Matrix();
         }
         _global = _globalBackup;
         _globalTransformMatrix = _globalTransformMatrixBackup;
      }
      
      function setParent(param1:FastBone) : void
      {
         _parent = param1;
      }
      
      public function dispose() : void
      {
         userData = null;
         _globalTransformMatrix = null;
         _global = null;
         _origin = null;
         armature = null;
         _parent = null;
      }
      
      protected function calculateParentTransform() : Object
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.parent && (this.inheritTranslation || this.inheritRotation || this.inheritScale))
         {
            _loc1_ = this._parent._global;
            _loc2_ = this._parent._globalTransformMatrix;
            if(!this.inheritTranslation && (_loc1_.x != 0 || _loc1_.y != 0) || !this.inheritRotation && (_loc1_.skewX != 0 || _loc1_.skewY != 0) || !this.inheritScale && (_loc1_.scaleX != 1 || _loc1_.scaleY != 1))
            {
               _loc1_ = FastDBObject._tempParentGlobalTransform;
               _loc1_.copy(this._parent._global);
               if(!this.inheritTranslation)
               {
                  _loc1_.x = 0;
                  _loc1_.y = 0;
               }
               if(!this.inheritScale)
               {
                  _loc1_.scaleX = 1;
                  _loc1_.scaleY = 1;
               }
               if(!this.inheritRotation)
               {
                  _loc1_.skewX = 0;
                  _loc1_.skewY = 0;
               }
               _loc2_ = DBObject._tempParentGlobalTransformMatrix;
               TransformUtil.transformToMatrix(_loc1_,_loc2_);
            }
            tempOutputObj.parentGlobalTransform = _loc1_;
            tempOutputObj.parentGlobalTransformMatrix = _loc2_;
            return tempOutputObj;
         }
         return null;
      }
      
      protected function updateGlobal() : Object
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         calculateRelativeParentTransform();
         var _loc3_:Object = calculateParentTransform();
         if(_loc3_ != null)
         {
            _loc1_ = _loc3_.parentGlobalTransformMatrix;
            _loc2_ = _loc3_.parentGlobalTransform;
            _loc5_ = _global.x;
            _loc4_ = _global.y;
            _global.x = _loc1_.a * _loc5_ + _loc1_.c * _loc4_ + _loc1_.tx;
            _global.y = _loc1_.d * _loc4_ + _loc1_.b * _loc5_ + _loc1_.ty;
            if(this.inheritRotation)
            {
               _global.skewX = _global.skewX + _loc2_.skewX;
               _global.skewY = _global.skewY + _loc2_.skewY;
            }
            if(this.inheritScale)
            {
               _global.scaleX = _global.scaleX * _loc2_.scaleX;
               _global.scaleY = _global.scaleY * _loc2_.scaleY;
            }
         }
         TransformUtil.transformToMatrix(_global,_globalTransformMatrix);
         return _loc3_;
      }
      
      protected function calculateRelativeParentTransform() : void
      {
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get global() : DBTransform
      {
         return _global;
      }
      
      public function get globalTransformMatrix() : Matrix
      {
         return _globalTransformMatrix;
      }
      
      public function get origin() : DBTransform
      {
         return _origin;
      }
      
      public function get parent() : FastBone
      {
         return _parent;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
      }
      
      public function set frameCache(param1:FrameCache) : void
      {
         _frameCache = param1;
      }
   }
}
