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
      
      public function GamePet(param1:Living, param2:GamePlayer){super(null);}
      
      public function get master() : GamePlayer{return null;}
      
      public function set effectClassLink(param1:String) : void{}
      
      public function get effectClassLink() : String{return null;}
      
      override protected function initListener() : void{}
      
      private function __usePetSkill(param1:LivingEvent) : void{}
      
      override protected function removeListener() : void{}
      
      override protected function initView() : void{}
      
      override public function get layer() : int{return 0;}
      
      override public function get smallView() : SmallObject{return null;}
      
      override protected function initSmallMapObject() : void{}
      
      override public function setMap(param1:Map) : void{}
      
      override protected function __playEffect(param1:ActionMovieEvent) : void{}
      
      public function showMasterEffect() : void{}
      
      override protected function __playerEffect(param1:ActionMovieEvent) : void{}
      
      override public function update(param1:Number) : void{}
      
      public function prepareForShow() : void{}
      
      public function show() : void{}
      
      public function hide() : void{}
      
      override public function dispose() : void{}
   }
}
