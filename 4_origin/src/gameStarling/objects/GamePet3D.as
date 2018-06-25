package gameStarling.objects
{
   import com.pickgliss.loader.ModuleLoader;
   import ddt.display.BitmapLoaderProxy;
   import ddt.events.LivingEvent;
   import ddt.manager.PathManager;
   import ddt.manager.PetSkillManager;
   import flash.geom.Rectangle;
   import gameCommon.model.Living;
   import pet.data.PetSkillTemplateInfo;
   import phy.object.SmallObject;
   import road.game.resource.ActionMovieEvent;
   import road7th.utils.BoneMovieWrapper;
   import starlingPhy.maps.Map3D;
   
   public class GamePet3D extends GameLiving3D
   {
       
      
      private var _master:GamePlayer3D;
      
      private var _effectClassLink:String;
      
      public function GamePet3D(info:Living, master:GamePlayer3D)
      {
         super(info);
         _master = master;
         _testRect = new Rectangle(-3,3,6,3);
         _mass = 5;
         _gravityFactor = 50;
      }
      
      public function get master() : GamePlayer3D
      {
         return _master;
      }
      
      public function set effectClassLink(value:String) : void
      {
         _effectClassLink = value;
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
      
      private function __usePetSkill(event:LivingEvent) : void
      {
         var skill:* = null;
         if(event.paras[0])
         {
            skill = PetSkillManager.getSkillByID(event.value);
            if(skill == null)
            {
               throw new Error("找不到技能，技能ID为：" + event.value);
            }
            if(skill.isActiveSkill)
            {
               _propArray.push(new BitmapLoaderProxy(PathManager.solveSkillPicUrl(skill.Pic),new Rectangle(0,0,40,40)));
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
      
      override public function setMap(map:Map3D) : void
      {
         super.setMap(map);
         if(map)
         {
            __posChanged(null);
         }
      }
      
      override protected function movieEffectEvent(e:BoneMovieWrapper, args:Array = null) : void
      {
         if(args)
         {
            _master.showEffect("asset.game.skill.effect." + args[0]);
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
      
      override protected function __playerEffect(evt:ActionMovieEvent) : void
      {
         showMasterEffect();
      }
      
      override public function update(dt:Number) : void
      {
         super.update(dt);
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
