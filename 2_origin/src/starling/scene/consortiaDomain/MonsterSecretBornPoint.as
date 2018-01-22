package starling.scene.consortiaDomain
{
   import bones.BoneMovieFactory;
   import bones.display.BoneMovieStarling;
   import com.pickgliss.utils.StarlingObjectUtils;
   import consortiaDomain.ConsortiaDomainManager;
   import flash.events.Event;
   import road7th.StarlingMain;
   import starling.core.Starling;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class MonsterSecretBornPoint extends Sprite
   {
       
      
      public var id:int;
      
      private var _monsterBornBuildState:int = -1;
      
      private var _build:Image;
      
      private var _monsterOutEff:BoneMovieStarling;
      
      private var _closeDoorImage:Image;
      
      private var _buildImageScale:Number;
      
      public function MonsterSecretBornPoint(param1:int, param2:String, param3:Number)
      {
         super();
         this.id = param1;
         _buildImageScale = param3;
         _build = StarlingMain.instance.createImage(param2);
         var _loc4_:* = _buildImageScale;
         _build.scaleY = _loc4_;
         _build.scaleX = _loc4_;
         _build.x = -_build.width * 0.5;
         _build.y = -_build.height;
         addChild(_build);
         ConsortiaDomainManager.instance.addEventListener("event_monster_born",onMonsterBorn);
      }
      
      public function setXY(param1:int, param2:int) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      private function onMonsterBorn(param1:Event) : void
      {
         monsterBornBuildState = 2;
         Starling.juggler.removeTweens(buildStateClose);
         Starling.juggler.delayCall(buildStateClose,8);
      }
      
      private function buildStateClose() : void
      {
         monsterBornBuildState = 1;
      }
      
      public function get monsterBornBuildState() : int
      {
         return _monsterBornBuildState;
      }
      
      public function set monsterBornBuildState(param1:int) : void
      {
         if(_monsterBornBuildState != param1)
         {
            _monsterBornBuildState = param1;
            if(_monsterBornBuildState == 1)
            {
               _closeDoorImage = StarlingMain.instance.createImage("consortiaDomainMonsterBornPoint2Door");
               var _loc2_:* = _buildImageScale;
               _closeDoorImage.scaleY = _loc2_;
               _closeDoorImage.scaleX = _loc2_;
               _closeDoorImage.x = 6;
               _closeDoorImage.y = -151;
               addChild(_closeDoorImage);
               if(_monsterOutEff)
               {
                  _monsterOutEff.removeFromParent(true);
                  _monsterOutEff = null;
               }
            }
            else if(_monsterBornBuildState == 2)
            {
               if(_closeDoorImage)
               {
                  _closeDoorImage.removeFromParent(true);
                  _closeDoorImage = null;
               }
               _monsterOutEff = BoneMovieFactory.instance.creatBoneMovie("consortiaDomainMonsterBornPointEff2");
               _monsterOutEff.x = -5;
               _monsterOutEff.y = -151;
               addChild(_monsterOutEff);
            }
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Starling.juggler.removeTweens(buildStateClose);
         ConsortiaDomainManager.instance.removeEventListener("event_monster_born",onMonsterBorn);
         _build = null;
         StarlingObjectUtils.disposeObject(_monsterOutEff);
         _monsterOutEff = null;
         StarlingObjectUtils.disposeObject(_closeDoorImage);
         _closeDoorImage = null;
      }
   }
}
