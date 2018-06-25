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
   
   public class BaseWingLayer extends Sprite implements ILayer
   {
      
      public static const SHOW_WING:int = 0;
      
      public static const GAME_WING:int = 1;
       
      
      protected var _info:ItemTemplateInfo;
      
      protected var _callBack:Function;
      
      protected var _loader:ModuleLoader;
      
      protected var _showType:int = 0;
      
      protected var _wing:MovieClip;
      
      private var _isComplete:Boolean;
      
      public function BaseWingLayer(info:ItemTemplateInfo, showType:int = 0)
      {
         _info = info;
         _showType = showType;
         super();
      }
      
      protected function initLoader() : void
      {
         if(!ClassUtils.uiSourceDomain.hasDefinition("wing_" + getshowTypeString() + "_" + info.TemplateID))
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
      
      protected function __sourceComplete(event:LoaderEvent = null) : void
      {
         var WingClass:* = null;
         if(info == null)
         {
            return;
         }
         if(_loader)
         {
            _loader.removeEventListener("complete",__sourceComplete);
         }
         if(event != null && !event.loader.isSuccess)
         {
            _wing = null;
         }
         else
         {
            WingClass = ClassUtils.uiSourceDomain.getDefinition("wing_" + getshowTypeString() + "_" + info.TemplateID) as Class;
            _wing = new WingClass();
         }
         _isComplete = true;
         if(_callBack != null)
         {
            _callBack(this);
         }
      }
      
      public function setColor(color:*) : Boolean
      {
         return false;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         _info = value;
      }
      
      public function getContent() : DisplayObject
      {
         return _wing;
      }
      
      public function dispose() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("complete",__sourceComplete);
            _loader = null;
         }
         _wing = null;
         _callBack = null;
         _info = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function load(callBack:Function) : void
      {
         _callBack = callBack;
         initLoader();
      }
      
      private function loadLayerComplete() : void
      {
      }
      
      public function set currentEdit(n:int) : void
      {
      }
      
      public function get currentEdit() : int
      {
         return 0;
      }
      
      override public function get width() : Number
      {
         return 0;
      }
      
      override public function get height() : Number
      {
         return 0;
      }
      
      protected function getUrl() : String
      {
         return PathManager.soloveWingPath(info.Pic);
      }
      
      public function getshowTypeString() : String
      {
         if(_showType == 0)
         {
            return "show";
         }
         return "game";
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
   }
}
