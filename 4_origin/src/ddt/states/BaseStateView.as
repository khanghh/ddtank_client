package ddt.states
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.loader.StartupResourceLoader;
   import ddt.manager.QQtipsManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import pet.sprite.PetSpriteManager;
   import trainer.view.NewHandContainer;
   
   public class BaseStateView extends Sprite
   {
       
      
      private var _prepared:Boolean;
      
      private var _container:Sprite;
      
      private var _timer:Timer;
      
      private var _size:int = 60;
      
      private var _completed:int = 0;
      
      private var _shapes:Vector.<DisplayObject>;
      
      private var _oldStageWidth:int;
      
      private var index:int;
      
      public function BaseStateView()
      {
         super();
         _container = new Sprite();
      }
      
      public function get prepared() : Boolean
      {
         return _prepared;
      }
      
      public function check(type:String) : Boolean
      {
         return true;
      }
      
      public function prepare() : void
      {
         _prepared = true;
      }
      
      public function enter(prev:BaseStateView, data:Object = null) : void
      {
         var type:String = getType();
         if(type != "roomLoading" && type != "consortia_domain" && !StartupResourceLoader.firstEnterHall)
         {
            SoundManager.instance.playMusic("062",true,false);
         }
         QQtipsManager.instance.checkStateView(getType());
         playEnterMovie();
         PetSpriteManager.Instance.showPetSprite(true,false);
      }
      
      private function playEnterMovie() : void
      {
         _completed = 0;
         if(StateManager.RecordFlag)
         {
            _container.x = 13;
            _container.y = 35;
         }
         if(_shapes == null || StageReferance.stageWidth != _oldStageWidth)
         {
            createShapes();
            _oldStageWidth = StageReferance.stageWidth;
         }
         rebackInitState();
         _container.visible = true;
         LayerManager.Instance.addToLayer(_container,0,false,0,true);
         _timer = new Timer(20);
         _timer.addEventListener("timer",__tick);
         _timer.start();
      }
      
      private function createShapes() : void
      {
         var h:int = 0;
         var w:int = 0;
         var i:int = 0;
         var bitmap:* = null;
         var src:BitmapData = new BitmapData(_size,_size,false,0);
         if(_shapes)
         {
            for(i = 0; i < _shapes.length; )
            {
               ObjectUtils.disposeObject(_shapes[i]);
               _shapes[i] = null;
               i++;
            }
            _shapes.splice(0,_shapes.length);
         }
         else
         {
            _shapes = new Vector.<DisplayObject>();
         }
         do
         {
            h = 0;
            do
            {
               bitmap = new Bitmap(src);
               _shapes.push(bitmap);
               h = h + _size;
            }
            while(h < StageReferance.stageHeight);
            
            w = w + _size;
         }
         while(w < StageReferance.stageWidth);
         
      }
      
      private function rebackInitState() : void
      {
         var w:int = 0;
         var h:int = 0;
         var i:int = 0;
         do
         {
            h = 0;
            do
            {
               if(i < _shapes.length)
               {
                  _shapes[i].width = _size;
                  _shapes[i].height = _size;
                  _shapes[i].x = w;
                  _shapes[i].y = h;
                  _shapes[i].alpha = 1;
                  _container.addChild(_shapes[i]);
                  i++;
               }
               h = h + _size;
            }
            while(h < StageReferance.stageHeight);
            
            w = w + _size;
         }
         while(w < StageReferance.stageWidth);
         
         index = 0;
      }
      
      private function __tick(evt:TimerEvent) : void
      {
         var half:* = 0;
         var len:int = 0;
         var shape:* = null;
         var idx:int = _timer.currentCount - 1;
         if(idx >= 0)
         {
            half = _size >> 1;
            len = StageReferance.stageHeight / _size;
            while(true)
            {
               len--;
               if(!(len > 0 && index < _shapes.length))
               {
                  break;
               }
               index = Number(index) + 1;
               shape = _shapes[Number(index)];
               TweenLite.to(shape,0.7,{
                  "x":shape.x + half,
                  "y":shape.y + half,
                  "width":0,
                  "height":0,
                  "alpha":0,
                  "onComplete":shapeTweenComplete
               });
            }
            if(index >= _shapes.length)
            {
               _timer.stop();
               _timer.removeEventListener("timer",__tick);
            }
         }
      }
      
      private function shapeTweenComplete() : void
      {
         _completed = Number(_completed) + 1;
         if(_completed >= _shapes.length)
         {
            _container.visible = false;
         }
      }
      
      public function addedToStage() : void
      {
      }
      
      public function leaving(next:BaseStateView) : void
      {
         NewHandContainer.Instance.clearArrowByID(-1);
         PetSpriteManager.Instance.hidePetSprite(true,false);
      }
      
      public function removedFromStage() : void
      {
      }
      
      public function getView() : DisplayObject
      {
         return this;
      }
      
      public function getType() : String
      {
         return "default";
      }
      
      public function getBackType() : String
      {
         return "";
      }
      
      public function goBack() : Boolean
      {
         return false;
      }
      
      public function fadingComplete() : void
      {
      }
      
      public function dispose() : void
      {
      }
      
      public function refresh() : void
      {
         playEnterMovie();
      }
   }
}
