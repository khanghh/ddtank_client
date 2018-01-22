package ddt.view.character
{
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.utils.ClassUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class BaseLightLayer extends Sprite implements ILayer
   {
       
      
      private var _light:MovieClip;
      
      private var _type:int;
      
      private var _callBack:Function;
      
      private var _loader:ModuleLoader;
      
      private var _nimbus:int;
      
      private var _isComplete:Boolean;
      
      public function BaseLightLayer(param1:int, param2:int = 0)
      {
         super();
         _nimbus = param1;
         _type = param2;
      }
      
      public function load(param1:Function) : void
      {
         _callBack = param1;
         initLoader();
      }
      
      protected function initLoader() : void
      {
         if(getId() == "00")
         {
            return;
         }
         if(!ClassUtils.uiSourceDomain.hasDefinition("game.crazyTank.view.light.CircleLightAsset_" + getId()))
         {
            _loader = LoadResourceManager.Instance.createLoader(getUrl(),4);
            _loader.addEventListener("complete",__sourceComplete);
            LoadResourceManager.Instance.startLoad(_loader);
         }
         else
         {
            __sourceComplete();
         }
      }
      
      private function getId() : String
      {
         if(_nimbus == 0)
         {
            return "00";
         }
         var _loc1_:String = _nimbus.toString();
         _loc1_ = _loc1_.substr(_loc1_.length - 2,_loc1_.length);
         _loc1_ = Number(_loc1_).toString();
         return _loc1_;
      }
      
      protected function __sourceComplete(param1:LoaderEvent = null) : void
      {
         var _loc2_:* = null;
         if(_loader)
         {
            _loader.removeEventListener("complete",__sourceComplete);
         }
         if(param1 != null && !param1.loader.isSuccess)
         {
            _light = null;
         }
         else if(getId() != "00" && getId() != "0")
         {
            _loc2_ = ClassUtils.uiSourceDomain.getDefinition("game.crazyTank.view.light.CircleLightAsset_" + getId()) as Class;
            _light = new _loc2_() as MovieClip;
         }
         _isComplete = true;
         if(_callBack != null && _light != null)
         {
            _callBack(this);
         }
      }
      
      protected function getUrl() : String
      {
         return PathManager.soloveCircleLightPath(getId());
      }
      
      public function getshowTypeString() : String
      {
         if(_type == 0)
         {
            return "show";
         }
         return "game";
      }
      
      public function get info() : ItemTemplateInfo
      {
         return null;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
      }
      
      public function getContent() : DisplayObject
      {
         return this._light;
      }
      
      public function dispose() : void
      {
         if(_light && _light.parent)
         {
            _light.parent.removeChild(_light);
         }
         _light = null;
         _callBack = null;
         if(_loader)
         {
            _loader.removeEventListener("complete",__sourceComplete);
         }
         _loader = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function set currentEdit(param1:int) : void
      {
      }
      
      public function get currentEdit() : int
      {
         return 0;
      }
      
      public function setColor(param1:*) : Boolean
      {
         return false;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
   }
}
