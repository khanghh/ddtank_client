package newChickenBox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   
   public class NewChickenBoxItem extends Sprite
   {
       
      
      private var _bg:MovieClip;
      
      private var _cell:NewChickenBoxCell;
      
      private var _position:int;
      
      public var info:NewChickenBoxGoodsTempInfo;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _currentFrameIndex:int = 1;
      
      protected var _tbxCount:FilterFrameText;
      
      public function NewChickenBoxItem(cell:NewChickenBoxCell, bg:MovieClip)
      {
         super();
         _cell = cell;
         _bg = bg;
         _bg.addEventListener("showItem",showItem);
         _bg.addEventListener("hideItem",hideItem);
         _bg.addEventListener("alphaItem",alphaItem);
         addChild(_bg);
         addChild(_cell);
         _tbxCount = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.CountText");
         _tbxCount.mouseEnabled = false;
         addChild(_tbxCount);
         updateCount();
         this.buttonMode = true;
         filterString = "null,lightFilter,null,grayFilter";
         addEvent();
      }
      
      public function countTextShowIf() : void
      {
         if(info.IsSelected)
         {
            _tbxCount.visible = true;
         }
         else if(info.IsSeeded)
         {
            _tbxCount.visible = true;
            _tbxCount.alpha = 0.5;
         }
         else
         {
            _tbxCount.visible = false;
         }
      }
      
      public function updateCount() : void
      {
         if(_tbxCount)
         {
            if(info && info.Count > 1)
            {
               _tbxCount.text = String(info.Count);
               _tbxCount.visible = true;
               addChild(_tbxCount);
            }
            else
            {
               _tbxCount.visible = false;
            }
         }
      }
      
      public function setBg(state:int) : void
      {
         if(state == 0)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            cell.visible = true;
         }
         else if(state == 1)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            cell.visible = true;
         }
         else if(state == 2)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
            cell.visible = true;
         }
         else if(state == 3)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenBack") as MovieClip;
            cell.visible = false;
         }
         this.setChildIndex(cell,0);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.removeEventListener("showItem",showItem);
            _bg.removeEventListener("hideItem",hideItem);
            _bg.removeEventListener("alphaItem",alphaItem);
            _bg = null;
         }
         if(_cell)
         {
            ObjectUtils.disposeObject(_cell);
         }
         _cell = null;
         if(_tbxCount)
         {
            ObjectUtils.disposeObject(_tbxCount);
         }
         _tbxCount = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function set filterString(value:String) : void
      {
         if(_filterString == value)
         {
            return;
         }
         _filterString = value;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function get frameFilter() : Array
      {
         return _frameFilter;
      }
      
      public function set frameFilter(value:Array) : void
      {
         _frameFilter = value;
      }
      
      private function alphaItem(e:Event) : void
      {
         _cell.visible = true;
         _cell.alpha = 0.5;
         updateCount();
         if(_tbxCount)
         {
            _tbxCount.alpha = 0.5;
         }
      }
      
      private function showItem(e:Event) : void
      {
         _cell.visible = true;
         updateCount();
      }
      
      private function hideItem(e:Event) : void
      {
         _cell.visible = false;
         if(_tbxCount)
         {
            _tbxCount.visible = false;
         }
      }
      
      public function get cell() : NewChickenBoxCell
      {
         return _cell;
      }
      
      public function set cell(value:NewChickenBoxCell) : void
      {
         if(_cell != null && _cell.parent != null)
         {
            _cell.parent.removeChild(_cell);
         }
         _cell = value;
         this.addChild(_cell);
      }
      
      public function get bg() : MovieClip
      {
         return _bg;
      }
      
      public function set bg(value:MovieClip) : void
      {
         if(_bg != null && _bg.parent != null)
         {
            _bg.removeEventListener("showItem",showItem);
            _bg.removeEventListener("hideItem",hideItem);
            _bg.removeEventListener("alphaItem",alphaItem);
            _bg.parent.removeChild(_bg);
            _bg = null;
         }
         _bg = value;
         _bg.addEventListener("showItem",showItem);
         _bg.addEventListener("hideItem",hideItem);
         _bg.addEventListener("alphaItem",alphaItem);
         this.addChild(_bg);
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function set position(value:int) : void
      {
         _position = value;
      }
      
      public function setFrame(frameIndex:int) : void
      {
         filters = _frameFilter[frameIndex - 1];
      }
      
      private function __onMouseRollout(event:MouseEvent) : void
      {
         setFrame(1);
      }
      
      private function __onMouseRollover(event:MouseEvent) : void
      {
         setFrame(2);
      }
      
      protected function addEvent() : void
      {
         addEventListener("rollOver",__onMouseRollover);
         addEventListener("rollOut",__onMouseRollout);
      }
      
      protected function removeEvent() : void
      {
         removeEventListener("rollOver",__onMouseRollover);
         removeEventListener("rollOut",__onMouseRollout);
      }
   }
}
