package petsBag.view.item
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.PathManager;
   import ddt.utils.Helpers;
   import flash.display.Bitmap;
   import flash.utils.getTimer;
   import pet.data.PetInfo;
   import road.game.resource.ActionMovie;
   import road.game.resource.ActionMovieEvent;
   
   public class PetBigItem extends Component implements Disposeable
   {
       
      
      private var _petMovie:ActionMovie;
      
      private var _info:PetInfo;
      
      private var ACTIONS:Array;
      
      private var _fightImg:Bitmap;
      
      private var _loader:BaseLoader;
      
      private var _lastTime:uint = 0;
      
      public function PetBigItem()
      {
         ACTIONS = ["standA","walkA","walkB","hunger"];
         super();
      }
      
      public function initTips() : void
      {
         tipStyle = "petsBag.view.item.PetGrowUpTip";
         tipDirctions = "5,2,7,1,6,4";
      }
      
      public function set info(param1:PetInfo) : void
      {
         var _loc3_:* = null;
         if(param1 == _info)
         {
            return;
         }
         var _loc2_:Boolean = false;
         if(_info && param1)
         {
            _loc2_ = _info.ID == param1.ID && _info.GameAssetUrl == param1.GameAssetUrl;
         }
         if(!_loc2_ && _loader && _loader.isLoading)
         {
            _loader.removeEventListener("complete",__onComplete);
         }
         _info = param1;
         tipData = param1;
         if((!_info || !_loc2_) && _petMovie)
         {
            _petMovie.removeEventListener("actionEnd",doNextAction);
            _petMovie.dispose();
            _petMovie = null;
         }
         if(_info)
         {
            if(_info.IsEquip)
            {
               if(!_fightImg)
               {
                  _fightImg = ComponentFactory.Instance.creatBitmap("assets.petsBag.fight3");
                  addChild(_fightImg);
               }
               _fightImg.visible = true;
            }
            else if(_fightImg)
            {
               _fightImg.visible = false;
            }
            if(_loc2_)
            {
               return;
            }
            if(ModuleLoader.hasDefinition("pet.asset.game." + param1.GameAssetUrl))
            {
               _loc3_ = ModuleLoader.getDefinition("pet.asset.game." + param1.GameAssetUrl) as Class;
               _petMovie = new _loc3_();
               _petMovie.mute();
               _petMovie.doAction(Helpers.randomPick(ACTIONS));
               _petMovie.addEventListener("actionEnd",doNextAction);
               addChild(_petMovie);
            }
            else
            {
               _loader = LoadResourceManager.Instance.createLoader(PathManager.solvePetGameAssetUrl(param1.GameAssetUrl),4);
               _loader.addEventListener("complete",__onComplete);
               LoadResourceManager.Instance.startLoad(_loader);
            }
         }
         else if(_fightImg)
         {
            _fightImg.visible = false;
         }
      }
      
      private function __onComplete(param1:LoaderEvent) : void
      {
         var _loc2_:* = null;
         _loader.removeEventListener("complete",__onComplete);
         if(ModuleLoader.hasDefinition("pet.asset.game." + _info.GameAssetUrl))
         {
            _loc2_ = ModuleLoader.getDefinition("pet.asset.game." + _info.GameAssetUrl) as Class;
            _petMovie = new _loc2_();
            _petMovie.mute();
            _petMovie.doAction(Helpers.randomPick(ACTIONS));
            _petMovie.addEventListener("actionEnd",doNextAction);
            addChild(_petMovie);
         }
      }
      
      private function doNextAction(param1:ActionMovieEvent) : void
      {
         if(_petMovie)
         {
            if(getTimer() - _lastTime > 40)
            {
               _petMovie.doAction(Helpers.randomPick(ACTIONS));
            }
            _lastTime = getTimer();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_petMovie)
         {
            _petMovie.removeEventListener("actionEnd",doNextAction);
         }
         ObjectUtils.disposeObject(_petMovie);
         _petMovie = null;
         _info = null;
         if(_fightImg)
         {
            ObjectUtils.disposeObject(_fightImg);
            _fightImg = null;
         }
         if(_loader)
         {
            _loader.removeEventListener("complete",__onComplete);
         }
         _loader = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get fightImg() : Bitmap
      {
         return _fightImg;
      }
   }
}
