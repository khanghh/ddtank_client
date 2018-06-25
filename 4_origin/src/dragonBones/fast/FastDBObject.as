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
      
      function setParent(value:FastBone) : void
      {
         _parent = value;
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
         var parentGlobalTransform:* = null;
         var parentGlobalTransformMatrix:* = null;
         if(this.parent && (this.inheritTranslation || this.inheritRotation || this.inheritScale))
         {
            parentGlobalTransform = this._parent._global;
            parentGlobalTransformMatrix = this._parent._globalTransformMatrix;
            if(!this.inheritTranslation && (parentGlobalTransform.x != 0 || parentGlobalTransform.y != 0) || !this.inheritRotation && (parentGlobalTransform.skewX != 0 || parentGlobalTransform.skewY != 0) || !this.inheritScale && (parentGlobalTransform.scaleX != 1 || parentGlobalTransform.scaleY != 1))
            {
               parentGlobalTransform = FastDBObject._tempParentGlobalTransform;
               parentGlobalTransform.copy(this._parent._global);
               if(!this.inheritTranslation)
               {
                  parentGlobalTransform.x = 0;
                  parentGlobalTransform.y = 0;
               }
               if(!this.inheritScale)
               {
                  parentGlobalTransform.scaleX = 1;
                  parentGlobalTransform.scaleY = 1;
               }
               if(!this.inheritRotation)
               {
                  parentGlobalTransform.skewX = 0;
                  parentGlobalTransform.skewY = 0;
               }
               parentGlobalTransformMatrix = DBObject._tempParentGlobalTransformMatrix;
               TransformUtil.transformToMatrix(parentGlobalTransform,parentGlobalTransformMatrix);
            }
            tempOutputObj.parentGlobalTransform = parentGlobalTransform;
            tempOutputObj.parentGlobalTransformMatrix = parentGlobalTransformMatrix;
            return tempOutputObj;
         }
         return null;
      }
      
      protected function updateGlobal() : Object
      {
         var parentMatrix:* = null;
         var parentGlobalTransform:* = null;
         var x:Number = NaN;
         var y:Number = NaN;
         calculateRelativeParentTransform();
         var output:Object = calculateParentTransform();
         if(output != null)
         {
            parentMatrix = output.parentGlobalTransformMatrix;
            parentGlobalTransform = output.parentGlobalTransform;
            x = _global.x;
            y = _global.y;
            _global.x = parentMatrix.a * x + parentMatrix.c * y + parentMatrix.tx;
            _global.y = parentMatrix.d * y + parentMatrix.b * x + parentMatrix.ty;
            if(this.inheritRotation)
            {
               _global.skewX = _global.skewX + parentGlobalTransform.skewX;
               _global.skewY = _global.skewY + parentGlobalTransform.skewY;
            }
            if(this.inheritScale)
            {
               _global.scaleX = _global.scaleX * parentGlobalTransform.scaleX;
               _global.scaleY = _global.scaleY * parentGlobalTransform.scaleY;
            }
         }
         TransformUtil.transformToMatrix(_global,_globalTransformMatrix);
         return output;
      }
      
      protected function calculateRelativeParentTransform() : void
      {
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
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
      
      public function set visible(value:Boolean) : void
      {
         _visible = value;
      }
      
      public function set frameCache(cache:FrameCache) : void
      {
         _frameCache = cache;
      }
   }
}
