package pyramid.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.PyramidSystemItemsInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PyramidEvent;
   import ddt.manager.PyramidManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PyramidCard extends Sprite implements Disposeable
   {
       
      
      private var _openCardMovie:MovieClip;
      
      private var _cell:PyramidCell;
      
      public var index:String;
      
      private var _state:int = 0;
      
      private var _openMovieState:int = 0;
      
      public function PyramidCard()
      {
         super();
         _openCardMovie = ComponentFactory.Instance.creat("assets.pyramid.openCard");
         addChild(_openCardMovie);
         _cell = new PyramidCell(0,null);
         _cell.setBgVisible(false);
         _cell.width = 46.5;
         _cell.height = 46.5;
         _cell.x = 2;
         _cell.y = 5;
         _cell.visible = false;
         addChild(_cell);
         initEvent();
         initData();
      }
      
      private function mouseMode(bool:Boolean) : void
      {
         this.buttonMode = bool;
         this.mouseEnabled = bool;
      }
      
      private function initEvent() : void
      {
         _openCardMovie.addEventListener("enterFrame",__enterFrame);
      }
      
      private function initData() : void
      {
         cardState(0);
      }
      
      private function playOpenCardMovie() : void
      {
         _openMovieState = 1;
         _openCardMovie.gotoAndStop(1);
      }
      
      private function playCloseCardMovie() : void
      {
         _openMovieState = 2;
         _openCardMovie.gotoAndStop(_openCardMovie.totalFrames - 1);
      }
      
      private function __enterFrame(event:Event) : void
      {
         if(_openMovieState == 1)
         {
            if(_openCardMovie.currentFrame < _openCardMovie.totalFrames - 1)
            {
               _openCardMovie.nextFrame();
            }
            else
            {
               _cell.visible = true;
               _openMovieState = 0;
               dispatchEvent(new PyramidEvent("openAndClose_Movie"));
            }
         }
         else if(_openMovieState == 2)
         {
            if(_openCardMovie.currentFrame > 1)
            {
               _openCardMovie.prevFrame();
            }
            else
            {
               _openMovieState = 0;
               dispatchEvent(new PyramidEvent("openAndClose_Movie"));
            }
         }
      }
      
      public function cardState(type:int, itemInfo:PyramidSystemItemsInfo = null) : void
      {
         _state = type;
         cellInfo(itemInfo);
         switch(int(_state))
         {
            case 0:
               mouseMode(false);
               _cell.visible = false;
               _openCardMovie.gotoAndStop(1);
               break;
            case 1:
               mouseMode(false);
               _openCardMovie.gotoAndStop(_openCardMovie.totalFrames - 1);
               _cell.visible = true;
               break;
            case 2:
               mouseMode(false);
               playOpenCardMovie();
               break;
            case 3:
               mouseMode(true);
               _cell.visible = false;
               _openCardMovie.gotoAndStop(_openCardMovie.totalFrames);
               break;
            case 4:
               mouseMode(false);
               _cell.visible = false;
               playCloseCardMovie();
               break;
            case 5:
               mouseMode(false);
               _cell.visible = true;
         }
      }
      
      private function cellInfo(itemInfo:PyramidSystemItemsInfo) : void
      {
         var tInfo:* = null;
         if(itemInfo)
         {
            tInfo = PyramidManager.instance.model.getInventoryItemInfo(itemInfo);
         }
         _cell.info = tInfo;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function reset() : void
      {
         cardState(0);
      }
      
      private function removeEvent() : void
      {
         _openCardMovie.removeEventListener("enterFrame",__enterFrame);
      }
      
      public function dispose() : void
      {
         removeEvent();
         index = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_openCardMovie);
         _openCardMovie = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
