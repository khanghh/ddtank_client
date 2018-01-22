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
      
      public function BaseLayer(param1:ItemTemplateInfo, param2:String = "", param3:Boolean = false, param4:int = 1, param5:String = null)
      {
         _info = param1;
         _color = param2 == null?"":param2;
         _gunBack = param3;
         _hairType = param4 == 1?"B":"A";
         _pic = param5 == null || String(param5) == "undefined"?_info.Pic:param5;
         super();
         init();
      }
      
      private function init() : void
      {
         _queueLoader = new LoaderQueue();
         _bitmaps = new Vector.<Bitmap>();
         _colors = [];
         initLoaders();
      }
      
      protected function initLoaders() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_info != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _info.Property8.length)
            {
               _loc2_ = getUrl(int(_info.Property8.charAt(_loc3_)));
               _loc2_ = _loc2_.toLocaleLowerCase();
               if(_loc2_.length != 0)
               {
                  _loc1_ = LoadResourceManager.Instance.createLoader(_loc2_,0);
                  _queueLoader.addLoader(_loc1_);
               }
               _loc3_++;
            }
            _defaultLayer = 0;
            _currentEdit = _queueLoader.length;
         }
      }
      
      protected function initColors(param1:String) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         _colors = param1.split("|");
         if(_bitmaps.length == 0)
         {
            return;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         _loc3_ = 0;
         while(_loc3_ < _bitmaps.length)
         {
            if(_bitmaps[_loc3_])
            {
               addChild(_bitmaps[_loc3_]);
               _bitmaps[_loc3_].visible = false;
            }
            _loc3_++;
         }
         if(_bitmaps[_defaultLayer])
         {
            _bitmaps[_defaultLayer].visible = true;
         }
         if(_colors.length == _bitmaps.length)
         {
            _loc5_ = 0;
            while(_loc5_ < _colors.length)
            {
               if(!StringHelper.isNullOrEmpty(_colors[_loc5_]) && _colors[_loc5_].toString() != "undefined" && _colors[_loc5_].toString() != "null")
               {
                  if(_bitmaps[_loc5_] != null)
                  {
                     _bitmaps[_loc5_].visible = true;
                     _bitmaps[_loc5_].transform.colorTransform = BitmapUtils.getColorTransfromByColor(_colors[_loc5_]);
                     _loc4_ = BitmapUtils.getHightlightColorTransfrom(_colors[_loc5_]);
                     _loc2_ = new Bitmap(_bitmaps[_loc5_].bitmapData,"auto",true);
                     if(_loc4_)
                     {
                        _loc2_.transform.colorTransform = _loc4_;
                     }
                     _loc2_.blendMode = "hardlight";
                     addChild(_loc2_);
                  }
               }
               else if(_bitmaps[_loc5_] != null)
               {
                  _bitmaps[_loc5_].transform.colorTransform = new ColorTransform();
               }
               _loc5_++;
            }
         }
      }
      
      public function getContent() : DisplayObject
      {
         return this;
      }
      
      public function setColor(param1:*) : Boolean
      {
         if(_info == null || param1 == null)
         {
            return false;
         }
         _color = String(param1);
         initColors(param1);
         return true;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function set info(param1:ItemTemplateInfo) : void
      {
         if(info == param1)
         {
            return;
         }
         clear();
         _info = param1;
         if(_info)
         {
            initLoaders();
            load(_callBack);
         }
      }
      
      public function set currentEdit(param1:int) : void
      {
         _currentEdit = param1;
         if(_currentEdit > _bitmaps.length)
         {
            _currentEdit = _bitmaps.length;
         }
         else if(_currentEdit < 1)
         {
            _currentEdit = 1;
         }
      }
      
      public function get currentEdit() : int
      {
         return _currentEdit;
      }
      
      public function dispose() : void
      {
         clear();
         _info = null;
         _callBack = null;
         _bitmaps = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      protected function clearBitmap() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bitmaps = new Vector.<Bitmap>();
      }
      
      protected function clear() : void
      {
         if(_queueLoader)
         {
            _queueLoader.removeEventListener("complete",__loadComplete);
            _queueLoader.removeEvent();
            _queueLoader.dispose();
            _queueLoader = null;
         }
         clearBitmap();
         _colors = [];
      }
      
      public final function load(param1:Function) : void
      {
         _callBack = param1;
         if(_info == null)
         {
            loadCompleteCallBack();
            return;
         }
         _queueLoader.addEventListener("complete",__loadComplete);
         _queueLoader.start();
      }
      
      protected function getUrl(param1:int) : String
      {
         return PathManager.solveGoodsPath(_info.CategoryID,_pic,_info.NeedSex == 1,"show",_hairType,String(param1),_info.Level,_gunBack,int(_info.Property1));
      }
      
      protected function __loadComplete(param1:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
      
      public function reSetBitmap() : void
      {
         var _loc1_:int = 0;
         clearBitmap();
         _loc1_ = 0;
         while(_loc1_ < _queueLoader.loaders.length)
         {
            _bitmaps.push(_queueLoader.loaders[_loc1_].content);
            if(_bitmaps[_loc1_])
            {
               _bitmaps[_loc1_].smoothing = true;
               _bitmaps[_loc1_].visible = false;
               addChild(_bitmaps[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      protected function loadCompleteCallBack() : void
      {
         _isComplete = true;
         if(_callBack != null)
         {
            _callBack(this);
         }
         dispatchEvent(new Event("complete"));
      }
      
      private function __onBitmapError(param1:LoaderEvent) : void
      {
         _isAllLoadSucceed = false;
      }
      
      public function get isAllLoadSucceed() : Boolean
      {
         return _isAllLoadSucceed;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
   }
}
