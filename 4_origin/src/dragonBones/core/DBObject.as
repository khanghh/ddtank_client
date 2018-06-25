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
      
      public function set visible(value:Boolean) : void
      {
         _visible = value;
      }
      
      public function get armature() : Armature
      {
         return _armature;
      }
      
      function setArmature(value:Armature) : void
      {
         _armature = value;
      }
      
      public function get parent() : Bone
      {
         return _parent;
      }
      
      function setParent(value:Bone) : void
      {
         _parent = value;
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
         var parentGlobalTransform:* = null;
         var parentGlobalTransformMatrix:* = null;
         if(this.parent && (this.inheritTranslation || this.inheritRotation || this.inheritScale))
         {
            parentGlobalTransform = this._parent._globalTransformForChild;
            parentGlobalTransformMatrix = this._parent._globalTransformMatrixForChild;
            if(!this.inheritTranslation || !this.inheritRotation || !this.inheritScale)
            {
               parentGlobalTransform = DBObject._tempParentGlobalTransform;
               parentGlobalTransform.copy(this._parent._globalTransformForChild);
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
            return {
               "parentGlobalTransform":parentGlobalTransform,
               "parentGlobalTransformMatrix":parentGlobalTransformMatrix
            };
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
   }
}
