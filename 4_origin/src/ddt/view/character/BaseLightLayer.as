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
      
      public function BaseLightLayer(nimbus:int, showType:int = 0)
      {
         super();
         _nimbus = nimbus;
         _type = showType;
      }
      
      public function load(callBack:Function) : void
      {
         _callBack = callBack;
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
         var nimbus:String = _nimbus.toString();
         nimbus = nimbus.substr(nimbus.length - 2,nimbus.length);
         nimbus = Number(nimbus).toString();
         return nimbus;
      }
      
      protected function __sourceComplete(event:LoaderEvent = null) : void
      {
         var LightClass:* = null;
         if(_loader)
         {
            _loader.removeEventListener("complete",__sourceComplete);
         }
         if(event != null && !event.loader.isSuccess)
         {
            _light = null;
         }
         else if(getId() != "00" && getId() != "0")
         {
            LightClass = ClassUtils.uiSourceDomain.getDefinition("game.crazyTank.view.light.CircleLightAsset_" + getId()) as Class;
            _light = new LightClass() as MovieClip;
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
      
      public function set info(value:ItemTemplateInfo) : void
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
      
      public function set currentEdit(n:int) : void
      {
      }
      
      public function get currentEdit() : int
      {
         return 0;
      }
      
      public function setColor(color:*) : Boolean
      {
         return false;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
   }
}
