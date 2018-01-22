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
      
      public function check(param1:String) : Boolean
      {
         return true;
      }
      
      public function prepare() : void
      {
         _prepared = true;
      }
      
      public function enter(param1:BaseStateView, param2:Object = null) : void
      {
         var _loc3_:String = getType();
         if(_loc3_ != "roomLoading" && _loc3_ != "consortia_domain" && !StartupResourceLoader.firstEnterHall)
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
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:* = null;
         var _loc3_:BitmapData = new BitmapData(_size,_size,false,0);
         if(_shapes)
         {
            _loc5_ = 0;
            while(_loc5_ < _shapes.length)
            {
               ObjectUtils.disposeObject(_shapes[_loc5_]);
               _shapes[_loc5_] = null;
               _loc5_++;
            }
            _shapes.splice(0,_shapes.length);
         }
         else
         {
            _shapes = new Vector.<DisplayObject>();
         }
         do
         {
            _loc4_ = 0;
            do
            {
               _loc2_ = new Bitmap(_loc3_);
               _shapes.push(_loc2_);
               _loc4_ = _loc4_ + _size;
            }
            while(_loc4_ < StageReferance.stageHeight);
            
            _loc1_ = _loc1_ + _size;
         }
         while(_loc1_ < StageReferance.stageWidth);
         
      }
      
      private function rebackInitState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         do
         {
            _loc2_ = 0;
            do
            {
               if(_loc3_ < _shapes.length)
               {
                  _shapes[_loc3_].width = _size;
                  _shapes[_loc3_].height = _size;
                  _shapes[_loc3_].x = _loc1_;
                  _shapes[_loc3_].y = _loc2_;
                  _shapes[_loc3_].alpha = 1;
                  _container.addChild(_shapes[_loc3_]);
                  _loc3_++;
               }
               _loc2_ = _loc2_ + _size;
            }
            while(_loc2_ < StageReferance.stageHeight);
            
            _loc1_ = _loc1_ + _size;
         }
         while(_loc1_ < StageReferance.stageWidth);
         
         index = 0;
      }
      
      private function __tick(param1:TimerEvent) : void
      {
         var _loc3_:* = 0;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:int = _timer.currentCount - 1;
         if(_loc2_ >= 0)
         {
            _loc3_ = _size >> 1;
            _loc5_ = StageReferance.stageHeight / _size;
            while(true)
            {
               _loc5_--;
               if(!(_loc5_ > 0 && index < _shapes.length))
               {
                  break;
               }
               index = Number(index) + 1;
               _loc4_ = _shapes[Number(index)];
               TweenLite.to(_loc4_,0.7,{
                  "x":_loc4_.x + _loc3_,
                  "y":_loc4_.y + _loc3_,
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
      
      public function leaving(param1:BaseStateView) : void
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
