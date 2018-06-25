package dragonBones.fast{   import dragonBones.cache.FrameCache;   import dragonBones.core.DBObject;   import dragonBones.objects.DBTransform;   import dragonBones.utils.TransformUtil;   import flash.geom.Matrix;      public class FastDBObject   {            static var _tempParentGlobalTransform:DBTransform = new DBTransform();            private static var tempOutputObj:Object = {};                   private var _name:String;            public var userData:Object;            public var inheritRotation:Boolean;            public var inheritScale:Boolean;            public var inheritTranslation:Boolean;            var _global:DBTransform;            var _globalTransformMatrix:Matrix;            var _globalBackup:DBTransform;            var _globalTransformMatrixBackup:Matrix;            var _frameCache:FrameCache;            public var armature:FastArmature;            protected var _origin:DBTransform;            protected var _visible:Boolean;            var _parent:FastBone;            public function FastDBObject() { super(); }
            protected function updateByCache() : void { }
            protected function switchTransformToBackup() : void { }
            protected function setParent(value:FastBone) : void { }
            public function dispose() : void { }
            protected function calculateParentTransform() : Object { return null; }
            protected function updateGlobal() : Object { return null; }
            protected function calculateRelativeParentTransform() : void { }
            public function get name() : String { return null; }
            public function set name(value:String) : void { }
            public function get global() : DBTransform { return null; }
            public function get globalTransformMatrix() : Matrix { return null; }
            public function get origin() : DBTransform { return null; }
            public function get parent() : FastBone { return null; }
            public function get visible() : Boolean { return false; }
            public function set visible(value:Boolean) : void { }
            public function set frameCache(cache:FrameCache) : void { }
   }}