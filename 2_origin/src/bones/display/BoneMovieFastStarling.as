package bones.display
{
   import bones.BoneMovieFactory;
   import bones.loader.BonesLoaderEvent;
   import bones.loader.BonesLoaderManager;
   import com.pickgliss.utils.StarlingObjectUtils;
   import dragonBones.animation.WorldClock;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastBone;
   import dragonBones.fast.animation.FastAnimationState;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.filters.FragmentFilter;
   
   public class BoneMovieFastStarling extends Sprite
   {
       
      
      private var _direction:int = 1;
      
      private var _armature:FastArmature = null;
      
      private var _armatureData:ArmatureData = null;
      
      private var _styleName:String;
      
      private var _loadComplete:Boolean = true;
      
      private var _movie:DisplayObject;
      
      private var _defaultBoneActionType:String;
      
      private var _deafultImage:Image;
      
      private var _argsData:DictionaryData;
      
      private var defaultFilter:FragmentFilter = null;
      
      public function BoneMovieFastStarling(param1:String = "")
      {
         super();
         _styleName = param1;
      }
      
      public function setArmature(param1:FastArmature, param2:ArmatureData = null) : BoneMovieFastStarling
      {
         clearArmature();
         _armature = param1;
         _armatureData = param2 || param1.armatureData;
         if(_argsData)
         {
            _argsData.clear();
         }
         _movie = _armature.display as DisplayObject;
         _movie.touchable = false;
         addChildAt(_movie,0);
         var _loc3_:AnimationData = _armatureData.animationDataList[0];
         if(_defaultBoneActionType == null || _defaultBoneActionType == "")
         {
            _defaultBoneActionType = _loc3_.name;
         }
         gotoAndPlay(_defaultBoneActionType);
         startClock();
         return this;
      }
      
      public function loadWait() : void
      {
         _loadComplete = false;
         var _loc1_:String = BoneMovieFactory.instance.model.getBonesStyle(_styleName).boneType;
         if(_loc1_ != "none")
         {
            _deafultImage = StarlingMain.instance.createImage("image_deafult_" + _loc1_);
            _deafultImage.x = -60;
            _deafultImage.y = -100;
            addChild(_deafultImage);
         }
         BonesLoaderManager.instance.addEventListener("complete",__onLoaderComplete);
      }
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN) : FastAnimationState
      {
         return _armature.animation.gotoAndPlay(param1,param2,param3,param4);
      }
      
      public function play(param1:String = "") : void
      {
         if(_armature)
         {
            gotoAndPlay(param1 == ""?_defaultBoneActionType:param1);
         }
         _defaultBoneActionType = param1;
      }
      
      public function stop() : void
      {
         if(_armature != null && _armature.animation != null)
         {
            _armature.animation.stop();
         }
      }
      
      public function getBoneByName(param1:String) : FastBone
      {
         var _loc2_:FastBone = _armature.getBone(param1);
         return _loc2_;
      }
      
      public function getBoneDataByName(param1:String) : BoneData
      {
         var _loc2_:BoneData = null;
         if(_armatureData != null)
         {
            _loc2_ = _armatureData.getBoneData(name);
            if(_loc2_ != null)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get boneMovieName() : String
      {
         if(_armature != null)
         {
            return _armature.name;
         }
         return null;
      }
      
      public function get boneMovieLabels() : Vector.<String>
      {
         if(_armature != null && _armature.animation != null)
         {
            return _armature.animation.movementList;
         }
         return null;
      }
      
      public function get currentLabel() : String
      {
         if(_armature != null && _armature.animation != null)
         {
            return _armature.animation.lastAnimationName;
         }
         return null;
      }
      
      public function get armature() : FastArmature
      {
         return _armature;
      }
      
      public function set direction(param1:int) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
         this.scaleX = _direction;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function get styleName() : String
      {
         return _styleName;
      }
      
      public function stopClock() : void
      {
         WorldClock.clock.remove(_armature);
      }
      
      public function startClock() : void
      {
         WorldClock.clock.add(_armature);
      }
      
      override public function set filter(param1:FragmentFilter) : void
      {
         .super.filter = param1;
      }
      
      private function clearArmature() : void
      {
         if(_armature)
         {
            stopClock();
            if(_armature.animation)
            {
               _armature.animation.stop();
            }
            _armature.dispose();
            _armature = null;
            _armatureData = null;
            if(_movie.parent)
            {
               _movie.parent.removeChild(_movie,true);
            }
            _movie = null;
         }
         StarlingObjectUtils.disposeObject(_deafultImage);
         _deafultImage = null;
      }
      
      public function get loadComplete() : Boolean
      {
         return _loadComplete;
      }
      
      private function __onLoaderComplete(param1:BonesLoaderEvent) : void
      {
         if(_styleName == param1.vo.styleName)
         {
            _loadComplete = true;
            BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
            setArmature(BoneMovieFactory.instance.getFastArmature(_styleName,BoneMovieFactory.instance.starlingFactory));
            dispatchEvent(new Event("complete"));
         }
      }
      
      public function getValueByAttribute(param1:String) : String
      {
         return _argsData[param1];
      }
      
      override public function dispose() : void
      {
         if(_argsData)
         {
            _argsData.clear();
         }
         _argsData = null;
         defaultFilter = null;
         clearArmature();
         BonesLoaderManager.instance.removeEventListener("complete",__onLoaderComplete);
         super.dispose();
      }
   }
}
