package bones.display{   import bones.BoneMovieFactory;   import bones.loader.BonesLoaderEvent;   import bones.loader.BonesLoaderManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import dragonBones.Armature;   import dragonBones.Bone;   import dragonBones.animation.AnimationState;   import dragonBones.animation.WorldClock;   import dragonBones.objects.AnimationData;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.BoneData;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Sprite;   import flash.events.Event;   import road7th.data.DictionaryData;      public class BoneMovieFlash extends Sprite implements IBoneMovie, Disposeable   {                   private var _direction:int = 1;            private var _armature:Armature = null;            private var _armatureData:ArmatureData = null;            private var _styleName:String;            private var _loadComplete:Boolean = true;            private var _movie:DisplayObject;            private var _defaultBoneActionType:String;            private var _deafultImage:Bitmap;            private var _argsData:DictionaryData;            private var _callBack:Function;            public function BoneMovieFlash(styleName:String = "") { super(); }
            public function setArmature(armature:Armature, data:ArmatureData = null) : IBoneMovie { return null; }
            public function loadWait() : void { }
            public function gotoAndPlay(animationName:String, fadeInTime:Number = -1, duration:Number = -1, playTimes:Number = NaN, layer:int = 0, group:String = null, fadeOutMode:String = "sameLayerAndGroup", pauseFadeOut:Boolean = true, pauseFadeIn:Boolean = true) : AnimationState { return null; }
            public function play(action:String = "") : void { }
            public function stop() : void { }
            public function changeBone(boneName:String, bone:Bone) : void { }
            public function getBoneByName(boneName:String) : Bone { return null; }
            public function getBoneDataByName(boneName:String) : BoneData { return null; }
            public function get boneMovieName() : String { return null; }
            public function get boneMovieLabels() : Vector.<String> { return null; }
            public function get currentLabel() : String { return null; }
            public function get armature() : Armature { return null; }
            public function set direction(value:int) : void { }
            public function get direction() : int { return 0; }
            public function get styleName() : String { return null; }
            public function stopClock() : void { }
            public function startClock() : void { }
            private function clearArmature() : void { }
            public function get loadComplete() : Boolean { return false; }
            private function __onLoaderComplete(e:BonesLoaderEvent) : void { }
            public function set onLoadComplete(value:Function) : void { }
            public function getValueByAttribute(attribute:String) : String { return null; }
            public function dispose() : void { }
   }}