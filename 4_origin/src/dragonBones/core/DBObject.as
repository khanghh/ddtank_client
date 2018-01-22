package dragonBones.core
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.§core:dragonBones_internal§._global;
   import dragonBones.§core:dragonBones_internal§._globalTransformMatrix;
   import dragonBones.§core:dragonBones_internal§._parent;
   import dragonBones.§core:dragonBones_internal§._tempParentGlobalTransform;
   import dragonBones.§core:dragonBones_internal§._tempParentGlobalTransformMatrix;
   import dragonBones.objects.DBTransform;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Matrix;
   
   public class DBObject
   {
      
      static var _tempParentGlobalTransformMatrix:Matrix = new Matrix();
      
      static var _tempParentGlobalTransform:DBTransform = new DBTransform();
       
      
      public var name:String;
      
      public var userData:Object;
      
      public var inheritRotation:Boolean;
      
      public var inheritScale:Boolean;
      
      public var inheritTranslation:Boolean;
      
      var _global:DBTransform;
      
      var _globalTransformMatrix:Matrix;
      
      protected var _origin:DBTransform;
      
      protected var _offset:DBTransform;
      
      protected var _visible:Boolean;
      
      protected var _armature:Armature;
      
      var _parent:Bone;
      
      public function DBObject()
      {
         super();
         _globalTransformMatrix = new Matrix();
         _global = new DBTransform();
         _origin = new DBTransform();
         _offset = new DBTransform();
         var _loc1_:int = 1;
         _offset.scaleY = _loc1_;
         _offset.scaleX = _loc1_;
         _visible = true;
         _armature = null;
         _parent = null;
         userData = null;
         this.inheritRotation = true;
         this.inheritScale = true;
         this.inheritTranslation = true;
      }
      
      public function get global() : DBTransform
      {
         return _global;
      }
      
      public function get origin() : DBTransform
      {
         return _origin;
      }
      
      public function get offset() : DBTransform
      {
         return _offset;
      }
      
      public function get visible() : Boolean
      {
         return _visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         _visible = param1;
      }
      
      public function get armature() : Armature
      {
         return _armature;
      }
      
      function setArmature(param1:Armature) : void
      {
         _armature = param1;
      }
      
      public function get parent() : Bone
      {
         return _parent;
      }
      
      function setParent(param1:Bone) : void
      {
         _parent = param1;
      }
      
      public function dispose() : void
      {
         userData = null;
         _globalTransformMatrix = null;
         _global = null;
         _origin = null;
         _offset = null;
         _armature = null;
         _parent = null;
      }
      
      protected function calculateRelativeParentTransform() : void
      {
      }
      
      protected function calculateParentTransform() : Object
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(this.parent && (this.inheritTranslation || this.inheritRotation || this.inheritScale))
         {
            _loc1_ = this._parent._globalTransformForChild;
            _loc2_ = this._parent._globalTransformMatrixForChild;
            if(!this.inheritTranslation || !this.inheritRotation || !this.inheritScale)
            {
               _loc1_ = DBObject._tempParentGlobalTransform;
               _loc1_.copy(this._parent._globalTransformForChild);
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
            return {
               "parentGlobalTransform":_loc1_,
               "parentGlobalTransformMatrix":_loc2_
            };
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
   }
}
