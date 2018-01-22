package dragonBones.core
{
   import dragonBones.Armature;
   import dragonBones.Bone;
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
      
      public function DBObject(){super();}
      
      public function get global() : DBTransform{return null;}
      
      public function get origin() : DBTransform{return null;}
      
      public function get offset() : DBTransform{return null;}
      
      public function get visible() : Boolean{return false;}
      
      public function set visible(param1:Boolean) : void{}
      
      public function get armature() : Armature{return null;}

       protected function setArmature(param1:Armature) : void{}
      
      public function get parent() : Bone{return null;}
      
      function setParent(param1:Bone) : void{}
      
      public function dispose() : void{}
      
      protected function calculateRelativeParentTransform() : void{}
      
      protected function calculateParentTransform() : Object{return null;}
      
      protected function updateGlobal() : Object{return null;}
   }
}
