package starling.scene.consortiaDomain
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieFastStarling;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachMonsterInfo;
   import ddt.events.CEvent;
   import starling.core.Starling;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.scene.common.WalkPlugin;
   import starling.text.TextField;
   
   public class MonsterBone extends Sprite
   {
       
      
      private var _moveEntityState:int = -1;
      
      private var _walkPlugin:WalkPlugin;
      
      private var _fight:BoneMovieFastStarling;
      
      private var _eachMonsterInfo:EachMonsterInfo;
      
      private var _bone:BoneMovieStarling;
      
      private var _direction:int;
      
      private var _debugBuildNameTf:TextField;
      
      public function MonsterBone(eachInfo:EachMonsterInfo)
      {
         super();
         _eachMonsterInfo = eachInfo;
         var styleName:String = eachInfo.Type == 0?"consortia_domain_bone_living007":"consortia_domain_bone_living191";
         _bone = BoneMovieFactory.instance.creatBoneMovie(styleName);
         addChild(_bone);
         _walkPlugin = new WalkPlugin(this,ConsortiaDomainManager.instance.consortiaLandMonsterSpeed);
         setTouchEnable();
         _bone.addEventListener("complete",onBoneComplete);
      }
      
      private function onBoneComplete(evt:Event) : void
      {
         setTouchEnable();
      }
      
      private function setTouchEnable() : void
      {
         touchGroup = true;
         touchable = true;
         _bone.touchable = true;
         useHandCursor = true;
         if(_bone.armature && _bone.armature.display)
         {
            _bone.armature.display.touchable = true;
         }
      }
      
      public function set moveEntityState(value:int) : void
      {
         if(value == 3)
         {
            _walkPlugin.walk();
            showFightState(false);
            _bone.play("walk");
            _moveEntityState = value;
            setTouchEnable();
         }
         if(_moveEntityState != value)
         {
            if(value == 1)
            {
               _walkPlugin.stop();
               showFightState(false);
               this.alpha = 0;
               Starling.juggler.removeTweens(this);
               Starling.juggler.tween(this,1,{"alpha":1});
               _bone.play("stand");
            }
            else if(value == 4 || value == 5)
            {
               _walkPlugin.stop();
               showFightState(true);
               _bone.play("stand");
            }
            else if(value == 6)
            {
               _walkPlugin.stop();
               showFightState(false);
               _bone.play("die");
               Starling.juggler.removeTweens(onMonsterDieComplete);
               Starling.juggler.delayCall(onMonsterDieComplete,1);
            }
            _moveEntityState = value;
            setTouchEnable();
         }
      }
      
      private function onMonsterDieComplete() : void
      {
         ConsortiaDomainManager.instance.dispatchEvent(new CEvent("event_remove_child_monster",this));
      }
      
      private function showFightState(isFight:Boolean) : void
      {
         if(isFight)
         {
            if(!_fight)
            {
               _fight = BoneMovieFactory.instance.creatBoneMovieFast("consortia_domain_bone_fight_state");
               _fight.x = 0;
               _fight.y = -120;
            }
            if(!_fight.parent)
            {
               this.addChild(_fight);
            }
         }
         else
         {
            _fight && _fight.removeFromParent(false);
         }
      }
      
      public function get pathArr() : Array
      {
         return _walkPlugin.pathArr;
      }
      
      public function set pathArr(value:Array) : void
      {
         _walkPlugin.pathArr = value;
      }
      
      public function get moveEntityState() : int
      {
         return _moveEntityState;
      }
      
      public function get eachMonsterInfo() : EachMonsterInfo
      {
         return _eachMonsterInfo;
      }
      
      public function set eachMonsterInfo(value:EachMonsterInfo) : void
      {
         _eachMonsterInfo = value;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(value:int) : void
      {
         _direction = value;
         if(_direction == 4 || _direction == 2)
         {
            _bone.scaleX = 1;
         }
         else if(_direction == 3 || _direction == 1)
         {
            _bone.scaleX = -1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Starling.juggler.removeTweens(this);
         Starling.juggler.removeTweens(onMonsterDieComplete);
         _bone.removeEventListener("complete",onBoneComplete);
         _walkPlugin.stop();
         _walkPlugin = null;
         StarlingObjectUtils.disposeObject(_fight);
         _fight = null;
         _eachMonsterInfo = null;
         _debugBuildNameTf = null;
      }
   }
}
