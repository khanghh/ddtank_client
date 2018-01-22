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
      
      public function NewChickenBoxItem(param1:NewChickenBoxCell, param2:MovieClip)
      {
         super();
         _cell = param1;
         _bg = param2;
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
      
      public function setBg(param1:int) : void
      {
         if(param1 == 0)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            cell.visible = true;
         }
         else if(param1 == 1)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            cell.visible = true;
         }
         else if(param1 == 2)
         {
            bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenOver") as MovieClip;
            cell.visible = true;
         }
         else if(param1 == 3)
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
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function get frameFilter() : Array
      {
         return _frameFilter;
      }
      
      public function set frameFilter(param1:Array) : void
      {
         _frameFilter = param1;
      }
      
      private function alphaItem(param1:Event) : void
      {
         _cell.visible = true;
         _cell.alpha = 0.5;
         updateCount();
         if(_tbxCount)
         {
            _tbxCount.alpha = 0.5;
         }
      }
      
      private function showItem(param1:Event) : void
      {
         _cell.visible = true;
         updateCount();
      }
      
      private function hideItem(param1:Event) : void
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
      
      public function set cell(param1:NewChickenBoxCell) : void
      {
         if(_cell != null && _cell.parent != null)
         {
            _cell.parent.removeChild(_cell);
         }
         _cell = param1;
         this.addChild(_cell);
      }
      
      public function get bg() : MovieClip
      {
         return _bg;
      }
      
      public function set bg(param1:MovieClip) : void
      {
         if(_bg != null && _bg.parent != null)
         {
            _bg.removeEventListener("showItem",showItem);
            _bg.removeEventListener("hideItem",hideItem);
            _bg.removeEventListener("alphaItem",alphaItem);
            _bg.parent.removeChild(_bg);
            _bg = null;
         }
         _bg = param1;
         _bg.addEventListener("showItem",showItem);
         _bg.addEventListener("hideItem",hideItem);
         _bg.addEventListener("alphaItem",alphaItem);
         this.addChild(_bg);
      }
      
      public function get position() : int
      {
         return _position;
      }
      
      public function set position(param1:int) : void
      {
         _position = param1;
      }
      
      public function setFrame(param1:int) : void
      {
         filters = _frameFilter[param1 - 1];
      }
      
      private function __onMouseRollout(param1:MouseEvent) : void
      {
         setFrame(1);
      }
      
      private function __onMouseRollover(param1:MouseEvent) : void
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
