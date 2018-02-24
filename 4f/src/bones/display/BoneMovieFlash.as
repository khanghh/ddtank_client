package bones.display
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.animation.AnimationState;
   import dragonBones.animation.WorldClock;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class BoneMovieFlash extends Sprite implements IBoneMovie, Disposeable
   {
       
      
      private var _direction:int = 1;
      
      private var _armature:Armature = null;
      
      private var _armatureData:ArmatureData = null;
      
      private var _styleName:String;
      
      private var _loadComplete:Boolean = true;
      
      private var _movie:DisplayObject;
      
      private var _defaultBoneActionType:String;
      
      private var _deafultImage:Bitmap;
      
      private var _argsData:DictionaryData;
      
      private var _callBack:Function;
      
      public function BoneMovieFlash(param1:String = ""){super();}
      
      public function setArmature(param1:Armature, param2:ArmatureData = null) : IBoneMovie{return null;}
      
      public function loadWait() : void{}
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN, param5:int = 0, param6:String = null, param7:String = "sameLayerAndGroup", param8:Boolean = true, param9:Boolean = true) : AnimationState{return null;}
      
      public function play(param1:String = "") : void{}
      
      public function stop() : void{}
      
      public function changeBone(param1:String, param2:Bone) : void{}
      
      public function getBoneByName(param1:String) : Bone{return null;}
      
      public function getBoneDataByName(param1:String) : BoneData{return null;}
      
      public function get boneMovieName() : String{return null;}
      
      public function get boneMovieLabels() : Vector.<String>{return null;}
      
      public function get currentLabel() : String{return null;}
      
      public function get armature() : Armature{return null;}
      
      public function set direction(param1:int) : void{}
      
      public function get direction() : int{return 0;}
      
      public function get styleName() : String{return null;}
      
      public function stopClock() : void{}
      
      public function startClock() : void{}
      
      private function clearArmature() : void{}
      
      public function get loadComplete() : Boolean{return false;}
      
      private function __onLoaderComplete(param1:BonesLoaderEvent) : void{}
      
      public function set onLoadComplete(param1:Function) : void{}
      
      public function getValueByAttribute(param1:String) : String{return null;}
      
      public function dispose() : void{}
   }
}
