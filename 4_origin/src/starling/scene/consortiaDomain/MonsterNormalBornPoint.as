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
   
   public class MonsterNormalBornPoint extends Sprite
   {
       
      
      public var id:int;
      
      private var _monsterBornBuildState:int = -1;
      
      private var _build:Image;
      
      private var _monsterOutEff:BoneMovieStarling;
      
      private var _buildImageScale:Number;
      
      public function MonsterNormalBornPoint(param1:int, param2:String, param3:Number)
      {
         super();
         this.id = param1;
         _buildImageScale = param3;
         _build = StarlingMain.instance.createImage(param2);
         var _loc4_:* = _buildImageScale;
         _build.scaleY = _loc4_;
         _build.scaleX = _loc4_;
         _build.x = -_build.width * 0.5;
         _build.y = -_build.height * 0.5;
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
               if(_monsterOutEff)
               {
                  _monsterOutEff.removeFromParent(true);
                  _monsterOutEff = null;
               }
            }
            else if(_monsterBornBuildState == 2)
            {
               _monsterOutEff = BoneMovieFactory.instance.creatBoneMovie("consortiaDomainMonsterBornPointEff1");
               _monsterOutEff.x = -457;
               _monsterOutEff.y = -381;
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
      }
   }
}
