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
      
      public function BaseLayer(info:ItemTemplateInfo, color:String = "", gunback:Boolean = false, hairType:int = 1, pic:String = null)
      {
         _info = info;
         _color = color == null?"":color;
         _gunBack = gunback;
         _hairType = hairType == 1?"B":"A";
         _pic = pic == null || String(pic) == "undefined"?_info.Pic:pic;
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
         var i:int = 0;
         var url:* = null;
         var l:* = null;
         if(_info != null)
         {
            for(i = 0; i < _info.Property8.length; )
            {
               url = getUrl(int(_info.Property8.charAt(i)));
               url = url.toLocaleLowerCase();
               if(url.length != 0)
               {
                  l = LoadResourceManager.Instance.createLoader(url,0);
                  _queueLoader.addLoader(l);
               }
               i++;
            }
            _defaultLayer = 0;
            _currentEdit = _queueLoader.length;
         }
      }
      
      protected function initColors(color:String) : void
      {
         var j:int = 0;
         var i:int = 0;
         var lightTransfrom:* = null;
         var lightBitmap:* = null;
         _colors = color.split("|");
         if(_bitmaps.length == 0)
         {
            return;
         }
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         for(j = 0; j < _bitmaps.length; )
         {
            if(_bitmaps[j])
            {
               addChild(_bitmaps[j]);
               _bitmaps[j].visible = false;
            }
            j++;
         }
         if(_bitmaps[_defaultLayer])
         {
            _bitmaps[_defaultLayer].visible = true;
         }
         if(_colors.length == _bitmaps.length)
         {
            for(i = 0; i < _colors.length; )
            {
               if(!StringHelper.isNullOrEmpty(_colors[i]) && _colors[i].toString() != "undefined" && _colors[i].toString() != "null")
               {
                  if(_bitmaps[i] != null)
                  {
                     _bitmaps[i].visible = true;
                     _bitmaps[i].transform.colorTransform = BitmapUtils.getColorTransfromByColor(_colors[i]);
                     lightTransfrom = BitmapUtils.getHightlightColorTransfrom(_colors[i]);
                     lightBitmap = new Bitmap(_bitmaps[i].bitmapData,"auto",true);
                     if(lightTransfrom)
                     {
                        lightBitmap.transform.colorTransform = lightTransfrom;
                     }
                     lightBitmap.blendMode = "hardlight";
                     addChild(lightBitmap);
                  }
               }
               else if(_bitmaps[i] != null)
               {
                  _bitmaps[i].transform.colorTransform = new ColorTransform();
               }
               i++;
            }
         }
      }
      
      public function getContent() : DisplayObject
      {
         return this;
      }
      
      public function setColor(color:*) : Boolean
      {
         if(_info == null || color == null)
         {
            return false;
         }
         _color = String(color);
         initColors(color);
         return true;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _info;
      }
      
      public function set info(value:ItemTemplateInfo) : void
      {
         if(info == value)
         {
            return;
         }
         clear();
         _info = value;
         if(_info)
         {
            initLoaders();
            load(_callBack);
         }
      }
      
      public function set currentEdit(n:int) : void
      {
         _currentEdit = n;
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
      
      public final function load(callBack:Function) : void
      {
         _callBack = callBack;
         if(_info == null)
         {
            loadCompleteCallBack();
            return;
         }
         _queueLoader.addEventListener("complete",__loadComplete);
         _queueLoader.start();
      }
      
      protected function getUrl(layer:int) : String
      {
         return PathManager.solveGoodsPath(_info.CategoryID,_pic,_info.NeedSex == 1,"show",_hairType,String(layer),_info.Level,_gunBack,int(_info.Property1));
      }
      
      protected function __loadComplete(event:Event) : void
      {
         reSetBitmap();
         _queueLoader.removeEventListener("complete",__loadComplete);
         _queueLoader.removeEvent();
         initColors(_color);
         loadCompleteCallBack();
      }
      
      public function reSetBitmap() : void
      {
         var i:int = 0;
         clearBitmap();
         for(i = 0; i < _queueLoader.loaders.length; )
         {
            _bitmaps.push(_queueLoader.loaders[i].content);
            if(_bitmaps[i])
            {
               _bitmaps[i].smoothing = true;
               _bitmaps[i].visible = false;
               addChild(_bitmaps[i]);
            }
            i++;
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
      
      private function __onBitmapError(event:LoaderEvent) : void
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
