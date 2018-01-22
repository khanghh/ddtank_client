package game.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import ddt.display.BitmapLoaderProxy;
   import ddt.events.LivingEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import flash.geom.Rectangle;
   import gameCommon.model.Living;
   import pet.data.PetSkillTemplateInfo;
   import phy.maps.Map;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovieEvent;
   
   public class GamePet extends GameLiving
   {
       
      
      private var _master:GamePlayer;
      
      private var _effectClassLink:String;
      
      public function GamePet(param1:Living, param2:GamePlayer)
      {
         super(param1);
         _master = param2;
         _testRect = new Rectangle(-3,3,6,3);
         _mass = 5;
         _gravityFactor = 50;
      }
      
      public function get master() : GamePlayer
      {
         return _master;
      }
      
      public function set effectClassLink(param1:String) : void
      {
         _effectClassLink = param1;
      }
      
      public function get effectClassLink() : String
      {
         return _effectClassLink;
      }
      
      override protected function initListener() : void
      {
         super.initListener();
         _info.addEventListener("usePetSkill",__usePetSkill);
      }
      
      private function __usePetSkill(param1:LivingEvent) : void
      {
         var _loc2_:* = null;
         if(param1.paras[0])
         {
            _loc2_ = PetSkillManager.getSkillByID(param1.value);
            if(_loc2_ == null)
            {
               throw new Error("找不到技能，技能ID为：" + param1.value);
            }
            if(_loc2_.isActiveSkill)
            {
               _propArray.push(new BitmapLoaderProxy(PathManager.solveSkillPicUrl(_loc2_.Pic),new Rectangle(0,0,40,40)));
               doUseItemAnimation();
            }
         }
      }
      
      override protected function removeListener() : void
      {
         super.removeListener();
         _info.removeEventListener("usePetSkill",__usePetSkill);
      }
      
      override protected function initView() : void
      {
         super.initView();
         initMovie();
         if(_bloodStripBg && _bloodStripBg.parent)
         {
            _bloodStripBg.parent.removeChild(_bloodStripBg);
         }
         if(_HPStrip && _HPStrip.parent)
         {
            _HPStrip.parent.removeChild(_HPStrip);
         }
         _nickName.x = _nickName.x + 20;
         _nickName.y = _nickName.y - 20;
      }
      
      override public function get layer() : int
      {
         if(_layer == -1)
         {
            return 1;
         }
         return _layer;
      }
      
      override public function get smallView() : SmallObject
      {
         return null;
      }
      
      override protected function initSmallMapObject() : void
      {
      }
      
      override public function setMap(param1:Map) : void
      {
         super.setMap(param1);
         if(param1)
         {
            __posChanged(null);
         }
      }
      
      override protected function __playEffect(param1:ActionMovieEvent) : void
      {
         if(param1.data)
         {
            if(ModuleLoader.hasDefinition("asset.game.skill.effect." + param1.data.effect))
            {
               _master.showEffect("asset.game.skill.effect." + param1.data.effect);
            }
            else
            {
               _master.showEffect("asset.game.AttackEffect2");
            }
         }
      }
      
      public function showMasterEffect() : void
      {
         if(_effectClassLink)
         {
            if(ModuleLoader.hasDefinition(_effectClassLink))
            {
               _master.showEffect(_effectClassLink);
            }
            else
            {
               _master.showEffect("asset.game.AttackEffect2");
            }
         }
         _effectClassLink = null;
      }
      
      override protected function __playerEffect(param1:ActionMovieEvent) : void
      {
         showMasterEffect();
      }
      
      override public function update(param1:Number) : void
      {
         super.update(param1);
      }
      
      public function prepareForShow() : void
      {
      }
      
      public function show() : void
      {
         master.map.addPhysical(this);
      }
      
      public function hide() : void
      {
         master.map.removePhysical(this);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
