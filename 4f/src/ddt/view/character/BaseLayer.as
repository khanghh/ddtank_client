package ddt.view.character
{
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.LoaderQueue;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.PathManager;
   import ddt.utils.BitmapUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import road7th.utils.StringHelper;
   
   public class BaseLayer extends Sprite implements ILayer
   {
      
      public static const ICON:String = "icon";
      
      public static const SHOW:String = "show";
      
      public static const GAME:String = "game";
      
      public static const CONSORTIA:String = "consortia";
      
      public static const STATE:String = "state";
       
      
      protected var _queueLoader:LoaderQueue;
      
      protected var _info:ItemTemplateInfo;
      
      protected var _colors:Array;
      
      protected var _gunBack:Boolean;
      
      protected var _hairType:String;
      
      protected var _currentEdit:uint;
      
      private var _callBack:Function;
      
      protected var _color:String;
      
      protected var _defaultLayer:uint;
      
      protected var _bitmaps:Vector.<Bitmap>;
      
      private var _isAllLoadSucceed:Boolean = true;
      
      protected var _pic:String;
      
      private var _isComplete:Boolean;
      
      public function BaseLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1, param5:String = null){super();}
      
      private function init() : void{}
      
      protected function initLoaders() : void{}
      
      protected function initColors(param1:String) : void{}
      
      public function getContent() : DisplayObject{return null;}
      
      public function setColor(param1:*) : Boolean{return false;}
      
      public function get info() : ItemTemplateInfo{return null;}
      
      public function set info(param1:ItemTemplateInfo) : void{}
      
      public function set currentEdit(param1:int) : void{}
      
      public function get currentEdit() : int{return 0;}
      
      public function dispose() : void{}
      
      protected function clearBitmap() : void{}
      
      protected function clear() : void{}
      
      public final function load(param1:Function) : void{}
      
      protected function getUrl(param1:int) : String{return null;}
      
      protected function __loadComplete(param1:Event) : void{}
      
      public function reSetBitmap() : void{}
      
      protected function loadCompleteCallBack() : void{}
      
      private function __onBitmapError(param1:LoaderEvent) : void{}
      
      public function get isAllLoadSucceed() : Boolean{return false;}
      
      public function get isComplete() : Boolean{return false;}
   }
}
