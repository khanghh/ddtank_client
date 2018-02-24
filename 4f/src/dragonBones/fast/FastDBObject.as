package dragonBones.fast
{
   import dragonBones.cache.FrameCache;
   import dragonBones.core.DBObject;
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
      
      public function FastDBObject(){super();}
      
      function updateByCache() : void{}
      
      function switchTransformToBackup() : void{}
      
      function setParent(param1:FastBone) : void{}
      
      public function dispose() : void{}
      
      protected function calculateParentTransform() : Object{return null;}
      
      protected function updateGlobal() : Object{return null;}
      
      protected function calculateRelativeParentTransform() : void{}
      
      public function get name() : String{return null;}
      
      public function set name(param1:String) : void{}
      
      public function get global() : DBTransform{return null;}
      
      public function get globalTransformMatrix() : Matrix{return null;}
      
      public function get origin() : DBTransform{return null;}
      
      public function get parent() : FastBone{return null;}
      
      public function get visible() : Boolean{return false;}
      
      public function set visible(param1:Boolean) : void{}
      
      public function set frameCache(param1:FrameCache) : void{}
   }
}
