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
   
   public class DynamicWeaponLayer extends Sprite implements ILayer
   {
       
      
      protected var _weapon:MovieClip;
      
      protected var _info:ItemTemplateInfo;
      
      protected var _colors:Array;
      
      protected var _hairType:String;
      
      protected var _currentEdit:uint;
      
      private var _callBack:Function;
      
      protected var _color:String;
      
      protected var _defaultLayer:uint;
      
      protected var _gunBack:Boolean;
      
      protected var _pic:String;
      
      protected var _loader:ModuleLoader;
      
      private var _isComplete:Boolean;
      
      public function DynamicWeaponLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1, param5:String = null){super();}
      
      protected function initLoader() : void{}
      
      protected function __sourceComplete(param1:LoaderEvent = null) : void{}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function getContent() : DisplayObject{return null;}
      
      public function dispose() : void{}
      
      public function load(param1:Function) : void{}
      
      private function loadLayerComplete() : void{}
      
      public function set currentEdit(param1:int) : void{}
      
      public function get currentEdit() : int{return 0;}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      protected function getUrl() : String{return null;}
      
      public function get isComplete() : Boolean{return false;}
   }
}
